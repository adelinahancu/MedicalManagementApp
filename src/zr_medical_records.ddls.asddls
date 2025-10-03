@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZMEDICAL_RECORDS'
@EndUserText.label: 'Medical Record'
define view entity ZR_MEDICAL_RECORDS
  as select from zmedical_records as MedicalRecord
  
  association to parent ZR_PATIENTS as _Patient on $projection.PatientID=_Patient.PatientID
  association [1..1] to ZR_DOCTORS as _Doctor on $projection.DoctorID=_Doctor.DoctorID
 
{
  key record_id as RecordID,
  patient_id as PatientID,
  doctor_id as DoctorID,
  record_date as RecordDate,
  diagnosis as Diagnosis,
  treatment as Treatment,
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
  _Patient,
  _Doctor
 
 
}
