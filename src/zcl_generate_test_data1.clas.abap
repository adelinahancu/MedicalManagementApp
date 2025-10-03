CLASS zcl_generate_test_data1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_generate_test_data1 IMPLEMENTATION.
method if_oo_adt_classrun~main.
DELETE FROM zspecializations.
    DELETE FROM zdoctors.
    DELETE FROM zpatients.

     DATA:lv_spec_uuid1 TYPE sysuuid_x16,
          lv_spec_uuid2 TYPE sysuuid_x16,
          lv_spec_uuid3 TYPE sysuuid_x16,
          lv_spec_uuid4 TYPE sysuuid_x16,

          lv_doc_uuid1  TYPE sysuuid_x16,
          lv_doc_uuid2  TYPE sysuuid_x16,
          lv_doc_uuid3  TYPE sysuuid_x16,
          lv_doc_uuid4  TYPE sysuuid_x16,
          lv_doc_uuid5  TYPE sysuuid_x16,

          lv_pat_uuid1  TYPE sysuuid_x16,
          lv_pat_uuid2  TYPE sysuuid_x16,
          lv_pat_uuid3  TYPE sysuuid_x16,
          lv_pat_uuid4  TYPE sysuuid_x16,
          lv_pat_uuid5  TYPE sysuuid_x16.


TRY.
*    " Generare UUID-uri pentru Specializations
    lv_spec_uuid1 = cl_system_uuid=>create_uuid_x16_static( ).
    lv_spec_uuid2 = cl_system_uuid=>create_uuid_x16_static( ).
    lv_spec_uuid3 = cl_system_uuid=>create_uuid_x16_static( ).
    lv_spec_uuid4 = cl_system_uuid=>create_uuid_x16_static( ).

*    " Generare UUID-uri pentru Doctors
    lv_doc_uuid1 = cl_system_uuid=>create_uuid_x16_static( ).
    lv_doc_uuid2 = cl_system_uuid=>create_uuid_x16_static( ).
    lv_doc_uuid3 = cl_system_uuid=>create_uuid_x16_static( ).
    lv_doc_uuid4 = cl_system_uuid=>create_uuid_x16_static( ).
    lv_doc_uuid5 = cl_system_uuid=>create_uuid_x16_static( ).

*    " Generare UUID-uri pentru Patients
    lv_pat_uuid1 = cl_system_uuid=>create_uuid_x16_static( ).
    lv_pat_uuid2 = cl_system_uuid=>create_uuid_x16_static( ).
    lv_pat_uuid3 = cl_system_uuid=>create_uuid_x16_static( ).
    lv_pat_uuid4 = cl_system_uuid=>create_uuid_x16_static( ).
    lv_pat_uuid5 = cl_system_uuid=>create_uuid_x16_static( ).



catch cx_uuid_error into data(lx_uuid_error).
    out->write( |Error generating uuids :{ lx_uuid_error->get_text( ) }| ).
    return.
    ENDTRY.

    TRY.
      INSERT zspecializations FROM TABLE @( VALUE #(
      ( client = sy-mandt specialization_id = lv_spec_uuid1
        specialization_code = 'CARDIO' title = 'Cardiologie'
        description = 'Specialist în boli cardiovasculare și de inimă'
        created_by = sy-uname created_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        local_last_changed_by = sy-uname local_last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) ) )

      ( client = sy-mandt specialization_id = lv_spec_uuid2
        specialization_code = 'NEURO' title = 'Neurologie'
        description = 'Specialist în sistemul nervos și creier'
        created_by = sy-uname created_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        local_last_changed_by = sy-uname local_last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) ) )

      ( client = sy-mandt specialization_id = lv_spec_uuid3
        specialization_code = 'ORTHO' title = 'Ortopedie'
        description = 'Specialist în oase, articulații și mușchi'
        created_by = sy-uname created_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        local_last_changed_by = sy-uname local_last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) ) )

      ( client = sy-mandt specialization_id = lv_spec_uuid4
        specialization_code = 'DERMATO' title = 'Dermatologie'
        description = 'Specialist în afecțiuni ale pielii'
        created_by = sy-uname created_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        local_last_changed_by = sy-uname local_last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) ) )
    ) ).

