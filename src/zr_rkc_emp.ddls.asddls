@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee'
define root view entity ZR_RKC_EMP
  as select from zrkc_emp
  composition [0..*] of ZR_RKC_VACENT     as _VacationEntitlements
  composition [0..*] of ZR_RKC_VACREQ     as _VacationRequests
  association [1..1] to ZRKC_VACREQ_SUM_B as _VacReq_Sum_B on $projection.EmployeeId = _VacReq_Sum_B.BVacReqApplicant
  association [1..1] to ZRKC_VACREQ_SUM_G as _VacReq_Sum_G on $projection.EmployeeId = _VacReq_Sum_G.GVacReqApplicant
  association [1..1] to ZR_RKC_VACENTSUM  as _VacEnt_Sum   on $projection.EmployeeId = _VacEnt_Sum.VacationEntitlementEmployee


  //composition of target_data_source_name as _association_name
{
      @EndUserText: {label: 'Employee Id', quickInfo: 'Employee Id'}
  key id                        as EmployeeId,
      employee_number           as EmployeeNumber,
      first_name                as FirstName,
      last_name                 as LastName,
      entry_date                as EntryDate,

      /*Administrative Data*/
      @Semantics.user.createdBy: true
      created_by                as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at                as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by           as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at           as LastChangedAt,

      @EndUserText: {label: 'Planned Vacation Days', quickInfo: 'Planned Vacation Days'}
      _VacReq_Sum_B.BVacReqDays as BVacReqDays,

      @EndUserText: {label: 'Approved Vacation Days', quickInfo: 'Approved Vacation Days'}
      _VacReq_Sum_G.GVacReqDays as GVacReqDays,

      @EndUserText: {label: 'Total Vacation Days Entitled', quickInfo: 'Total Vacation Days Entitled'}
      _VacEnt_Sum.VacationDays  as VacationDays,


      ///* Associations */
      _VacationEntitlements, // Make association public
      _VacationRequests
}
