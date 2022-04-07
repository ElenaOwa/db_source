*---------------------------------------------------------------------*
*    view related FORM routines
*   generation date: 03.12.2021 at 11:00:45
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZODN_V_CUSTOMER.................................*
FORM GET_DATA_ZODN_V_CUSTOMER.
  PERFORM VIM_FILL_WHERETAB.
*.read data from database.............................................*
  REFRESH TOTAL.
  CLEAR   TOTAL.
  SELECT * FROM ZODN_D_CUSTOMERS WHERE
(VIM_WHERETAB) .
    CLEAR ZODN_V_CUSTOMER .
ZODN_V_CUSTOMER-MANDT =
ZODN_D_CUSTOMERS-MANDT .
ZODN_V_CUSTOMER-CUSTOMERS_ID =
ZODN_D_CUSTOMERS-CUSTOMERS_ID .
ZODN_V_CUSTOMER-PHONENUMBER =
ZODN_D_CUSTOMERS-PHONENUMBER .
ZODN_V_CUSTOMER-ADDRESS =
ZODN_D_CUSTOMERS-ADDRESS .
ZODN_V_CUSTOMER-PASSWD =
ZODN_D_CUSTOMERS-PASSWD .
ZODN_V_CUSTOMER-EMAIL =
ZODN_D_CUSTOMERS-EMAIL .
    SELECT SINGLE * FROM ZODN_D_CUSTOM_T WHERE
CUSTOMERS_ID = ZODN_D_CUSTOMERS-CUSTOMERS_ID AND
LANGU = SY-LANGU .
    IF SY-SUBRC EQ 0.
ZODN_V_CUSTOMER-FIRSTNAME =
ZODN_D_CUSTOM_T-FIRSTNAME .
ZODN_V_CUSTOMER-LASTNAME =
ZODN_D_CUSTOM_T-LASTNAME .
    ENDIF.
<VIM_TOTAL_STRUC> = ZODN_V_CUSTOMER.
    APPEND TOTAL.
  ENDSELECT.
  SORT TOTAL BY <VIM_XTOTAL_KEY>.
  <STATUS>-ALR_SORTED = 'R'.
*.check dynamic selectoptions (not in DDIC)...........................*
  IF X_HEADER-SELECTION NE SPACE.
    PERFORM CHECK_DYNAMIC_SELECT_OPTIONS.
  ELSEIF X_HEADER-DELMDTFLAG NE SPACE.
    PERFORM BUILD_MAINKEY_TAB.
  ENDIF.
  REFRESH EXTRACT.
ENDFORM.
*---------------------------------------------------------------------*
FORM DB_UPD_ZODN_V_CUSTOMER .
*.process data base updates/inserts/deletes.........................*
LOOP AT TOTAL.
  CHECK <ACTION> NE ORIGINAL.
MOVE <VIM_TOTAL_STRUC> TO ZODN_V_CUSTOMER.
  IF <ACTION> = UPDATE_GELOESCHT.
    <ACTION> = GELOESCHT.
  ENDIF.
  CASE <ACTION>.
   WHEN NEUER_GELOESCHT.
IF STATUS_ZODN_V_CUSTOMER-ST_DELETE EQ GELOESCHT.
     READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY>.
     IF SY-SUBRC EQ 0.
       DELETE EXTRACT INDEX SY-TABIX.
     ENDIF.
    ENDIF.
    DELETE TOTAL.
    IF X_HEADER-DELMDTFLAG NE SPACE.
      PERFORM DELETE_FROM_MAINKEY_TAB.
    ENDIF.
   WHEN GELOESCHT.
  SELECT SINGLE FOR UPDATE * FROM ZODN_D_CUSTOMERS WHERE
  CUSTOMERS_ID = ZODN_V_CUSTOMER-CUSTOMERS_ID .
    IF SY-SUBRC = 0.
    DELETE ZODN_D_CUSTOMERS .
    ENDIF.
    DELETE FROM ZODN_D_CUSTOM_T WHERE
    CUSTOMERS_ID = ZODN_D_CUSTOMERS-CUSTOMERS_ID .
    IF STATUS-DELETE EQ GELOESCHT.
      READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY> BINARY SEARCH.
      DELETE EXTRACT INDEX SY-TABIX.
    ENDIF.
    DELETE TOTAL.
    IF X_HEADER-DELMDTFLAG NE SPACE.
      PERFORM DELETE_FROM_MAINKEY_TAB.
    ENDIF.
   WHEN OTHERS.
  SELECT SINGLE FOR UPDATE * FROM ZODN_D_CUSTOMERS WHERE
  CUSTOMERS_ID = ZODN_V_CUSTOMER-CUSTOMERS_ID .
    IF SY-SUBRC <> 0.   "insert preprocessing: init WA
      CLEAR ZODN_D_CUSTOMERS.
    ENDIF.
