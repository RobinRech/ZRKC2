CLASS lhc_Employee DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Employee RESULT result.

      METHODS get_instance_authorizations_2 FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR VacationRequest RESULT result.

    METHODS ApproveVacReq FOR MODIFY
      IMPORTING keys FOR ACTION VacationRequest~ApproveVacReq RESULT result.

    METHODS DeclineVacReq FOR MODIFY
      IMPORTING keys FOR ACTION VacationRequest~DeclineVacReq RESULT result.

    "Define the status of the request
       METHODS DetermineVacReqStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR VacationRequest~DetermineVacReqStatus.


      "Validates whether the end date is before the start date."
      METHODS ValidateIfEndBeforeBegin FOR VALIDATE ON SAVE
      IMPORTING keys FOR VacationRequest~ValidateIfEndBeforeBegin.

      "Once an already approved request is modified (updated), it is reset to 'Requested' status."
      METHODS DetermineVacReqStatusWhenEdit FOR DETERMINE ON MODIFY
      IMPORTING keys FOR VacationRequest~DetermineVacReqStatusWhenEdit.

      METHODS DetermineVacationDays FOR DETERMINE ON MODIFY
      IMPORTING keys FOR VacationRequest~DetermineVacationDays.



ENDCLASS.


CLASS lhc_Employee IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD ApproveVacReq.

    DATA message TYPE REF TO zcm_rkc_vacreq.

    "Read selected vacations request which should be approved"
    READ ENTITY IN LOCAL MODE zr_rkc_vacreq
    "Required Fields -> Status has to change"
    FIELDS ( VacReqStatus VacReqComment )
    WITH CORRESPONDING #( keys )
    RESULT DATA(VacationRequests).

    "Process VacationRequests"
    LOOP AT VacationRequests REFERENCE INTO DATA(VacationRequest).

    "Validate Status and create Error
    IF VacationRequest->VacReqStatus = 'G'.
        "Presentation for error message."
        message = NEW zcm_rkc_vacreq(
       severity = if_abap_behv_message=>severity-error
        textid = zcm_rkc_vacreq=>already_approved_VacReq2
                               VacReqComment = VacationRequest->VacReqComment ).
        APPEND VALUE #( %tky = VacationRequest->%tky
                        %element = VALUE #(  VacReqStatus = if_abap_behv=>mk-on )
                        %msg = message ) TO reported-vacationrequest.
        APPEND VALUE #( %tky = VacationRequest->%tky ) TO failed-vacationrequest.
        DELETE VacationRequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      "Validate Status and create Error
    IF VacationRequest->VacReqStatus = 'A'.
        "Presentation for error message."
        message = NEW zcm_rkc_vacreq(
       severity = if_abap_behv_message=>severity-error
        textid = zcm_rkc_vacreq=>already_declined_VacReq2
                               VacReqComment = VacationRequest->VacReqComment ).
        APPEND VALUE #( %tky = VacationRequest->%tky
                        %element = VALUE #(  VacReqStatus = if_abap_behv=>mk-on )
                        %msg = message ) TO reported-vacationrequest.
        APPEND VALUE #( %tky = VacationRequest->%tky ) TO failed-vacationrequest.
        DELETE VacationRequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      "set status on approved and receive a success message"
      vacationrequest->VacReqStatus = 'G'.
      message = NEW zcm_rkc_vacreq(
      "Presentation for success message."
      severity = if_abap_behv_message=>severity-success
      textid = zcm_rkc_vacreq=>approved_VacReq2
      vacreqcomment = vacationrequest->VacReqComment ).
      APPEND VALUE #( %tky = vacationrequest->%tky
                      %element = VALUE #(  VacReqStatus = if_abap_behv=>mk-on )
                      %msg = message ) TO reported-vacationrequest.

      "Modify VacationRequests
        MODIFY ENTITY IN LOCAL MODE zr_rkc_vacreq "Modifying entities"
        UPDATE FIELDS ( VacReqStatus ) "Updating Vacation Request Status"
        WITH VALUE #( FOR i IN VacationRequests ( %tky = i-%tky VacReqStatus = i-VacReqStatus ) ).

        "Set result -> Define the return value for the result
        result = VALUE #( FOR i IN VacationRequests ( %tky = i-%tky %param = i ) ).
    ENDLOOP.
ENDMETHOD.

