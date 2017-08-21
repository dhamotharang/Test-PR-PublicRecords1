IMPORT Business_Header, ut,mdr;

export fBusReg_As_Business_Header(dataset(Layout_BusReg_Company) pInput,boolean isPRCT=false):=
function

	//*************************************************************************
	// Translate BusReg to Common Business Header Format
	//*************************************************************************

	Layout_BR_Local := busreg.Layout_Busreg_Company_RID;

	Layout_BHF_Local := RECORD
	Business_Header.Layout_Business_Header_New;
	UNSIGNED6 orig_id;
	UNSIGNED6 split_id := 0;
	END;

	// Add unique record id to Business Registration file
	Layout_BR_Local AddRecordID(Layout_BusReg_Company L) := TRANSFORM
	SELF.bdid  := If(IsPRCT,(integer)l.BDID,0); 
	SELF := L;
	END;

	BR_Init := PROJECT(pInput, AddRecordID(LEFT));

	ut.MAC_Sequence_Records(BR_Init, record_id, BR_Seq)

	Layout_BHF_Local  Translate_BR_to_BHF(Layout_BR_Local L, INTEGER CTR) := 
	TRANSFORM
	  SELF.bdid  := If(IsPRCT,(integer)l.BDID,0); 
		lcounty := CHOOSE(CTR, L.mail_fipscounty, L.loc_fipscounty);
		
		SELF.orig_id := L.record_id;
		SELF.company_name := Stringlib.StringToUpperCase(L.company_name);
		SELF.vl_id := 'BRC' + (STRING)l.br_id;
		SELF.vendor_id := 'BRC' + (STRING)l.br_id;
		SELF.source := MDR.sourceTools.src_Business_Registration;
		SELF.source_group := IF(L.filing_num <> '',
									   (STRING34)(trim(L.filing_num)+trim(L.company_name)),
									   '');
		SELF.phone := (UNSIGNED6)((UNSIGNED8)L.company_phone10);
		SELF.phone_score := IF((UNSIGNED8)L.company_phone10 = 0, 0, 1);
		SELF.prim_range := CHOOSE(CTR, L.mail_prim_range, L.loc_prim_range);
		SELF.predir := CHOOSE(CTR, L.mail_predir, L.loc_predir);
		SELF.prim_name := CHOOSE(CTR, L.mail_prim_name, L.loc_prim_name);
		SELF.addr_suffix := CHOOSE(CTR, L.mail_addr_suffix, L.loc_addr_suffix);
		SELF.postdir := CHOOSE(CTR, L.mail_postdir, L.loc_postdir);
		SELF.unit_desig := CHOOSE(CTR, L.mail_unit_desig, L.loc_unit_desig);
		SELF.sec_range := CHOOSE(CTR, L.mail_sec_range, L.loc_sec_range);
		SELF.city := CHOOSE(CTR, L.mail_v_city_name, L.loc_v_city_name);
		SELF.state := CHOOSE(CTR, L.mail_st, L.loc_st);
		SELF.zip := CHOOSE(CTR, (UNSIGNED3)L.mail_zip, (UNSIGNED3)L.loc_zip);
		SELF.zip4 := CHOOSE(CTR, (UNSIGNED2)L.mail_zip4, (UNSIGNED2)L.loc_zip4);
		SELF.county := if(regexfind('[a-z]+', lcounty, NOCASE), '', lcounty);
		SELF.msa := CHOOSE(CTR, L.mail_msa, L.loc_msa);
		SELF.geo_lat := CHOOSE(CTR, L.mail_geo_lat, L.loc_geo_lat);
		SELF.geo_long := CHOOSE(CTR, L.mail_geo_long, L.loc_geo_long);
		SELF.dt_first_seen := (unsigned4)L.dt_first_seen;
		SELF.dt_last_seen := (unsigned4)l.dt_last_seen;
		SELF.dt_vendor_last_reported := (unsigned4)l.record_date;
		SELF.dt_vendor_first_reported := (unsigned4)l.record_date;
		SELF.current := TRUE;
		SELF.fein := (UNSIGNED4)L.co_fei;
		self.RAWAID	:=	CHOOSE(CTR, L.Append_MailRawAID, L.Append_LocRawAID);
		SELF := L;
	END;

	from_br_norm := NORMALIZE(BR_Seq, 2, Translate_BR_To_BHF(LEFT, COUNTER));
	from_br_norm_dist := DISTRIBUTE(from_br_norm, HASH(orig_id, company_name));
	from_br_norm_sort := SORT(from_br_norm_dist, orig_id, company_name,  -zip, -state, -city, local);

	Layout_BHF_Local RollupBRNorm(Layout_BHF_Local L, Layout_BHF_Local R) := TRANSFORM
	SELF.bdid  := If(IsPRCT,(integer)l.BDID,0); 
	SELF := L;
	END;

	from_br_norm_rollup := ROLLUP(from_br_norm_sort,
								  LEFT.orig_id = RIGHT.orig_id AND
								  LEFT.company_name = RIGHT.company_name AND
								  ((LEFT.zip = RIGHT.zip AND
								   LEFT.prim_name = RIGHT.prim_name AND
								   LEFT.prim_range = RIGHT.prim_range AND
								   LEFT.city = RIGHT.city AND
								   LEFT.state = RIGHT.state)
								  OR
								   (RIGHT.zip = 0 AND
									RIGHT.prim_name = '' AND
									RIGHT.prim_range = '' AND
									RIGHT.city = '' AND
									RIGHT.state = '' AND
									RIGHT.city = '')
								  ),
								  RollupBRNorm(LEFT, RIGHT),
								  LOCAL);
								  
	ut.MAC_Sequence_Records(from_br_norm_rollup, split_id, from_br_seq)

	// Group by original id
	from_br_dist := DISTRIBUTE(from_br_seq, hash(orig_id));
	from_br_sort := SORT(from_br_dist, orig_id, LOCAL);
	from_br_grpd := GROUP(from_br_sort, orig_id, LOCAL);
	from_br_grpd_sort := SORT(from_br_grpd, split_id);

	Layout_BHF_Local SetGroupId(Layout_BHF_Local L, Layout_BHF_Local R) := TRANSFORM
	SELF.group1_id := IF(L.group1_id <> 0, L.group1_id, R.split_id);
	SELF := R;
	END;

	// Set group id
	from_br_iter := GROUP(ITERATE(from_br_grpd_sort, SetGroupId(LEFT, RIGHT)));

	// Calculate stat to determine count by group_id
	Layout_Group_List := RECORD
	from_br_iter.group1_id;
	END;

	br_group_list := TABLE(from_br_iter, Layout_Group_List);

	Layout_Group_Stat := RECORD
	br_group_list.group1_id;
	cnt := COUNT(GROUP);
	END;

	br_group_stat := TABLE(br_group_list, Layout_Group_Stat, group1_id);

	// Clean single group ids and format
	Business_Header.Layout_Business_Header_New FormatToBHF(Layout_BHF_Local L, Layout_Group_Stat R) := TRANSFORM
	SELF.group1_id := R.group1_id;
	SELF.bdid  := If(IsPRCT,(integer)l.BDID,0); 
	SELF := L;
	END;

	br_group_clean := JOIN(from_br_iter,
							 br_group_stat(cnt > 1),
							 LEFT.group1_id = RIGHT.group1_id,
							 FormatToBHF(LEFT, RIGHT),
							 LEFT OUTER,
							 LOOKUP);

	Business_Header.Layout_Business_Header_New  Translate_BR_Owner_to_BHF(Layout_BR_Local L) := TRANSFORM
	SELF.bdid  := If(IsPRCT,(integer)l.BDID,0); 
	SELF.group1_id := 0;
	SELF.company_name := Stringlib.StringToUpperCase(L.OFC1_NAME);
	SELF.vl_id := 'BRO' + (STRING)l.br_id;
	SELF.vendor_id := 'BRO' + (STRING)l.br_id;
	SELF.zip := (UNSIGNED3)L.ofc1_zip;
	SELF.zip4 := (UNSIGNED2)L.ofc1_zip4;
	SELF.phone := (UNSIGNED6)((UNSIGNED8)L.ofc1_phone10);
	SELF.phone_score := 0;
	SELF.addr_suffix := L.ofc1_addr_suffix;
	SELF.state := L.ofc1_st;
	SELF.source := MDR.sourceTools.src_Business_Registration;
	SELF.source_group := IF(L.filing_num <> '',
								   (STRING34)(trim(L.filing_num)+trim(L.company_name)),
								   '');
	SELF.dt_first_seen := (unsigned4)L.dt_first_seen;
	SELF.dt_last_seen := (unsigned4)l.dt_last_seen;
	SELF.dt_vendor_last_reported := (unsigned4)l.dt_last_seen;
	SELF.dt_vendor_first_reported := (unsigned4)l.dt_first_seen;
	SELF.current := TRUE;
	SELF.geo_lat := L.ofc1_geo_Lat;
	SELF.geo_long := L.ofc1_geo_Long;
	SELF.fein := (UNSIGNED4)L.co_fei;
	SELF.prim_range := l.ofc1_prim_range;
	SELF.predir := l.ofc1_predir;
	SELF.prim_name := l.ofc1_prim_name;
	SELF.postdir := l.ofc1_postdir;
	SELF.unit_desig := l.ofc1_unit_desig;
	SELF.sec_range := l.ofc1_sec_range;
	SELF.city := l.ofc1_v_city_name;
	SELF.msa := l.ofc1_msa;
	SELF := L;
	END;

	// Fix for Accutrend Data Problem
	// Create list of Agent companies to use as filters for owners

	busreg_owner := br_seq(OWNR_CODE='C', OFC1_NAME <> '', OFC1_TITLE <> 'AGT', ofc1_prim_name <> '', ofc1_v_city_name <> '');

	busreg_owner_no_agents := busreg.remove_agents(busreg_owner,1000);

	// Business Registration Owner Information
	//busreg_owner := PROJECT(br_seq(OWNR_CODE='C', OFC1_NAME <> '', OFC1_TITLE <> 'AGT', ofc1_prim_name <> '', ofc1_v_city_name <> ''), Translate_BR_Owner_to_BHF(LEFT));
	busreg_owner_filtered := PROJECT(busreg_owner_no_agents, Translate_BR_Owner_to_BHF(LEFT));

	// Rollup
	Business_Header.Layout_Business_Header_New RollupBR(Business_Header.Layout_Business_Header_New L, Business_Header.Layout_Business_Header_New R) := TRANSFORM
 	SELF.bdid  := If(IsPRCT,(integer)l.BDID,0); 	
	SELF.dt_first_seen := 
				ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
				ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	SELF.dt_last_seen := MAX(L.dt_last_seen,R.dt_last_seen);
	SELF.dt_vendor_last_reported := MAX(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
	SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
	SELF.company_name := IF(L.company_name = '', R.company_name, L.company_name);
	SELF.group1_id := IF(L.group1_id = 0, R.group1_id, L.group1_id);
	SELF.vl_id := IF(L.vl_id = '', R.vl_id, L.vl_id);
	SELF.vendor_id := IF((L.group1_id = 0 AND R.group1_id <> 0) OR
						 L.vendor_id = '', R.vendor_id, L.vendor_id);
	SELF.source_group := IF((L.group1_id = 0 AND R.group1_id <> 0) OR
						 L.source_group = '', R.source_group, L.source_group);
	SELF.phone := IF(L.phone = 0, R.phone, L.phone);
	SELF.phone_score := IF(L.phone = 0, R.phone_score, L.phone_score);
	SELF.fein := IF(L.fein = 0, R.fein, L.fein);
	SELF.prim_range := IF(l.prim_range = '' AND l.zip4 = 0, r.prim_range, l.prim_range);
	SELF.predir := IF(l.predir = '' AND l.zip4 = 0, r.predir, l.predir);
	SELF.prim_name := IF(l.prim_name = '' AND l.zip4 = 0, r.prim_name, l.prim_name);
	SELF.addr_suffix := IF(l.addr_suffix = '' AND l.zip4 = 0, r.addr_suffix, l.addr_suffix);
	SELF.postdir := IF(l.postdir = '' AND l.zip4 = 0, r.postdir, l.postdir);
	SELF.unit_desig := IF(l.unit_desig = ''AND l.zip4 = 0, r.unit_desig, l.unit_desig);
	SELF.sec_range := IF(l.sec_range = '' AND l .zip4 = 0, r.sec_range, l.sec_range);
	SELF.city := IF(l.city = '' AND l.zip4 = 0, r.city, l.city);
	SELF.state := IF(l.state = '' AND l.zip4 = 0, r.state, l.state);
	SELF.zip := IF(l.zip = 0 AND l.zip4 = 0, r.zip, l.zip);
	SELF.zip4 := IF(l.zip4 = 0, r.zip4, l.zip4);
	SELF.county := IF(l.county = '' AND l.zip4 = 0, r.county, l.county);
	SELF.msa := IF(l.msa = '' AND l.zip4 = 0, r.msa, l.msa);
	SELF.geo_lat := IF(l.geo_lat = '' AND l.zip4 = 0, r.geo_lat, l.geo_lat);
	SELF.geo_long := IF(l.geo_long = '' AND l.zip4 = 0, r.geo_long, l.geo_long);
	SELF := L;
	END;

	br_clean_dist := DISTRIBUTE(br_group_clean + busreg_owner_filtered,
						HASH(zip, TRIM(prim_name), TRIM(prim_range), TRIM(source_group), TRIM(company_name)));
	br_clean_sort := SORT(br_clean_dist, zip, prim_range, prim_name, source_group, company_name,
						IF(sec_range <> '', 0, 1), sec_range,
						IF(phone <> 0, 0, 1), phone,
						IF(fein <> 0, 0, 1), fein,
						dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, LOCAL);
	br_clean_rollup := ROLLUP(br_clean_sort,
						left.zip = right.zip and
						  left.prim_name = right.prim_name and
						  left.prim_range = right.prim_range and
						  left.source_group = right.source_group and
						  left.company_name = right.company_name and
						  (right.sec_range = '' OR left.sec_range = right.sec_range) and
						  (right.phone = 0 OR left.phone = right.phone) and
						  (right.fein = 0 OR left.fein = right.fein),
						RollupBR(LEFT, RIGHT),
						LOCAL);

	return br_clean_rollup;

end;