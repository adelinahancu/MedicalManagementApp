CLASS zcl_appointment_singleton DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.
  CLASS-METHODS:
      get_instance RETURNING VALUE(ro_instance) TYPE REF TO zcl_appointment_singleton,
      check_and_update_if_needed.
  PROTECTED SECTION.
  PRIVATE SECTION.
   CLASS-DATA:
      go_instance TYPE REF TO zcl_appointment_singleton,
      gv_last_update TYPE timestampl.

    METHODS:
      update_if_time_elapsed,
      update_past_appointments,
      log_update_result IMPORTING iv_count TYPE i.
ENDCLASS.



CLASS zcl_appointment_singleton IMPLEMENTATION.
METHOD get_instance.
    IF go_instance IS NOT BOUND.
      CREATE OBJECT go_instance.
    ENDIF.
    ro_instance = go_instance.
  ENDMETHOD.

  METHOD check_and_update_if_needed.
    DATA(lo_instance) = get_instance( ).
    lo_instance->update_if_time_elapsed( ).
  ENDMETHOD.

  METHOD update_if_time_elapsed.
    DATA(lv_current_time) = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) ).

    " Actualizează doar dacă au trecut 15 minute de la ultima verificare
    IF lv_current_time - gv_last_update > 900. " 15 minute = 900 secunde
      update_past_appointments( ).
      gv_last_update = lv_current_time.
    ENDIF.
  ENDMETHOD.

  METHOD update_past_appointments.
    DATA(lv_current_date) = cl_abap_context_info=>get_system_date( ).
    DATA(lv_current_time) = cl_abap_context_info=>get_system_time( ).

    " Selectează programările din trecut care nu sunt cancelled sau completed
    SELECT appointment_id, doctor_id, appointment_date, appointment_start_time, status
      FROM zappointments

      WHERE ( appointment_date < @lv_current_date OR
              ( appointment_date = @lv_current_date AND
                appointment_start_time < @lv_current_time ) )
        AND status <> 'CANCELLED'
        AND status <> 'COMPLETED'
         INTO TABLE @DATA(lt_past_appointments).

    IF lines( lt_past_appointments ) > 0.
      " Actualizează direct în baza de date pentru eficiență maximă
      LOOP AT lt_past_appointments INTO DATA(ls_appointment).
        UPDATE zappointments
          SET status = 'COMPLETED',
              local_last_changed_at = @( cl_abap_tstmp=>utclong2tstmp( utclong_current( ) ) ),
              local_last_changed_by = @sy-uname,
              last_changed_at = @( cl_abap_tstmp=>utclong2tstmp( utclong_current( ) ) )
          WHERE appointment_id = @ls_appointment-appointment_id
            AND doctor_id = @ls_appointment-doctor_id.
      ENDLOOP.

      COMMIT WORK.

      " Log pentru monitorizare
      log_update_result( lines( lt_past_appointments ) ).
    ENDIF.
  ENDMETHOD.

  METHOD log_update_result.
    TRY.
        DATA(lo_log) = cl_bali_log=>create_with_header(
          header = cl_bali_header_setter=>create( object = 'ZAPPOINT'
                                                 subobject = 'STATUS'
                                                 external_id = |AUTO_UPDATE_{ sy-datum }_{ sy-uzeit }| ) ).

        DATA(lv_message) = |Auto-updated { iv_count } appointments to COMPLETED|.

        lo_log->add_item( item = cl_bali_message_setter=>create( severity = if_bali_constants=>c_severity_information
                                                               id = 'Z_APPOINTMENTS'
                                                               number = '001'
                                                               variable_1 = |{ iv_count }| ) ).

        cl_bali_log_db=>get_instance( )->save_log( log = lo_log ).

      CATCH cx_bali_runtime INTO DATA(lx_log).
        " Dacă Application Log nu funcționează, ignoră eroarea
        " În producție ai putea folosi o altă metodă de logging
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