ZODN_D_CUSTOMERS-MANDT =
ZODN_V_CUSTOMER-MANDT .
ZODN_D_CUSTOMERS-CUSTOMERS_ID =
ZODN_V_CUSTOMER-CUSTOMERS_ID .
ZODN_D_CUSTOMERS-PHONENUMBER =
ZODN_V_CUSTOMER-PHONENUMBER .
ZODN_D_CUSTOMERS-ADDRESS =
ZODN_V_CUSTOMER-ADDRESS .
ZODN_D_CUSTOMERS-PASSWD =
ZODN_V_CUSTOMER-PASSWD .
ZODN_D_CUSTOMERS-EMAIL =
ZODN_V_CUSTOMER-EMAIL .
    IF SY-SUBRC = 0.
    UPDATE ZODN_D_CUSTOMERS .
    ELSE.
    INSERT ZODN_D_CUSTOMERS .
    ENDIF.
    SELECT SINGLE FOR UPDATE * FROM ZODN_D_CUSTOM_T WHERE
    CUSTOMERS_ID = ZODN_D_CUSTOMERS-CUSTOMERS_ID AND
    LANGU = SY-LANGU .
      IF SY-SUBRC <> 0.   "insert preprocessing: init WA
        CLEAR ZODN_D_CUSTOM_T.
ZODN_D_CUSTOM_T-CUSTOMERS_ID =
ZODN_D_CUSTOMERS-CUSTOMERS_ID .
ZODN_D_CUSTOM_T-LANGU =
SY-LANGU .
      ENDIF.
ZODN_D_CUSTOM_T-FIRSTNAME =
ZODN_V_CUSTOMER-FIRSTNAME .
ZODN_D_CUSTOM_T-LASTNAME =
ZODN_V_CUSTOMER-LASTNAME .
    IF SY-SUBRC = 0.
    UPDATE ZODN_D_CUSTOM_T .
    ELSE.
    INSERT ZODN_D_CUSTOM_T .
    ENDIF.
    READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY>.
    IF SY-SUBRC EQ 0.
      <XACT> = ORIGINAL.
      MODIFY EXTRACT INDEX SY-TABIX.
    ENDIF.
    <ACTION> = ORIGINAL.
    MODIFY TOTAL.
  ENDCASE.
ENDLOOP.
CLEAR: STATUS_ZODN_V_CUSTOMER-UPD_FLAG,
STATUS_ZODN_V_CUSTOMER-UPD_CHECKD.
MESSAGE S018(SV).
ENDFORM.
*---------------------------------------------------------------------*
FORM READ_SINGLE_ZODN_V_CUSTOMER.
  SELECT SINGLE * FROM ZODN_D_CUSTOMERS WHERE
CUSTOMERS_ID = ZODN_V_CUSTOMER-CUSTOMERS_ID .
ZODN_V_CUSTOMER-MANDT =
ZODN_D_CUSTOMERS-MANDT .
ZODN_V_CUSTOMER-CUSTOMERS_ID =
ZODN_D_CUSTOMERS-CUSTOMERS_ID .
ZODN_V_CUSTOMER-PHONENUMBER =
ZODN_D_CUSTOMERS-PHONENUMBER .
ZODN_V_CUSTOMER-ADDRESS =
ZODN_D_CUSTOMERS-ADDRESS .
ZODN_V_CUSTOMER-PASSWD =
ZODN_D_CUSTOMERS-PASSWD .
ZODN_V_CUSTOMER-EMAIL =
ZODN_D_CUSTOMERS-EMAIL .
    SELECT SINGLE * FROM ZODN_D_CUSTOM_T WHERE
