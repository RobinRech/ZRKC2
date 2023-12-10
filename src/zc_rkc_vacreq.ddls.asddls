@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VacationRequest'
@Metadata.allowExtensions: true
define view entity ZC_RKC_VACREQ
  as projection on ZR_RKC_VACREQ
{
  key VacReqId,
      @ObjectModel.text.element: [ 'ApplicantName' ]
      VacReqApplicant,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_RKC_APPROVER_VH', element: 'EmpApproverID' }}]
      @ObjectModel.text.element: [ 'ApproverName' ]
      VacReqApprover,
      VacStartDate,
      VacEndDate,
      VacReqComment,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_RKC_STATUS_VH', element: 'Status' } }]
      VacReqStatus,
      VacReqDays,

      /*Administrative Data*/
      
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,

      /*Transient Data*/
      ApplicantName,
      ApproverName,
      StatusName,
      StatusCriticality,
      VacationDays,
      BVacReqDays,
      GVacReqDays,


      /* Associations */
      _Employee : redirected to parent ZC_RKC_EMP

}
