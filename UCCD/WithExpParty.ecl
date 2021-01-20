import ucc,did_add,ut;
/* no did for experian */
/* need to split debtor from secured/assigned */
/* probably shouldn't normalize direct for clean names */


df := ucc.File_UCC_Secured_Master;
df2 := ucc.File_UCC_Debtor_Master;

df3 := uccd.File_Party_Base;

rec := uccd.Layout_WithExpParty;

rec into_withExp(df L) := transform
	self.isDirect := false;
	self.record_type := 'C';

	self.ucc_vendor := ut.st2FipsCode(l.file_state);
	self.ucc_process_Date := '';
	self.ucc_key := uccd.constructUCCkey(l.file_state, l.orig_filing_num);
	self.event_key 	:= uccd.constructUCCkey(l.file_state, l.orig_filing_num);
	self.party_key := '';
	self.collateral_key := '';

	self.party_status_cd := '';
	self.party_status_desc := '';
	self.party_address1_type_cd := '';
	self.party_address1_type_desc := '';

	self.bdid := intformat(L.bdid,12,1);
	self.did := '';
	self.file_state := L.file_state;
	self.contrib_num := L.contrib_num;
	self.orig_filing_num := L.orig_filing_num;
	self.party_type := L.party_type;
	self.orig_name := L.orig_name;
	self.street_address := L.street_address;
	self.city := L.city;
	self.orig_state := L.Orig_state;
	self.zip_code := L.zip_code;
	self.insert_date := L.insert_date;
	self.ssn := L.ssn;
	self.clean_address := L.prim_range + L.predir + L.prim_name + L.suffix + L.postdir + L.unit_desig + L.sec_range + L.p_city_name + L.v_city_name + L.state + L.zip5 + L.zip4 + L.cart + L.cr_sort_sz + L.lot + L.lot_order + L.dpbc + L.chk_digit + L.rec_type + L.ace_fips_st + L.county + L.geo_lat + L.geo_long + L.msa + L.geo_blk + L.geo_match + L.err_stat;
	self.p_name := L.title + L.fname + L.mname + L.lname + L.name_suffix;
	self.name := L.name;

end;

o1 := project(df(file_state not in uccd.set_DirectStates),into_WithExp(LeFT));
output(o1);
o2 := project(df2(file_state not in uccd.set_DirectStates),into_WithExp(LeFT));
output(o2);

denorm_rec := record
	rec;
	string182	clean_address2;
	string70	pname2;
	string70	pname3;
	string70	pname4;
	string70	pname5;
end;


