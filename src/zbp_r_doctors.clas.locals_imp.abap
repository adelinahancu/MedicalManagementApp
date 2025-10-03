CLASS lhc_appointments DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS determineStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Appointments~determineStatus.
    METHODS validateAppointmentDate FOR DETERMINE ON modify
      IMPORTING keys FOR Appointments~validateAppointmentDate.

    METHODS calculateEndTime FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Appointments~calculateEndTime.

    METHODS validateWorkingHours FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Appointments~validateWorkingHours.

*    METHODS setStatusToCompleted FOR DETERMINE ON SAVE
*        Importing keys for Appointments~setStatusToCompleted.
    METHODS validateUniqueAppointmentTime FOR VALIDATE ON SAVE
      IMPORTING keys FOR Appointments~validateUniqueAppointmentTime.




*    METHODS createMedicalRecordsOnComplete FOR DETERMINE ON MODIFY
*      IMPORTING keys FOR Appointments~createMedicalRecordsOnComplete.

ENDCLASS.

CLASS lhc_appointments IMPLEMENTATION.

  METHOD determineStatus.

    READ ENTITIES OF zr_doctors IN LOCAL MODE
      ENTITY Appointments
        FIELDS ( Status )
        WITH CORRESPONDING #( keys )
      RESULT DATA(appointments).

    LOOP AT appointments INTO DATA(appointment).
      IF appointment-Status IS INITIAL.
        MODIFY ENTITIES OF zr_doctors IN LOCAL MODE
          ENTITY Appointments
            UPDATE FIELDS ( Status )
            WITH VALUE #( ( %tky = appointment-%tky
                           Status = 'SCHEDULED' ) ).
      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD validateAppointmentDate.

DATA(current_date) = cl_abap_context_info=>get_system_date( ).

    READ ENTITIES OF zr_doctors IN LOCAL MODE
      ENTITY Appointments
        FIELDS ( AppointmentDate )
        WITH CORRESPONDING #( keys )
      RESULT DATA(appointments).

    LOOP AT appointments INTO DATA(appointment).
      IF appointment-AppointmentDate IS NOT INITIAL AND
         appointment-AppointmentDate < current_date.


        APPEND VALUE #( %tky = appointment-%tky
                       %msg = new_message_with_text(
                         severity = if_abap_behv_message=>severity-error
                         text = |Appointment date cannot be in the past! Please select a future date.|
                       )
                       %element-AppointmentDate = if_abap_behv=>mk-on
                     ) TO reported-appointments.
      ENDIF.
    ENDLOOP.  ENDMETHOD.

  METHOD calculateEndTime.
  READ ENTITIES OF zr_doctors IN LOCAL MODE

  ENTITY Appointments
  fields ( AppointmentStartTime )
  with corresponding #( keys )
  result data(appointments).

  Loop at appointments into data(appointment).
  if appointment-AppointmentStartTime is not initial.
  data(start_time) = appointment-AppointmentStartTime.
  data(end_time) = start_time + 1800.

  modify entities of zr_doctors in local mode
  entity Appointments
  UPDATE FIELDS ( AppointmentEndTime )
  with value #( (  %tky = appointment-%tky
                    AppointmentEndTime = end_time ) ).
                    endif.
                    endloop.

  ENDMETHOD.

  METHOD validateWorkingHours.

  data(start_working_hour) = '080000'.
  data(ent_working_hour) = '170000'.
  data(last_start_time) = '163000'.

  read entities of zr_doctors in local mode
  ENTITY Appointments
  fields ( AppointmentStartTime AppointmentEndTime )
  with CORRESPONDING #(  keys )
  result data(appointments).

  loop at appointments into data(appointment).
  if appointment-AppointmentStartTime is not INITIAL.
  if appointment-AppointmentStartTime < start_working_hour.
  append value #( %tky = appointment-%tky
                           %msg = new_message_with_text(
                           severity = if_abap_behv_message=>severity-error
                           text = |⏰ Working hours start at 08:00. Please select a later time.|
  )  %element-AppointmentStartTime = if_abap_behv=>mk-on
                       ) TO reported-appointments.

  ELSEIF appointment-AppointmentStartTime > last_start_time.
          APPEND VALUE #( %tky = appointment-%tky
                         %msg = new_message_with_text(
                           severity = if_abap_behv_message=>severity-error
                           text = |⏰ Last appointment starts at 16:30 (ends at 17:00). Please select an earlier time.|
                         )
                         %element-AppointmentStartTime = if_abap_behv=>mk-on
                       ) TO reported-appointments.

 ELSE.
          DATA(time_string) = |{ appointment-AppointmentStartTime TIME = ISO }|.
          DATA(minutes) = time_string+3(2).

          IF minutes <> '00' AND minutes <> '30'.
            APPEND VALUE #( %tky = appointment-%tky
                           %msg = new_message_with_text(
                             severity = if_abap_behv_message=>severity-warning
                             text = |⚠️ Recommended: Select times at 30-minute intervals (08:00, 08:30, 09:00, etc.)|
                           )
                           %element-AppointmentStartTime = if_abap_behv=>mk-on
                         ) TO reported-appointments.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.



