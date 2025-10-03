@AbapCatalog.sqlViewName: 'ZR_PATIENT_VH'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value help'
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZPATIENTS'
@Search.searchable: true
define view ZR_PATIENTS_VH as select from zpatients as PatientValueHelp
{
     @Search.defaultSearchElement: true   
     @ObjectModel.text.element: [ 'FullName' ]
     @UI.textArrangement: #TEXT_SEPARATE
     @UI.lineItem: [{ position:10,importance:#HIGH }]
    key patient_id as PatientID,
    first_name as FirstName,
    last_name as LastName,
    
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.8
    @Semantics.text: true
    @UI.lineItem: [{ position: 20,importance:#HIGH }]
    concat_with_space(first_name,last_name,1) as FullName
}
