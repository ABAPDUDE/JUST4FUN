*&---------------------------------------------------------------------*
*& Report YXLS_2_ABAP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT yxls_2_abap.

*/**
* change of plans my Padawan
* we will use a FM to import the excel data into SAP
* the open source ABAP2XLSX on GitHub is actually more suitable for
* moving data in internal tables from SAP to MS Excel!
* But documentation does state that it should work vice versa
*/*

FIELD-SYMBOLS <gt_data> TYPE STANDARD TABLE .
FIELD-SYMBOLS <table>   TYPE STANDARD TABLE.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME .
  PARAMETERS : p_file TYPE sdok_filnm OBLIGATORY
            DEFAULT 'C:\Users\mderksem\Documents\Customers\StarWars\data\sw_movies_excel.xlsx',    " ibipparms-path
               p_ncol TYPE i OBLIGATORY DEFAULT 6.
SELECTION-SCREEN END OF BLOCK b1 .

*--------------------------------------------------------------------*
* at selection screen
*--------------------------------------------------------------------*
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.

  DATA: lv_rc TYPE i.
  DATA: lt_file_table TYPE filetable,
        ls_file_table TYPE file_table.

  CALL METHOD cl_gui_frontend_services=>file_open_dialog
    EXPORTING
      window_title = 'Select a file'
    CHANGING
      file_table   = lt_file_table
      rc           = lv_rc.
  IF sy-subrc = 0.
    READ TABLE lt_file_table INTO ls_file_table INDEX 1.
    p_file = ls_file_table-filename.
  ENDIF.

START-OF-SELECTION .

  PERFORM read_file .
*  PERFORM process_file.

*---------------------------------------------------------------------*
* Form READ_FILE
*---------------------------------------------------------------------*
FORM read_file .

  DATA : lv_filename      TYPE string,
         lt_records       TYPE solix_tab,
         lv_headerxstring TYPE xstring,
         lv_filelength    TYPE i.

  lv_filename = p_file.

  CALL FUNCTION 'GUI_UPLOAD'
    EXPORTING
      filename                = lv_filename
      filetype                = 'BIN'
    IMPORTING
      filelength              = lv_filelength
*     header                  = lv_headerxstring
    TABLES
      data_tab                = lt_records
    EXCEPTIONS
      file_open_error         = 1
      file_read_error         = 2
      no_batch                = 3
      gui_refuse_filetransfer = 4
      invalid_type            = 5
      no_authority            = 6
      unknown_error           = 7
      bad_data_format         = 8
      header_not_allowed      = 9
      separator_not_allowed   = 10
      header_too_long         = 11
      unknown_dp_error        = 12
      access_denied           = 13
      dp_out_of_memory        = 14
      disk_full               = 15
      dp_timeout              = 16
      OTHERS                  = 17.

  " convert binary data to xstring
  " if you are using cl_fdt_xl_spreadsheet in odata then skips this step
  " as excel file will already be in xstring
  CALL FUNCTION 'SCMS_BINARY_TO_XSTRING'
    EXPORTING
      input_length = lv_filelength
    IMPORTING
      buffer       = lv_headerxstring
    TABLES
      binary_tab   = lt_records
    EXCEPTIONS
      failed       = 1
      OTHERS       = 2.

  IF sy-subrc <> 0.
    " Implement suitable error handling here
  ENDIF.

  DATA : lo_excel_ref TYPE REF TO cl_fdt_xl_spreadsheet .

  TRY .
      lo_excel_ref = NEW cl_fdt_xl_spreadsheet(
                              document_name = lv_filename
                              xdocument     = lv_headerxstring ) .
    CATCH cx_fdt_excel_core.
      " Implement suitable error handling here
  ENDTRY .

  " Get List of possible Worksheets
  lo_excel_ref->if_fdt_doc_spreadsheet~get_worksheet_names(
    IMPORTING
      worksheet_names = DATA(lt_worksheets) ).

  IF NOT lt_worksheets IS INITIAL.

    READ TABLE lt_worksheets INTO DATA(lv_woksheetname) INDEX 1.

    DATA(lo_data_ref) = lo_excel_ref->if_fdt_doc_spreadsheet~get_itab_from_worksheet(
                                             lv_woksheetname ).
    " now you have excel work sheet data in dyanmic internal table
    ASSIGN lo_data_ref->* TO <gt_data>.

*    PERFORM build_table.

    TRY.
* Dummy für Datadescriptor
        DATA: lv_revenue TYPE zsw_movie-revenue.

