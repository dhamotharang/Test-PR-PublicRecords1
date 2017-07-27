import LiensV2, address;

file_in := liensV2.NYFederal_DID;

liensV2.Layout_liens_party ttransform(liensv2.Layout_Liens_DID L) := transform

self.orig_name :=  L.DEBTOR_NAME;
self.orig_address1 := L.debtor_address1;
self.orig_address2 := L.debtor_address2 ;
self.orig_city :=  L.debtor_city;
self.orig_state :=  L.debtor_state;
self.orig_zip5 :=  L.debtor_zip5;
self.orig_zip4 := '';
self.orig_county := '';
self.orig_country :='';
self.tax_id := '';
self.ssn := '';
self.name_type :=  'D';
self.title :=  L.clean_debtor_title;
self.fname :=  L.clean_debtor_fname;
self.mname :=  L.clean_debtor_mname;
self.lname :=  L.clean_debtor_lname;
self.name_suffix := L.clean_debtor_name_suffix;
self.name_score  := L.clean_debtor_score;
self.prim_range  :=  L.clean_debtor_prim_range;
self.predir:=  L.clean_debtor_predir;
self.prim_name:= L.clean_debtor_prim_name;
self.addr_suffix:=  L.clean_debtor_addr_suffix;
self.postdir:=  L.clean_debtor_postdir;
self.unit_desig:= L.clean_debtor_unit_desig;
self.sec_range:=  L.clean_debtor_sec_range;
self.p_city_name:= L.clean_debtor_p_city_name;
self.v_city_name:= L.clean_debtor_v_city_name;
self.st:=  L.clean_debtor_st;
self.zip:=  L.clean_debtor_zip;
self.zip4:=  L.clean_debtor_zip4;
self.cart:=  L.clean_debtor_cart;
self.cr_sort_sz:=  L.clean_debtor_cr_sort_sz;
self.lot:=  L.clean_debtor_lot;
self.lot_order:=  L.clean_debtor_lot_order;
self.dbpc:=  L.clean_debtor_dpbc;
self.chk_digit:=  L.clean_debtor_chk_digit;
self.rec_type:=  L.clean_debtor_record_type;
self.county:=  L.clean_debtor_fipscounty;
self.geo_lat:= L.clean_debtor_geo_lat;
self.geo_long:= L.clean_debtor_geo_long ;
self.msa:= L.clean_debtor_msa;
self.geo_blk:= '';
self.geo_match:=  L.clean_debtor_geo_match;
self.err_stat:= L.clean_debtor_err_stat;
self.phone := '' ;
self.cname :=  L.clean_debtor_cname;
self.DID  :=  L.def_did;
self.BDID :=  L.def_bdid;
self := L ;
end;

NY_xfr :=  project(file_in, ttransform(left)) ;

//NY_dedup := sort(dedup(NY_xfr(orig_name <> ''), all),rmsid );
NY_sort  := sort(NY_xfr(orig_name <> ''), rmsid, -date_vendor_last_reported );

NY_dedup := dedup(NY_sort, except date_first_seen, date_last_seen, date_vendor_first_reported, date_vendor_last_reported);

export Mapping_NYFDLN_party := NY_dedup  ;