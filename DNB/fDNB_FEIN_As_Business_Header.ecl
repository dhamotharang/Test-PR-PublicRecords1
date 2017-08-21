IMPORT Business_Header, ut,mdr;

export fDNB_FEIN_As_Business_Header(dataset(Layout_DNB_FEIN_In) pInput) :=
function

	//*************************************************************************
	// Translate D&B file to Common Business Header Format
	//*************************************************************************

	dnb_fein_base := pInput(zip <> '');

	bh_layout := business_header.Layout_Business_Header_New;

	bh_layout Translate_DNB_To_BHF(dnb_fein_base L, unsigned1 ntyp) := transform
	  SELF.vl_id := L.CASE_DUNS_NUMBER;
	  SELF.vendor_id := L.CASE_DUNS_NUMBER;
	  SELF.phone := (UNSIGNED6)((UNSIGNED8)L.DB_TELEPHONE_NUMBER);
	  SELF.phone_score := IF((UNSIGNED8)L.DB_TELEPHONE_NUMBER = 0, 0, 1);
	  SELF.source := MDR.sourceTools.src_Dunn_Bradstreet_Fein;
	  SELF.source_group := L.CASE_DUNS_NUMBER;
	  SELF.company_name := CHOOSE(ntyp, stringlib.stringtouppercase(L.BUSINESS_NAME), 
		stringlib.stringtouppercase(L.DB_COMPANY_NAME), stringlib.stringtouppercase(L.DB_TRADESTYLE));
	  SELF.city := L.p_city_name;
	  SELF.state := L.st;
	  SELF.zip := (UNSIGNED3)L.zip;
	  SELF.zip4 := (UNSIGNED2)L.zip4;
	  SELF.county := L.county[3..5];
	  SELF.dt_first_seen := if(L.DATE_OF_INPUT_DATA <> '', (UNSIGNED4)L.DATE_OF_INPUT_DATA, (UNSIGNED4)L.process_date);
	  SELF.dt_last_seen := if(L.DATE_OF_INPUT_DATA <> '', (UNSIGNED4)L.DATE_OF_INPUT_DATA, (UNSIGNED4)L.process_date);
	  SELF.dt_vendor_first_reported := (UNSIGNED4)L.process_date;
	  SELF.dt_vendor_last_reported := (UNSIGNED4)L.process_date;
	  SELF.fein := if(Business_header.ValidFEIN((UNSIGNED4)L.TAX_ID_NUMBER), (UNSIGNED4)L.TAX_ID_NUMBER, 0);
	  SELF.current := TRUE;	  
	  SELF := L;
	END;

	//--------------------------------------------
	// Normalize names
	//--------------------------------------------

	dnb_bus_names  := project(dnb_fein_base(BUSINESS_NAME <> ''), Translate_DNB_To_BHF(LEFT, 1));
	dnb_comp_names := project(dnb_fein_base(DB_COMPANY_NAME <> ''), Translate_DNB_To_BHF(LEFT, 2));
	dnb_trad_names := project(dnb_fein_base(DB_TRADESTYLE <> ''), Translate_DNB_To_BHF(LEFT, 3));

	dnb_combined := dnb_bus_names + dnb_comp_names + dnb_trad_names;

	// Group by company name and address and propagate duns numbers(vendor_id, and source_group)
	dnb_combined_dist := distribute(dnb_combined, hash(ut.CleanCompany(company_name), zip, prim_name, prim_range));
	dnb_combined_sort := sort(dnb_combined_dist, ut.CleanCompany(company_name), zip, prim_name, prim_range, local);
	dnb_combined_grp := group(dnb_combined_sort, ut.CleanCompany(company_name), zip, prim_name, prim_range, local);
	dnb_combined_grp_sort := sort(dnb_combined_grp, -source_group);

	bh_layout PropagateDunsNumber(bh_layout l, bh_layout r) := transform
	self.vendor_id := if(r.vendor_id <> '' or r.vendor_id = '000000000', r.vendor_id, l.vendor_id);
	self.source_group := if(r.source_group <> '' or r.source_group = '000000000', r.source_group, l.source_group);
	self := r;
	end;

	dnb_combined_grp_iter := group(iterate(dnb_combined_grp_sort, PropagateDunsNumber(left, right)));

	// Join records with blank Duns Numbers to DNB_As_Business_Header
	dnb_bh := fDNB_As_Business_Header(File_DNB_Base_Plus)(vendor_id[1] <> 'D', zip <> 0, prim_name <> '');

	layout_dnb_slim := record
	string81 clean_company_name := ut.CleanCompany(dnb_bh.company_name);
	dnb_bh.zip;
	dnb_bh.prim_name;
	dnb_bh.prim_range;
	string9 duns_number := (string)dnb_bh.source_group;
	end;

	dnb_bh_slim := table(dnb_bh, layout_dnb_slim);
	dnb_bh_slim_dedup := dedup(dnb_bh_slim, clean_company_name, zip, prim_name, prim_range, all);
	dnb_bh_slim_dist := distribute(dnb_bh_slim_dedup, hash(clean_company_name, zip, prim_name, prim_range));

	bh_layout AppendDunsNumber(bh_layout l, layout_dnb_slim r) := transform
	self.vendor_id := r.duns_number;
	self.source_group := r.duns_number;
	self := l;
	end;

	dnb_combined_append := join(dnb_combined_grp_iter(source_group = '' or source_group = '000000000'),
								dnb_bh_slim_dist,
						   ut.CleanCompany(left.company_name) = right.clean_company_name and
							 left.zip = right.zip and
							left.prim_name = right.prim_name and
							left.prim_range = right.prim_range,
						   AppendDunsNumber(left, right),
						   left outer,
						   local);
						   
	dnb_combined_all := dnb_combined_grp_iter(source_group <> '' and source_group <> '000000000') + dnb_combined_append;

	// Final Rollup
	bh_layout RollupDNB(bh_layout L, bh_layout R) := TRANSFORM
	SELF.dt_first_seen := 
				ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
				ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	SELF.dt_last_seen := ut.LatestDate(L.dt_last_seen,R.dt_last_seen);
	SELF.dt_vendor_last_reported := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
	SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
	SELF.vl_id := IF(L.vl_id = '', R.vl_id, L.vl_id);
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

	dnb_clean_dist := DISTRIBUTE(dnb_combined_all,
						HASH(zip, TRIM(prim_name), TRIM(prim_range), TRIM(source_group), TRIM(company_name)));
	dnb_clean_sort := SORT(dnb_clean_dist, zip, prim_range, prim_name, source_group, company_name,
						IF(sec_range <> '', 0, 1), sec_range,
						IF(phone <> 0, 0, 1), phone,
						IF(fein <> 0, 0, 1), fein,
						dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, LOCAL);
	dnb_clean_rollup := ROLLUP(dnb_clean_sort,
						left.zip = right.zip and
						  left.prim_name = right.prim_name and
						  left.prim_range = right.prim_range and
						  left.company_name = right.company_name and
						  left.source_group = right.source_group and
						  (right.sec_range = '' OR left.sec_range = right.sec_range) and
						  (right.phone = 0 OR left.phone = right.phone) and
						  (right.fein = 0 OR left.fein = right.fein),
						RollupDNB(LEFT, RIGHT),
						LOCAL);

	return dnb_clean_rollup(vendor_id <> '' and vendor_id <> '000000000') ;

end;

