import LiensV2, address;

file_in := LiensV2.Mapping_Hogan;

rec_temp := record

string1 ADDDELFLAG := '';
qstring34  vendor_id := '';
liensV2.Layout_liens_party_for_hogan;
end;

rec_temp tnormalize(liensV2.Layout_Liens_temp_base L, integer cnt) := transform
city := choose(cnt, L.debtor_city, L.creditor_city, L.atty_city);
self.vendor_id := L.record_code;
self.orig_rmsid := L.orig_rmsid;
self.bCBFlag	:= L.bCBFlag;
self.eviction	:= L.eviction;
SELF.dob	:= CHOOSE(cnt, L.DOB, '', '');
self.orig_name := choose(Cnt, L.DEBTOR_NAME, L.creditor_name, L.ATTY_name);
self.orig_address1 := choose(cnt, L.debtor_address1, L.creditor_address1, L.atty_address1);
self.orig_address2 := '';

self.orig_state := choose(cnt, L.debtor_state, L.creditor_state, L.atty_state);
self.orig_city := map(city = 'BX' and self.orig_state = 'NY'=>'BRONX',city);

self.orig_zip5 := choose(cnt, L.debtor_zip5, L.creditor_zip5, L.atty_zip5);
self.orig_zip4 := '';
self.orig_county := '';
self.orig_country :='';
self.tax_id := choose(cnt, L.debtor_tax_id, '', '');
self.ssn := choose(cnt, if(l.debtor_ssn[1..5] in ['', 'XXXXX', 'xxxxx'] and l.debtor_ssn <> '', '00000'+l.debtor_ssn[6..9], l.debtor_ssn), '', '');
self.name_type := choose(cnt, 'D', 'C', 'A');
self.title := choose(cnt, L.clean_debtor_title, L.clean_creditor_title, L.clean_atty_title);
self.fname := choose(cnt, L.clean_debtor_fname, L.clean_creditor_fname, L.clean_atty_fname);
self.mname := choose(cnt, L.clean_debtor_mname, L.clean_creditor_mname, L.clean_atty_mname);
self.lname := choose(cnt, L.clean_debtor_lname, L.clean_creditor_lname, L.clean_atty_lname);
self.name_suffix := choose(cnt, L.clean_debtor_name_suffix, L.clean_creditor_name_suffix, L.clean_atty_name_suffix);
self.name_score  := choose(cnt, L.clean_debtor_score, L.clean_creditor_score, L.clean_atty_score);
self.prim_range  := choose(cnt, L.clean_debtor_prim_range, L.clean_creditor_prim_range, L.clean_atty_prim_range);
self.predir:= choose(cnt, L.clean_debtor_predir, L.clean_creditor_predir, L.clean_atty_predir);
self.prim_name:= choose(cnt, L.clean_debtor_prim_name, L.clean_creditor_prim_name, L.clean_atty_prim_name);
self.addr_suffix:= choose(cnt, L.clean_debtor_addr_suffix, L.clean_creditor_addr_suffix, L.clean_atty_addr_suffix);
self.postdir:= choose(cnt, L.clean_debtor_postdir, L.clean_creditor_postdir, L.clean_atty_postdir);
self.unit_desig:= choose(cnt, L.clean_debtor_unit_desig, L.clean_creditor_unit_desig, L.clean_atty_unit_desig);
self.sec_range:= choose(cnt, L.clean_debtor_sec_range, L.clean_creditor_sec_range, L.clean_atty_sec_range);
self.p_city_name:= choose(cnt, L.clean_debtor_p_city_name, L.clean_creditor_p_city_name, L.clean_atty_p_city_name);
self.v_city_name:= choose(cnt, L.clean_debtor_v_city_name, L.clean_creditor_v_city_name, L.clean_atty_v_city_name);
self.st:= choose(cnt, L.clean_debtor_st, L.clean_creditor_st, L.clean_atty_st);
self.zip:= choose(cnt, L.clean_debtor_zip, L.clean_creditor_zip, L.clean_atty_zip);
self.zip4:= choose(cnt, L.clean_debtor_zip4, L.clean_creditor_zip4, L.clean_atty_zip4);
self.cart:= choose(cnt, L.clean_debtor_cart, L.clean_creditor_cart, L.clean_atty_cart);
self.cr_sort_sz:= choose(cnt, L.clean_debtor_cr_sort_sz, L.clean_creditor_cr_sort_sz, L.clean_atty_cr_sort_sz);
self.lot:= choose(cnt, L.clean_debtor_lot, L.clean_creditor_lot, L.clean_atty_lot);
self.lot_order:= choose(cnt, L.clean_debtor_lot_order, L.clean_creditor_lot_order, L.clean_atty_lot_order);
self.dbpc:= choose(cnt, L.clean_debtor_dpbc, L.clean_creditor_dpbc, L.clean_atty_dpbc);
self.chk_digit:= choose(cnt, L.clean_debtor_chk_digit, L.clean_creditor_chk_digit, L.clean_atty_chk_digit);
self.rec_type:= choose(cnt, L.clean_debtor_record_type, L.clean_creditor_record_type, L.clean_atty_record_type);
self.county:= choose(cnt,L.clean_debtor_ace_fips_st + L.clean_debtor_fipscounty, L.clean_creditor_ace_fips_st + L.clean_creditor_fipscounty, L.clean_atty_ace_fips_st + L.clean_atty_fipscounty);
self.geo_lat:= choose(cnt, L.clean_debtor_geo_lat, L.clean_creditor_geo_lat, L.clean_atty_geo_lat);
self.geo_long:= choose(cnt, L.clean_debtor_geo_long, L.clean_creditor_geo_long, L.clean_atty_geo_long);
self.msa:= choose(cnt, L.clean_debtor_msa, L.clean_creditor_msa, L.clean_atty_msa);
self.geo_blk:= '';
self.geo_match:= choose(cnt, L.clean_debtor_geo_match, L.clean_creditor_geo_match, L.clean_atty_geo_match);
self.err_stat:= choose(cnt, L.clean_debtor_err_stat, L.clean_creditor_err_stat, L.clean_atty_err_stat);
self.phone := choose(cnt, '', '', L.atty_phone);
self.cname := choose(cnt, L.clean_debtor_cname, L.clean_creditor_cname, L.clean_atty_cname);
self.date_first_seen                :=      L.orig_filing_date;
self.date_last_seen                 :=      L.release_date;
self.date_vendor_first_reported     :=      L.process_date;
self.date_vendor_last_reported      :=      L.process_date;
self := L;
end;

