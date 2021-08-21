*&---------------------------------------------------------------------*
*& Report YLOGGING_TEST01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ylogging_test01.

*/**
* Summary of the steps to Create and View logs:
*  1)  Create object and sub object in SLG0 transaction.
*  2) The program where you want to create the LOG call the FMs:
*            BAL_LOG_CREATE
*            BAL_LOG_MSG_ADD
*            BAL_DB_SAVE
*   3)  For viewing the logs go to SLG1 transaction and give the object name,
*       sub object name (if any) and other related information like the
*       Username and date etc.
*       Then click on Execute. You will be able to see the logs.
*       Double click on any one of them to see the detailed error message.
*   4) One can even view the logs through the program itself by using
*      the FM BAL_DSP_LOG_DISPLAY.
*/*

DATA gv_number TYPE i.

DO 10 TIMES.

  ADD 1 TO gv_number.

  IF gv_number EQ 10.
    PERFORM logging_test01.
  ENDIF.

ENDDO.

*/---
FORM logging_test01.

  DATA ls_log        TYPE bal_s_log.
  DATA ls_log_handle TYPE balloghndl.


  CONSTANTS lc_object    TYPE balobj_d VALUE 'YTEST01'.
  CONSTANTS lc_subobject TYPE balsubobj VALUE 'YSUBTEST_01'.

  ls_log-object    = lc_object.        " object name
  ls_log-subobject = lc_subobject.     " subobject name
  ls_log-aluser    = sy-uname.         " username
  ls_log-alprog    = sy-repid.         " report name

  CALL FUNCTION 'BAL_LOG_CREATE'
    EXPORTING
      i_s_log                 = ls_log
    IMPORTING
      e_log_handle            = ls_log_handle
    EXCEPTIONS
      log_header_inconsistent = 1
      OTHERS                  = 2.

  IF sy-subrc EQ 0.

    DATA lt_log_handle TYPE bal_t_logh.
    DATA ls_msg        TYPE bal_s_msg.
    DATA lv_message1   TYPE symsgv.
    DATA lv_message2   TYPE symsgv.
    DATA lv_message3   TYPE symsgv.
    DATA lv_message4   TYPE symsgv.

    lv_message1 = 'this is for testing!'.

    " Create message
    ls_msg-msgty = 'I'.              " Message type
    ls_msg-msgid = 'Y1'.             " Message id
    ls_msg-msgno = '901'.            " Message number
    ls_msg-msgv1 = lv_message1.      " Text that you want to pass as message
    ls_msg-msgv2 = lv_message2.
    ls_msg-msgv3 = lv_message3.
    ls_msg-msgv4 = lv_message4.
    ls_msg-probclass = 2.

    CALL FUNCTION 'BAL_LOG_MSG_ADD'
      EXPORTING
        i_log_handle     = ls_log_handle
        i_s_msg          = ls_msg
*                   IMPORTING
*       E_S_MSG_HANDLE   =
*       E_MSG_WAS_LOGGED =
*       E_MSG_WAS_DISPLAYED       =
      EXCEPTIONS
        log_not_found    = 1
        msg_inconsistent = 2
        log_is_full      = 3
        OTHERS           = 4.

    IF sy-subrc EQ 0.

      INSERT ls_log_handle INTO TABLE lt_log_handle.

      " save message
      CALL FUNCTION 'BAL_DB_SAVE'
        EXPORTING
          i_client               = sy-mandt
          i_save_all             = abap_true
          i_t_log_handle         = lt_log_handle
        EXCEPTIONS
          log_not_found          = 1
          save_not_allowed       = 2
          numbering_error        = 3
          others                 = 4.

      IF sy-subrc EQ 0.
        REFRESH lt_log_handle.
      ELSE.
        " something went wrong.
      ENDIF.

    ELSE.
      " something went wrong.
    ENDIF.
  ELSE.
    " something went wrong
  ENDIF.

ENDFORM.
