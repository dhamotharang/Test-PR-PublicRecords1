layout_sure_contact := record
	string open_date;
	string name_first;
	string name_last;
	string address_1;
	string city;
	string state;
	string zip;
	string ssn;
	string dob_yyyymmdd;
	string phoneno;
	string phoneno_2;
	string addr_name_first_a;
	string addr_name_middle_a;
	string addr_name_last_a;
	string addr_name_suffix_a;
	string addr_address_a;
	string addr_city_a;
	string addr_state_a;
	string addr_zipcode_a;
	string addr_type_a;
	string addr_confidence_a;
	string ph_phone_a_1;
	string ph_listing_name_a_1;
	string ph_phone_type_a_1;
	string ph_phone_a_2;
	string ph_listing_name_a_2;
	string ph_phone_type_a_2;
	string ph_phone_a_3;
	string ph_listing_name_a_3;
	string ph_phone_type_a_3;
	string addr_name_first_b;
	string addr_name_middle_b;
	string addr_name_last_b;
	string addr_name_suffix_b;
	string addr_address_b;
	string addr_city_b;
	string addr_state_b;
	string addr_zipcode_b;
	string addr_type_b;
	string addr_confidence_b;
	string ph_phone_b_1;
	string ph_listing_name_b_1;
	string ph_phone_type_b_1;
	string ph_phone_b_2;
	string ph_listing_name_b_2;
	string ph_phone_type_b_2;
	string ph_phone_b_3;
	string ph_listing_name_b_3;
	string ph_phone_type_b_3;
	string addr_name_first_c;
	string addr_name_middle_c;
	string addr_name_last_c;
	string addr_name_suffix_c;
	string addr_address_c;
	string addr_city_c;
	string addr_state_c;
	string addr_zipcode_c;
	string addr_type_c;
	string addr_confidence_c;
	string ph_phone_c_1;
	string ph_listing_name_c_1;
	string ph_phone_type_c_1;
	string ph_phone_c_2;
	string ph_listing_name_c_2;
	string ph_phone_type_c_2;
	string ph_phone_c_3;
	string ph_listing_name_c_3;
	string ph_phone_type_c_3;
	string bk_match_type_1;
	string bk_screen_1;
	string bk_case_number_1;
	string bk_chapter_1;
	string bk_chapter_code_1;
	string bk_file_date_1;
	string bk_status_date_1;
	string bk_disp_1;
	string bk_disp_code_1;
	string bk_debtor1_ssn_1;
	string bk_debtor1_first_1;
	string bk_debtor1_middle_1;
	string bk_debtor1_last_1;
	string bk_debtor1_suffix_1;
	string bk_debtor1_address_1;
	string bk_debtor1_city_1;
	string bk_debtor1_state_1;
	string bk_dezipcode_1;
	string bk_debtor1_aka_first_1;
	string bk_debtor1_aka_middle_1;
	string bk_debtor1_aka_last_1;
	string bk_debtor1_aka2_first_1;
	string bk_debtor1_aka2_middle_1;
	string bk_debtor1_aka2_last_1;
	string bk_debtor2_ssn_1;
	string bk_debtor2_first_1;
	string bk_debtor2_middle_1;
	string bk_debtor2_last_1;
	string bk_debtor2_suffix_1;
	string bk_debtor2_address_1;
	string bk_debtor2_city_1;
	string bk_debtor2_state_1;
	string bk_dezipcode_2;
	string bk_debtor2_aka_first_1;
	string bk_debtor2_aka_middle_1;
	string bk_debtor2_aka_last_1;
	string bk_debtor2_aka2_first_1;
	string bk_debtor2_aka2_middle_1;
	string bk_debtor2_aka2_last_1;
	string bk_business_1;
	string bk_business_1_1;
	string bk_court_code_1;
	string bk_city_filed_1;
	string bk_state_filed_1;
	string bk_county_1;
	string bk_judge_1;
	string bk_law_firm_1;
	string bk_atty_name_1;
	string bk_atty_address1_1;
	string bk_atty_address2_1;
	string bk_atty_city_1;
	string bk_atty_state_1;
	string bk_atzipcode_1;
	string bk_atty_phone_1;
	string bk_trustee_name_1;
	string bk_trustee_address1_1;
	string bk_trustee_address2_1;
	string bk_trustee_city_1;
	string bk_trustee_state_1;
	string bk_trzipcode_1;
	string bk_trustee_phone_1;
	string bk_341_date_1;
	string bk_341_time_1;
	string bk_341_location_1;
	string bk_341_city_1;
	string bk_341_state_1;
	string bk_34zipcode_1;
	string bk_bar_date_1;
	string bk_ecoa_code_1;
	string bk_funds_1;
	string dcd_match_code_1;
	string dcd_name_first_1;
	string dcd_name_last_1;
	string dcd_dob_1;
	string dcd_dod_1;
	string dcd_zip_gvt_benefit_1;
	string dcd_zip_death_benefit_1;
