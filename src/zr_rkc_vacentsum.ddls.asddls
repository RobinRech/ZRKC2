@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sum Vacation Entitlement'
define view entity ZR_RKC_VACENTSUM
  as select from zrkc_vacent
{
  key employee           as VacationEntitlementEmployee,
      sum(vacation_days) as VacationDays
}
group by
  employee
