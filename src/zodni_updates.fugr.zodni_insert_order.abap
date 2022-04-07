FUNCTION ZODNI_INSERT_ORDER.
*"----------------------------------------------------------------------
*"*"Update Function Module:
*"
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IS_ORDER) TYPE  ZODN_S_ORDER
*"     VALUE(IT_ORDER_ITEM) TYPE  ZODN_T_ORDER_ITEM
*"----------------------------------------------------------------------
  INSERT zodn_d_orders FROM is_order.
  IF  sy-subrc <> 0.
    MESSAGE 'Error occured during Order insertion' TYPE 'A'.
  ENDIF.
  INSERT zodn_d_orderitem FROM TABLE it_order_item.
  IF sy-subrc <> 0.
    MESSAGE 'Error occured during Order Items insertion' TYPE 'A'.
  ENDIF.



ENDFUNCTION.
