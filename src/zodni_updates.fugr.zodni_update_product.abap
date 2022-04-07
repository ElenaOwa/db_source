FUNCTION ZODNI_UPDATE_PRODUCT.
*"----------------------------------------------------------------------
*"*"Update Function Module:
*"
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IT_PRODUCT) TYPE  ZODN_T_GOODS
*"----------------------------------------------------------------------

  UPDATE zodn_d_goods FROM TABLE it_product.
  IF  sy-subrc <> 0.
    MESSAGE 'Error occured during Goods updating' TYPE 'A'.
  ENDIF.

ENDFUNCTION.
