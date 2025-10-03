
@AbapCatalog.sqlViewName: 'ZI_STATUS_DROPD'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Status dropdown data definition'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS
define view zi_status_dropdown as select from zstatus_dropdown
{
    key status as Status
}
