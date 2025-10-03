@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZAPPOINTMENTS'
@EndUserText.label: 'Appointments'
define view entity ZR_APPOINTMENTS
  as select from zappointments as Appointment
  
  association [1..1] to ZR_PATIENTS as _Patient on $projection.PatientID=_Patient.PatientID
  association to parent ZR_DOCTORS as _Doctor on $projection.DoctorID=_Doctor.DoctorID
    
{
  key appointment_id as AppointmentID,
  patient_id as PatientID,
  doctor_id as DoctorID,
  
  appointment_date as AppointmentDate,
  appointment_start_time as AppointmentStartTime,
  appointment_end_time as AppointmentEndTime,
  status as Status,
  notes as Notes,
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
  _Doctor,
   case status
        when 'SCHEDULED' then 2
        when 'COMPLETED' then 3  
        when 'CANCELLED' then 1  
        else 0                   
      end as StatusCriticality

 
}
