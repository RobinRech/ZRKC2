@EndUserText.label: 'Vacation Request App2'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Search.searchable: true
define view entity ZC_RKC_VACREQ_APP2 as projection on ZR_RKC_VACREQ
{
    key VacReqId,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_RKC_APPROVER_VH', element: 'EmpApproverID' }}] 
      @ObjectModel.text.element: [ 'ApplicantName' ]
      VacReqApplicant,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_RKC_APPROVER_VH', element: 'EmpApproverID' }}]
      @ObjectModel.text.element: [ 'ApproverName' ]
      VacReqApprover,
      VacStartDate,
      VacEndDate,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      VacReqComment,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_RKC_STATUS_VH', element: 'Status' } }]
      VacReqStatus,
      
      /*Administrative Data*/
      VacReqDays,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      
      
      
     /* Transient Data */
      ApplicantName,
      ApproverName,
      StatusName,
      StatusCriticality,
  

      /*Associations*/
      _Employee: redirected to parent ZC_RKC_EMP_APP2
      // Make association public
}