end;

f := enth(dataset('~eschepers::in::jcchristiansen_bocashell', layout_sure_contact, csv(heading(1), quote('"'))),2);

output(f, named('original_layout'));

l := RECORD
	STRING old_account_number;
	Risk_Indicators.Layout_InstID_SoapCall;
END;

l t_f(f le, INTEGER c) := TRANSFORM
	SELF.old_account_number := le.open_date;
	SELF.AccountNumber := (STRING)c;	
	SELF.FirstName := if(le.addr_type_a='X', le.name_first, le.addr_name_first_a);
	SELF.MiddleName := '';
	SELF.LastName := if(le.addr_type_a='X', le.name_last, le.addr_name_last_a);
	SELF.NameSuffix := '';
	SELF.StreetAddress := if(le.addr_type_a='X', le.address_1, le.addr_address_a);
	SELF.City := if(le.addr_type_a='X', le.city, le.addr_city_a);
	SELF.State := if(le.addr_type_a='X', le.state, le.addr_state_a);
	SELF.Zip := if(le.addr_type_a='X', le.zip, le.addr_zipcode_a);
	SELF.Country := '';
	SELF.SSN := le.ssn;
	SELF.DateOfBirth := le.dob_yyyymmdd;
	SELF.Age := '';
	SELF.DLNumber := '';
	SELF.DLState := '';
	SELF.Email := '';
	SELF.IPAddress := '';
	SELF.HomePhone := if(le.addr_type_a='X', le.phoneno, le.ph_phone_a_1);
	SELF.WorkPhone := '';
	SELF.EmployerName := '';
	SELF.FormerName := '';
	SELF.GLBPurpose := 1;
	SELF.DPPAPurpose := 1;
	SELF.HistoryDateYYYYMM := '200603';
END;

p_f := PROJECT(f,t_f(LEFT,COUNTER));

output(p_f, named('bocashell_input'));

roxieIP := 'http://roxiestaging.br.seisint.com:9876';
//roxieIP := 'http://stcloudroxievip.sc.seisint.com:9876';  //St. Cloud Roxie

s_f := Risk_Indicators.BocaShell_SoapCall(PROJECT(p_f,TRANSFORM(Risk_Indicators.Layout_InstID_SoapCall,SELF := LEFT)), roxieIP);

try_2 := JOIN(p_f, s_f(errorcode<>''), (unsigned)LEFT.accountnumber=RIGHT.seq, TRANSFORM(l,SELF := LEFT));

s_f2 := Risk_Indicators.BocaShell_SoapCall(PROJECT(try_2,TRANSFORM(Risk_Indicators.Layout_InstID_SoapCall,SELF := LEFT)), roxieIP);

s := s_f(errorcode='') + s_f2;

ox :=
RECORD
	STRING AccountNumber;
	risk_indicators.Layout_Boca_Shell_Edina;
	STRING errorcode;
END;

ox getold(s le, l ri) :=
TRANSFORM
	SELF.AccountNumber := ri.old_account_number;
	SELF := le;
END;

j_f := JOIN(s,p_f,LEFT.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));

output(j_f,,'~thor_data50::out::bocashell_test_scroxie',CSV(QUOTE('"')),overwrite);
output(j_f(errorcode<>''),,'~thor_data50::out::bocashell_test_scroxie_errors',CSV(QUOTE('"')),overwrite);
