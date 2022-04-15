@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'Item view'

define view entity zodn_i_item
  as select from zodn_aitems

  association        to parent zodn_i_order as _Order   on $projection.OrderUid = _Order.OrderUuid

  association [1..1] to zodn_agoods         as _Product on $projection.GoodsId = _Product.goods_id
{
  key items_uuid    as ItemsUuid,
      order_uuid    as OrderUid,
      order_id      as OrderId,
      item_position as ItemPosition,
      goods_id      as GoodsId,
      quantity      as Quantity,

      _Order,
      _Product
}
