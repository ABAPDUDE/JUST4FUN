*&---------------------------------------------------------------------*
*& Report YPERSISTANT_FLIGHT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ypersistant_flight.

*/**
* Test program to Create, Read, Update and Delete from table
* using Persistent Class YCL_FLIGHT YCA_FLIGHT  YCB_FLIGHT
*
*/*
INCLUDE yselscreen_flight.

DATA go_input TYPE REF TO ycl_flight_input.
DATA go_run   TYPE REF TO ycl_flight_processing.

CREATE OBJECT go_input
  EXPORTING
    carrier_id    = p_carrid          " Flight Reference Scenario: Carrier ID
    connection_id = p_connid          " Flight Reference Scenario: Connection ID
    flight_date   = p_fldate          " Flight Reference Scenario: Flight Date
    price         = p_price           " Flight Reference Scenario: Flight Price
*   currency_code =                   " Flight Reference Scenario: Currency Code
*   plane_type_id =                   " Flight Reference Scenario: Plane Type ID
*   seats_max     =                   " Flight Reference Scenario: Plane Seats Max
*   seats_occupied =                  " Flight Reference Scenario: Plane Seats Occupied
    radio_bt_1    = p_rad1           " Reference type for radio buttons
    radio_bt_2    = p_rad2           " Reference type for radio buttons
    radio_bt_3    = p_rad3           " Reference type for radio buttons
    radio_bt_4    = p_rad4.           " Reference type for radio buttons

CREATE OBJECT go_run
  EXPORTING
    input = go_input.                 " input fields Flight

go_run->run_program( ).





DATA lo_flight TYPE REF TO ycl_flight.

TRY .
    lo_flight = yca_flight=>agent->create_persistent(
                  i_carrier_id    = 'AF'
                  i_connection_id = '0102'
                  i_flight_date   = '11092021'
                ).

    CALL METHOD lo_flight->set_price( '1200.00' ).
    CALL METHOD lo_flight->set_currency_code( 'EUR' ).
    CALL METHOD lo_flight->set_plane_type_id( 'CONCORDE' ).
    CALL METHOD lo_flight->set_seats_max( '255' ).
    CALL METHOD lo_flight->set_seats_occupied( '230' ).

    COMMIT WORK.
  CATCH cx_os_object_existing.  " Object Services Exception
ENDTRY.

* update:
* for updation everything remains the same only you need to replace
* the create_persistent method with the get_persistent method
* and the exception will change from cx_os_object_existing
* to cx_os_object_not_found.

TRY.

    lo_flight = yca_flight=>agent->get_persistent(
                  i_carrier_id    = 'JL'
                  i_connection_id = '0407'
                  i_flight_date   = '18092020'
                ).

    CALL METHOD lo_flight->set_plane_type_id( 'A580-900' ).
    CALL METHOD lo_flight->set_seats_max( '510' ).

    COMMIT WORK.

  CATCH cx_os_object_not_found.
ENDTRY.

* READ:
* Code for READ is same as UPDATE, the only change is
* we will use getter METHODS instead of setter METHODS.
DATA ls_flight1 TYPE /dmo/flight.
TRY .
    lo_flight = yca_flight=>agent->get_persistent(
                  i_carrier_id    = 'UA'
                  i_connection_id = '0058'
                  i_flight_date   = '19112019'
                ).

    ls_flight1-price          = lo_flight->get_price( ).
    ls_flight1-seats_occupied = lo_flight->get_seats_occupied( ).
    ls_flight1-seats_max      = lo_flight->get_seats_max( ).
    ls_flight1-plane_type_id  = lo_flight->get_plane_type_id( ).

  CATCH cx_os_object_not_found.
ENDTRY.

* DELETE:
* for deletion use METHOD delete_persistent
* and exception cx_os_object_not_existing.
TRY .
    yca_flight=>agent->delete_persistent(
      EXPORTING
        i_carrier_id    = 'SQ'
        i_connection_id = '0001'
        i_flight_date   = '21112019'
    ).
    COMMIT WORK.

  CATCH cx_os_object_not_existing.
ENDTRY.

* READ Multiple records:
* here instead of using the get_persistent METHOD
* we use the get_persistent_by_query METHOD,
* which will RETURN us the list of objects. each
* record in the database will correspond to an object in the internal table.
DATA lt_obj TYPE osreftab.
DATA ls_obj TYPE osref.
DATA ls_flight2 TYPE /dmo/flight.

TRY .
    lt_obj = yca_flight=>agent->if_os_ca_persistency~get_persistent_by_query(
                  i_par1 = '5%'
                  i_query = cl_os_system=>get_query_manager( )->create_query(
                                    i_filter = 'carrier_id like par1' ) ).


    IF lines( lt_obj ) <> 0.

      LOOP AT lt_obj INTO ls_obj.

        lo_flight ?= ls_obj.

        ls_flight2-carrier_id    = lo_flight->get_carrier_id( ).
        ls_flight2-connection_id = lo_flight->get_connection_id( ).
        ls_flight2-flight_date   = lo_flight->get_flight_date( ).
        ls_flight2-plane_type_id = lo_flight->get_plane_type_id( ).

        WRITE: /
        ls_flight2-carrier_id,
        ls_flight2-connection_id,
        ls_flight2-flight_date,
        ls_flight2-plane_type_id.

      ENDLOOP.

    ENDIF.

  CATCH cx_os_object_not_found.

ENDTRY.
