CLASS zcl_rkc_generator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_rkc_generator IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA Employees TYPE TABLE OF zRKC_EMP.
    DATA maier TYPE zRKC_EMP.
    DATA mueller TYPE zRKC_EMP.
    DATA schmid TYPE zRKC_EMP.


    DATA VacationEntitlements TYPE TABLE OF zrkc_vacent.
    DATA VacationEntitlement TYPE zrkc_vacent.

    DATA VacationRequests TYPE TABLE OF zrkc_Vacreq.
    DATA VacationRequest TYPE zrkc_Vacreq.


    DELETE FROM zRKC_EMP.
    DELETE FROM zrkc_vacent.
    DELETE FROM zrkc_vacreq.

    " Hans Maier "

    maier-client = sy-mandt.
    maier-id = cl_system_uuid=>create_uuid_x16_static( ) .
    maier-employee_number = 1.
    maier-first_name      = 'Hans'.
    maier-last_name       = 'Maier'.
    maier-entry_date      = '20000501'.
    maier-created_by      = 'KH'.
    GET TIME STAMP FIELD maier-created_at.
    maier-last_changed_by = 'KH'.
    GET TIME STAMP FIELD maier-last_changed_at.
    APPEND maier TO Employees.

    "Lisa Müller"

    mueller-client = sy-mandt.
    mueller-id = cl_system_uuid=>create_uuid_x16_static( ) .
    mueller-employee_number = 2.
    mueller-first_name      = 'Lisa'.
    mueller-last_name       = 'Müller'.
    mueller-entry_date      = '20100701'.
    mueller-created_by      = 'KH'.
    GET TIME STAMP FIELD mueller-created_at.
    mueller-last_changed_by = 'KH'.
    GET TIME STAMP FIELD mueller-last_changed_at.
    APPEND mueller TO Employees.

    "Petra Schmid"

    schmid-client = sy-mandt.
    schmid-id = cl_system_uuid=>create_uuid_x16_static( ) .
    schmid-employee_number = 3.
    schmid-first_name      = 'Petra'.
    schmid-last_name        = 'Schmid'.
    schmid-entry_date      = '20221001'.
    schmid-created_by      = 'KH'.
    GET TIME STAMP FIELD schmid-created_at.
    schmid-last_changed_by = 'KH'.
    GET TIME STAMP FIELD schmid-last_changed_at.
    APPEND schmid TO Employees.

    "Hans Maier"
    VacationEntitlement-client = sy-mandt.
    GET TIME STAMP FIELD VacationEntitlement-created_at.
    GET TIME STAMP FIELD VacationEntitlement-last_changed_at.
    VacationEntitlement-created_by = 'RR'.
    VacationEntitlement-last_changed_by = 'RR'.
    VacationEntitlement-id = cl_system_uuid=>create_uuid_x16_static( ).
    VacationEntitlement-year_ = 2022.
    VacationEntitlement-vacation_days = 30.
    VacationEntitlement-employee = maier-id.
    APPEND VacationEntitlement TO VacationEntitlements.

    "Hans Maier"
    VacationEntitlement-client = sy-mandt.
    GET TIME STAMP FIELD VacationEntitlement-created_at.
    GET TIME STAMP FIELD VacationEntitlement-last_changed_at.
    VacationEntitlement-created_by = 'RR'.
    VacationEntitlement-last_changed_by = 'RR'.
    VacationEntitlement-id = cl_system_uuid=>create_uuid_x16_static( ).
    VacationEntitlement-year_ = 2023.
    VacationEntitlement-vacation_days = 30.
    VacationEntitlement-employee = maier-id.
    APPEND VacationEntitlement TO VacationEntitlements.

    "Hans Maier Applicant"
    VacationRequest-client = sy-mandt.
    GET TIME STAMP FIELD VacationRequest-created_at.
    VacationRequest-created_by = 'KH'.
    VacationRequest-id = cl_system_uuid=>create_uuid_x16_static( ).
    GET TIME STAMP FIELD VacationRequest-last_changed_at.
    VacationRequest-last_changed_by = 'KH'.
    VacationRequest-applicant = maier-id.
    VacationRequest-approver = mueller-id.
    VacationRequest-comment_ = 'Sommerurlaub'.
    VacationRequest-end_date = '20220710'.
    VacationRequest-start_date = '20220701'.
    VacationRequest-status = 'G'.
    VacationRequest-vacationreqdays = 6.
    APPEND VacationRequest TO VacationRequests.

    "Hans Maier"
    VacationRequest-client = sy-mandt.
    GET TIME STAMP FIELD VacationRequest-created_at.
    VacationRequest-created_by = 'KH'.
    VacationRequest-id = cl_system_uuid=>create_uuid_x16_static( ).
    GET TIME STAMP FIELD VacationRequest-last_changed_at.
    VacationRequest-last_changed_by = 'KH'.
    VacationRequest-applicant = maier-id.
    VacationRequest-approver = mueller-id.
    VacationRequest-comment_ = 'Weihnachtsurlaub'.
    VacationRequest-end_date = '20221230'.
    VacationRequest-start_date = '20221227'.
    VacationRequest-status = 'A'.
    VacationRequest-vacationreqdays = 4.
    APPEND VacationRequest TO VacationRequests.

    "Hans Maier"
    VacationRequest-client = sy-mandt.
    GET TIME STAMP FIELD VacationRequest-created_at.
    VacationRequest-created_by = 'KH'.
    VacationRequest-id = cl_system_uuid=>create_uuid_x16_static( ).
    GET TIME STAMP FIELD VacationRequest-last_changed_at.
    VacationRequest-last_changed_by = 'KH'.
    VacationRequest-applicant = maier-id.
    VacationRequest-approver = mueller-id.
    VacationRequest-comment_ = 'Weihnachtsurlaub (2. Versuch)'.
    VacationRequest-end_date = '20221230'.
    VacationRequest-start_date = '20221228'.
    VacationRequest-status = 'G'.
    VacationRequest-vacationreqdays = 3.
    APPEND VacationRequest TO VacationRequests.

    "Hans Maier"
    VacationRequest-client = sy-mandt.
    GET TIME STAMP FIELD VacationRequest-created_at.
    VacationRequest-created_by = 'KH'.
    VacationRequest-id = cl_system_uuid=>create_uuid_x16_static( ).
    GET TIME STAMP FIELD VacationRequest-last_changed_at.
    VacationRequest-last_changed_by = 'KH'.
    VacationRequest-applicant = maier-id.
    VacationRequest-approver = mueller-id.
    VacationRequest-comment_ = ''.
    VacationRequest-end_date = '20230614'.
    VacationRequest-start_date = '20230527'.
    VacationRequest-status = 'G'.
    VacationRequest-vacationreqdays = 12.
    APPEND VacationRequest TO VacationRequests.

    "Hans Maier
    VacationRequest-client = sy-mandt.
    GET TIME STAMP FIELD VacationRequest-created_at.
    VacationRequest-created_by = 'RR'.
    VacationRequest-id = cl_system_uuid=>create_uuid_x16_static( ).
    GET TIME STAMP FIELD VacationRequest-last_changed_at.
    VacationRequest-last_changed_by = 'RR'.
    VacationRequest-applicant = maier-id.
    VacationRequest-approver = mueller-id.
    VacationRequest-comment_ = 'Winterurlaub'.
    VacationRequest-end_date = '20231231'.
    VacationRequest-start_date = '20231220'.
    VacationRequest-status = 'B'.
    VacationRequest-vacationreqdays = 6.
    APPEND VacationRequest TO VacationRequests.


    "Lisa Müller Entitlement"
    VacationEntitlement-client = sy-mandt.
    GET TIME STAMP FIELD VacationEntitlement-created_at.
    GET TIME STAMP FIELD VacationEntitlement-last_changed_at.
    VacationEntitlement-created_by = 'RR'.
    VacationEntitlement-last_changed_by = 'RR'.
    VacationEntitlement-id = cl_system_uuid=>create_uuid_x16_static( ).
    VacationEntitlement-year_ = 2023.
    VacationEntitlement-vacation_days = 30.
    VacationEntitlement-employee = mueller-id.
    APPEND VacationEntitlement TO VacationEntitlements.

    "Petra Schmid Entitlement"
    VacationEntitlement-client = sy-mandt.
    GET TIME STAMP FIELD VacationEntitlement-created_at.
    GET TIME STAMP FIELD VacationEntitlement-last_changed_at.
    VacationEntitlement-created_by = 'RR'.
    VacationEntitlement-last_changed_by = 'RR'.
    VacationEntitlement-id = cl_system_uuid=>create_uuid_x16_static( ).
    VacationEntitlement-year_ = 2023.
    VacationEntitlement-vacation_days = 7.
    VacationEntitlement-employee = schmid-id.
    APPEND VacationEntitlement TO VacationEntitlements.

    "Petra Schmid Request"
    VacationRequest-client = sy-mandt.
    GET TIME STAMP FIELD VacationRequest-created_at.
    VacationRequest-created_by = 'KH'.
    VacationRequest-id = cl_system_uuid=>create_uuid_x16_static( ).
    GET TIME STAMP FIELD VacationRequest-last_changed_at.
    VacationRequest-last_changed_by = 'KH'.
    VacationRequest-approver = maier-id.
    VacationRequest-applicant = schmid-id.
    VacationRequest-comment_ = 'Weihnachtsurlaub'.
    VacationRequest-end_date = '20231231'.
    VacationRequest-start_date = '20231227'.
    VacationRequest-status = 'B'.
    VacationRequest-vacationreqdays = 3.
    APPEND VacationRequest TO VacationRequests.

    " DBT für Mitarbeiter befüllen "
    INSERT zrkc_emp FROM TABLE @Employees.
    INSERT zrkc_vacent FROM TABLE @VacationEntitlements.
    INSERT zrkc_vacreq FROM TABLE @VacationRequests.


  ENDMETHOD.
ENDCLASS.
