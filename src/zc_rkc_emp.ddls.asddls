@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee'
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC_RKC_EMP
  as projection on ZR_RKC_EMP
{
  key EmployeeId,
      EmployeeNumber,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      FirstName,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      LastName,
      EntryDate,

      /*Administrative Data*/
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,

      /* Transient Data */
      VacationDays,
      BVacReqDays,
      GVacReqDays,



      /* Associations */
      _VacationEntitlements : redirected to composition child ZC_RKC_VACENT,
      _VacationRequests     : redirected to composition child ZC_RKC_VACREQ

}
