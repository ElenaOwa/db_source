FUNCTION zodni_update_customer.
*"----------------------------------------------------------------------
*"*"Update Function Module:
*"
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IT_CUSTOMER) TYPE  ZODN_T_CUSTOMER
*"     VALUE(IT_CUSTOMER_T) TYPE  ZODN_T_CUSTOMER_T
*"----------------------------------------------------------------------
  UPDATE zodn_d_customers FROM TABLE it_customer.
  IF  sy-subrc <> 0.
    MESSAGE 'Error occured during Customer updating' TYPE 'A'.
  ENDIF.
  UPDATE zodn_d_custom_t FROM TABLE it_customer_t.
  IF sy-subrc <> 0.
    MESSAGE 'Error occured during Customer_t updating' TYPE 'A'.
  ENDIF.



ENDFUNCTION.
