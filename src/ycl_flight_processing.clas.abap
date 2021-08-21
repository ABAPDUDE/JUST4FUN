class YCL_FLIGHT_PROCESSING definition
  public
  create public .

public section.

  data MO_INPUT type ref to YCL_FLIGHT_INPUT .

  methods CONSTRUCTOR
    importing
      !INPUT type ref to YCL_FLIGHT_INPUT .
  methods RUN_PROGRAM .
protected section.
private section.

  methods ADD_LINE_TO_TABLE .
ENDCLASS.



CLASS YCL_FLIGHT_PROCESSING IMPLEMENTATION.


  METHOD add_line_to_table.

    DATA lo_flight TYPE REF TO ycl_flight.

    TRY .
        lo_flight = yca_flight=>agent->create_persistent(
                      i_carrier_id    = me->mo_input->mv_carrier_id
                      i_connection_id = me->mo_input->mv_connection_id
                      i_flight_date   = me->mo_input->mv_flight_date
                    ).

        CALL METHOD lo_flight->set_price( me->mo_input->mv_price ).
        CALL METHOD lo_flight->set_currency_code( me->mo_input->mv_curcode ).
        CALL METHOD lo_flight->set_plane_type_id( me->mo_input->mv_planetype ).
        CALL METHOD lo_flight->set_seats_max( me->mo_input->mv_seats_max ).
        CALL METHOD lo_flight->set_seats_occupied( me->mo_input->mv_seats_occ ).

        COMMIT WORK.
      CATCH cx_os_object_existing.  " Object Services Exception
    ENDTRY.


  ENDMETHOD.


  METHOD constructor.

    me->mo_input = input.

  ENDMETHOD.


  METHOD run_program.

    IF me->mo_input->mv_add_line EQ abap_true.

      me->add_line_to_table( ).

    ENDIF.

  ENDMETHOD.
ENDCLASS.
