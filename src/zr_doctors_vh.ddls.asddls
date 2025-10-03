
@AbapCatalog.sqlViewName: 'ZR_DOCTOR_VH'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value help for doctors'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
define view ZR_DOCTORS_VH as select from zdoctors
{
     @Search.defaultSearchElement: true   
     @ObjectModel.text.element: [ 'FullName' ]
     @UI.textArrangement: #TEXT_SEPARATE
     @UI.lineItem: [{ position:10,importance:#HIGH }]
    key doctor_id as DoctorID,
    first_name as FirstName,
    last_name as LastName,
    
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.8
    @Semantics.text: true
    @UI.lineItem: [{ position: 20,importance:#HIGH }]
    concat_with_space(first_name,last_name,1) as FullName
    
}
