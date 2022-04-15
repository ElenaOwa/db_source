CLASS lhc_Order DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
      CONSTANTS:
      BEGIN OF order_status,
        open     TYPE c LENGTH 2  VALUE 'S1', " In progress
        closed TYPE c LENGTH 2  VALUE 'S2', " Closed
        canceled TYPE c LENGTH 2  VALUE 'S3', " Cancelled
        ready    TYPE c LENGTH 2  VALUE 'S4', "Ready
      END OF order_status.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Order RESULT result.

    METHODS acceptOrder FOR MODIFY
      IMPORTING keys FOR ACTION Order~acceptOrder RESULT result.

    METHODS rejectOrder FOR MODIFY
      IMPORTING keys FOR ACTION Order~rejectOrder RESULT result.

    METHODS setInitialDate FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Order~setInitialDate.

    METHODS setInitialStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Order~setInitialStatus.

    METHODS calculateOrderID FOR DETERMINE ON SAVE
      IMPORTING keys FOR Order~calculateOrderID.

    METHODS validateCustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR Order~validateCustomer.

ENDCLASS.

CLASS lhc_Order IMPLEMENTATION.

  METHOD get_instance_features.
   " Read the order status of the existing orders
    READ ENTITIES OF zodn_i_order IN LOCAL MODE
      ENTITY Order
        FIELDS ( OrderstatusId ) WITH CORRESPONDING #( keys )
      RESULT DATA(orders)
      FAILED failed.

      result =
      VALUE #(
        FOR order IN orders
          LET is_accepted =   COND #( WHEN order-OrderstatusId = order_status-ready OR order-OrderstatusId = order_status-closed
                                      THEN if_abap_behv=>fc-o-disabled
                                      ELSE if_abap_behv=>fc-o-enabled  )
              is_rejected =   COND #( WHEN order-OrderstatusId = order_status-canceled OR order-OrderstatusId = order_status-closed
                                      THEN if_abap_behv=>fc-o-disabled
                                      ELSE if_abap_behv=>fc-o-enabled )
          IN
            ( %tky                 = order-%tky
              %action-acceptOrder = is_accepted
              %action-rejectOrder = is_rejected
             ) ).

  ENDMETHOD.

  METHOD acceptOrder.
  " Set the new order status
    MODIFY ENTITIES OF zodn_i_order IN LOCAL MODE
      ENTITY Order
         UPDATE
           FIELDS ( OrderstatusId )
           WITH VALUE #( FOR key IN keys
                           ( %tky         = key-%tky
                             OrderstatusId = order_status-ready ) )
      FAILED failed
      REPORTED reported.

    " Fill the response table
    READ ENTITIES OF zodn_i_order IN LOCAL MODE
      ENTITY Order
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

    result = VALUE #( FOR order IN orders
                        ( %tky   = order-%tky
                          %param = order ) ).
  ENDMETHOD.

  METHOD rejectOrder.
  " Set the new order status
    MODIFY ENTITIES OF zodn_i_order IN LOCAL MODE
      ENTITY Order
         UPDATE
           FIELDS ( OrderstatusId )
           WITH VALUE #( FOR key IN keys
                           ( %tky         = key-%tky
                             OrderstatusId = order_status-canceled ) )
      FAILED failed
      REPORTED reported.

    " Fill the response table
    READ ENTITIES OF zodn_i_order IN LOCAL MODE
      ENTITY Order
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

    result = VALUE #( FOR order IN orders
                        ( %tky   = order-%tky
                          %param = order ) ).
  ENDMETHOD.

  METHOD setInitialDate.
  " Read relevant order instance data
    READ ENTITIES OF zodn_i_order IN LOCAL MODE
      ENTITY Order
        FIELDS ( OrderDate OrderTime ) WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

    CHECK orders IS NOT INITIAL.

    " Set default travel status
    MODIFY ENTITIES OF zodn_i_order IN LOCAL MODE
    ENTITY Order
      UPDATE
        FIELDS ( OrderDate OrderTime )
        WITH VALUE #( FOR order IN orders
                      ( %tky         = order-%tky
                       OrderDate = sy-datum
                       OrderTime = sy-uzeit ) )
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).
  ENDMETHOD.

  METHOD setInitialStatus.
    " Read relevant order instance data
    READ ENTITIES OF zodn_i_order IN LOCAL MODE
      ENTITY Order
        FIELDS ( OrderstatusId ) WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

    " Remove all travel instance data with defined status
    DELETE orders WHERE OrderstatusId IS NOT INITIAL.
    CHECK orders IS NOT INITIAL.

    " Set default travel status
    MODIFY ENTITIES OF zodn_i_order IN LOCAL MODE
    ENTITY Order
      UPDATE
        FIELDS ( OrderstatusId )
        WITH VALUE #( FOR order IN orders
                      ( %tky         = order-%tky
                        OrderstatusId = order_status-open ) )
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).
  ENDMETHOD.

  METHOD calculateorderid.
   " check if OrderId is already filled
    READ ENTITIES OF zodn_i_order IN LOCAL MODE
      ENTITY Order
        FIELDS ( OrderId ) WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

    " remove lines where OrderId is already filled.
    DELETE orders WHERE OrderId IS NOT INITIAL.

    " anything left ?
    CHECK orders IS NOT INITIAL.

    " Select max travel ID
    SELECT SINGLE
        FROM  zodn_aorder
        FIELDS MAX( order_id ) AS orderid
        INTO @DATA(max_orderid).

    " Set the travel ID
    MODIFY ENTITIES OF zodn_i_order IN LOCAL MODE
    ENTITY Order
      UPDATE
        FROM VALUE #( FOR order IN orders INDEX INTO i (
          %tky              = order-%tky
          OrderId         = max_orderid + i
          %control-OrderId = if_abap_behv=>mk-on )  )
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).
  ENDMETHOD.

  METHOD validateCustomer.
    READ ENTITY IN LOCAL MODE zodn_i_order\\Order
    FROM VALUE #(
        FOR <root_key> IN keys ( %key-OrderUuid     = <root_key>-OrderUuid
                                 %control = VALUE #( CustomersId = if_abap_behv=>mk-on ) ) )
        RESULT DATA(lt_order).

    DATA lt_customer TYPE SORTED TABLE OF zodn_acust WITH UNIQUE KEY customers_id.

    " Optimization of DB select: extract distinct non-initial customer IDs
    lt_customer = CORRESPONDING #( lt_order DISCARDING DUPLICATES MAPPING customers_id = CustomersId EXCEPT * ).
    DELETE lt_customer WHERE customers_id IS INITIAL.
    CHECK lt_customer IS NOT INITIAL.

    " Check if customer ID exist
    SELECT FROM zodn_acust FIELDS customers_id
      FOR ALL ENTRIES IN @lt_customer
      WHERE customers_id = @lt_customer-customers_id
      INTO TABLE @DATA(lt_customer_db).

    " Raise msg for non existing customer id
    LOOP AT lt_order INTO DATA(ls_order).
      IF ls_order-CustomersId IS NOT INITIAL AND NOT line_exists( lt_customer_db[ customers_id = ls_order-CustomersId ] ).
        APPEND VALUE #(  %key = ls_order-%key ) TO failed-order.
        APPEND VALUE #(  %key = ls_order-%key
                         %msg      = new_message( id       = zcx_shop_=>customer_unknown-msgid
                                                  number   = zcx_shop_=>customer_unknown-msgno
                                                  v1       = ls_order-CustomersId
                                                  severity = if_abap_behv_message=>severity-error )
                         %element-OrderId = if_abap_behv=>mk-on ) TO reported-order.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
