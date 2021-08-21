*&---------------------------------------------------------------------*
*& Report YDYNAMIC_ITAB_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ydynamic_itab_02_sw.

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
    cl_demo_output=>display( <table> ).

  CATCH cx_root INTO DATA(e_txt).
    WRITE: / e_txt->get_text( ).
ENDTRY.
