@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Patients details page'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_PATIENTS
  provider contract transactional_query as projection on ZR_PATIENTS
{
    key PatientID,
    FirstName,
    LastName,
    FullName,
    PhoneNumber,
    Email,
    DateOfBirth,
    HasAssurance,
    @Semantics: {
    user.createdBy: true
  }
  CreatedBy,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  CreatedAt,
  @Semantics: {
    user.localInstanceLastChangedBy: true
  }
  LocalLastChangedBy,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  LocalLastChangedAt,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  LastChangedAt,
  _MedicalRecords: redirected to composition child ZC_MEDICAL_RECORDS,
  _PatientVisits: redirected to composition child ZC_PATIENT_VISITS
  
}
