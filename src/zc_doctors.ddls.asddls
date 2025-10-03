@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: 'Doctor details page'
}

@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_DOCTORS
  provider contract transactional_query
  as projection on ZR_DOCTORS

{
  key DoctorID,
  FirstName,
  LastName,
  
  FullName,
 @Consumption.valueHelpDefinition: [
        {
          entity: {
            name: 'ZR_SPECIALIZATIONS',
            element: 'SpecializationID'
          },
          additionalBinding: [
            {
              localElement: 'SpecializationTitle',  
              element: 'Title'                      
            }
          ]
        }
      ]
      @ObjectModel.text.element: ['SpecializationTitle']  
      @UI.textArrangement: #TEXT_ONLY
      SpecializationID,
   
  PhoneNumber,
  Email,
  IsAtWork,
  YearsExperience,
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
  _Specialization,
  _Specialization.Title as SpecializationTitle,
  _Appointment: redirected to composition child ZC_APPOINTMENTS
  
  
 

}
