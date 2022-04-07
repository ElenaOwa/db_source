*----------------------------------------------------------------------*
***INCLUDE LZODNI_BOOKO01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module change OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE change OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  IF sy-ucomm = 'newl' OR sy-ucomm = 'save'.

    LOOP AT SCREEN.

      IF screen-name = 'SAPLZODNI_BOOK'.

        screen-input = 0 .
        MODIFY SCREEN .

      ENDIF.

    ENDLOOP.

  ENDIF.
ENDMODULE.
