class YCL_FLIGHT definition
  public
  create protected

  global friends YCB_FLIGHT .

public section.

  interfaces IF_OS_STATE .

  methods GET_CARRIER_ID
    returning
      value(RESULT) type /DMO/CARRIER_ID
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods GET_CONNECTION_ID
    returning
      value(RESULT) type /DMO/CONNECTION_ID
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods GET_CURRENCY_CODE
    returning
      value(RESULT) type /DMO/CURRENCY_CODE
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods GET_FLIGHT_DATE
    returning
      value(RESULT) type /DMO/FLIGHT_DATE
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods GET_PLANE_TYPE_ID
    returning
      value(RESULT) type /DMO/PLANE_TYPE_ID
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods GET_PRICE
    returning
      value(RESULT) type /DMO/FLIGHT_PRICE
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods GET_SEATS_MAX
    returning
      value(RESULT) type /DMO/PLANE_SEATS_MAX
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods GET_SEATS_OCCUPIED
    returning
      value(RESULT) type /DMO/PLANE_SEATS_OCCUPIED
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods SET_CURRENCY_CODE
    importing
      !I_CURRENCY_CODE type /DMO/CURRENCY_CODE
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods SET_PLANE_TYPE_ID
    importing
      !I_PLANE_TYPE_ID type /DMO/PLANE_TYPE_ID
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods SET_PRICE
    importing
      !I_PRICE type /DMO/FLIGHT_PRICE
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods SET_SEATS_MAX
    importing
      !I_SEATS_MAX type /DMO/PLANE_SEATS_MAX
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods SET_SEATS_OCCUPIED
    importing
      !I_SEATS_OCCUPIED type /DMO/PLANE_SEATS_OCCUPIED
    raising
      CX_OS_OBJECT_NOT_FOUND .
protected section.

  data CARRIER_ID type /DMO/CARRIER_ID .
  data CONNECTION_ID type /DMO/CONNECTION_ID .
  data FLIGHT_DATE type /DMO/FLIGHT_DATE .
  data PRICE type /DMO/FLIGHT_PRICE .
  data CURRENCY_CODE type /DMO/CURRENCY_CODE .
  data PLANE_TYPE_ID type /DMO/PLANE_TYPE_ID .
  data SEATS_MAX type /DMO/PLANE_SEATS_MAX .
  data SEATS_OCCUPIED type /DMO/PLANE_SEATS_OCCUPIED .
private section.
ENDCLASS.



CLASS YCL_FLIGHT IMPLEMENTATION.


  method GET_CARRIER_ID.
***BUILD 090501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute CARRIER_ID
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = CARRIER_ID.

           " GET_CARRIER_ID
  endmethod.


  method GET_CONNECTION_ID.
***BUILD 090501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute CONNECTION_ID
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = CONNECTION_ID.

           " GET_CONNECTION_ID
  endmethod.


  method GET_CURRENCY_CODE.
***BUILD 090501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute CURRENCY_CODE
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = CURRENCY_CODE.

           " GET_CURRENCY_CODE
  endmethod.


  method GET_FLIGHT_DATE.
***BUILD 090501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute FLIGHT_DATE
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = FLIGHT_DATE.

           " GET_FLIGHT_DATE
  endmethod.


  method GET_PLANE_TYPE_ID.
***BUILD 090501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute PLANE_TYPE_ID
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = PLANE_TYPE_ID.

           " GET_PLANE_TYPE_ID
  endmethod.


  method GET_PRICE.
***BUILD 090501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute PRICE
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = PRICE.

           " GET_PRICE
  endmethod.


  method GET_SEATS_MAX.
***BUILD 090501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute SEATS_MAX
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = SEATS_MAX.

           " GET_SEATS_MAX
  endmethod.


  method GET_SEATS_OCCUPIED.
***BUILD 090501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute SEATS_OCCUPIED
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = SEATS_OCCUPIED.

           " GET_SEATS_OCCUPIED
  endmethod.


  method IF_OS_STATE~GET.
***BUILD 090501
     " returning result type ref to object
************************************************************************
* Purpose        : Get state.
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : -
*
* OO Exceptions  : -
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-07   : (BGR) Initial Version 2.0
************************************************************************
* GENERATED: Do not modify
************************************************************************

  data: STATE_OBJECT type ref to CL_OS_STATE.

  create object STATE_OBJECT.
  call method STATE_OBJECT->SET_STATE_FROM_OBJECT( ME ).
  result = STATE_OBJECT.

  endmethod.


  method IF_OS_STATE~HANDLE_EXCEPTION.
***BUILD 090501
     " importing I_EXCEPTION type ref to IF_OS_EXCEPTION_INFO optional
     " importing I_EX_OS type ref to CX_OS_OBJECT_NOT_FOUND optional
