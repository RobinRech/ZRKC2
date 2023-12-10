@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VacationEntitlement'
@Metadata.allowExtensions: true
define view entity ZC_RKC_VACENT as projection on ZR_RKC_VACENT

{
    key VacentId,
    @ObjectModel.text.element:['VacEntEmpName']
    VacentEmployee,
    Year_,
    VacationDays,
    
    /*Administrative Data*/
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    
    /*Transient Data*/
    VacEntEmpName,
    
    /* Associations */
    _Employee: redirected to parent ZC_RKC_EMP // Make association public
}