* Komponenten (Spalten) der Tabelle
        DATA(it_components) = VALUE cl_abap_structdescr=>component_table(
* Erzeugung über direkte Typangabe, abgeleitet aus dem Typ des eigentlichen Datenelements
* CHAR 12
                                                                          (
                                                                            name = 'CUSTMOVIEID'
                                                                            type = cl_abap_elemdescr=>get_c( 12 )
                                                                          )
* CHAR 30
                                                                          (
                                                                            name = 'FILMNAME'
                                                                            type = cl_abap_elemdescr=>get_c( 30 )
                                                                          )
* Erzeugung über Namen des Datenelements
                                                                          (
                                                                            name = 'EPISODE'
                                                                            type = CAST #( cl_abap_elemdescr=>describe_by_name( 'Z_EPISODE' ) )
                                                                          )
* Erzeugung über Namen des Datenelements
                                                                          (
                                                                            name = 'SWDATE'
                                                                            type = CAST #( cl_abap_elemdescr=>describe_by_name( 'Z_DATE' ) )
                                                                          )
* Erzeugung über Namen des Datenelements
                                                                          (
                                                                            name = 'HEADNAME'
                                                                            type = CAST #( cl_abap_elemdescr=>describe_by_name( 'Z_HEADNAME' ) )
                                                                          )
* Erzeugung über Dummy-Datenobjekt
                                                                          (
                                                                            name = 'REVENUE'
                                                                            type = CAST #( cl_abap_datadescr=>describe_by_data( lv_revenue ) )
                                                                          )
                                                                        ).

* Strukturdeskriptor für Komponententabelle
        DATA(o_struct_desc) = cl_abap_structdescr=>create( it_components ).

* Tabellendeskriptor
        DATA(o_table_desc) = cl_abap_tabledescr=>create(
                                                         p_line_type  = o_struct_desc                       " Spalten
                                                         p_table_kind = cl_abap_tabledescr=>tablekind_std   " Tabellentyp STANDARD TABLE
                                                         p_unique     = abap_false                          " NON-UNIQUE KEY
                                                         p_key        = VALUE #(                            " CUSTMOVIEID KEY
                                                                                 ( name = 'CUSTMOVIEID' )
                                                                               )
                                                         p_key_kind   = cl_abap_tabledescr=>keydefkind_user " Benutzerdefinierter Schlüssel
                                                       ).

        " Table objekt based on Table descriptors
        DATA: o_table TYPE REF TO data.
        CREATE DATA o_table TYPE HANDLE o_table_desc.
        " Fieldsymbol for the Table objekt
        " FIELD-SYMBOLS <table> TYPE standard TABLE.
        ASSIGN o_table->* TO <table>.

* Daten holen und in Feldsymbol schreiben
*    SELECT carrid, connid, carrname, fldate FROM sflights INTO CORRESPONDING FIELDS OF TABLE @<table>.

* Datenausgabe
*   cl_demo_output=>display( <table> ).

      CATCH cx_root INTO DATA(e_txt).
        WRITE: / e_txt->get_text( ).
    ENDTRY.

*/---

    ASSIGN lo_data_ref->* TO <gt_data>.
    " delete column headers
    DELETE <gt_data> INDEX 1.


    FIELD-SYMBOLS <dyn_wa2>.
    DATA dy_line2  TYPE REF TO data.
    CREATE DATA dy_line2 LIKE LINE OF <table>.
    ASSIGN dy_line2->* TO <dyn_wa2>.


    FIELD-SYMBOLS <dyn_wa>.
    FIELD-SYMBOLS <dyn_field>.

    DATA dy_line  TYPE REF TO data.
    CREATE DATA dy_line LIKE LINE OF <gt_data>.
    ASSIGN dy_line->* TO <dyn_wa>.


    DATA: lt_movie_insert TYPE STANDARD TABLE OF zsw_movie.
    DATA: lt_movie_update TYPE STANDARD TABLE OF zsw_movie.
    DATA: lt_movie TYPE STANDARD TABLE OF zsw_movie.
    FIELD-SYMBOLS: <fs_movie> TYPE zsw_movie.

    LOOP AT <gt_data> INTO <dyn_wa>.

      APPEND INITIAL LINE TO lt_movie ASSIGNING <fs_movie>.
      IF <fs_movie> IS ASSIGNED.
        ASSIGN COMPONENT 'A' OF STRUCTURE <dyn_wa> TO <dyn_field>.
        <fs_movie>-custmovieid = <dyn_field>.
        ASSIGN COMPONENT 'B' OF STRUCTURE <dyn_wa> TO <dyn_field>.
        <fs_movie>-filmname    = <dyn_field>.
        ASSIGN COMPONENT 'C' OF STRUCTURE <dyn_wa> TO <dyn_field>.
        <fs_movie>-episode     = <dyn_field>.
         ASSIGN COMPONENT 'D' OF STRUCTURE <dyn_wa> TO <dyn_field>.
        <fs_movie>-swdate      = <dyn_field>.
        ASSIGN COMPONENT 'E' OF STRUCTURE <dyn_wa> TO <dyn_field>.
        <fs_movie>-headname    = <dyn_field>.
        ASSIGN COMPONENT 'F' OF STRUCTURE <dyn_wa> TO <dyn_field>.
        <fs_movie>-revenue     = <dyn_field>.

        <fs_movie>-currency = 'EUR'.
