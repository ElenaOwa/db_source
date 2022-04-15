@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer view'

@Search.searchable: true
define view entity ZODN_I_CUST
  as select from zodn_acust
{
      @UI.hidden: true
  key cust_uuid    as CustUuid,
      @UI.hidden: true
  key langu        as Langu,
      @UI.hidden: true
      customers_id as CustomersId,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      firstname    as Firstname,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      lastname     as Lastname
}
