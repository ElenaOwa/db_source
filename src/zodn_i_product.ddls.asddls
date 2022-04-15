@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product view'

@Search.searchable: true
define view entity ZODN_I_PRODUCT
  as select from zodn_agoods
{
      @UI.hidden: true
  key product_uuid as ProductUuid,
      @UI.hidden: true
  key langu        as Langu,
      goods_id     as GoodsId,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      name         as Name
}