*       <fs_movie>-movieid  = me->get_next_id_nr( ).  " functional method

        UNASSIGN <fs_movie>.
      ENDIF.

    ENDLOOP.

    DATA(lv_lines) = lines( lt_movie ).
    IF lv_lines GE 1.
      " check if entries already exist in database table ZSW_MOVIE
      " based on CUSTMOVIEID

      " if entry exist this is a required update of the data and we need
      " to take this line out of internal table LT_MOVIE
      "and put it in a new internal table: LT_MOVIE_UPDATE

      " we will then update the already existing line in the database
      " instead of inserting a new line whih would lead to duplicate entries

      DATA(lv_lines_u) = lines( lt_movie_update ).
      IF lv_lines_u GE 1.
        UPDATE zsw_movie FROM TABLE lt_movie_update.
      ENDIF.

      DATA(lv_lines_i) = lines( lt_movie_insert ).
      IF lv_lines_i GE 1.
        INSERT zsw_movie FROM TABLE lt_movie_insert.
      ENDIF.

    ENDIF.

    " displaying data
    LOOP AT <gt_data> INTO <dyn_wa>.
      DO.
        ASSIGN COMPONENT  sy-index
           OF STRUCTURE <dyn_wa> TO <dyn_field>.
        IF sy-subrc <> 0.
          EXIT.
        ENDIF.
        IF sy-index = 1.
          WRITE:/ <dyn_field>.
        ELSE.
          WRITE: <dyn_field>.
        ENDIF.
      ENDDO.
    ENDLOOP.

  ENDIF.

ENDFORM.

*---------------------------------------------------------------------*
* Form PROCESS_FILE
*---------------------------------------------------------------------*
FORM process_file .

  DATA : lv_numberofcolumns   TYPE i,
         lv_date_string       TYPE string,
         lv_target_date_field TYPE datum.


  FIELD-SYMBOLS : <ls_data>  TYPE any,
                  <lv_field> TYPE any.

  "you could find out number of columns dynamically from table <gt_data>
  lv_numberofcolumns = p_ncol .

  LOOP AT <table> ASSIGNING <ls_data> FROM 1 .  " TODO: column header or not to be included?

    IF sy-tabix = 1.
      DATA(lv_pass_over) = abap_true.
    ELSE.
    ENDIF.

    " processing columns
    DO lv_numberofcolumns TIMES.
      ASSIGN COMPONENT sy-index OF STRUCTURE <ls_data> TO <lv_field> .
      IF sy-subrc = 0 .
        CASE sy-index .
*         WHEN 1 .
*         WHEN 2 .
          WHEN 3 .
            IF lv_pass_over EQ abap_true.
              " do nothing.
              CLEAR lv_pass_over.
              WRITE : <lv_field> .
            ELSE.
              lv_date_string = <lv_field> .
              PERFORM date_convert USING lv_date_string CHANGING lv_target_date_field .
              WRITE lv_target_date_field .
            ENDIF.
          WHEN OTHERS.
            WRITE : <lv_field> .
        ENDCASE .
      ENDIF.
    ENDDO .
    NEW-LINE .
  ENDLOOP .
ENDFORM.

