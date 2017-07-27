import ut; 
LiensV2.Layout_liens_party_ssn_BIPV2 refHGPTY(LiensV2.layout_liens_party_ssn_for_hogan_BIPv2 l) := transform
	self := l;
end;

Hogan_party := project(LiensV2.file_Hogan_party, refHGPTY(left));

file_liens := Hogan_party((cname <> ''or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID and NOT regexfind('CAALAC1',tmsid))
              + LiensV2.file_ILFDLN_party((cname <> '' or lname <> '' or fname <> '' or mname <> '')and tmsid not in Liensv2.Suppress_TMSID and NOT regexfind('CAALAC1',tmsid))
   						+ LiensV2.file_NYC_party((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID and NOT regexfind('CAALAC1',tmsid))
   						+ LiensV2.file_NYFDLN_party((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID and NOT regexfind('CAALAC1',tmsid))
   						+ LiensV2.file_SA_party((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID and NOT regexfind('CAALAC1',tmsid))
   						+ LiensV2.file_chicago_law_party((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID and NOT regexfind('CAALAC1',tmsid))
   						+ LiensV2.file_CA_federal_party((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID and NOT regexfind('CAALAC1',tmsid))
   						+ LiensV2.file_Superior_Party((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID and NOT regexfind('CAALAC1',tmsid))
   						+ LiensV2.file_MA_Party((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID and NOT regexfind('CAALAC1',tmsid))
;

file_liens_dist := distribute(project(file_liens, transform({file_liens},
															self.tmsid := ut.fnTrim2Upper(left.tmsid); 
															self.rmsid:= ut.fnTrim2Upper(left.rmsid);
															self.orig_full_debtorname:=ut.fnTrim2Upper(left.orig_full_debtorname);
															self.orig_name:=ut.fnTrim2Upper(left.orig_name );
															self.orig_lname:= ut.fnTrim2Upper(left.orig_lname);
															self.orig_fname:= ut.fnTrim2Upper(left.orig_fname);
															self.orig_mname:= ut.fnTrim2Upper(left.orig_mname );
															self.orig_suffix:= ut.fnTrim2Upper(left.orig_suffix );
															self.tax_id:= ut.fnTrim2Upper(left.tax_id );
															self.ssn:=ut.fnTrim2Upper(left.ssn );
															self.cname:= ut.fnTrim2Upper(left.cname );
															self.orig_address1 := ut.fnTrim2Upper(left.orig_address1 );
															self.orig_address2 := ut.fnTrim2Upper(left.orig_address2 );
															self.orig_city  :=ut.fnTrim2Upper(left.orig_city );
															self.orig_state := ut.fnTrim2Upper(left.orig_state );
															self.orig_zip5 := ut.fnTrim2Upper(left.orig_zip5 );
															self.orig_zip4 := ut.fnTrim2Upper(left.orig_zip4 );
															self.orig_county :=ut.fnTrim2Upper(left.orig_county );
															self.orig_country :=ut.fnTrim2Upper(left.orig_country );
															self.phone := ut.fnTrim2Upper(left.phone );
															self.name_type:= ut.fnTrim2Upper(left.name_type );
															self.did := if (trim(left.did,left,right)= '', '000000000000', left.did) ; 
															self.bdid := if (trim(left.bdid,left,right)= '', '000000000000', left.bdid);
											self := left)) ,hash(tmsid));

get_recs_sort  := sort(file_liens_dist,record,- Date_Last_Seen, local);

LiensV2.Layout_liens_party_ssn_BIPV2  rollupXform(LiensV2.Layout_liens_party_ssn_BIPV2 l, LiensV2.Layout_liens_party_ssn_BIPV2  r) := transform
		self.Date_First_Seen := if(l.Date_First_Seen > r.Date_First_Seen, r.Date_First_Seen, l.Date_First_Seen);
		self.Date_Last_Seen  := if(l.Date_Last_Seen  < r.Date_Last_Seen,  r.Date_Last_Seen,  l.Date_Last_Seen);
		self.Date_Vendor_First_Reported := if(l.Date_Vendor_First_Reported > r.Date_Vendor_First_Reported, r.Date_Vendor_First_Reported, l.Date_Vendor_First_Reported);
		self.Date_Vendor_Last_Reported  := if(l.Date_Vendor_Last_Reported  < r.Date_Vendor_Last_Reported,  r.Date_Vendor_Last_Reported, l.Date_Vendor_Last_Reported);
		self := l;
end;

get_recs_party := rollup(get_recs_sort,rollupXform(LEFT,RIGHT),RECORD,
                                EXCEPT Date_First_Seen, Date_Last_Seen,
																Date_Vendor_First_Reported, Date_Vendor_Last_Reported,lot,lot_order,geo_lat, geo_long,geo_match ,cart,msa,cr_sort_sz,dbpc,rec_type,err_stat,p_city_name,name_score, local); // All these are because of address cleaning issues once AID implemented this should be resloved

LiensV2.Layout_liens_party_ssn_BIPV2  tformat(get_recs_party L) := transform

self.persistent_record_id := hash64(trim(l.tmsid,left,right)+','+
																		trim(l.rmsid,left,right)+','+
																		trim(l.orig_full_debtorname,left,right)+','+
																		trim(l.orig_name ,left,right)+','+
																		trim(l.orig_lname,left,right)+','+
																		trim(l.orig_fname,left,right)+','+
																		trim(l.orig_mname ,left,right)+','+
																		trim(l.orig_suffix ,left,right)+','+
																		trim(l.tax_id ,left,right)+','+
																		trim(l.ssn ,left,right)+','+
																		trim(l.cname ,left,right)+','+
																		trim(l.orig_address1 ,left,right)+','+
																		trim(l.orig_address2 ,left,right)+','+
																		trim(l.orig_city ,left,right)+','+
																		trim(l.orig_state ,left,right)+','+
																		trim(l.orig_zip5 ,left,right)+','+
																		trim(l.orig_zip4 ,left,right)+','+
																		trim(l.orig_county ,left,right)+','+
																		trim(l.orig_country ,left,right)+','+
																		trim(l.phone ,left,right)+ ','+
																		trim(l.name_type ,left,right) +','+ trim(l.bdid,left,right) +','+trim(l.did,left,right)+','+trim(l.zip,left,right)
																		+trim(l.fname,left,right)+','+trim(l.lname,left,right)+','+trim(l.mname,left,right)+','+trim(l.name_suffix,left,right) +','+ trim(l.zip4,left,right)); // orig name has multiple names 
self := L;
end;

Add_puid := project(get_recs_party, tformat(left)):persist('~thor_data400::Liens::party_BIPV2::PUID');

 export file_liens_party_BIPV2 := Add_puid;