************************************************************************
* Purpose        : Handles exceptions during attribute access.
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : -
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : If an exception is raised during attribut access,
*                  this method is called and the exception is passed
*                  as a paramater. The default is to raise the exception
*                  again, so that the caller can handle the exception.
*                  But it is also possible to handle the exception
*                  here in the callee.
*
************************************************************************
* Changelog:
* - 2000-03-07   : (BGR) Initial Version 2.0
* - 2000-08-02   : (SB)  OO Exceptions
************************************************************************
* Modify if you like
************************************************************************

  if i_ex_os is not initial.
    raise exception i_ex_os.
  endif.

  endmethod.


  method IF_OS_STATE~INIT.
***BUILD 090501
"#EC NEEDED
************************************************************************
* Purpose        : Initialisation of the transient state partition.
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : Transient state is initial.
*
* OO Exceptions  : -
*
* Implementation : Caution!: Avoid Throwing ACCESS Events.
*
************************************************************************
* Changelog:
* - 2000-03-07   : (BGR) Initial Version 2.0
************************************************************************
* Modify if you like
************************************************************************

  endmethod.


  method IF_OS_STATE~INVALIDATE.
***BUILD 090501
"#EC NEEDED
************************************************************************
* Purpose        : Do something before all persistent attributes are
*                  cleared.
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : -
*
* OO Exceptions  : -
*
* Implementation : Whatever you like to do.
*
************************************************************************
* Changelog:
* - 2000-03-07   : (BGR) Initial Version 2.0
************************************************************************
* Modify if you like
************************************************************************

  endmethod.


  method IF_OS_STATE~SET.
***BUILD 090501
     " importing I_STATE type ref to object
************************************************************************
* Purpose        : Set state.
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : -
*
* OO Exceptions  : -
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-07   : (BGR) Initial Version 2.0
************************************************************************
* GENERATED: Do not modify
************************************************************************

  data: STATE_OBJECT type ref to CL_OS_STATE.

  STATE_OBJECT ?= I_STATE.
  call method STATE_OBJECT->SET_OBJECT_FROM_STATE( ME ).

  endmethod.


  method SET_CURRENCY_CODE.
***BUILD 090501
     " importing I_CURRENCY_CODE
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Set attribute CURRENCY_CODE
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, attribute is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
* - 2000-10-04   : (SB)  Namespaces
************************************************************************

* * Inform class agent and handle exceptions
  state_write_access.

  if ( I_CURRENCY_CODE <> CURRENCY_CODE ).

    CURRENCY_CODE = I_CURRENCY_CODE.

*   * Inform class agent and handle exceptions
    state_changed.

  endif. "( I_CURRENCY_CODE <> CURRENCY_CODE )

           " GET_CURRENCY_CODE
  endmethod.


  method SET_PLANE_TYPE_ID.
***BUILD 090501
     " importing I_PLANE_TYPE_ID
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Set attribute PLANE_TYPE_ID
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, attribute is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
* - 2000-10-04   : (SB)  Namespaces
************************************************************************

* * Inform class agent and handle exceptions
  state_write_access.

  if ( I_PLANE_TYPE_ID <> PLANE_TYPE_ID ).

    PLANE_TYPE_ID = I_PLANE_TYPE_ID.

*   * Inform class agent and handle exceptions
    state_changed.

  endif. "( I_PLANE_TYPE_ID <> PLANE_TYPE_ID )

           " GET_PLANE_TYPE_ID
  endmethod.


  method SET_PRICE.
***BUILD 090501
     " importing I_PRICE
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Set attribute PRICE
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, attribute is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
* - 2000-10-04   : (SB)  Namespaces
************************************************************************

* * Inform class agent and handle exceptions
  state_write_access.

  if ( I_PRICE <> PRICE ).

    PRICE = I_PRICE.

*   * Inform class agent and handle exceptions
    state_changed.

  endif. "( I_PRICE <> PRICE )

           " GET_PRICE
  endmethod.


  method SET_SEATS_MAX.
***BUILD 090501
     " importing I_SEATS_MAX
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Set attribute SEATS_MAX
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, attribute is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
* - 2000-10-04   : (SB)  Namespaces
************************************************************************

* * Inform class agent and handle exceptions
  state_write_access.

  if ( I_SEATS_MAX <> SEATS_MAX ).

    SEATS_MAX = I_SEATS_MAX.

*   * Inform class agent and handle exceptions
    state_changed.

  endif. "( I_SEATS_MAX <> SEATS_MAX )

           " GET_SEATS_MAX
  endmethod.


  method SET_SEATS_OCCUPIED.
***BUILD 090501
     " importing I_SEATS_OCCUPIED
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Set attribute SEATS_OCCUPIED
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, attribute is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
* - 2000-10-04   : (SB)  Namespaces
************************************************************************

* * Inform class agent and handle exceptions
  state_write_access.

  if ( I_SEATS_OCCUPIED <> SEATS_OCCUPIED ).

    SEATS_OCCUPIED = I_SEATS_OCCUPIED.

*   * Inform class agent and handle exceptions
    state_changed.

  endif. "( I_SEATS_OCCUPIED <> SEATS_OCCUPIED )

           " GET_SEATS_OCCUPIED
  endmethod.
ENDCLASS.
