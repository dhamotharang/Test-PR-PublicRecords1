import Business_Header, ut;

export fBankrupt_As_Business_Header(dataset(Layout_BK_Search_v8) pFile_BK_Search, dataset(layout_bk_main_v8) pFile_BK_Main) :=
function

	//*************************************************************************
	// Translate Banruptcy to Common Business Header Format
	//*************************************************************************


	bs := pFile_BK_Search((debtor_lname = '' and debtor_company <> '' and court_code <> '' and case_number <> '') or case_number[1..3] <> '449');
	bm := pFile_BK_Main((court_code <> '' and case_number <> '') or case_number[1..3] <> '449');

	layout_bk_temp_loc := record
	Layout_BK_Search_v8;
	string8 orig_filing_date;
	string8 date_filed;
	string8 disposed_date;
	string8 reopen_date;
	string8 converted_date;
	end;

	layout_bk_main_slim := record
	bm.court_code;
	bm.case_number;
	bm.seq_number;
	bm.orig_filing_date;
	bm.date_filed;
	bm.disposed_date;
	bm.reopen_date;
	bm.converted_date;
	end;

	bm_init := table(bm, layout_bk_main_slim);
	bm_init_dist := distribute(bm_init, hash(court_code, case_number));
	bm_init_sort := sort(bm_init_dist, court_code, case_number, -seq_number, local);
	bm_init_dedup := dedup(bm_init_sort, court_code, case_number, local);

	bs_dist := distribute(bs, hash(court_code, case_number));

	layout_bk_temp_loc AppendFromMain(Layout_BK_Search_v8 l, layout_bk_main_slim r) := transform
	self.orig_filing_date := r.orig_filing_date;
	self.date_filed := r.date_filed;
	self.disposed_date := r.disposed_date;
	self.reopen_date := r.reopen_date;
	self.converted_date := r.converted_date;
	self := l;
	end;

	bs_append := join(bs_dist,
					  bm_init_dedup,
					  left.court_code = right.court_code and
						left.case_number = right.case_number,
					  AppendFromMain(left, right),
					  local);

	Business_Header.Layout_Business_Header  Translate_Bankruptcy_to_BHF(layout_bk_temp_loc l) := transform
	self.bdid := 0;
	self.company_name := Stringlib.StringToUpperCase(l.debtor_company);
	self.vendor_id := (qstring34)(l.court_code + l.case_number + l.debtor_type);
	self.zip := (unsigned3)l.z5;
	self.zip4 := (unsigned2)l.zip4;
	self.phone := 0;
	self.phone_score := 0;
	self.addr_suffix := l.suffix;
	self.city := l.p_city_name;
	self.state := l.st;
	self.source := 'B';
	self.county := l.county[3..5];
	self.source_group := (qstring34)(l.court_code + l.case_number);
	self.dt_first_seen := ut.min2((integer)l.orig_filing_date, (integer)l.date_filed);
	self.dt_last_seen := ut.max2(
						   ut.max2((integer)l.disposed_date, (integer) l.reopen_date),
						   ut.max2((integer)l.converted_date, (integer)l.date_filed));
	self.dt_vendor_last_reported := self.dt_last_seen;
	self.dt_vendor_first_reported := self.dt_first_seen;
	self.current := true;
	self.fein := if((unsigned4)l.debtor_ssn > 9999, (unsigned4)l.debtor_ssn, 0);
	self := l;
	end;

	bs_companies := project(bs_append, Translate_Bankruptcy_to_BHF(left));

	// Rollup
	Business_Header.Layout_Business_Header RollupBS(Business_Header.Layout_Business_Header L, Business_Header.Layout_Business_Header R) := transform
	self.dt_first_seen := 
				ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
				ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	self.dt_last_seen := ut.LatestDate(L.dt_last_seen,R.dt_last_seen);
	self.dt_vendor_last_reported := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
	self.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
	self.company_name := if(L.company_name = '', R.company_name, L.company_name);
	self.group1_id := if(L.group1_id = 0, R.group1_id, L.group1_id);
	self.vendor_id := if((L.group1_id = 0 and R.group1_id <> 0) or
						 L.vendor_id = '', R.vendor_id, L.vendor_id);
	self.source_group := if((L.group1_id = 0 and R.group1_id <> 0) or
						 L.source_group = '', R.source_group, L.source_group);
	self.phone := if(L.phone = 0, R.phone, L.phone);
	self.phone_score := if(L.phone = 0, R.phone_score, L.phone_score);
	self.fein := if(L.fein = 0, R.fein, L.fein);
	self.prim_range := if(l.prim_range = '' and l.zip4 = 0, r.prim_range, l.prim_range);
	self.predir := if(l.predir = '' and l.zip4 = 0, r.predir, l.predir);
	self.prim_name := if(l.prim_name = '' and l.zip4 = 0, r.prim_name, l.prim_name);
	self.addr_suffix := if(l.addr_suffix = '' and l.zip4 = 0, r.addr_suffix, l.addr_suffix);
	self.postdir := if(l.postdir = '' and l.zip4 = 0, r.postdir, l.postdir);
	self.unit_desig := if(l.unit_desig = '' and l.zip4 = 0, r.unit_desig, l.unit_desig);
	self.sec_range := if(l.sec_range = '' and l .zip4 = 0, r.sec_range, l.sec_range);
	self.city := if(l.city = '' and l.zip4 = 0, r.city, l.city);
	self.state := if(l.state = '' and l.zip4 = 0, r.state, l.state);
	self.zip := if(l.zip = 0 and l.zip4 = 0, r.zip, l.zip);
	self.zip4 := if(l.zip4 = 0, r.zip4, l.zip4);
	self.county := if(l.county = '' and l.zip4 = 0, r.county, l.county);
	self.msa := if(l.msa = '' and l.zip4 = 0, r.msa, l.msa);
	self.geo_lat := if(l.geo_lat = '' and l.zip4 = 0, r.geo_lat, l.geo_lat);
	self.geo_long := if(l.geo_long = '' and l.zip4 = 0, r.geo_long, l.geo_long);
	self := l;
	end;

	bs_companies_dist := distribute(bs_companies,
								   hash(zip, trim(prim_name), trim(prim_range), trim(source_group), trim(company_name)));
	bs_companies_sort := sort(bs_companies_dist, zip, prim_range, prim_name, source_group, company_name,
						  if(sec_range <> '', 0, 1), sec_range,
						  if(phone <> 0, 0, 1), phone,
						  if(fein <> 0, 0, 1), fein,
						  dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, local);
	bs_companies_rollup := rollup(bs_companies_sort,
							left.zip = right.zip and
							left.prim_name = right.prim_name and
							left.prim_range = right.prim_range and
							left.company_name = right.company_name and
							left.source_group = right.source_group and
							(right.sec_range = '' OR left.sec_range = right.sec_range) and
							(right.phone = 0 OR left.phone = right.phone) and
							(right.fein = 0 OR left.fein = right.fein),
						   RollupBS(left, right),
							 local);

	return  project(bs_append, Translate_Bankruptcy_to_BHF(left));

end;