
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee App2'
@Metadata.allowExtensions: true
define root view entity ZC_RKC_EMP_APP2 
provider contract transactional_query as projection on ZR_RKC_EMP
{
    key EmployeeId,
    EmployeeNumber,
    FirstName,
    LastName,
    EntryDate,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    BVacReqDays,
    GVacReqDays,
    VacationDays,
    
    /* Associations */
    _VacationRequests: redirected to composition child ZC_RKC_VACREQ_APP2
}
