class YCA_FLIGHT definition
  public
  inheriting from YCB_FLIGHT
  final
  create private .

public section.

  class-data AGENT type ref to YCA_FLIGHT read-only .

  class-methods CLASS_CONSTRUCTOR .
protected section.
private section.
ENDCLASS.



CLASS YCA_FLIGHT IMPLEMENTATION.


  method CLASS_CONSTRUCTOR.
***BUILD 090501
************************************************************************
* Purpose        : Initialize the 'class'.
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : Singleton is created.
*
* OO Exceptions  : -
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 1999-09-20   : (OS) Initial Version
* - 2000-03-06   : (BGR) 2.0 modified REGISTER_CLASS_AGENT
************************************************************************
* GENERATED: Do not modify
************************************************************************

  create object AGENT.

  call method AGENT->REGISTER_CLASS_AGENT
    exporting
      I_CLASS_NAME          = 'YCL_FLIGHT'
      I_CLASS_AGENT_NAME    = 'YCA_FLIGHT'
      I_CLASS_GUID          = '0242AC1100021EDBB9B5CF6974D372F4'
      I_CLASS_AGENT_GUID    = '0242AC1100021EDBB9B5CF916DBDF2F4'
      I_AGENT               = AGENT
      I_STORAGE_LOCATION    = '/DMO/FLIGHT'
      I_CLASS_AGENT_VERSION = '2.0'.

           "CLASS_CONSTRUCTOR
  endmethod.
ENDCLASS.
