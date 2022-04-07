*----------------------------------------------------------------------*
***INCLUDE LZODNI_BOOKF01.
*----------------------------------------------------------------------*
FORM update.
  DATA: c_count TYPE zodni_d_book-book_id,
        u_range TYPE inri-nrrangenr VALUE '01' . " INRI–NRRANGENR

  DATA : num(7)  TYPE c,
         num1(2) TYPE c VALUE 'B'.

  CALL FUNCTION 'NUMBER_GET_NEXT'
    EXPORTING
      nr_range_nr             = u_range
      object                  = 'ZODNI_NUMC'
*     QUANTITY                = ‘1’
*     SUBOBJECT               = ‘ ‘
*     TOYEAR                  = ‘0000’
*     IGNORE_BUFFER           = ‘ ‘
    IMPORTING
      number                  = c_count
*     QUANTITY                =
*     RETURNCODE              =
    EXCEPTIONS
      interval_not_found      = 1
      number_range_not_intern = 2
      object_not_found        = 3
      quantity_is_0           = 4
      quantity_is_not_1       = 5
      interval_overflow       = 6
      buffer_overflow         = 7
      OTHERS                  = 8.
  CONCATENATE num1 c_count INTO num .
  IF sy-subrc = 0.
* Implement suitable error handling here
    zodni_d_book-book_id = num .
  ENDIF.
ENDFORM.