denorm_rec into_WithExp2(df3 L) := transform
	self.isDirect := true;
	self.record_type := L.record_type;

	self.ucc_vendor := L.ucc_vendor;
	self.ucc_process_Date := L.ucc_process_date;
	self.ucc_key := L.ucc_key;
	self.event_key := L.event_key;
	self.party_key := L.party_key;
	self.collateral_key := L.collateral_key;

	self.party_status_cd := L.status_cd;
	self.party_status_desc := L.status_desc;
	self.party_address1_type_cd := L.address1_type_cd;
	self.party_address1_type_desc := L.address1_type_desc;

	self.bdid := intformat(L.bdid,12,1);
	self.did 	:= intformat(L.did,12,1);
	self.file_state := L.ucc_state_origin;
	self.contrib_num := L.ucc_vendor;
	self.orig_filing_num := '';
	self.party_type := L.std_type;
	self.orig_name := L.name;
	self.street_address := trim(L.address1_line1) + ', ' + trim(L.address1_line2) + ', ' + trim(L.address1_line3);
	self.city := L.address1_line4;
	self.orig_state := L.address1_line5;
	self.zip_code := L.address1_line6;
	self.insert_date := L.ucc_process_date;
	self.ssn := if (L.fein != '', L.fein, L.ssn);
	self.clean_address  := L.address1_prim_range + L.address1_predir + L.address1_prim_name + L.address1_addr_suffix + L.address1_postdir + L.address1_unit_desig + L.address1_sec_range + L.address1_p_city_name + L.address1_v_city_name + L.address1_st + L.address1_zip + L.address1_zip4 + L.address1_cart + L.address1_cr_sort_sz + L.address1_lot + L.address1_lot_order + L.address1_dbpc + L.address1_chk_digit + L.address1_rec_type + L.address1_fips_st + L.address1_fips_county + L.address1_geo_lat + L.address1_geo_long + L.address1_msa + L.address1_geo_blk + L.address1_geo_match + L.address1_err_stat;
	self.clean_address2 := L.address2_prim_range + L.address2_predir + L.address2_prim_name + L.address2_addr_suffix + L.address2_postdir + L.address2_unit_desig + L.address2_sec_range + L.address2_p_city_name + L.address2_v_city_name + L.address2_st + L.address2_zip + L.address2_zip4 + L.address2_cart + L.address2_cr_sort_sz + L.address2_lot + L.address2_lot_order + L.address2_dbpc + L.address2_chk_digit + L.address2_rec_type + L.address2_fips_st + L.address2_fips_county + L.address2_geo_lat + L.address2_geo_long + L.address2_msa + L.address2_geo_blk + L.address2_geo_match + L.address2_err_stat;
	self.p_name := L.pname1_title + L.pname1_fname + L.pname1_mname + L.pname1_lname + L.pname1_name_suffix;
	self.pname2 := L.pname2_title + L.pname2_fname + L.pname2_mname + L.pname2_lname + L.pname2_name_suffix;
	self.pname3 := L.pname3_title + L.pname3_fname + L.pname3_mname + L.pname3_lname + L.pname3_name_suffix;
	self.pname4 := L.pname4_title + L.pname4_fname + L.pname4_mname + L.pname4_lname + L.pname4_name_suffix;
	self.pname5 := L.pname5_title + L.pname5_fname + L.pname5_mname + L.pname5_lname + L.pname5_name_suffix;
	self.name := trim(L.name);
end;

o3 := project(df3,into_WithExp2(LEFT));

//keep non-blank orig name and pname with blank

o3_pname_blank := o3(orig_name <> '' and p_name ='' and pname2 ='' and pname3 ='' and pname4 ='' and pname5 ='');

rec norm_direct(o3 L,integer C) := transform
	self.clean_address := L.clean_address;
	self.p_name := choose(C,L.p_name,L.pname2,L.pname3,L.pname4,L.pname5);
	self := L;
end;

o3_norm := normalize(o3,5,norm_direct(LEFT,COUNTER));

//keep non-blank orig name and pname with blank

o3_norm_pname_blank := normalize(o3_pname_blank,5,norm_direct(LEFT,COUNTER));

o4 := o1 + o2;

addr_rec := record
	o4;
	string10	prim_range 	:= o4.clean_address[1..10];
	string28	prim_name		:= o4.clean_address[13..40];
	string8	sec_range		:= o4.clean_address[56..64];
	string20	fname 		:= o4.p_name[6..25];
	string20	mname 		:= o4.p_name[26..45];
	string20	lname		:= o4.p_name[46..65];
	string5	name_suffix	:= o4.p_name[66..70];
	unsigned6	match_did 	:= 0;
	unsigned1	match_Score	:= 0;
end;

o5 := table(o4,addr_rec);

myset := ['A','Z'];

did_add.mac_match_flex(o5,myset,foo,foo,fname,mname,lname,name_suffix,
				prim_range,prim_name,sec_range,zip_code,orig_state,foo,
				match_did,addr_rec,true,match_score,70,outf)


rec into_outrec(outf L) := transform
	self.did := intformat(L.match_did,12,1);
	self := l;
end;

dups := o3_norm(~(p_name = '')) + o3_norm_pname_blank + project(outf,into_outrec(LEFT));

export WithExpParty := dedup(dups, all);