*  METHOD createMedicalRecordsOnComplete.
*  READ ENTITIES OF zr_doctors IN LOCAL MODE
*    ENTITY Appointments
*      ALL FIELDS
*      WITH CORRESPONDING #( keys )
*    RESULT DATA(appointments).
*
*  " Procesează fiecare appointment
*  LOOP AT appointments INTO DATA(appointment).
*
*    " Verifică dacă statusul este 'COMPLETED'
*    IF appointment-Status = 'COMPLETED'.
*
*      " Verifică dacă există deja un medical record pentru acest appointment
*      SELECT SINGLE appointment_id
*        FROM zmedical_records
*        WHERE appointment_id = @appointment-AppointmentID
*        INTO @DATA(existing_record).
*
*      " Dacă nu există, creează unul nou
*      IF existing_record IS INITIAL.
*
*        " Pregătește structura pentru medical record
*        DATA: medical_record TYPE zmedical_records.
*
**        " Generează un ID nou
**        SELECT MAX( record_id ) FROM zmedical_records INTO @DATA(max_id).
**        medical_record-record_id = max_id + 1.
*
*        " Completează câmpurile
*        medical_record-patient_id = appointment-PatientID.
*        medical_record-doctor_id = appointment-DoctorID.
*        medical_record-appointment_id = appointment-AppointmentID.
*        medical_record-diagnosis = 'Consultation completed'.
*        medical_record-treatment = 'To be updated by doctor'.
*        medical_record-created_by = sy-uname.
*        GET TIME STAMP FIELD medical_record-created_at.
*        medical_record-local_last_changed_by = sy-uname.
*        GET TIME STAMP FIELD medical_record-local_last_changed_at.
*        GET TIME STAMP FIELD medical_record-last_changed_at.
*
*        " Inserează în tabelă
*        INSERT zmedical_records FROM @medical_record.
*
*      ENDIF.
*    ENDIF.
*  ENDLOOP.
*
*  ENDMETHOD.
*

