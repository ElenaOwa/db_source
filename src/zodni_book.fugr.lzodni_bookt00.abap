*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 28.11.2021 at 15:47:30
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZODNI_D_BOOK....................................*
DATA:  BEGIN OF STATUS_ZODNI_D_BOOK                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZODNI_D_BOOK                  .
CONTROLS: TCTRL_ZODNI_D_BOOK
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZODNI_D_BOOK                  .
TABLES: ZODNI_D_BOOK                   .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
