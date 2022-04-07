FUNCTION zodni_delete_order.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(I_ORDERID) TYPE  ZODNI_ORDER_ID
*"  EXCEPTIONS
*"      NOT_FOUND
*"----------------------------------------------------------------------

  DELETE FROM zodn_d_orders WHERE order_id = @i_orderid.
  DELETE FROM zodn_d_orderitem WHERE order_id = @i_orderid.



  ENDFUNCTION.
