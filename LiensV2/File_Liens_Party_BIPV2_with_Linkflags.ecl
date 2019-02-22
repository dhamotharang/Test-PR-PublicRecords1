import LiensV2,	LiensV2_preprocess, ut; 

rLayout_liens_party_temp := record
LiensV2.Layout_liens_party_SSN_BIPV2_with_LinkFlags;
string50 TMSID_old;
string50 RMSID_old;
end;

rLayout_liens_party_temp refHGPTY(LiensV2.Layout_liens_party_SSN_for_hogan_BIPV2_with_LinkFlags l) :=
TRANSFORM
	//	Clear Date_Last_Seen for Hogan records with filing_type_desc=CORRECTED FEDERAL TAX LIEN
	dHoganMain	:=	LiensV2.file_Hogan_main;
	dCFRecords	:=	dHoganMain(
										filing_type_desc	=	LiensV2_preprocess.Code_lkps.HG_FileType('CF')	AND
										rmsid[1..3]	=	'HGR'
									);
	Set_tmsid		:=	SET(dCFRecords,dCFRecords.tmsid);
	Set_rmsid		:=	SET(dCFRecords,dCFRecords.rmsid);
	
	SELF.Date_Last_Seen	:=	IF(
														l.tmsid	IN Set_tmsid	AND
														l.rmsid	IN Set_rmsid,
														'',l.Date_Last_Seen
													);
	SELF				:=	l;
END;

Hogan_party := project(LiensV2.file_Hogan_party, refHGPTY(left));

Other_Party := LiensV2.file_ILFDLN_party((cname <> '' or lname <> '' or fname <> '' or mname <> '')and tmsid not in Liensv2.Suppress_TMSID())
   						+ LiensV2.file_NYC_party((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID())
   						+ LiensV2.file_NYFDLN_party((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID())
   						+ LiensV2.file_SA_party((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID())
   						+ LiensV2.file_chicago_law_party((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID())
   						+ LiensV2.file_CA_federal_party((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID())
   						+ LiensV2.file_Superior_Party((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID())
   						+ LiensV2.file_MA_Party((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID());
						
/* DF-24044 - Populate the old tmsids in other sources*/								
rLayout_liens_party_temp propagate_ids(LiensV2.Layout_liens_party_SSN_BIPV2_with_LinkFlags l) :=
TRANSFORM							

  self.TMSID_old  := l.tmsid;
  self.RMSID_old  := l.rmsid;
  SELF				    := l;
end;

Other_Party_withIDS := project(Other_Party, propagate_ids(left));

file_liens := Hogan_party((cname <> ''or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID())
              + Other_Party_withIDS;

file_liens_dist := distribute(project(file_liens, transform({file_liens},
															self.tmsid := ut.CleanSpacesAndUpper(left.tmsid); 
															self.rmsid:= ut.CleanSpacesAndUpper(left.rmsid);
															self.orig_full_debtorname:=ut.CleanSpacesAndUpper(left.orig_full_debtorname);
															self.orig_name:=ut.CleanSpacesAndUpper(left.orig_name );
															self.orig_lname:= ut.CleanSpacesAndUpper(left.orig_lname);
															self.orig_fname:= ut.CleanSpacesAndUpper(left.orig_fname);
															self.orig_mname:= ut.CleanSpacesAndUpper(left.orig_mname );
															self.orig_suffix:= ut.CleanSpacesAndUpper(left.orig_suffix );
															self.tax_id:= ut.CleanSpacesAndUpper(left.tax_id );
															self.ssn:=ut.CleanSpacesAndUpper(left.ssn );
															self.cname:= ut.CleanSpacesAndUpper(left.cname );
															self.orig_address1 := ut.CleanSpacesAndUpper(left.orig_address1 );
															self.orig_address2 := ut.CleanSpacesAndUpper(left.orig_address2 );
															self.orig_city  :=ut.CleanSpacesAndUpper(left.orig_city );
															self.orig_state := ut.CleanSpacesAndUpper(left.orig_state );
															self.orig_zip5 := ut.CleanSpacesAndUpper(left.orig_zip5 );
															self.orig_zip4 := ut.CleanSpacesAndUpper(left.orig_zip4 );
															self.orig_county :=ut.CleanSpacesAndUpper(left.orig_county );
															self.orig_country :=ut.CleanSpacesAndUpper(left.orig_country );
															self.phone := ut.CleanSpacesAndUpper(left.phone );
															self.name_type:= ut.CleanSpacesAndUpper(left.name_type );
															self.did := if (trim(left.did,left,right)= '', '000000000000', left.did) ; 
															self.bdid := if (trim(left.bdid,left,right)= '', '000000000000', left.bdid);
															self.tmsid_old := ut.CleanSpacesAndUpper(left.TMSID_old); 
															self.rmsid_old := ut.CleanSpacesAndUpper(left.RMSID_old);
											self := left)) ,hash(tmsid));

get_recs_sort  := sort(file_liens_dist,record,- Date_Last_Seen, local);

rLayout_liens_party_temp  rollupXform(rLayout_liens_party_temp l, rLayout_liens_party_temp  r) := transform
		self.Date_First_Seen := if(l.Date_First_Seen > r.Date_First_Seen, r.Date_First_Seen, l.Date_First_Seen);
		self.Date_Last_Seen  := if(l.Date_Last_Seen  < r.Date_Last_Seen,  r.Date_Last_Seen,  l.Date_Last_Seen);
		self.Date_Vendor_First_Reported := if(l.Date_Vendor_First_Reported > r.Date_Vendor_First_Reported, r.Date_Vendor_First_Reported, l.Date_Vendor_First_Reported);
		self.Date_Vendor_Last_Reported  := if(l.Date_Vendor_Last_Reported  < r.Date_Vendor_Last_Reported,  r.Date_Vendor_Last_Reported, l.Date_Vendor_Last_Reported);
		self := l;
end;

get_recs_party := rollup(get_recs_sort,rollupXform(LEFT,RIGHT),RECORD,
                                EXCEPT Date_First_Seen, Date_Last_Seen,
																Date_Vendor_First_Reported, Date_Vendor_Last_Reported,lot,lot_order,geo_lat, geo_long,geo_match ,cart,msa,cr_sort_sz,dbpc,rec_type,err_stat,p_city_name,name_score, local); // All these are because of address cleaning issues once AID implemented this should be resloved

rLayout_liens_party_temp  tformat(get_recs_party L) := transform

self.persistent_record_id := hash64(trim(l.tmsid_old,left,right)+','+ //DF-24044 use the old ids to prevent the overrides from changing
																		trim(l.rmsid_old,left,right)+','+ //DF-24044 use the old ids to prevent the overrides from changing
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

Add_puid := project(get_recs_party, tformat(left));


Allrecords := project(Add_puid, LiensV2.Layout_liens_party_SSN_BIPV2_with_LinkFlags); 

EXPORT File_Liens_Party_BIPV2_with_Linkflags := Allrecords :persist('persist::File_Liens_Party_BIPV2_with_Linkflags');