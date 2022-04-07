*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZODNI_BOOK
*   generation date: 28.11.2021 at 15:47:29
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZODNI_BOOK         .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
