@EndUserText.label: 'value help for approver'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZI_RKC_APPROVER_VH
  as select from zrkc_emp
{
  key id              as EmpApproverID,
      employee_number as EmpApproverNumber,
      first_name      as EmpFirstName,
      last_name       as EmpLastName,
      entry_date      as EmpEntranceDate
}
