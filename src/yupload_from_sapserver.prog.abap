*&---------------------------------------------------------------------*
*& Report YUPLOAD_FROM_SAPSERVER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT yupload_from_sapserver.

CONSTANTS lco_dirname_starwars TYPE dirname VALUE 'DIR_STARWARS'.

SELECT SINGLE dirname
  FROM user_dir INTO
  @DATA(path) WHERE aliass = @lco_dirname_starwars.

IF sy-subrc IS INITIAL.
  "message succesfull
ELSE.
  "message unsuccesfull
ENDIF.
