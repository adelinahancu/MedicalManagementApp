
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for available time slots'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZI_AVAILABLE_TIME_SLOTS with parameters 


     P_DoctorID : sysuuid_x16,
    P_AppointmentDate : abap.dats
  as select from ZI_TIME_SLOTS as TimeSlots
  
  left outer join zappointments as Appointments
    on  Appointments.doctor_id = $parameters.P_DoctorID
    and Appointments.appointment_date = $parameters.P_AppointmentDate
    and Appointments.appointment_start_time = TimeSlots.TimeSlot
    and Appointments.status != 'CANCELLED'
{
  key TimeSlots.TimeSlot
      
}


where Appointments.appointment_id is null
