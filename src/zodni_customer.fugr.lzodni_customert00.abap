*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 03.12.2021 at 11:00:45
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZODN_V_CUSTOMER.................................*
TABLES: ZODN_V_CUSTOMER, *ZODN_V_CUSTOMER. "view work areas
CONTROLS: TCTRL_ZODN_V_CUSTOMER
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_ZODN_V_CUSTOMER. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZODN_V_CUSTOMER.
* Table for entries selected to show on screen
DATA: BEGIN OF ZODN_V_CUSTOMER_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZODN_V_CUSTOMER.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZODN_V_CUSTOMER_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZODN_V_CUSTOMER_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZODN_V_CUSTOMER.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZODN_V_CUSTOMER_TOTAL.

*.........table declarations:.................................*
TABLES: ZODN_D_CUSTOMERS               .
TABLES: ZODN_D_CUSTOM_T                .
