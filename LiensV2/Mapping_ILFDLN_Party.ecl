import LiensV2, address;

file_in := liensV2.mapping_ILFDLN;

liensV2.Layout_liens_party tnormalize(liensV2.Layout_Liens_Temp_Base L, integer cnt) := transform

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
self.county:= choose(cnt,L.clean_debtor_ace_fips_st + L.clean_debtor_fipscounty, '');
self.geo_lat:= choose(cnt, L.clean_debtor_geo_lat, '');
self.geo_long:= choose(cnt, L.clean_debtor_geo_long, '');
self.msa:= choose(cnt, L.clean_debtor_msa,'');
self.geo_blk:= '';
self.geo_match:= choose(cnt, L.clean_debtor_geo_match,'' );
self.err_stat:= choose(cnt, L.clean_debtor_err_stat, '');
self.phone := '' ;
self.cname := choose(cnt, L.clean_debtor_cname,L.creditor_name);
self.date_first_seen                :=      L.orig_filing_date;
self.date_last_seen                 :=      L.release_date;
self.date_vendor_first_reported     :=      L.process_date;
self.date_vendor_last_reported      :=      L.process_date;
self := L;
end;

IL_norm := normalize(file_in, 2, tnormalize(left, counter));
IL_dist := distribute(IL_norm(lname <> '' or fname <> '' or mname <> '' or cname <> ''), hash(tmsid,rmsid));

ILFDLN_sort  := sort(IL_dist,record,EXCEPT Date_First_Seen, Date_Last_Seen,
			   Date_Vendor_First_Reported, Date_Vendor_Last_Reported,name_type, local);

liensV2.Layout_liens_party  rollupXform(liensV2.Layout_liens_party l, liensV2.Layout_liens_party r) := transform
		self.Date_First_Seen := if(l.Date_First_Seen > r.Date_First_Seen, r.Date_First_Seen, l.Date_First_Seen);
		self.Date_Last_Seen  := if(l.Date_Last_Seen  < r.Date_Last_Seen,  r.Date_Last_Seen,  l.Date_Last_Seen);
		self.Date_Vendor_First_Reported := if(l.Date_Vendor_First_Reported > r.Date_Vendor_First_Reported, r.Date_Vendor_First_Reported, l.Date_Vendor_First_Reported);
		self.Date_Vendor_Last_Reported  := if(l.Date_Vendor_Last_Reported  < r.Date_Vendor_Last_Reported,  r.Date_Vendor_Last_Reported, l.Date_Vendor_Last_Reported);
		self := l;
end;

export mapping_ILFDLN_party := rollup(ILFDLN_sort,rollupXform(LEFT,RIGHT),RECORD,
                                EXCEPT Date_First_Seen, Date_Last_Seen,
																Date_Vendor_First_Reported, Date_Vendor_Last_Reported, name_type,local);



