import ut,doxie;

export bankruptcy_records_prs(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

br := doxie_cbrs.bankruptcy_records(bdids);

rec := record , maxlength(200000)
  integer   penalt := 0;
	  string20 filer_type_mapped;
       string20 court_state;
	  	string1    source;
	string5    court_code;
	string7    case_number;
	string25   orig_case_number;
	string12   id;
	string10   seq_number;
	string8    date_created;
	string8    date_modified;
	string50   court_name;
	string40   court_location;
	string8    case_closing_date;
	string3    chapter;
	string10   orig_filing_type;
	string12   filing_status;
	string3    orig_chapter;
	string8    orig_filing_date;
	string3    corp_flag;
	string8    meeting_date;
	string8    meeting_time;
	string90   address_341;
	string8    claims_deadline;
	string8    complaint_deadline;
	string8    disposed_date;
	string35   disposition;
	string8	   converted_date;
	string8	   reopen_date;
	string35   judge_name;
	string128  record_type;
	string8    date_filed;
	string5    assets_no_asset_indicator;
	string1    filing_type;
	string1    filer_type;
	string3    pro_se_ind;
	string5    judges_identification;
	string55   attorney_name;
	string10   attorney_phone;
	string65   attorney_company;
	string60   attorney_address1;
	string60   attorney_address2;
	string25   attorney_city;
	string2    attorney_st;
	string5    attorney_zip;
	string4    attorney_zip4;
	string55   attorney2_name;
	string10   attorney2_phone;
	string65   attorney2_company;
	string60   attorney2_address1;
	string60   attorney2_address2;
	string25   attorney2_city;
	string2    attorney2_st;
	string5    attorney2_zip;
	string4    attorney2_zip4;
	dataset(doxie.layout_bk_child) debtor_records; 
	boolean    SelfRepresented;		//to match accurint
	boolean    AssetsForUnsecured;
end;

doxie.layout_bk_child tra0(doxie.layout_bk_child l) := transform
	self.names := l.names(debtor_company <> '' and debtor_fname = '' and debtor_lname ='');
	self.debtor_ssn := '';
	self := l;
end;

//slim down and pull out person debtor info
rec tra(br l) := transform
	self.debtor_records := 
		if(doxie_cbrs.stored_ShowPersonalData_value,
		   l.debtor_records,
		   project(l.debtor_records((integer)debtor_did = 0), tra0(left)));
	self := l;
end;

brslim := project(br, tra(left));

return brslim;
END;