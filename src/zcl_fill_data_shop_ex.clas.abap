CLASS zcl_fill_data_shop_ex DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_fill_data_shop_ex IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*    DELETE FROM zodn_acust.
*    INSERT zodn_acust FROM TABLE @( VALUE #( ( client ='100' cust_uuid = '2083274D4CB35DDD1700A4FADF41BA5D' langu ='E' customers_id ='000221' firstname ='Polly' lastname ='Window'  )
*    ( client ='100' cust_uuid = '2083274D4CB35DDD1701A4FADF41BA5D' langu ='E' customers_id ='000222' firstname ='Vin' lastname ='Din'  )
*    ( client ='100' cust_uuid = '2083274D4CB35DDD1702A4FADF41BA5D' langu ='E' customers_id ='000223' firstname ='Misha' lastname ='Fox'  )
*    ( client ='100' cust_uuid = '2083274D4CB35DDD1703A4FADF41BA5D' langu ='E' customers_id ='000224' firstname ='Lora' lastname ='Fire'  )
*    (  client ='100' cust_uuid = '2083274D4CB35DDD1704A4FADF41BA5D' langu ='E' customers_id ='000225' firstname ='Frog' lastname ='Guy'  )
*    (  client ='100' cust_uuid = '2083274D4CB35DDD1705A4FADF41BA5D' langu ='E' customers_id ='000226' firstname ='Simple' lastname ='Summer'  )
*    (  client ='100' cust_uuid = '2083274D4CB35DDD1706A4FADF41BA5D' langu ='E' customers_id ='000227' firstname ='Asya' lastname ='Shark'  ) )  ).
*
*    DELETE FROM  zodn_agoods.
*    INSERT zodn_agoods FROM TABLE @( VALUE #( ( client ='100'  product_uuid = '3192274D4CB35DDD1700A4FADF41BA5D' langu ='E' goods_id ='000001' name ='Xiaomi'  )
*    ( client ='100' product_uuid = '3192274D4CB35DDD1701A4FADF41BA5D' langu ='E' goods_id ='000002' name ='iPhone'  )
*    ( client ='100'  product_uuid = '3192274D4CB35DDD1702A4FADF41BA5D' langu ='E' goods_id ='000003' name ='Samsung'  )
*    ( client ='100'  product_uuid = '3192274D4CB35DDD1703A4FADF41BA5D' langu ='E' goods_id ='000004' name ='Honors'  )
*    ( client ='100'  product_uuid = '3192274D4CB35DDD1704A4FADF41BA5D' langu ='E' goods_id ='000005' name ='BQ'  )
*    ( client ='100'  product_uuid = '3192274D4CB35DDD1705A4FADF41BA5D' langu ='E' goods_id ='000006' name ='Mi Watch'  )
*    ( client ='100'  product_uuid = '3192274D4CB35DDD1706A4FADF41BA5D' langu ='E' goods_id ='000007' name ='Jet Wizard'  )
*    ( client ='100'  product_uuid = '3192274D4CB35DDD1707A4FADF41BA5D' langu ='E' goods_id ='000008' name ='Lenovo'  )
*    ( client ='100'  product_uuid = '3192274D4CB35DDD1708A4FADF41BA5D' langu ='E' goods_id ='000009' name ='MacBook'  )
*    ( client ='100'  product_uuid = '3192274D4CB35DDD1709A4FADF41BA5D' langu ='E' goods_id ='000010' name ='Sony'  )
*    ) ).
*
*    DELETE FROM zodn_astatus.
*    INSERT zodn_astatus FROM TABLE @( VALUE #( ( client ='100' status_uuid = '8C92274D4CB35DDD1700A4FADF41BA5D' orderstatus_id ='S1' orderstatus ='1'   description = 'In progress')
* ( client ='100' status_uuid = '8C92274D4CB35DDD1701A4FADF41BA5D' orderstatus_id ='S2' orderstatus ='2'  description = 'Closed')
* ( client ='100' status_uuid = '8C92274D4CB35DDD1702A4FADF41BA5D' orderstatus_id ='S3' orderstatus ='3'  description = 'Canceled')
* ( client ='100' status_uuid = '8C92274D4CB35DDD1703A4FADF41BA5D' orderstatus_id ='S4' orderstatus ='4'  description = 'Ready')
*    ) ).

  DELETE FROM zodn_aitems.
    INSERT zodn_aitems FROM TABLE @( VALUE #( ( client ='100' items_uuid = '2A82274D4CB35DDD1700A4FADF41BA5D' order_uuid = '2B82274D4CB35DDD1700A4FADF41BA5D' order_id = '1001' item_position ='002' goods_id ='000010' quantity ='1'  )
    ( client ='100' items_uuid = '2A82274D4CB35DDD1701A4FADF41BA5D' order_uuid = '2B82274D4CB35DDD1701A4FADF41BA5D' order_id = '1002' item_position ='001' goods_id ='000002' quantity ='1'  )
    ( client ='100' items_uuid = '2A82274D4CB35DDD1702A4FADF41BA5D' order_uuid = '2B82274D4CB35DDD1702A4FADF41BA5D' order_id = '1003' item_position ='001' goods_id ='000006' quantity ='2'  )
    ( client ='100' items_uuid = '2A82274D4CB35DDD1703A4FADF41BA5D' order_uuid = '2B82274D4CB35DDD1703A4FADF41BA5D' order_id = '1004' item_position ='002' goods_id ='000004' quantity ='1'  )
    ( client ='100' items_uuid = '2A82274D4CB35DDD1704A4FADF41BA5D' order_uuid = '2B82274D4CB35DDD1704A4FADF41BA5D' order_id = '115' item_position ='001' goods_id ='000007' quantity ='1'  )
    ( client ='100' items_uuid = '2A82274D4CB35DDD1705A4FADF41BA5D' order_uuid = '2B82274D4CB35DDD1704A4FADF41BA5D' order_id = '115' item_position ='002' goods_id ='000010' quantity ='2'  )
    ( client ='100' items_uuid = '2A82274D4CB35DDD1706A4FADF41BA5D' order_uuid = '2B82274D4CB35DDD1706A4FADF41BA5D' order_id = '116' item_position ='001' goods_id ='000008' quantity ='2'  )
    ( client ='100' items_uuid = '2A82274D4CB35DDD1707A4FADF41BA5D' order_uuid = '2B82274D4CB35DDD1706A4FADF41BA5D' order_id = '116' item_position ='002' goods_id ='000004' quantity ='1'  )
    )  ).
  DELETE FROM zodn_aorder.
    INSERT zodn_aorder FROM TABLE @( VALUE #( ( client ='100' order_uuid = '2B82274D4CB35DDD1700A4FADF41BA5D' order_id = '1001' orderstatus_id ='S1' customers_id ='000221'  order_date ='20211202' order_time ='110500'   )
    ( client ='100' order_uuid = '2B82274D4CB35DDD1701A4FADF41BA5D' order_id = '1002' orderstatus_id ='S4' customers_id ='000222'  order_date ='20211120' order_time ='213700'   )
    ( client ='100' order_uuid = '2B82274D4CB35DDD1702A4FADF41BA5D' order_id = '1003' orderstatus_id ='S2' customers_id ='000223'  order_date ='20210517' order_time ='104000'   )
    ( client ='100' order_uuid = '2B82274D4CB35DDD1704A4FADF41BA5D' order_id = '115'  orderstatus_id ='S1' customers_id ='000227'  order_date ='20220206' order_time ='163417'   )
    ( client ='100' order_uuid = '2B82274D4CB35DDD1706A4FADF41BA5D'  order_id = '116' orderstatus_id ='S1' customers_id ='000224'  order_date ='20220211' order_time ='143848'   )
    ( client ='100' order_uuid = '2B82274D4CB35DDD1703A4FADF41BA5D' order_id = '1004'  orderstatus_id ='S1' customers_id ='000227'  order_date ='20220306' order_time ='163417'   )
    ) ).

    out->write( 'Data inserted.').
  ENDMETHOD.
ENDCLASS.
