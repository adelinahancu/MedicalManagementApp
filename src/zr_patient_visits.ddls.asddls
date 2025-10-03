@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Inteface view for patient visits'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZR_PATIENT_VISITS 
 as select from zappointments as app
  inner join zdoctors as doc on app.doctor_id = doc.doctor_id
  inner join zpatients as pat on app.patient_id = pat.patient_id
  association [1..1] to ZR_DOCTORS as _Doctor
    on $projection.DoctorID = _Doctor.DoctorID
    
  association to parent ZR_PATIENTS as _Patient
    on $projection.PatientID = _Patient.PatientID
{
  key app.appointment_id as VisitID,
  app.patient_id as PatientID,
  app.doctor_id as DoctorID,
  app.appointment_date as VisitDate,
  app.appointment_start_time as VisitStartTime,
  app.appointment_end_time as VisitEndtTime,
  app.status as Status,
  app.notes as VisitNotes,
  
  concat_with_space(doc.first_name, doc.last_name, 1) as FullName,
  _Doctor._Specialization.Title as Title,
  

  app.created_at as CreatedAt,
  app.created_by as CreatedBy,
  app.local_last_changed_at as LocalLastChangedAt,
  app.local_last_changed_by as LocalLastChangedBy,
  app.last_changed_at as LastChangedAt,
  _Doctor,
  _Patient
  
  
  
}
where app.status = 'COMPLETED'
