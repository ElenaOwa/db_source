FUNCTION ZODNI_INSERT_CUSTOMER.
*"----------------------------------------------------------------------
*"*"Update Function Module:
*"
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IS_CUSTOMER) TYPE  ZODN_S_CUSTOMER
*"     VALUE(IT_CUSTOMER_T) TYPE  ZODN_T_CUSTOMER_T
*"----------------------------------------------------------------------

  INSERT zodn_d_customers FROM is_customer.
  IF  sy-subrc <> 0.
    MESSAGE 'Error occured during Customer insertion' TYPE 'A'.
  ENDIF.
  INSERT zodn_d_custom_t FROM TABLE it_customer_t.
  IF sy-subrc <> 0.
    MESSAGE 'Error occured during Customer_t insertion' TYPE 'A'.
  ENDIF.




ENDFUNCTION.
