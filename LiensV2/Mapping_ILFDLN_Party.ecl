import LiensV2, address;

file_in := liensV2.ILFederal_DID;

liensV2.Layout_liens_party tnormalize(liensv2.Layout_Liens_DID L, integer cnt) := transform

self.orig_name := choose(Cnt, L.DEBTOR_NAME, L.creditor_name);
self.orig_address1 := choose(cnt, L.debtor_address1, '' );
self.orig_address2 := '';
self.orig_city := choose(cnt, L.debtor_city,'' );
self.orig_state := choose(cnt, L.debtor_state, '');
self.orig_zip5 := choose(cnt, L.debtor_zip5, '');
self.orig_zip4 := '';
self.orig_county := '';
self.orig_country :='';
self.tax_id := choose(cnt,L.debtor_tax_id, '');
self.ssn := choose(cnt,L.debtor_ssn, '') ;
self.name_type := choose(cnt, 'D', 'C');
self.title := choose(cnt, L.clean_debtor_title, '');
self.fname := choose(cnt, L.clean_debtor_fname, '');
self.mname := choose(cnt, L.clean_debtor_mname, '');
self.lname := choose(cnt, L.clean_debtor_lname, '');
self.name_suffix := choose(cnt, L.clean_debtor_name_suffix, '');
self.name_score  := choose(cnt, L.clean_debtor_score, '');
self.prim_range  := choose(cnt, L.clean_debtor_prim_range, '');
self.predir:= choose(cnt, L.clean_debtor_predir, '');
self.prim_name:= choose(cnt, L.clean_debtor_prim_name, '');
self.addr_suffix:= choose(cnt, L.clean_debtor_addr_suffix,'');
self.postdir:= choose(cnt, L.clean_debtor_postdir, '');
self.unit_desig:= choose(cnt, L.clean_debtor_unit_desig, '');
self.sec_range:= choose(cnt, L.clean_debtor_sec_range, '');
self.p_city_name:= choose(cnt, L.clean_debtor_p_city_name, '');
self.v_city_name:= choose(cnt, L.clean_debtor_v_city_name, '');
self.st:= choose(cnt, L.clean_debtor_st, '');
self.zip:= choose(cnt, L.clean_debtor_zip, '');
self.zip4:= choose(cnt, L.clean_debtor_zip4, '');
self.cart:= choose(cnt, L.clean_debtor_cart, '');
self.cr_sort_sz:= choose(cnt, L.clean_debtor_cr_sort_sz,'');
self.lot:= choose(cnt, L.clean_debtor_lot, '');
self.lot_order:= choose(cnt, L.clean_debtor_lot_order, '');
self.dbpc:= choose(cnt, L.clean_debtor_dpbc, '');
self.chk_digit:= choose(cnt, L.clean_debtor_chk_digit, '');
self.rec_type:= choose(cnt, L.clean_debtor_record_type, '');
self.county:= choose(cnt, L.clean_debtor_fipscounty, '');
self.geo_lat:= choose(cnt, L.clean_debtor_geo_lat, '');
self.geo_long:= choose(cnt, L.clean_debtor_geo_long, '');
self.msa:= choose(cnt, L.clean_debtor_msa,'');
self.geo_blk:= '';
self.geo_match:= choose(cnt, L.clean_debtor_geo_match,'' );
self.err_stat:= choose(cnt, L.clean_debtor_err_stat, '');
self.phone := '' ;
self.cname := choose(cnt, L.clean_debtor_cname,'');
self.DID  := choose(cnt, L.def_did, '');
self.BDID := choose(cnt, L.def_bdid, '' );
self := L;
end;

IL_norm := normalize(file_in, 2, tnormalize(left, counter));

//IL_dedup := dedup(IL_norm(orig_name <> ''), all);

IL_sort  := sort(IL_norm(orig_name <> ''), rmsid, -date_vendor_last_reported );

IL_dedup := dedup(IL_sort, except date_first_seen, date_last_seen, date_vendor_first_reported, date_vendor_last_reported);

export Mapping_ILFDLN_Party := IL_dedup ;