*---------------------------------------------------------------------*
* Form DATE_CONVERT
*---------------------------------------------------------------------*
FORM date_convert USING iv_date_string TYPE string CHANGING cv_date TYPE datum .

  DATA: lv_convert_date(10) TYPE c.

  lv_convert_date = iv_date_string .

  "date format YYYY/MM/DD
  FIND REGEX '^\d{4}[/|-]\d{1,2}[/|-]\d{1,2}$' IN lv_convert_date.
  IF sy-subrc = 0.
    CALL FUNCTION '/SAPDMC/LSM_DATE_CONVERT'
      EXPORTING
        date_in             = lv_convert_date
        date_format_in      = 'DYMD'
        to_output_format    = ' '
        to_internal_format  = 'X'
      IMPORTING
        date_out            = lv_convert_date
      EXCEPTIONS
        illegal_date        = 1
        illegal_date_format = 2
        no_user_date_format = 3
        OTHERS              = 4.
  ELSE.

    " date format DD/MM/YYYY
    FIND REGEX '^\d{1,2}[/|-]\d{1,2}[/|-]\d{4}$' IN lv_convert_date.
    IF sy-subrc = 0.
      CALL FUNCTION '/SAPDMC/LSM_DATE_CONVERT'
        EXPORTING
          date_in             = lv_convert_date
          date_format_in      = 'DDMY'
          to_output_format    = ' '
          to_internal_format  = 'X'
        IMPORTING
          date_out            = lv_convert_date
        EXCEPTIONS
          illegal_date        = 1
          illegal_date_format = 2
          no_user_date_format = 3
          OTHERS              = 4.
    ENDIF.

  ENDIF.

  IF sy-subrc = 0.
    cv_date = lv_convert_date .
  ENDIF.

ENDFORM .
*&---------------------------------------------------------------------*
*& Form build_table
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM build_table.

  TRY.
* Dummy für Datadescriptor
      DATA: lv_revenue TYPE zsw_movie-revenue.

* Komponenten (Spalten) der Tabelle
      DATA(it_components) = VALUE cl_abap_structdescr=>component_table(
* Erzeugung über direkte Typangabe, abgeleitet aus dem Typ des eigentlichen Datenelements
* CHAR 12
                                                                        (
                                                                          name = 'CUSTMOVIEID'
                                                                          type = cl_abap_elemdescr=>get_c( 12 )
                                                                        )
* CHAR 30
                                                                        (
                                                                          name = 'FILMNAME'
                                                                          type = cl_abap_elemdescr=>get_c( 30 )
                                                                        )
* Erzeugung über Namen des Datenelements
                                                                        (
                                                                          name = 'EPISODE'
                                                                          type = CAST #( cl_abap_elemdescr=>describe_by_name( 'Z_EPISODE' ) )
                                                                        )
* Erzeugung über Namen des Datenelements
                                                                        (
                                                                          name = 'SWDATE'
                                                                          type = CAST #( cl_abap_elemdescr=>describe_by_name( 'Z_DATE' ) )
                                                                        )
* Erzeugung über Namen des Datenelements
                                                                        (
                                                                          name = 'HEADNAME'
                                                                          type = CAST #( cl_abap_elemdescr=>describe_by_name( 'Z_HEADNAME' ) )
                                                                        )
* Erzeugung über Dummy-Datenobjekt
                                                                        (
                                                                          name = 'REVENUE'
                                                                          type = CAST #( cl_abap_datadescr=>describe_by_data( lv_revenue ) )
                                                                        )
                                                                      ).

* Strukturdeskriptor für Komponententabelle
      DATA(o_struct_desc) = cl_abap_structdescr=>create( it_components ).

* Tabellendeskriptor
      DATA(o_table_desc) = cl_abap_tabledescr=>create(
                                                       p_line_type  = o_struct_desc                       " Spalten
                                                       p_table_kind = cl_abap_tabledescr=>tablekind_std   " Tabellentyp STANDARD TABLE
                                                       p_unique     = abap_false                          " NON-UNIQUE KEY
                                                       p_key        = VALUE #(                            " CUSTMOVIEID KEY
                                                                               ( name = 'CUSTMOVIEID' )
                                                                             )
                                                       p_key_kind   = cl_abap_tabledescr=>keydefkind_user " Benutzerdefinierter Schlüssel
                                                     ).

* Tabellenobjekt anhand des Tabellendeskriptors erstellen
      DATA: o_table TYPE REF TO data.
      CREATE DATA o_table TYPE HANDLE o_table_desc.

* Feldsymbol auf das Tabellenobjekt
      FIELD-SYMBOLS <table> TYPE ANY TABLE.
      ASSIGN o_table->* TO <table>.

* Daten holen und in Feldsymbol schreiben
*    SELECT carrid, connid, carrname, fldate FROM sflights INTO CORRESPONDING FIELDS OF TABLE @<table>.

* Datenausgabe
*   cl_demo_output=>display( <table> ).

    CATCH cx_root INTO DATA(e_txt).
      WRITE: / e_txt->get_text( ).
  ENDTRY.

ENDFORM.