*    " 2. Insert Patients
    INSERT zpatients FROM TABLE @( VALUE #(
      ( client = sy-mandt patient_id = lv_pat_uuid1
        first_name = 'Ana' last_name = 'Dumitrescu'
        phone_number = '0731111111' email = 'ana.dumitrescu@email.ro'
        date_of_birth = '19850315' has_assurance = abap_true
        created_by = sy-uname created_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        local_last_changed_by = sy-uname local_last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) ) )

      ( client = sy-mandt patient_id = lv_pat_uuid2
        first_name = 'Mihai' last_name = 'Radu'
        phone_number = '0732222222' email = 'mihai.radu@email.ro'
        date_of_birth = '19901220' has_assurance = abap_false
        created_by = sy-uname created_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        local_last_changed_by = sy-uname local_last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) ) )

      ( client = sy-mandt patient_id = lv_pat_uuid3
        first_name = 'Elena' last_name = 'Stoica'
        phone_number = '0733333333' email = 'elena.stoica@email.ro'
        date_of_birth = '19780708' has_assurance = abap_true
        created_by = sy-uname created_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        local_last_changed_by = sy-uname local_last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) ) )

      ( client = sy-mandt patient_id = lv_pat_uuid4
        first_name = 'Cristian' last_name = 'Marinescu'
        phone_number = '0734444444' email = 'cristian.marinescu@email.ro'
        date_of_birth = '19920505' has_assurance = abap_true
        created_by = sy-uname created_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        local_last_changed_by = sy-uname local_last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) ) )

      ( client = sy-mandt patient_id = lv_pat_uuid5
        first_name = 'Roxana' last_name = 'Popa'
        phone_number = '0735555555' email = 'roxana.popa@email.ro'
        date_of_birth = '19881012' has_assurance = abap_false
        created_by = sy-uname created_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        local_last_changed_by = sy-uname local_last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) ) )
    ) ).

*    3. Insert Doctors (cu referințe corecte la specializations)
    INSERT zdoctors FROM TABLE @( VALUE #(
      ( client = sy-mandt doctor_id = lv_doc_uuid1
        first_name = 'Ion' last_name = 'Popescu'
        specialization_id = lv_spec_uuid1 phone_number = '0721123456'
        email = 'ion.popescu@hospital.ro' is_at_work = abap_true years_experience = 15
        created_by = sy-uname created_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        local_last_changed_by = sy-uname local_last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) ) )

      ( client = sy-mandt doctor_id = lv_doc_uuid2
        first_name = 'Maria' last_name = 'Ionescu'
        specialization_id = lv_spec_uuid2 phone_number = '0722234567'
        email = 'maria.ionescu@hospital.ro' is_at_work = abap_true years_experience = 10
        created_by = sy-uname created_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        local_last_changed_by = sy-uname local_last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) ) )

      ( client = sy-mandt doctor_id = lv_doc_uuid3
        first_name = 'Andrei' last_name = 'Georgescu'
        specialization_id = lv_spec_uuid3 phone_number = '0723345678'
        email = 'andrei.georgescu@hospital.ro' is_at_work = abap_true years_experience = 8
        created_by = sy-uname created_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        local_last_changed_by = sy-uname local_last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) ) )

      ( client = sy-mandt doctor_id = lv_doc_uuid4
        first_name = 'Carmen' last_name = 'Vasilescu'
        specialization_id = lv_spec_uuid4 phone_number = '0724456789'
        email = 'carmen.vasilescu@hospital.ro' is_at_work = abap_true years_experience = 12
        created_by = sy-uname created_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        local_last_changed_by = sy-uname local_last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) ) )

      ( client = sy-mandt doctor_id = lv_doc_uuid5
        first_name = 'Alexandru' last_name = 'Munteanu'
        specialization_id = lv_spec_uuid1 phone_number = '0725567890'
        email = 'alexandru.munteanu@hospital.ro' is_at_work = abap_false years_experience = 20
        created_by = sy-uname created_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        local_last_changed_by = sy-uname local_last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) )
        last_changed_at = cl_abap_tstmp=>utclong2tstmp( utclong_current( ) ) )
    ) ).

*

*     Output rezultate
    out->write( |=== TEST DATA GENERATED SUCCESSFULLY ===| ).
    out->write( |Specializations: 4 records| ).
    out->write( |Patients: 5 records| ).
    out->write( |Doctors: 5 records| ).
    out->write( |=====================================| ).

catch cx_sy_open_sql_db into DATA(lx_sql_error).
out->write( |Database error: { lx_sql_error->get_text( ) }| ).

 CATCH cx_root INTO DATA(lx_general_error).
        out->write( |General error: { lx_general_error->get_text( ) }| ).

    ENDTRY.





    ENDMETHOD.

ENDCLASS.
