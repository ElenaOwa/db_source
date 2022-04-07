*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 04.12.2021 at 17:55:14
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZODN_D_ORDERITEM................................*
DATA:  BEGIN OF STATUS_ZODN_D_ORDERITEM              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZODN_D_ORDERITEM              .
CONTROLS: TCTRL_ZODN_D_ORDERITEM
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZODN_D_ORDERITEM              .
TABLES: ZODN_D_ORDERITEM               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
