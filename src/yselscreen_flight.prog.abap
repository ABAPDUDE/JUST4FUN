*&---------------------------------------------------------------------*
*& Include          YSELSCREEN_FLIGHT
*&---------------------------------------------------------------------*


  SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

    SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
      PARAMETERS p_rad1 RADIOBUTTON GROUP grp1 DEFAULT 'X'.
      PARAMETERS p_rad2 RADIOBUTTON GROUP grp1.
      PARAMETERS p_rad3 RADIOBUTTON GROUP grp1.
      PARAMETERS p_rad4 RADIOBUTTON GROUP grp1.
    SELECTION-SCREEN END OF BLOCK b2.

*    SELECT-OPTIONS so_carr FOR gs_spfli-carrid,
*   SELECT-OPTIONS so_conn FOR gs_spfli-connid.
    PARAMETERS p_carrid TYPE /dmo/carrier_id.
    PARAMETERS p_connid	TYPE /dmo/connection_id.
    PARAMETERS p_fldate TYPE /dmo/flight_date.
    PARAMETERS p_price  TYPE /dmo/flight_price.
    PARAMETERS p_curcod TYPE /dmo/currency_code.
    PARAMETERS p_planet TYPE /dmo/plane_type_id.
    PARAMETERS p_seatsm TYPE /dmo/plane_seats_max.
    PARAMETERS p_seatso TYPE /dmo/plane_seats_occupied.

  SELECTION-SCREEN END OF BLOCK b1.
