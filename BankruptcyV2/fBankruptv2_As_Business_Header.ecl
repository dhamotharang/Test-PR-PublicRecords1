import Business_Header, ut,mdr;

export fBankruptv2_As_Business_Header(

	 dataset(layout_bankruptcy_search															) pFile_BK_Search
	,dataset(layout_bankruptcy_main.layout_bankruptcy_main_filing	) pFile_BK_Main

) :=
function

/*************************************************************************
	Translate Bankruptcy to Common Business Header Format
	*************************************************************************/


	bs := pFile_BK_Search((cname <> '' and ((lname = '' and cname <> '' and court_code <> '' and case_number <> '') or case_number[1..3] <> '449')),(trim(name_type) = 'D'));
	bm := pFile_BK_Main((court_code <> '' and case_number <> '') or case_number[1..3] <> '449');

	layout_bk_temp_loc := record
	layout_bankruptcy_search;
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

	layout_bk_temp_loc AppendFromMain(layout_bankruptcy_search l, layout_bk_main_slim r) := transform
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
					  local
						);

	Business_Header.Layout_Business_Header_New  Translate_Bankruptcy_to_BHF(layout_bk_temp_loc l) := transform
	// self.bdid := 0;
	self.bdid := (unsigned6)l.bdid;
	SELF.vl_id := l.tmsid + trim(l.debtor_type,left,right);
	self.company_name := Stringlib.StringToUpperCase(l.cname);
	self.vendor_id := (qstring34)(l.court_code + l.case_number + l.debtor_type);
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.phone := 0;
	self.phone_score := 0;
	self.addr_suffix := l.name_suffix;
	self.city := l.v_city_name;
	self.state := l.st;
	self.source := MDR.sourceTools.src_Bankruptcy;
	self.county := l.county[3..5];
	self.source_group := (qstring34)(l.court_code + l.case_number);
	self.dt_first_seen := ut.min2((integer)l.orig_filing_date, (integer)l.date_filed);
	self.dt_last_seen :=MAX(
						   MAX((integer)l.disposed_date, (integer) l.reopen_date),
						   MAX((integer)l.converted_date, (integer)l.date_filed));
	self.dt_vendor_last_reported := self.dt_last_seen;
	self.dt_vendor_first_reported := self.dt_first_seen;
	self.current := true;
	self.fein := if((unsigned4)l.app_ssn > 9999, (unsigned4)l.app_ssn, 0);
	self := l;
	end;

	bs_companies := project(bs_append(trim(name_type) = 'D'), Translate_Bankruptcy_to_BHF(left));

	return  project(bs_append, Translate_Bankruptcy_to_BHF(left));

end;