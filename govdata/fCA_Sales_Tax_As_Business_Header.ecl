import Business_Header, ut,mdr,address;

export fCA_Sales_Tax_As_Business_Header(dataset(Layout_CA_Sales_Tax) pBasefile) :=
function

	f := pBasefile;

	Layout_CA_ST_Local := record
	unsigned6 record_id := 0;
	f;
	end;

	Layout_CA_ST_Local InitCA_ST(f l) := transform
	self := l;
	end;

	CA_ST_Init := project(f, InitCA_ST(left));

	ut.MAC_Sequence_Records(CA_ST_Init, record_id, CA_ST_Seq)

	Layout_BHF_Local := record
	UNSIGNED6 orig_id;
	UNSIGNED6 split_id := 0;
	unsigned1 ntyp;
	Business_Header.Layout_Business_Header;
	end;

	Layout_BHF_Local Translate_CASalesTax_To_BHF(Layout_CA_ST_Local L, unsigned1 CTR, unsigned1 ntyp) := transform
	  SELF.ntyp := ntyp;
	  SELF.orig_id := L.record_id;
	  SELF.vendor_id := 'CA' + L.ACCOUNT_NUMBER;
	  SELF.phone := 0;
	  SELF.source := MDR.sourceTools.src_CA_Sales_Tax;
	  SELF.source_group := 'CA' + L.ACCOUNT_NUMBER;
	  SELF.company_name := CHOOSE(ntyp, stringlib.stringtouppercase(L.firm_name), stringlib.stringtouppercase(L.owner_name));
	  SELF.prim_range := CHOOSE(CTR, L.mail_prim_range, L.prim_range);
	  SELF.predir := CHOOSE(CTR, L.mail_predir, L.predir);
	  SELF.prim_name := CHOOSE(CTR, L.mail_prim_name, L.prim_name);
	  SELF.addr_suffix := CHOOSE(CTR, L.mail_addr_suffix, L.addr_suffix);
	  SELF.postdir := CHOOSE(CTR, L.mail_postdir, L.postdir);
	  SELF.unit_desig := CHOOSE(CTR, L.mail_unit_desig, L.unit_desig);
	  SELF.sec_range := CHOOSE(CTR, L.mail_sec_range, L.sec_range);
	  SELF.city := CHOOSE(CTR, L.mail_v_city_name, L.v_city_name);
	  SELF.state := CHOOSE(CTR, L.mail_st, L.st);
	  SELF.zip := CHOOSE(CTR, (UNSIGNED3)L.mail_zip, (UNSIGNED3)L.zip);
	  SELF.zip4 := CHOOSE(CTR, (UNSIGNED2)L.mail_zip4, (UNSIGNED2)L.zip4);
	  SELF.county := CHOOSE(CTR, L.mail_fipscounty, L.fipscounty);
	  SELF.msa := CHOOSE(CTR, L.mail_msa, L.msa);
	  SELF.geo_lat := CHOOSE(CTR, L.mail_geo_lat, L.geo_lat);
	  SELF.geo_long := CHOOSE(CTR, L.mail_geo_long, L.geo_long);
	  SELF.dt_first_seen := (UNSIGNED4)L.start_date;
	  SELF.dt_last_seen := (UNSIGNED4)CA_Sales_Tax_File_Date;
	  SELF.dt_vendor_first_reported := (UNSIGNED4)L.start_date;
	  SELF.dt_vendor_last_reported := (UNSIGNED4)CA_Sales_Tax_File_Date;
	  SELF.fein := 0;
	  SELF.current := TRUE;
	END;

	CA_ST_Firms := normalize(CA_ST_Seq(firm_name <> ''), 2, Translate_CASalesTax_To_BHF(left, counter, 1));

	CA_ST_Owners := normalize(CA_ST_Seq((owner_name <> '' and firm_name = '') or (owner_name <> '' and firm_name <> '' and
						 not (Address.Business.GetNameType(name_first + ' ' + name_middle + ' ' + name_last + ' ' + name_suffix) in ['P','D']
						 and datalib.CompanyClean(owner_name)[41..120] = ''))), 2, Translate_CASalesTax_To_BHF(left, counter, 2));

	CA_ST_Companies := CA_ST_Firms(company_name <> '', company_name[1..12] <> 'UNIDENTIFIED', NOT (prim_name='' AND city='' AND state='' AND zip=0)) +
					   CA_ST_Owners(company_name <> '', company_name[1..12] <> 'UNIDENTIFIED', NOT (prim_name='' AND city='' AND state='' AND zip=0));


	ut.MAC_Sequence_Records(CA_ST_Companies, split_id, CA_ST_Companies_Seq)

	// Group by original id and name type
	CA_ST_Companies_Dist := DISTRIBUTE(CA_ST_Companies_Seq, hash(orig_id));
	CA_ST_Companies_Sort := SORT(CA_ST_Companies_Dist, orig_id, ntyp, LOCAL);
	CA_ST_Companies_Grpd := GROUP(CA_ST_Companies_Sort, orig_id, ntyp, LOCAL);
	CA_ST_Companies_Grpd_Sort := SORT(CA_ST_Companies_Grpd, split_id);

	Layout_BHF_Local SetGroupId(Layout_BHF_Local L, Layout_BHF_Local R) := TRANSFORM
	SELF.group1_id := IF(L.group1_id <> 0, L.group1_id, R.split_id);
	SELF := R;
	END;

	// Set group id for firm name and addesses, owner name and addresses
	CA_ST_Companies_Iter := GROUP(ITERATE(CA_ST_Companies_Grpd_Sort, SetGroupId(LEFT, RIGHT)));

	// Calculate stat to determine count by group_id
	Layout_Group_List := RECORD
	CA_ST_Companies_Iter.group1_id;
	END;

	CA_ST_Group_List := TABLE(CA_ST_Companies_Iter, Layout_Group_List);

	Layout_Group_Stat := RECORD
	CA_ST_Group_List.group1_id;
	cnt := COUNT(GROUP);
	END;

	CA_ST_Group_Stat := TABLE(CA_ST_Group_List, Layout_Group_Stat, group1_id);

	// Clean single group ids and format
	Business_Header.Layout_Business_Header FormatToBHF(Layout_BHF_Local L, Layout_Group_Stat R) := TRANSFORM
	SELF.group1_id := R.group1_id;
	SELF := L;
	END;

	CA_ST_Group_Clean := JOIN(CA_ST_Companies_Iter,
							  CA_ST_Group_Stat(cnt > 1),
							  LEFT.group1_id = RIGHT.group1_id,
							  FormatToBHF(LEFT, RIGHT),
							  LEFT OUTER,
							  LOOKUP);

	// Rollup
	Business_Header.Layout_Business_Header RollupCA_ST(Business_Header.Layout_Business_Header L, Business_Header.Layout_Business_Header R) := TRANSFORM
	SELF.dt_first_seen := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),	ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	SELF.dt_last_seen := max(L.dt_last_seen,R.dt_last_seen);
	SELF.dt_vendor_last_reported := max(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
	SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
	SELF.company_name := IF(L.company_name = '', R.company_name, L.company_name);
	SELF.group1_id := IF(L.group1_id = 0, R.group1_id, L.group1_id);
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

	CA_ST_Clean_Companies_Dist := DISTRIBUTE(CA_ST_Group_Clean,
								   HASH(zip, TRIM(prim_name), TRIM(prim_range), TRIM(source_group), TRIM(company_name)));
	CA_ST_Clean_Companies_Sort := SORT(CA_ST_Clean_Companies_Dist, zip, prim_range, prim_name, source_group, company_name,
						IF(sec_range <> '', 0, 1), sec_range,
						IF(phone <> 0, 0, 1), phone,
						IF(fein <> 0, 0, 1), fein,
						dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, LOCAL);
	CA_ST_Clean_Companies_Rollup := ROLLUP(CA_ST_Clean_Companies_Sort,
						left.zip = right.zip and
						  left.prim_name = right.prim_name and
						  left.prim_range = right.prim_range and
						  left.company_name = right.company_name and
						  left.source_group = right.source_group and
						  (right.sec_range = '' OR left.sec_range = right.sec_range) and
						  (right.phone = 0 OR left.phone = right.phone) and
						  (right.fein = 0 OR left.fein = right.fein),
						RollupCA_ST(LEFT, RIGHT),
						LOCAL);

	return CA_ST_Clean_Companies_Rollup;
end;