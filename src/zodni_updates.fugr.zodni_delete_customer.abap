FUNCTION zodni_delete_customer.
*"----------------------------------------------------------------------
*"*"Update Function Module:
*"
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_ID) TYPE  ZODNI_CUSTOMERS_ID
*"----------------------------------------------------------------------

  DELETE FROM zodn_d_customers WHERE customers_id = @iv_id.
  IF  sy-subrc <> 0.
    MESSAGE 'Error occured during Customer removing' TYPE 'A'.
  ENDIF.
  DELETE FROM zodn_d_custom_t WHERE customers_id = @iv_id.
  IF sy-subrc <> 0.
    MESSAGE 'Error occured during Customer_t removing' TYPE 'A'.
  ENDIF.




ENDFUNCTION.
