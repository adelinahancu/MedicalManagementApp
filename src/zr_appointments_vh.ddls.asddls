@AbapCatalog.sqlViewName: 'ZR_APPOINTMEN'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value help for appointments'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
define view ZR_APPOINTMENTS_VH as select from zappointments
{
    @Search.defaultSearchElement: true   
     @ObjectModel.text.element: [ 'AppointmentDate' ]
     @UI.textArrangement: #TEXT_SEPARATE
     @UI.lineItem: [{ position:10,importance:#HIGH }]
    key appointment_id as AppointmentID,
   
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.8
    @Semantics.text: true
    @UI.lineItem: [{ position: 20,importance:#HIGH }]
    appointment_date as AppointmentDate,
    appointment_start_time as AppointmentStartTime,
    appointment_end_time as AppointmentEndTime,
    status as Status,
    notes as Notes
   
}
