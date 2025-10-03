@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZPATIENTS'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_PATIENTS
  as select from zpatients as Patient
  
  composition [0..*] of ZR_MEDICAL_RECORDS as _MedicalRecords
  composition [0..*] of ZR_PATIENT_VISITS as _PatientVisits
  
 {
  key patient_id as PatientID,
  first_name as FirstName,
  last_name as LastName,
  concat_with_space(first_name,last_name,1) as FullName,
  phone_number as PhoneNumber,
  email as Email,
  date_of_birth as DateOfBirth,
  has_assurance as HasAssurance,

  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  _MedicalRecords,
  _PatientVisits
  
  
}
