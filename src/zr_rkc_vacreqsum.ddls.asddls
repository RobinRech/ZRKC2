@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sum Vacation Request'
define view entity ZR_RKC_VACREQSUM
  as select from zrkc_vacreq
{
  key id                   as VacReqID,
      applicant            as VacReqApplicant,
      status               as VacReqStatus,
      sum(vacationreqdays) as VacReqDays
}
where
  status = 'G'
group by
  id,
  applicant,
  status
