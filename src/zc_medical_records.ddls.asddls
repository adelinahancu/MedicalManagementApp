@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Medical record details page'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@Search.searchable: true
define view entity ZC_MEDICAL_RECORDS as projection on ZR_MEDICAL_RECORDS
{
    key RecordID,
    
    @UI.textArrangement: #TEXT_ONLY
    @ObjectModel.text.element: [ 'PatientName' ]
    PatientID,
    @Search.defaultSearchElement: true
  @Consumption.valueHelpDefinition: [{ 
    entity: { name: 'ZR_DOCTORS_VH', element: 'DoctorID' }, useForValidation: true
   
  }]
  @UI.textArrangement: #TEXT_ONLY
  @ObjectModel.text.element: [ 'DoctorFullName' ]
    DoctorID,
  
  @ObjectModel.text.element: [ 'RecordDate' ]
    RecordDate,
    Diagnosis,
    Treatment,
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

    
    _Doctor,
    _Patient: redirected to parent ZC_PATIENTS,
    _Doctor.FullName as DoctorFullName,
  
    _Patient.FullName as PatientName
}
