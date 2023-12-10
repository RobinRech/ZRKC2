CLASS zcm_rkc_vacreq DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    "Interfaces
    INTERFACES if_abap_behv_message .
    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

    "Message Constants
    CONSTANTS:
        BEGIN OF declined_VacReq2,
        msgid TYPE symsgid      VALUE 'ZRKC_VACREQ',
        msgno TYPE symsgno      VALUE '403',
        attr1 TYPE scx_attrname VALUE 'VacReqComment',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF declined_VacReq2.


     CONSTANTS:
      BEGIN OF approved_VacReq2,
        msgid TYPE symsgid      VALUE 'ZRKC_VACREQ',
        msgno TYPE symsgno      VALUE '404',
        attr1 TYPE scx_attrname VALUE 'VacReqComment',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF approved_VacReq2.

      CONSTANTS:
      BEGIN OF already_declined_VacReq2,
        msgid TYPE symsgid      VALUE 'ZRKC_VACREQ',
        msgno TYPE symsgno      VALUE '405',
        attr1 TYPE scx_attrname VALUE 'VacReqComment',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF already_declined_VacReq2.

    CONSTANTS:
      BEGIN OF already_approved_VacReq2,
        msgid TYPE symsgid      VALUE 'ZRKC_VACREQ',
        msgno TYPE symsgno      VALUE '406',
        attr1 TYPE scx_attrname VALUE 'VacReqComment',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF already_approved_VacReq2.

     CONSTANTS:
      BEGIN OF invalid_amount_VacReq2,
        msgid TYPE symsgid      VALUE 'ZRKC_VACREQ',
        msgno TYPE symsgno      VALUE '401',
        attr1 TYPE scx_attrname VALUE 'VacReqComment',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF invalid_amount_VacReq2.


       CONSTANTS:
      BEGIN OF invalid_dates_VacReq2,
        msgid TYPE symsgid      VALUE 'ZRKC_VACREQ',
        msgno TYPE symsgno      VALUE '402',
        attr1 TYPE scx_attrname VALUE 'VacReqComment',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF invalid_dates_VacReq2.


      " Attributs
      DATA VacReqComment TYPE zrkc_comment.

      METHODS constructor
        IMPORTING
         severity      TYPE if_abap_behv_message=>t_severity
        !textid       LIKE if_t100_message=>t100key OPTIONAL
        !previous     LIKE previous OPTIONAL
        VacReqComment TYPE zrkc_comment OPTIONAL.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcm_rkc_vacreq IMPLEMENTATION.

    METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.

    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
    me->VacReqComment = VacReqComment.
    if_abap_behv_message~m_severity = severity.
  ENDMETHOD.


ENDCLASS.
