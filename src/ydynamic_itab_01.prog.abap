*&---------------------------------------------------------------------*
*& Report YDYNAMIC_ITAB_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ydynamic_itab_01.

TRY.
* Strukturdeskriptor für Komponenten (Spalten) der Tabelle anhand einer vorhandenen Struktur erzeugen
    DATA(o_struct_desc) = cl_abap_structdescr=>describe_by_name( 'SFLIGHTS' ).

* Tabellendeskriptor
    DATA(o_table_desc) = cl_abap_tabledescr=>create(
                                                     p_line_type  = CAST #( o_struct_desc )           " Spalten
                                                     p_table_kind = cl_abap_tabledescr=>tablekind_std " Tabellentyp STANDARD TABLE
                                                     p_unique     = abap_false                        " NON-UNIQUE KEY
                                                   ).

* Tabellenobjekt anhand des Tabellendeskriptors erstellen
    DATA: o_table TYPE REF TO data.
    CREATE DATA o_table TYPE HANDLE o_table_desc.

* Feldsymbol auf das Tabellenobjekt
    FIELD-SYMBOLS <table> TYPE ANY TABLE.
    ASSIGN o_table->* TO <table>.

* Daten holen und in Feldsymbol schreiben
    SELECT carrid, connid, carrname, fldate FROM sflights INTO CORRESPONDING FIELDS OF TABLE @<table>.

* Datenausgabe
    cl_demo_output=>display( <table> ).

  CATCH cx_root INTO DATA(e_txt).
    WRITE: / e_txt->get_text( ).
ENDTRY.
