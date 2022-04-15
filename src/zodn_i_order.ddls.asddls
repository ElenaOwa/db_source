@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'Order view'
define root view entity zodn_i_order
  as select from zodn_aorder

  association [1..1] to zodn_acust   as _Customer on $projection.CustomersId = _Customer.customers_id
  association [1..1] to zodn_astatus as _Status   on $projection.OrderstatusId = _Status.orderstatus_id
  composition [0..*] of zodn_i_item  as _OrderItem
{
  key order_uuid     as OrderUuid,
      order_id       as OrderId,
      orderstatus_id as OrderstatusId,
      customers_id   as CustomersId,
      order_date     as OrderDate,
      order_time     as OrderTime,

      case _Status.orderstatus_id
      when 'S1'  then 2    -- 'In progress'       | 2: yellow colour
      when 'S2'  then 0    -- 'Closed'   | 0: grey
      when 'S3'  then 1    -- 'Canceled'   | 1: red colour
      when 'S4'  then 3 --'Ready' | 3: green
                 else 0    -- 'nothing'    | 0: unknown
       end           as StatusColor,
      _OrderItem,
      _Customer,
      _Status
}
