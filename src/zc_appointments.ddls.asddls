@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Appoitnment details'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@Search.searchable: true
define view entity ZC_APPOINTMENTS as projection on ZR_APPOINTMENTS
{
    key AppointmentID,
    
  @Search.defaultSearchElement: true
  @Consumption.valueHelpDefinition: [{ 
    entity: { name: 'ZR_PATIENTS_VH', element: 'PatientID' }, useForValidation: true
   
  }]
  @UI.textArrangement: #TEXT_ONLY
  @ObjectModel.text.element: [ 'PatientName' ]
    PatientID,
   
   @ObjectModel.text.element: [ 'DoctorName' ]
   @UI.textArrangement: #TEXT_ONLY
    DoctorID,
    
  
    AppointmentDate,
    
  @Consumption.valueHelpDefinition: [{ 
  entity: { 
    name: 'ZI_TIME_SLOTS', 
    element: 'TimeSlot' 
  }
}]     
    AppointmentStartTime,
    AppointmentEndTime,
    
    @EndUserText.label: 'Status'
    @Consumption.valueHelpDefinition: [{ entity:{name:'zi_status_dropdown',element:'Status'} }]   
    Status,
    StatusCriticality,
    Notes,
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
 
    _Doctor: redirected to parent ZC_DOCTORS,
    _Patient,
    @UI.hidden: true
    _Patient.FullName as PatientName,
    _Doctor.FullName as DoctorName
}
