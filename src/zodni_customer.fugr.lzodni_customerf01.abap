*----------------------------------------------------------------------*
***INCLUDE LZODNI_CUSTOMERF01.
*----------------------------------------------------------------------*
form ZODNI_EVE.
DATA: lv_count type zodn_v_customer-customers_id,
lv_range TYPE Inri-nrrangenr VALUE '01' . "INRI–NRRANGENR


CALL FUNCTION 'NUMBER_GET_NEXT'
EXPORTING
nr_range_nr                   = lv_range
object                        = 'ZODNI_NUMC'
*     QUANTITY                      = ‘1’
*     SUBOBJECT                     = ‘ ‘
*     TOYEAR                        = ‘0000’
*     IGNORE_BUFFER                 = ‘ ‘
IMPORTING
NUMBER                        = lv_count
*     QUANTITY                      =
*     RETURNCODE                    =
EXCEPTIONS
INTERVAL_NOT_FOUND            = 1
NUMBER_RANGE_NOT_INTERN       = 2
OBJECT_NOT_FOUND              = 3
QUANTITY_IS_0                 = 4
QUANTITY_IS_NOT_1             = 5
INTERVAL_OVERFLOW             = 6
BUFFER_OVERFLOW               = 7
OTHERS                        = 8
.

IF sy-subrc = 0.
* Implement suitable error handling here
zodn_v_customer-customers_id = lv_count.
ENDIF.
ENDFORM.
