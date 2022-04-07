FUNCTION zodni_update_author.
*"----------------------------------------------------------------------
*"*"Update Function Module:
*"
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IT_AUTHOR) TYPE  ZODNI_T_AUTHOR
*"     VALUE(IT_AUTHOR_T) TYPE  ZODNI_T_AUTHOR_T
*"----------------------------------------------------------------------
  INSERT zodni_d_author_t FROM TABLE it_author_t.
  IF sy-subrc <> 0.
    MESSAGE 'Error occured during Order Items insertion' TYPE 'A'.
  ENDIF.
  INSERT zodni_d_author FROM TABLE it_author.
  IF sy-subrc <> 0.
    MESSAGE 'Error occured during Order Items insertion' TYPE 'A'.
  ENDIF.




ENDFUNCTION.
