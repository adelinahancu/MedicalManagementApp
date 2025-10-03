CLASS zv_insert_data_status DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_adt_classrun.
  methods add_status_data.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zv_insert_data_status IMPLEMENTATION.

method add_status_data.
data status type standard table of zstatus_dropdown.
 status = VALUE #(
 ( status = 'SCHEDULLED' )
 ( status = 'CANCELLED' )
 ( status = 'COMPLETED' ) ).

 INSERT zstatus_dropdown from table @status.
 ENDMETHOD.

 method if_oo_adt_classrun~main.
 add_status_data( ).
 out->write( 'Data inserted on status table.').
 ENDMETHOD.

ENDCLASS.
