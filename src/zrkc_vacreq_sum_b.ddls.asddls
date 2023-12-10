@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sum B Vacation Request'
define view entity ZRKC_VACREQ_SUM_B
  as select from zrkc_vacreq
{
  key applicant            as BVacReqApplicant,
      sum(vacationreqdays) as BVacReqDays
}
where
  status = 'B'
group by
  applicant
