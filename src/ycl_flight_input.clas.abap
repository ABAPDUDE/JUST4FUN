class YCL_FLIGHT_INPUT definition
  public
  final
  create public .

public section.

  data MV_CARRIER_ID type /DMO/CARRIER_ID .
  data MV_CONNECTION_ID type /DMO/CONNECTION_ID .
  data MV_FLIGHT_DATE type /DMO/FLIGHT_DATE .
  data MV_PRICE type /DMO/FLIGHT_PRICE .
  data MV_CURCODE type /DMO/CURRENCY_CODE .
  data MV_PLANETYPE type /DMO/PLANE_TYPE_ID .
  data MV_SEATS_MAX type /DMO/PLANE_SEATS_MAX .
  data MV_SEATS_OCC type /DMO/PLANE_SEATS_OCCUPIED .
  data MV_ADD_LINE type SEU_RADIOB .
  data MV_DELETE_LINE type SEU_RADIOB .
  data MV_MODIFY_LINE type SEU_RADIOB .
  data MV_READ_LINE type SEU_RADIOB .

  methods CONSTRUCTOR
    importing
      !CARRIER_ID type /DMO/CARRIER_ID
      !CONNECTION_ID type /DMO/CONNECTION_ID
      !FLIGHT_DATE type /DMO/FLIGHT_DATE
      !PRICE type /DMO/FLIGHT_PRICE optional
      !CURRENCY_CODE type /DMO/CURRENCY_CODE optional
      !PLANE_TYPE_ID type /DMO/PLANE_TYPE_ID optional
      !SEATS_MAX type /DMO/PLANE_SEATS_MAX optional
      !SEATS_OCCUPIED type /DMO/PLANE_SEATS_OCCUPIED optional
      !RADIO_BT_1 type SEU_RADIOB optional
      !RADIO_BT_2 type SEU_RADIOB
      !RADIO_BT_3 type SEU_RADIOB
      !RADIO_BT_4 type SEU_RADIOB .
protected section.
private section.
ENDCLASS.



CLASS YCL_FLIGHT_INPUT IMPLEMENTATION.


  METHOD constructor.

    me->mv_carrier_id    = carrier_id.
    me->mv_connection_id = connection_id.
    me->mv_flight_date   = flight_date.
    me->mv_price         = price.
    me->mv_curcode       = currency_code.
    me->mv_planetype     = plane_type_id.
    me->mv_seats_occ     = seats_max.
    me->mv_seats_occ     = seats_occupied.

    me->mv_add_line = radio_bt_1.
    me->mv_delete_line = radio_bt_2.
    me->mv_modify_line = radio_bt_3.
    me->mv_read_line = radio_bt_4.

  ENDMETHOD.
ENDCLASS.
