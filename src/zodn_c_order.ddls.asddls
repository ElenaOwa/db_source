@EndUserText.label: 'Order projection view'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZODN_C_ORDER
  as projection on zodn_i_order
{
  key OrderUuid,
      OrderId,
      @ObjectModel.text.element: ['Status']
      @EndUserText.label: 'Status'
      @Consumption.valueHelpDefinition: [{ entity : {name: 'ZODN_I_STATUS', element: 'OrderstatusId'  } }]
      OrderstatusId,
      _Status.description as Status,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @ObjectModel.text.element: ['Name']
      @EndUserText.label: 'Customer'
      @Consumption.valueHelpDefinition: [{ entity : {name: 'ZODN_I_CUST', element: 'CustomersId'  } }]
      CustomersId,
      _Customer.lastname  as Name,
      OrderDate,
      OrderTime,
      StatusColor,
      /* Associations */
      _Customer,
      _OrderItem : redirected to composition child ZODN_C_ITEM,
      _Status
}
