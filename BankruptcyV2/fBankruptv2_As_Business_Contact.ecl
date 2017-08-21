IMPORT ut, Business_Header,mdr;

export fBankruptv2_As_Business_Contact(

	 dataset(layout_bankruptcy_search															) pFile_BK_Search
	,dataset(layout_bankruptcy_main.layout_bankruptcy_main_filing	) pFile_BK_Main

) :=
function
	//*************************************************************************
	// Translate Banruptcy to Common Business Header Format
	//*************************************************************************

	bs := pFile_BK_Search(((court_code <> '' and case_number <> '') or case_number[1..3] <> '449'),(trim(name_type) = 'D'));
	bm := pFile_BK_Main((court_code <> '' and case_number <> '') or case_number[1..3] <> '449');

	layout_court_case_list := record
	bs.court_code;
	bs.case_number;
	end;

	court_case_list := table(bs(lname = '', cname <> ''), layout_court_case_list);
	court_case_list_dedup := dedup(court_case_list, court_code, case_number, all);

	// Join business bankruptcy list to search file to get contacts
	BankruptcyV2.layout_bankruptcy_search SelectContacts(BankruptcyV2.layout_bankruptcy_search l, layout_court_case_list r) := transform
	self := l;
	end;

	bc_init := join(bs(lname <> '', cname = ''),
					court_case_list_dedup,
					left.court_code = right.court_code and
					  left.case_number = right.case_number,
					SelectContacts(left, right),
					hash);

	bc_dist := distribute(bc_init, hash(court_code, case_number));

	// Join Contacts to Businesses to get Company Information
	Business_Header.Layout_Business_Contact_Full_New  Translate_Bankruptcy_to_BCF(Business_Header.Layout_Business_Header_New l, BankruptcyV2.layout_bankruptcy_search r) := transform
	SELF.vl_id := r.tmsid + trim(r.debtor_type,left,right);
	SELF.did := (unsigned6)r.did;
	SELF.company_name := l.company_name;
	SELF.company_source_group := l.source_group;
	SELF.company_prim_range := l.prim_range;
	SELF.company_predir := l.predir;
	SELF.company_prim_name := l.prim_name;
	SELF.company_addr_suffix := l.addr_suffix;
	SELF.company_postdir := l.postdir;
	SELF.company_unit_desig := l.unit_desig;
	SELF.company_sec_range := l.sec_range;
	SELF.company_city := l.city;
	SELF.company_state := l.state;
	SELF.company_zip := l.zip;
	SELF.company_zip4 := l.zip4;
	SELF.company_phone := l.phone;
	SELF.company_fein := l.fein;
	self.company_title := '';
	SELF.vendor_id := (qstring34)(r.court_code + r.case_number + r.debtor_type);
	SELF.title := r.title;
	SELF.fname := r.fname;
	SELF.mname := r.mname;
	SELF.lname := r.lname;
	SELF.name_suffix := r.name_suffix;
	SELF.name_score := Business_Header.CleanName(r.fname, r.mname, r.lname, r.name_suffix)[142];
	SELF.prim_range := r.prim_range;
	SELF.predir := r.predir;
	SELF.prim_name := r.prim_name;
	SELF.addr_suffix := r.addr_suffix;
	SELF.postdir := r.postdir;
	SELF.unit_desig := r.unit_desig;
	SELF.sec_range := r.sec_range;
	SELF.city := r.v_city_name;
	SELF.state := r.st;
	SELF.zip := (UNSIGNED3)r.zip;
	SELF.zip4 := (UNSIGNED2)r.zip4;
	SELF.county := r.county[3..5];
	SELF.msa := r.msa;
	SELF.geo_lat := r.geo_lat;
	SELF.geo_long := r.geo_long;
	SELF.source := MDR.sourceTools.src_Bankruptcy;
	SELF.dt_first_seen := l.dt_first_seen;
	SELF.dt_last_seen := l.dt_last_seen;
	SELF.record_type := 'C';
	SELF.phone := 0;
	SELF.email_address := '';
	SELF.ssn := (unsigned4)r.app_ssn;
	SELF := L;
	end;

	Business_Bankruptcies_Dist := distribute(bankruptcyv2.fBankruptv2_As_Business_Header(pFile_BK_Search, pFile_BK_Main), hash((string5)vendor_id[1..5], (string7)(vendor_id[6..12])));

	Bankruptcy_Contacts := join(Business_Bankruptcies_Dist,
								bc_dist,
								left.vendor_id[1..5] = right.court_code and
								  left.vendor_id[6..12] = right.case_number,
								Translate_Bankruptcy_to_BCF(left, right),
								local);

	return Bankruptcy_Contacts((integer)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix));

end;