Hogan_norm := normalize(file_in, 3, tnormalize(left, counter));

Hogan_dist := distribute(Hogan_norm(lname <> '' or fname <> '' or mname <> '' or cname <> ''), hash(tmsid,rmsid));

Hogan_sort  := sort(Hogan_dist,record,EXCEPT Date_First_Seen, Date_Last_Seen,
			   Date_Vendor_First_Reported, Date_Vendor_Last_Reported,name_type, local);

rec_temp  rollupXform(rec_temp l, rec_temp r) := transform
		self.Date_First_Seen := if(l.Date_First_Seen > r.Date_First_Seen, r.Date_First_Seen, l.Date_First_Seen);
		self.Date_Last_Seen  := if(l.Date_Last_Seen  < r.Date_Last_Seen,  r.Date_Last_Seen,  l.Date_Last_Seen);
		self.Date_Vendor_First_Reported := if(l.Date_Vendor_First_Reported > r.Date_Vendor_First_Reported, r.Date_Vendor_First_Reported, l.Date_Vendor_First_Reported);
		self.Date_Vendor_Last_Reported  := if(l.Date_Vendor_Last_Reported  < r.Date_Vendor_Last_Reported,  r.Date_Vendor_Last_Reported, l.Date_Vendor_Last_Reported);
		self := l;
end;

export mapping_Hogan_party := rollup(Hogan_sort,rollupXform(LEFT,RIGHT),RECORD,
                                EXCEPT Date_First_Seen, Date_Last_Seen,
																Date_Vendor_First_Reported, Date_Vendor_Last_Reported, name_type,local);



