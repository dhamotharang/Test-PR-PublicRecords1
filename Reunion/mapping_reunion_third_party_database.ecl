//-----------------------------------------------------------------------------
// Items from reunion_clean where vendor<>'1' (indicating third party data
// source)
//-----------------------------------------------------------------------------
reunion.layouts.lThirdPartyDB tProject(reunion.reunion_clean L):=TRANSFORM
 SELF.orig_usernum:=L.orig_vendor_id;
 SELF.main_adl:=IF(L.did<>0,INTFORMAT(L.did,12,1),'');
 SELF.orig_street:=L.orig_strt;
 SELF.orig_city:=L.orig_locnm;
 SELF:=L;
END;

EXPORT mapping_reunion_third_party_database:=DEDUP(PROJECT(reunion.reunion_clean(vendor<>'1'),tProject(LEFT)),ALL);