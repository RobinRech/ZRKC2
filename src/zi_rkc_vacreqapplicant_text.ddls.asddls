@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Text for VacationRequestApplicant'
define view entity ZI_RKC_VACREQAPPLICANT_TEXT
  as select from zrkc_emp
{
  key id                                          as VacationRequestApplicantId,
      concat_with_space(first_name, last_name, 1) as VacReqApplicantName
}
