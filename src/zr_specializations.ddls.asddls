@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZSPECIALIZATIONS'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define view entity ZR_SPECIALIZATIONS
  as select from zspecializations as Specialization
{
  @Search.defaultSearchElement: true  
  key specialization_id as SpecializationID,
  
  @Search.defaultSearchElement: true  
  specialization_code as SpecializationCode,
  
  @Search.defaultSearchElement: true  
  @Semantics.text: true              
  title as Title,
  description as Description,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt
}
