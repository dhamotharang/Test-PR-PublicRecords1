import LiensV2, address;

file_in := liensV2.Mapping_CA_Federal;

liensV2.Layout_liens_party tnormalize(liensv2.Layout_Liens_temp_base L, integer cnt) := transform

self.orig_name := choose(Cnt, L.DEBTOR_NAME , L.creditor_name);
self.orig_lname := choose(Cnt, L.debtor_lname , L.creditor_lname);
self.orig_fname := choose(Cnt, L.debtor_fname , L.creditor_fname);
self.orig_mname := choose(Cnt, L.debtor_mname , L.creditor_mname);
self.orig_address1 := choose(cnt, L.debtor_address1, L.creditor_address1);
self.orig_address2 := '';
self.orig_city := choose(cnt, L.debtor_city, L.creditor_city);
self.orig_state := choose(cnt, L.debtor_state, L.creditor_state);
self.orig_zip5 := choose(cnt, L.debtor_zip5, L.creditor_zip5);
self.orig_zip4 := choose(cnt, L.debtor_zip4, L.creditor_zip4);
self.orig_county := '';
self.orig_country := choose(cnt, L.debtor_country, L.creditor_country);
self.tax_id := '';
self.ssn := '';
self.name_type := choose(cnt, 'D', 'C');
self.title := choose(cnt, L.clean_debtor_title, L.clean_creditor_title);
self.fname := choose(cnt, L.clean_debtor_fname, L.clean_creditor_fname);
self.mname := choose(cnt, L.clean_debtor_mname, L.clean_creditor_mname);
self.lname := choose(cnt, L.clean_debtor_lname, L.clean_creditor_lname);
self.name_suffix := choose(cnt, L.clean_debtor_name_suffix, L.clean_creditor_name_suffix);
self.name_score  := choose(cnt, L.clean_debtor_score, L.clean_creditor_score);
self.prim_range  := choose(cnt, L.clean_debtor_prim_range, L.clean_creditor_prim_range);
self.predir:= choose(cnt, L.clean_debtor_predir, L.clean_creditor_predir);
self.prim_name:= choose(cnt, L.clean_debtor_prim_name, L.clean_creditor_prim_name);
self.addr_suffix:= choose(cnt, L.clean_debtor_addr_suffix, L.clean_creditor_addr_suffix);
self.postdir:= choose(cnt, L.clean_debtor_postdir, L.clean_creditor_postdir);
self.unit_desig:= choose(cnt, L.clean_debtor_unit_desig, L.clean_creditor_unit_desig);
self.sec_range:= choose(cnt, L.clean_debtor_sec_range, L.clean_creditor_sec_range);
self.p_city_name:= choose(cnt, L.clean_debtor_p_city_name, L.clean_creditor_p_city_name);
self.v_city_name:= choose(cnt, L.clean_debtor_v_city_name, L.clean_creditor_v_city_name);
self.st:= choose(cnt, L.clean_debtor_st, L.clean_creditor_st);
self.zip:= choose(cnt, L.clean_debtor_zip, L.clean_creditor_zip);
self.zip4:= choose(cnt, L.clean_debtor_zip4, L.clean_creditor_zip4);
self.cart:= choose(cnt, L.clean_debtor_cart, L.clean_creditor_cart);
self.cr_sort_sz:= choose(cnt, L.clean_debtor_cr_sort_sz, L.clean_creditor_cr_sort_sz);
self.lot:= choose(cnt, L.clean_debtor_lot, L.clean_creditor_lot);
self.lot_order:= choose(cnt, L.clean_debtor_lot_order, L.clean_creditor_lot_order);
self.dbpc:= choose(cnt, L.clean_debtor_dpbc, L.clean_creditor_dpbc);
self.chk_digit:= choose(cnt, L.clean_debtor_chk_digit, L.clean_creditor_chk_digit);
self.rec_type:= choose(cnt, L.clean_debtor_record_type, L.clean_creditor_record_type);
self.county:= choose(cnt, L.clean_debtor_ace_fips_st + L.clean_debtor_fipscounty, L.clean_creditor_ace_fips_st + L.clean_creditor_fipscounty);
self.geo_lat:= choose(cnt, L.clean_debtor_geo_lat, L.clean_creditor_geo_lat);
self.geo_long:= choose(cnt, L.clean_debtor_geo_long, L.clean_creditor_geo_long);
self.msa:= choose(cnt, L.clean_debtor_msa, L.clean_creditor_msa);
self.geo_blk:= '';
self.geo_match:= choose(cnt, L.clean_debtor_geo_match, L.clean_creditor_geo_match);
self.err_stat:= choose(cnt, L.clean_debtor_err_stat, L.clean_creditor_err_stat);
self.phone := '';
self.cname := choose(cnt, L.clean_debtor_cname, L.clean_creditor_cname);
//self.DID  := choose(cnt, L.def_did, L.creditor_did);
//self.BDID := choose(cnt, L.def_bdid, L.creditor_bdid);
self.date_first_seen                :=      if(L.filing_date <> '', L.filing_date, L.orig_filing_date);
self.date_last_seen                 :=      if(L.filing_date <> '', L.filing_date, L.orig_filing_date);
self.date_vendor_first_reported     :=      L.process_date;
self.date_vendor_last_reported      :=      L.process_date;

self := L;
end;

CA_federal_norm := normalize(file_in, 2, tnormalize(left, counter));

CA_federal_dist := distribute(CA_federal_norm(lname <> '' or fname <> '' or mname <> '' or cname <> ''), hash(tmsid,rmsid));

CA_federal_sort  := sort(CA_federal_dist,record,EXCEPT Date_First_Seen, Date_Last_Seen,
			   Date_Vendor_First_Reported, Date_Vendor_Last_Reported,name_type, local);

liensV2.Layout_liens_party  rollupXform(liensV2.Layout_liens_party l, liensV2.Layout_liens_party r) := transform
		self.Date_First_Seen := if(l.Date_First_Seen > r.Date_First_Seen, r.Date_First_Seen, l.Date_First_Seen);
		self.Date_Last_Seen  := if(l.Date_Last_Seen  < r.Date_Last_Seen,  r.Date_Last_Seen,  l.Date_Last_Seen);
		self.Date_Vendor_First_Reported := if(l.Date_Vendor_First_Reported > r.Date_Vendor_First_Reported, r.Date_Vendor_First_Reported, l.Date_Vendor_First_Reported);
		self.Date_Vendor_Last_Reported  := if(l.Date_Vendor_Last_Reported  < r.Date_Vendor_Last_Reported,  r.Date_Vendor_Last_Reported, l.Date_Vendor_Last_Reported);
		self := l;
end;

export mapping_CA_federal_party := rollup(CA_federal_sort,rollupXform(LEFT,RIGHT),RECORD,
                                EXCEPT Date_First_Seen, Date_Last_Seen,
																Date_Vendor_First_Reported, Date_Vendor_Last_Reported, name_type,local);



