FUNCTION ZODNI_DELETE1_ORDER.
*"----------------------------------------------------------------------
*"*"Update Function Module:
*"
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_ID) TYPE  ZODNI_ORDER_ID
*"----------------------------------------------------------------------

  DELETE FROM zodn_d_orders WHERE order_id = @iv_id.
  IF  sy-subrc <> 0.
    MESSAGE 'Error occured during Order updating' TYPE 'A'.
  ENDIF.
  DELETE FROM zodn_d_orderitem where order_id = @iv_id.
  IF sy-subrc <> 0.
    MESSAGE 'Error occured during Order Items updating' TYPE 'A'.
  ENDIF.



ENDFUNCTION.
