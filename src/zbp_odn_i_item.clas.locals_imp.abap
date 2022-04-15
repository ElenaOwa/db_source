CLASS lhc_Item DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS validateProduct FOR VALIDATE ON SAVE
      IMPORTING keys FOR Item~validateProduct.
    METHODS setOrdeId FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Item~setOrdeId.

ENDCLASS.

CLASS lhc_Item IMPLEMENTATION.

  METHOD validateProduct.

    READ ENTITY IN LOCAL MODE zodn_i_order\\Item
      FROM VALUE #(
          FOR <root_key> IN keys ( %key   = <root_key>-%key
                                   %control = VALUE #( GoodsId = if_abap_behv=>mk-on ) ) )
          RESULT DATA(lt_item).

    DATA lt_product TYPE SORTED TABLE OF zodn_agoods WITH UNIQUE KEY goods_id.

    " Optimization of DB select: extract distinct non-initial customer IDs
    lt_product = CORRESPONDING #( lt_item DISCARDING DUPLICATES MAPPING goods_id = GoodsId EXCEPT * ).
    DELETE lt_product WHERE goods_id IS INITIAL.
    CHECK lt_product IS NOT INITIAL.

    " Check if customer ID exist
    SELECT FROM zodn_agoods FIELDS goods_id
      FOR ALL ENTRIES IN @lt_product
      WHERE goods_id = @lt_product-goods_id
      INTO TABLE @DATA(lt_goods_db).

    " Raise msg for non existing customer id
    LOOP AT lt_item INTO DATA(ls_item).
      IF ls_item-GoodsId IS NOT INITIAL AND NOT line_exists( lt_goods_db[ goods_id = ls_item-GoodsId ] ).
        APPEND VALUE #(  %tky = ls_item-%tky ) TO failed-order.
        APPEND VALUE #( %tky = ls_item-%tky
                         %msg      = new_message( id       = zcx_shop_=>product_unknown-msgid
                                                  number   = zcx_shop_=>product_unknown-msgno
                                                  v1       = ls_item-GoodsId
                                                  severity = if_abap_behv_message=>severity-error )
                         %element-OrderId = if_abap_behv=>mk-on ) TO reported-order.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD setOrdeId.
    DATA value_id TYPE zodn_order_id.
    DATA update TYPE TABLE FOR UPDATE zodn_i_order\\Item.

    " Read all travels for the requested bookings.
    " If multiple bookings of the same travel are requested, the travel is returned only once.
    READ ENTITIES OF zodn_i_order IN LOCAL MODE
    ENTITY Item BY \_Order
      FIELDS ( OrderUuid OrderId )
      WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

    " Process all affected Travels. Read respective bookings, determine the max-id and update the bookings without ID.
    LOOP AT orders INTO DATA(order).
      READ ENTITIES OF zodn_i_order IN LOCAL MODE
        ENTITY Order BY \_OrderItem
          FIELDS ( OrderId )
        WITH VALUE #( ( %tky = order-%tky ) )
        RESULT DATA(items).

      " Provide a booking ID for all bookings that have none.
      LOOP AT items INTO data(item)  WHERE OrderId IS INITIAL.
        APPEND VALUE #( %tky      = item-%tky
                        OrderId = order-OrderId
                      ) TO update.
      ENDLOOP.
    ENDLOOP.

    " Update the Booking ID of all relevant bookings
    MODIFY ENTITIES OF zodn_i_order IN LOCAL MODE
    ENTITY Item
      UPDATE FIELDS ( OrderId ) WITH update
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).
  ENDMETHOD.

ENDCLASS.
