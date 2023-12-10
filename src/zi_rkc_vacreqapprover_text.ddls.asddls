@EndUserText.label: 'Text for VacationRequestAuthorizer'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZI_RKC_VACREQAPPROVER_TEXT
  as select from zrkc_emp
{
  key id                                          as VacReqApproverID,
      concat_with_space(first_name, last_name, 1) as ApproverName
}
