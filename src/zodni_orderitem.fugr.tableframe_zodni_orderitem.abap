*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZODNI_ORDERITEM
*   generation date: 04.12.2021 at 17:55:13
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZODNI_ORDERITEM    .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
