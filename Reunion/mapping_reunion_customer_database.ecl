//-----------------------------------------------------------------------------
// Items from reunion_clean where vendor='1' (indicating primary data source)
//-----------------------------------------------------------------------------
reunion.layouts.lCustomerDB tProject(reunion.reunion_clean L):=TRANSFORM
 SELF.orig_usernum:=L.orig_vendor_id;
 SELF.main_adl:=IF(L.did<>0,INTFORMAT(L.did,12,1),'');
 SELF:=L;
END;

EXPORT mapping_reunion_customer_database:=DEDUP(PROJECT(reunion.reunion_clean(vendor='1'),tProject(LEFT)),ALL);