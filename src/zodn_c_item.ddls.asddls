@EndUserText.label: 'Item projection view'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Search.searchable: true
define view entity ZODN_C_ITEM
  as projection on zodn_i_item
{
  key ItemsUuid,
      OrderUid,
      OrderId,
      @EndUserText.label: 'Position'
      ItemPosition,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Consumption.valueHelpDefinition: [{ entity : {name: 'ZODN_I_PRODUCT', element: 'GoodsId'  } }]
      @ObjectModel.text.element: ['Name']
      @EndUserText.label: 'Product'
      GoodsId,
      _Product.name as Name,
      @EndUserText.label: 'Quantity'
      Quantity,
      /* Associations */
      _Order : redirected to parent ZODN_C_ORDER,
      _Product
}
