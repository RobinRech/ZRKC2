@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sum G Vacation Request'
define view entity ZRKC_VACREQ_SUM_G
  as select from zrkc_vacreq
{
  key applicant            as GVacReqApplicant,
      sum(vacationreqdays) as GVacReqDays
}
where
  status = 'G'
group by
  applicant