*  METHOD updatePastAppointmentsStatus.
*   DATA(lv_current_date) = cl_abap_context_info=>get_system_date( ).
*  DATA(lv_current_time) = cl_abap_context_info=>get_system_time( ).
*
*  " Actualizează direct în baza de date
*  UPDATE zappointments
*    SET status = 'COMPLETED',
*        local_last_changed_at = @( cl_abap_tstmp=>utclong2tstmp( utclong_current( ) ) ),
*        local_last_changed_by = @sy-uname,
*        last_changed_at = @( cl_abap_tstmp=>utclong2tstmp( utclong_current( ) ) )
*    WHERE ( appointment_date < @lv_current_date OR
*            ( appointment_date = @lv_current_date AND
*              appointment_start_time < @lv_current_time ) )
*      AND status <> 'CANCELLED'
*      AND status <> 'COMPLETED'.
*
*  IF sy-dbcnt > 0.
*    " Adaugă mesaj informativ doar dacă keys nu este gol
*    IF keys IS NOT INITIAL.
*      APPEND VALUE #(
*        %tky = keys[ 1 ]-%tky
*        %msg = new_message_with_text(
*          severity = if_abap_behv_message=>severity-information
*          text = |{ sy-dbcnt } programări din trecut au fost marcate ca COMPLETED|
*        )
*      ) TO reported-appointments.
*    ENDIF.
*  ENDIF.
*
*  ENDMETHOD.
*
*  METHOD setstatustocompleted.
*    DATA(current_date) = cl_abap_context_info=>get_system_date( ).
*  DATA(current_time) = cl_abap_context_info=>get_system_time( ).
*
*  " Citește programările curente din keys
*  READ ENTITIES OF zr_doctors IN LOCAL MODE
*    ENTITY Appointments
*      FIELDS ( AppointmentDate AppointmentStartTime AppointmentEndTime Status )
*      WITH CORRESPONDING #( keys )
*    RESULT DATA(current_appointments).
*
*  " Pregătește tabelul pentru actualizare
*  DATA appointments_update TYPE TABLE FOR UPDATE zr_doctors\\Appointments.
*
*  " Pentru fiecare programare din keys, verifică și actualizează
*  LOOP AT current_appointments INTO DATA(appointment).
*    " Verifică dacă statusul nu este CANCELLED
*    IF appointment-Status <> 'CANCELLED'.
*      " Verifică dacă programarea este în trecut
*      IF appointment-AppointmentDate < current_date OR
*         ( appointment-AppointmentDate = current_date AND
*           appointment-AppointmentEndTime < current_time ).
*
*        " Adaugă în tabelul de actualizare doar dacă statusul nu este deja COMPLETED
*        IF appointment-Status <> 'COMPLETED'.
*          APPEND VALUE #( %tky = appointment-%tky
*                         Status = 'COMPLETED'
*                         %control-Status = if_abap_behv=>mk-on )
*                 TO appointments_update.
*        ENDIF.
*      ENDIF.
*    ENDIF.
*  ENDLOOP.
*
*
*  IF appointments_update IS NOT INITIAL.
*    MODIFY ENTITIES OF zr_doctors IN LOCAL MODE
*      ENTITY Appointments
*        UPDATE FIELDS ( Status )
*        WITH appointments_update.
*  ENDIF.
*
*  ENDMETHOD.

  METHOD validateUniqueAppointmentTime.
  READ ENTITIES OF zr_doctors IN LOCAL MODE
    ENTITY Appointments
      FIELDS ( AppointmentDate AppointmentStartTime DoctorID AppointmentID )
      WITH CORRESPONDING #( keys )
    RESULT DATA(appointments).


  LOOP AT appointments INTO DATA(appointment).


    IF appointment-AppointmentDate IS NOT INITIAL AND
       appointment-AppointmentStartTime IS NOT INITIAL AND
       appointment-DoctorID IS NOT INITIAL.


      SELECT SINGLE appointment_id
        FROM zappointments
        WHERE doctor_id = @appointment-DoctorID
          AND appointment_date = @appointment-AppointmentDate
          AND appointment_start_time = @appointment-AppointmentStartTime
          AND appointment_id <> @appointment-AppointmentID
          AND status <> 'CANCELLED'
        INTO @DATA(existing_appointment).


      IF existing_appointment IS NOT INITIAL.
        APPEND VALUE #( %tky = appointment-%tky
                       %msg = new_message_with_text(
                         severity = if_abap_behv_message=>severity-error
                         text = |Doctor has already an appointment: { appointment-AppointmentDate DATE = USER } time { appointment-AppointmentStartTime TIME = USER }|
                       )
                       %element-AppointmentDate = if_abap_behv=>mk-on
                       %element-AppointmentStartTime = if_abap_behv=>mk-on
                     ) TO reported-appointments.

        APPEND VALUE #( %tky = appointment-%tky ) TO failed-appointments.
      ENDIF.
    ENDIF.
  ENDLOOP.
  ENDMETHOD.

ENDCLASS.

CLASS LHC_ZR_DOCTORS DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR Doctors
        RESULT result.
ENDCLASS.

CLASS LHC_ZR_DOCTORS IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
ENDCLASS.
