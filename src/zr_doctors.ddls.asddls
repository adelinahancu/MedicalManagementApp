@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZDOCTORS'
@EndUserText.label: 'Doctors'
define root view entity ZR_DOCTORS
  as select from zdoctors as Doctors
 association [1..1] to ZR_SPECIALIZATIONS  as _Specialization on $projection.SpecializationID=_Specialization.SpecializationID
 composition [0..*] of ZR_APPOINTMENTS as _Appointment 
{
  key doctor_id as DoctorID,
  first_name as FirstName,
  last_name as LastName,
  concat_with_space(first_name,last_name,1) as FullName,  
  specialization_id as SpecializationID,
  phone_number as PhoneNumber,
  email as Email,
  is_at_work as IsAtWork,
  years_experience as YearsExperience,
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
  _Specialization,
  _Appointment


  
}
