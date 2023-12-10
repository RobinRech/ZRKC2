@EndUserText.label: 'Text for Status'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZI_RKC_STATUS_TEXT
  as select from zrkc_vacreq
{
  key id          as TextVacReqID,
      status      as TextVacReqStatus,

      'Declined'  as StatusNameA,
      'Requested' as StatusNameB,
      'Approved'  as StatusNameG
}
