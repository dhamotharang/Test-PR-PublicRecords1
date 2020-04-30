
EXPORT mapping_reunion_customer_database(unsigned1 mode, STRING sVersion) := FUNCTION

clean := reunion.reunion_clean(mode);

//-----------------------------------------------------------------------------
// Items from reunion_clean where vendor='1' (indicating primary data source)
//-----------------------------------------------------------------------------
reunion.layouts.lCustomerDB tProject(clean L):=TRANSFORM
 SELF.orig_usernum:=L.orig_vendor_id;
 SELF.main_adl:=IF(L.did<>0,INTFORMAT(L.did,12,1),'');
 SELF:=L;
END;

return DEDUP(PROJECT(clean(vendor='1'),tProject(LEFT)),ALL);

END;