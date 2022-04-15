CLASS zcx_shop_ DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_abap_behv_message .
    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

    CONSTANTS:
      BEGIN OF customer_unknown,
        msgid TYPE symsgid VALUE 'ZCL_MSG_SHOP',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'CUSTONMERSId',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF customer_unknown,
      BEGIN OF product_unknown,
        msgid TYPE symsgid VALUE 'ZCL_MSG_SHOP',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE 'GOODSID',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF product_unknown.

    METHODS constructor
      IMPORTING
        severity    TYPE if_abap_behv_message=>t_severity DEFAULT if_abap_behv_message=>severity-error
        textid      LIKE if_t100_message=>t100key OPTIONAL
        previous    TYPE REF TO cx_root OPTIONAL
        customersid TYPE zodni_customers_id  OPTIONAL
        goodsid   TYPE  zodni_goods_id OPTIONAL.

    DATA       customersid TYPE zodni_customers_id  READ-ONLY.
    DATA  goodsid TYPE  zodni_goods_id  READ-ONLY.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcx_shop_ IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

    me->customersid = |{ customersid ALPHA = OUT }|.
    me->goodsid = |{ goodsid ALPHA = OUT }|.

  ENDMETHOD.

ENDCLASS.
