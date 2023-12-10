@EndUserText.label: 'Text for Vacation Entitlement'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZI_RKC_VACENTTEXT
  as select from zrkc_emp
{
  key id                                          as VacEntTextID,
      concat_with_space(first_name, last_name, 1) as VacEntEmpName
}