CUSTOMERS_ID = ZODN_D_CUSTOMERS-CUSTOMERS_ID AND
LANGU = SY-LANGU .
    IF SY-SUBRC EQ 0.
ZODN_V_CUSTOMER-FIRSTNAME =
ZODN_D_CUSTOM_T-FIRSTNAME .
ZODN_V_CUSTOMER-LASTNAME =
ZODN_D_CUSTOM_T-LASTNAME .
    ELSE.
      CLEAR SY-SUBRC.
      CLEAR ZODN_V_CUSTOMER-FIRSTNAME .
      CLEAR ZODN_V_CUSTOMER-LASTNAME .
    ENDIF.
ENDFORM.
*---------------------------------------------------------------------*
FORM CORR_MAINT_ZODN_V_CUSTOMER USING VALUE(CM_ACTION) RC.
  DATA: RETCODE LIKE SY-SUBRC, COUNT TYPE I, TRSP_KEYLEN TYPE SYFLENG.
  FIELD-SYMBOLS: <TAB_KEY_X> TYPE X.
  CLEAR RC.
MOVE ZODN_V_CUSTOMER-CUSTOMERS_ID TO
ZODN_D_CUSTOMERS-CUSTOMERS_ID .
MOVE ZODN_V_CUSTOMER-MANDT TO
ZODN_D_CUSTOMERS-MANDT .
  CORR_KEYTAB             =  E071K.
  CORR_KEYTAB-OBJNAME     = 'ZODN_D_CUSTOMERS'.
  IF NOT <vim_corr_keyx> IS ASSIGNED.
    ASSIGN CORR_KEYTAB-TABKEY TO <vim_corr_keyx> CASTING.
  ENDIF.
  ASSIGN ZODN_D_CUSTOMERS TO <TAB_KEY_X> CASTING.
  PERFORM VIM_GET_TRSPKEYLEN
    USING 'ZODN_D_CUSTOMERS'
    CHANGING TRSP_KEYLEN.
  <VIM_CORR_KEYX>(TRSP_KEYLEN) = <TAB_KEY_X>(TRSP_KEYLEN).
  PERFORM UPDATE_CORR_KEYTAB USING CM_ACTION RETCODE.
  ADD: RETCODE TO RC, 1 TO COUNT.
  IF RC LT COUNT AND CM_ACTION NE PRUEFEN.
    CLEAR RC.
  ENDIF.

MOVE ZODN_D_CUSTOMERS-CUSTOMERS_ID TO
ZODN_D_CUSTOM_T-CUSTOMERS_ID .
MOVE SY-LANGU TO
ZODN_D_CUSTOM_T-LANGU .
MOVE ZODN_V_CUSTOMER-MANDT TO
ZODN_D_CUSTOM_T-MANDT .
  CORR_KEYTAB             =  E071K.
  CORR_KEYTAB-OBJNAME     = 'ZODN_D_CUSTOM_T'.
  IF NOT <vim_corr_keyx> IS ASSIGNED.
    ASSIGN CORR_KEYTAB-TABKEY TO <vim_corr_keyx> CASTING.
  ENDIF.
  ASSIGN ZODN_D_CUSTOM_T TO <TAB_KEY_X> CASTING.
  PERFORM VIM_GET_TRSPKEYLEN
    USING 'ZODN_D_CUSTOM_T'
    CHANGING TRSP_KEYLEN.
  <VIM_CORR_KEYX>(TRSP_KEYLEN) = <TAB_KEY_X>(TRSP_KEYLEN).
  PERFORM UPDATE_CORR_KEYTAB USING CM_ACTION RETCODE.
  ADD: RETCODE TO RC, 1 TO COUNT.
  IF RC LT COUNT AND CM_ACTION NE PRUEFEN.
    CLEAR RC.
  ENDIF.

ENDFORM.
*---------------------------------------------------------------------*