@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VacationEntitlement'
define view entity ZR_RKC_VACENT
  as select from zrkc_vacent
  association        to parent ZR_RKC_EMP as _Employee   on $projection.VacentEmployee = _Employee.EmployeeId
  association [1..1] to ZI_RKC_VACENTTEXT as _VacEntText on $projection.VacEntEmployee = _VacEntText.VacEntTextID

{
      @EndUserText: {label: 'Vaciation Entitlement ID', quickInfo: 'Vaciation Entitlement ID'}
  key id                        as VacentId,
      employee                  as VacentEmployee,
      year_                     as Year_,
      vacation_days             as VacationDays,

      /* Administrative Data*/
      @Semantics.user.createdBy: true
      created_by                as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at                as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by           as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at           as LastChangedAt,

      /* Transient Data */
      _VacEntText.VacEntEmpName as VacEntEmpName,


      /* Associations */
      _Employee
      //_association_name // Make association public
}
