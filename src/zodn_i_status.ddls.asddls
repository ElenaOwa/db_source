@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Status view'
@ObjectModel.resultSet.sizeCategory: #XS -- drop down menu for value help

define view entity ZODN_I_STATUS
  as select from zodn_astatus
{

  key status_uuid    as StatusUuid,
      @UI.textArrangement: #TEXT_ONLY
      @ObjectModel.text.element: [ 'Description' ]
      orderstatus_id as OrderstatusId,
      @UI.hidden: true
      orderstatus    as Orderstatus,
      @UI.hidden: true
      description    as Description
}
