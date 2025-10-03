@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view for ZR_PATIENT_VISITS'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_PATIENT_VISITS as projection on ZR_PATIENT_VISITS
{
    key VisitID,
    PatientID,
    DoctorID,
    VisitDate,
    VisitStartTime,
    VisitEndtTime,
    Status,
    VisitNotes,
    FullName,
    Title,
    CreatedAt,
    CreatedBy,
    LocalLastChangedAt,
    LocalLastChangedBy,
    LastChangedAt,
 
    _Doctor,
    _Patient :redirected to parent ZC_PATIENTS
}
