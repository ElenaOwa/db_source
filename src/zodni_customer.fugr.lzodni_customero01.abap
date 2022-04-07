*----------------------------------------------------------------------*
***INCLUDE LZODNI_CUSTOMERO01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module ZODNI_CHANGE OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE zodni_change OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  IF sy-ucomm = 'NEWL' OR sy-ucomm = 'SAVE'.

    LOOP AT SCREEN.

      IF screen-name = 'ZODN_V_CUSTOMER-CUSTOMERS_ID'.

        screen-input = 0 .
        MODIFY SCREEN .

      ENDIF.

    ENDLOOP.

  ENDIF.

ENDMODULE.
