@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vacation Request'
define view entity ZR_RKC_VACREQ
  as select from zrkc_vacreq
  association        to parent ZR_RKC_EMP           as _Employee            on $projection.VacReqApplicant = _Employee.EmployeeId
  association [1..1] to ZI_RKC_VACREQAPPLICANT_TEXT as _VacReqApplicantText on $projection.VacReqApplicant = _VacReqApplicantText.VacationRequestApplicantId
  association [1..1] to ZI_RKC_VACREQAPPROVER_TEXT  as _VacReqApproverText  on $projection.VacReqApprover = _VacReqApproverText.VacReqApproverID
  association [1..1] to ZI_RKC_STATUS_TEXT          as _StatusText          on $projection.VacReqId = _StatusText.TextVacReqID
  association [1..1] to ZR_RKC_VACENTSUM            as _VacEnt_Sum          on $projection.VacReqApplicant = _VacEnt_Sum.VacationEntitlementEmployee
  association [1..1] to ZRKC_VACREQ_SUM_B           as _VacReq_Sum_B        on $projection.VacReqApplicant = _VacReq_Sum_B.BVacReqApplicant
  association [1..1] to ZRKC_VACREQ_SUM_G           as _VacReq_Sum_G        on $projection.VacReqApplicant = _VacReq_Sum_G.GVacReqApplicant
{

      @EndUserText: {label:'Vacation Request ID', quickInfo: 'Vacation Request ID'}
  key id                                       as VacReqId,
      @EndUserText: {label:'Vacation Applicant', quickInfo: 'Vacation Applicant'}
      applicant                                as VacReqApplicant,
      @EndUserText: {label:'Vacation Approver', quickInfo: 'Vacation Approver'}
      approver                                 as VacReqApprover,
      start_date                               as VacStartDate,
      end_date                                 as VacEndDate,
      comment_                                 as VacReqComment,
      @ObjectModel.text.element: ['StatusName']
      status                                   as VacReqStatus,
      @EndUserText: {label:'Planned Vacation Days', quickInfo: 'Planned Vacation Days'}
      vacationreqdays                          as VacReqDays,


      /*Administrative Data */
      @Semantics.user.createdBy: true
      created_by                               as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at                               as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by                          as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at                          as LastChangedAt,



      /*Cases*/

      case status   when 'A' then _StatusText.StatusNameA
                    when 'B' then _StatusText.StatusNameB
                    when 'G' then _StatusText.StatusNameG
           else null
           end                                 as StatusName,

      case status   when  'A' then 1
                    when  'B' then 2
                    when  'G' then 3
           else 0
           end                                 as StatusCriticality,


      /*Transient Data*/
      _VacReqApplicantText.VacReqApplicantName as ApplicantName,
      _VacReqApproverText.ApproverName         as ApproverName,
      _VacEnt_Sum.VacationDays                 as VacationDays,
      _VacReq_Sum_B.BVacReqDays                as BVacReqDays,
      _VacReq_Sum_G.GVacReqDays                as GVacReqDays,

      /* Associations */
      _Employee
      //_association_name // Make association public







}