"Next Method"
METHOD DeclineVacReq.
     DATA message TYPE REF TO zcm_rkc_vacreq.

     "Read selected vacations request which should be declined
    READ ENTITY IN LOCAL MODE zr_rkc_vacreq
        FIELDS ( VacReqStatus VacReqComment )
        WITH CORRESPONDING #(  keys )
        RESULT DATA(VacationRequests).

    "Process VacationRequests
    LOOP AT VacationRequests REFERENCE INTO DATA(VacationRequest).

     "Validate Status and create Error
    IF VacationRequest->VacReqStatus = 'G'.
        "Presentation for error message."
        message = NEW zcm_rkc_vacreq(
       severity = if_abap_behv_message=>severity-error
       "Error occurs if an attempt is made to decline a vacation request that has already been approved."
        textid = zcm_rkc_vacreq=>already_approved_VacReq2
                               VacReqComment = VacationRequest->VacReqComment ).
        APPEND VALUE #( %tky = VacationRequest->%tky
                        %element = VALUE #(  VacReqStatus = if_abap_behv=>mk-on )
                        %msg = message ) TO reported-vacationrequest.
        APPEND VALUE #( %tky = VacationRequest->%tky ) TO failed-vacationrequest.
        DELETE VacationRequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

       "Validate Status and create Error
    IF VacationRequest->VacReqStatus = 'A'.
        "Presentation for error message."
        message = NEW zcm_rkc_vacreq(
       severity = if_abap_behv_message=>severity-error
       "Error: If an attempt is made to decline a Vacation Request that has already been previously declined."
        textid = zcm_rkc_vacreq=>already_declined_VacReq2
                               VacReqComment = VacationRequest->VacReqComment ).
        APPEND VALUE #( %tky = VacationRequest->%tky
                        %element = VALUE #(  VacReqStatus = if_abap_behv=>mk-on )
                        %msg = message ) TO reported-vacationrequest.
        APPEND VALUE #( %tky = VacationRequest->%tky ) TO failed-vacationrequest.
        DELETE VacationRequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      "set status on approved and receive a success message"
      vacationrequest->VacReqStatus = 'A'.
      message = NEW zcm_rkc_vacreq(
      "Presentation for success message."
      severity = if_abap_behv_message=>severity-success
      textid = zcm_rkc_vacreq=>declined_VacReq2
      vacreqcomment = vacationrequest->VacReqComment ).
      APPEND VALUE #( %tky = vacationrequest->%tky
                      %element = VALUE #(  VacReqStatus = if_abap_behv=>mk-on )
                      %msg = message ) TO reported-vacationrequest.

    "Modify VacationRequests
        MODIFY ENTITY IN LOCAL MODE zr_rkc_vacreq "Modifying entities"
        UPDATE FIELDS ( VacReqStatus ) "Updating Vacation Request Status"
        WITH VALUE #( FOR i IN VacationRequests ( %tky = i-%tky VacReqStatus = i-VacReqStatus ) ).

        "Set result -> Define the return value for the result
        result = VALUE #( FOR i IN VacationRequests ( %tky = i-%tky %param = i ) ).
    ENDLOOP.
ENDMETHOD.

METHOD DetermineVacReqStatus.

    "Read selected vacation Requests"
    READ ENTITY IN LOCAL MODE zr_rkc_vacreq
    "Required Fields -> Status has to change"
    FIELDS ( VacReqStatus )
    WITH CORRESPONDING #( keys )
    RESULT DATA(VacationRequests).

    "Modify Vacation Requests -> Update the status field to 'Requested'
    MODIFY ENTITY IN LOCAL MODE zr_rkc_vacreq
    UPDATE FIELDS ( VacReqStatus )
    WITH VALUE #( FOR r IN vacationRequests
                      ( %tky = r-%tky
                          VacReqStatus = 'B' ) ).
  ENDMETHOD.

  METHOD get_instance_authorizations_2.
  ENDMETHOD.

  METHOD ValidateIfEndBeforeBegin.
    DATA message TYPE REF TO zcm_rkc_vacreq.

     "Read selected vacation Requests"
    READ ENTITY IN LOCAL MODE zr_rkc_vacreq
    "Required Fields -> Status has to change"
    FIELDS ( VacStartDate VacEndDate )
    WITH CORRESPONDING #( keys )
    RESULT DATA(VacationRequests).

    LOOP AT VacationRequests INTO DATA(VacationRequest).
      IF VacationRequest-VacEndDate < VacationRequest-VacStartDate.
        message = NEW zcm_rkc_vacreq(
        severity = if_abap_behv_message=>severity-error

        textid = zcm_rkc_vacreq=>invalid_dates_VacReq2 VacReqComment = VacationRequest-VacReqcomment ).

        APPEND VALUE #( %tky = VacationRequest-%tky
                        %element = VALUE #( VacReqStatus = if_abap_behv=>mk-on )
                        %msg = message ) TO reported-VacationRequest.
        APPEND VALUE #( %tky = VacationRequest-%tky ) TO failed-VacationRequest.
      ENDIF.
    ENDLOOP.
ENDMETHOD.

METHOD DetermineVacReqStatusWhenEdit.
    READ ENTITY IN LOCAL MODE zr_rkc_vacreq
    FIELDS ( VacReqStatus )
    WITH CORRESPONDING #( keys )
    RESULT DATA(VacationRequests).

    LOOP AT VacationRequests REFERENCE INTO DATA(VacationRequest).
      IF Vacationrequest->VacReqStatus = 'G'.
        MODIFY ENTITY IN LOCAL MODE zr_rkc_vacreq
         UPDATE FIELDS ( VacReqStatus )
         WITH VALUE #( FOR j IN vacationrequests ( %tky = j-%tky vacreqstatus = 'B' ) ).
      ENDIF.
    ENDLOOP.

ENDMETHOD.

METHOD DetermineVacationDays.

 "Read selected vacation Requests"
    READ ENTITY IN LOCAL MODE zr_rkc_vacreq
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(VacationRequests).

    LOOP AT VacationRequests INTO DATA(VacationRequest).

    "Computation Vacation Days"
    TRY.
     DATA(calendar) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime( 'SAP_DE_BW' ).
        CATCH cx_fhc_runtime.
          RETURN.
      ENDTRY.


    "Calculate the working days from our RequestStartDate to RequestEndDate
      TRY.
          DATA(working_days) = calendar->calc_workingdays_between_dates( iv_start = VacationRequest-VacStartDate iv_end = VacationRequest-VacEndDate ).
        CATCH cx_fhc_runtime.
          RETURN.
      ENDTRY.

 "Modify VacationRequests
      MODIFY ENTITY IN LOCAL MODE zr_rkc_vacreq
      UPDATE FIELDS ( VacReqDays ) "Vacation Days should be updated
      WITH VALUE #( FOR k IN vacationrequests
      ( %tky = k-%tky
      VacReqDays = working_days + 1 ) ).


ENDLOOP.

  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
