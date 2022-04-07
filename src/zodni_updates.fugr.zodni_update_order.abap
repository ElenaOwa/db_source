FUNCTION ZODNI_UPDATE_ORDER.
*"----------------------------------------------------------------------
*"*"Update Function Module:
*"
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IT_ORDER) TYPE  ZODN_T_ORDER
*"     VALUE(IT_ORDER_ITEM) TYPE  ZODN_T_ORDER_ITEM
*"----------------------------------------------------------------------
  UPDATE zodn_d_orders FROM TABLE it_order.
  IF  sy-subrc <> 0.
    MESSAGE 'Error occured during Order updating' TYPE 'A'.
  ENDIF.
  UPDATE zodn_d_orderitem FROM TABLE it_order_item.
  IF sy-subrc <> 0.
    MESSAGE 'Error occured during Order Items updating' TYPE 'A'.
  ENDIF.



ENDFUNCTION.
