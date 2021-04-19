#workunit('name','Consumer IID-FD Process');

prii_layout := RECORD
	STRING AccountNumber;
	STRING FirstName;
	STRING MiddleName;
	STRING LastName;
	STRING StreetAddress;
	STRING City;
	STRING State;
	STRING Zip;
	STRING HomePhone;
	STRING SSN;
	STRING DateOfBirth;
	STRING WorkPhone;
	STRING income;  
	string DLNumber;
	string DLState;
	string BALANCE; 
	string CHARGEOFFD;  
	string FormerName;
	string EMAIL;  
	string COMPANY;
	string historydateyyyymm;
END;

f := DATASET('~tfuerstenberg::out::ssbank2_ciid_fd_missing',prii_layout,csv(quote('"')));
//f := choosen(DATASET('~tfuerstenberg::in::sbbank2_ciid_fd',prii_layout,csv(quote('"'))),5);

//f1 := DATASET('~tfuerstenberg::in::sbbank2_ciid_fd',prii_layout,csv(quote('"')));
//f := f1((string)AccountnUMBER='EOL1432320');
output(f);

layout_soap := record
	STRING AccountNumber;
	STRING FirstName;
	STRING MiddleName;
	STRING LastName;
	STRING NameSuffix;
	STRING StreetAddress;
	STRING City;
	STRING State;
	STRING Zip;
	STRING Country;
	STRING SSN;
	STRING DateOfBirth;
	STRING Age;
	STRING DLNumber;
	STRING DLState;
	STRING Email;
	STRING IPAddress;
	STRING HomePhone;
	STRING WorkPhone;
	STRING EmployerName;
	STRING FormerName;
	INTEGER GLBPurpose;
	INTEGER DPPAPurpose;
	STRING6 HistoryDateYYYYMM := '';
	string neutral_gateway := '';
	dataset(Models.Layout_Score_Chooser) scores;
end;

l := RECORD
	STRING old_account_number;
	layout_soap;
END;

parms := dataset ([],models.Layout_Parameters);

l t_f(f le, INTEGER c) := TRANSFORM
	SELF.old_account_number := le.accountnumber;
	SELF.Accountnumber := (STRING)c;	
	SELF.DPPAPurpose := 3;
	SELF.GLBPurpose := 1;
//	self.historydateyyyymm := '200601';
	self.scores := dataset([{'Models.FraudAdvisor_Service','http://prdrroxiethorvip.hpcc.risk.regn.net:9876',parms}], models.Layout_Score_Chooser);
	SELF := le;
	self := [];
end;

p_f := project(f, t_f(left, counter));
output(p_f, named('CIID_Input'));

dist_dataset := PROJECT(p_f,TRANSFORM(layout_soap,SELF := LEFT));

roxieIP := 'http://prdrroxiethorvip.hpcc.risk.regn.net:9876'; // dr vip

xlayout := RECORD
	(risk_indicators.Layout_InstandID_NuGen)
	STRING errorcode;
END;

xlayout myFail(dist_dataset le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF.AcctNo := le.AccountNumber;
	SELF := le;
	SELF := [];
END;

resu := soapcall(dist_dataset, roxieIP,
				'risk_indicators.InstantID', {dist_dataset}, 
				DATASET(xlayout),
				PARALLEL(15), onFail(myFail(LEFT)));
				
ox := RECORD
	STRING30 acctNo;
	// new field:
	string12 did;
	// field 1: all input
	string12  seq;
	STRING5   title := '';
	STRING20  fname;
	STRING20  mname;
	STRING20  lname;
	STRING5   suffix;
	STRING120 in_streetAddress;
	STRING25  in_city;
	STRING2   in_state;
	STRING5   in_zipCode;
	STRING25  in_country;
	STRING10  prim_range;
	STRING2   predir;
	STRING28  prim_name;
	STRING4   addr_suffix;
	STRING2   postdir;
	STRING10  unit_desig;
	STRING8   sec_range;
	STRING25  p_city_name;
	STRING2   st;
	STRING5   z5;
	STRING4   zip4;
	STRING10  lat := '';
	STRING11  long := '';
	string3   county := '';
	string7   geo_blk := '';
	STRING1   addr_type;
	STRING4   addr_status;
	STRING25  country;
	STRING9   ssn;
	STRING8   dob;
	STRING3   age;
	STRING20  dl_number := '';
	STRING2   dl_state := '';
	STRING50  email_address := '';
	STRING20  ip_address := '';
	STRING10  phone10;
	STRING10  wphone10;
	STRING100 employer_name := '';
	STRING20  lname_prev := '';
//	field 2: transaction id assigned by us
	string12 transaction_id;
//	field 3-8: consumer id verification
	STRING20 verfirst;
	STRING20 verlast;
	STRING65 veraddr;
	STRING25 vercity;
	STRING2  verstate;
	STRING9  verzip;
	STRING9  verssn;
	STRING8  verdob;
	STRING10 verhphone;
	STRING1  verify_addr;
	STRING1  verify_dob;
	STRING1  valid_ssn;
//	field 9
	string3 NAS_Summary;
//	field 10
	string3 NAP_Summary;
	STRING1  NAP_Type;
	STRING1  NAP_Status;
//	field 11
	string3 CVI;
	string3 additional_score1;
	string3 additional_score2;
//	field 14-19: risk indicators
	string4  hri_1;
	string100 hri_desc_1;
	string4  hri_2;
	string100 hri_desc_2;
	string4  hri_3;
	string100 hri_desc_3;
	string4  hri_4;
	string100 hri_desc_4;
	string4  hri_5;
	string100 hri_desc_5;
	string4  hri_6;
	string100 hri_desc_6;
//	field 19-22: potential follow-up actions
	string4  fua_1;
	string150 fua_desc_1;
	string4  fua_2;
	string150 fua_desc_2;
	string4  fua_3;
	string150 fua_desc_3;
	string4  fua_4;
	string150 fua_desc_4;
//	field 23-27
	STRING20 corrected_lname;
	STRING8  corrected_dob;
	STRING10 corrected_phone;
	STRING9  corrected_ssn;
	STRING65 corrected_address;
//	field 27-28: area code split
	STRING3  area_code_split;			
	STRING8  area_code_split_date;
//	field 29-33: phone lookup info
	STRING20 phone_fname;					
	STRING20 phone_lname;
	STRING65 phone_address;
	STRING25 phone_city;
	STRING2  phone_st;
	STRING5  phone_zip;
//	field 34: tele from a name-address
	STRING10 name_addr_phone;			
//	field 35-37: ssn issuance info
	STRING6  ssa_date_first;
	STRING6  ssa_date_last;
	STRING2  ssa_state;
	STRING20 ssa_state_name;
//	field 38-54: chronological address history
//	38-44: current info
	STRING20  current_fname;
	STRING20  current_lname;
	STRING65  Chron_Address_1;
	STRING25  Chron_City_1;
	STRING2   Chron_St_1;
	STRING5   Chron_Zip_1;
	STRING50  Chron_phone_1;
	STRING65  Chron_Address_2;
	STRING25  Chron_City_2;
	STRING2   Chron_St_2;
	STRING5   Chron_Zip_2;
	STRING50  Chron_phone_2;
	STRING65  Chron_Address_3;
	STRING25  Chron_City_3;
	STRING2   Chron_St_3;
	STRING5   Chron_Zip_3;
	STRING50  Chron_phone_3;
//	field 55-60: additional last names
	string20	additional_fname_1;
	string20	additional_lname_1;
	string8	additional_lname_date_last_1;
	string20	additional_fname_2;
	string20	additional_lname_2;
	string8	additional_lname_date_last_2;
	string20	additional_fname_3;
	string20	additional_lname_3;
	string8	additional_lname_date_last_3;
//	field 61-59 watchlists
	STRING60  Watchlist_Table;
	STRING120 Watchlist_Program;
	STRING10  Watchlist_Record_Number;
	STRING20  Watchlist_fname;
	STRING20  Watchlist_lname;
	STRING65  Watchlist_address;
	STRING25  Watchlist_city;
	STRING2   Watchlist_state;
	STRING5   Watchlist_zip;
	STRING30  Watchlist_contry;
	STRING200 Watchlist_Entity_Name;
//	output the extra model score and reason code
	string3 score;
	string3 reason;
	string3 reason2;
	string3 reason3;
	string3 reason4;
	STRING errorcode;
END;

ox normit(resu L, p_f R) := transform
	SELF.Acctno := R.old_account_number;
	
	self.hri_1 := if (count(l.ri) >= 1, L.ri[1].hri, '');
	self.hri_desc_1 := if (count(l.ri) >= 1, L.ri[1].desc, '');
	self.hri_2 := if (count(l.ri) >= 2, L.ri[2].hri, '');
	self.hri_desc_2 := if (count(l.ri) >= 2, L.ri[2].desc, '');
	self.hri_3 := if (count(l.ri) >= 3, L.ri[3].hri, '');
	self.hri_desc_3 := if (count(l.ri) >= 3, L.ri[3].desc, '');
	self.hri_4 := if (count(l.ri) >= 4, L.ri[4].hri, '');
	self.hri_desc_4 := if (count(l.ri) >= 4, L.ri[4].desc, '');
	self.hri_5 := if (count(l.ri) >= 5, L.ri[5].hri, '');
	self.hri_desc_5 := if (count(l.ri) >= 5, L.ri[5].desc, '');
	self.hri_6 := if (count(l.ri) >= 6, L.ri[6].hri, '');
	self.hri_desc_6 := if (count(l.ri) >= 6, L.ri[6].desc, '');
	self.fua_1 := if (count(l.fua) >= 1, L.fua[1].hri, '');
	self.fua_desc_1 := if (count(l.fua) >= 1, L.fua[1].desc, '');
	self.fua_2 := if (count(l.fua) >= 2, L.fua[2].hri, '');
	self.fua_desc_2 := if (count(l.fua) >= 2, L.fua[2].desc, '');
	self.fua_3 := if (count(l.fua) >= 3, L.fua[3].hri, '');
	self.fua_desc_3 := if (count(l.fua) >= 3, L.fua[3].desc, '');
	self.fua_4 := if (count(l.fua) >= 4, L.fua[4].hri, '');
	self.fua_desc_4 := if (count(l.fua) >= 4, L.fua[4].desc, '');
	self.additional_fname_1 := if (count(L.additional_lname) >= 1, l.additional_lname[1].fname1,'');
	self.additional_lname_1 := if (count(l.additional_lname) >= 1, L.additional_lname[1].lname1, '');
	self.additional_lname_date_last_1 := if (count(l.additional_lname) >= 1, L.additional_lname[1].date_last, '');
	self.additional_fname_2 := if (count(L.additional_lname) >= 2, l.additional_lname[2].fname1,'');
	self.additional_lname_2 := if (count(l.additional_lname) >= 2, L.additional_lname[2].lname1, '');
	self.additional_lname_date_last_2 := if (count(l.additional_lname) >= 2, L.additional_lname[2].date_last, '');
	self.additional_fname_3 := if (count(L.additional_lname) >= 3, l.additional_lname[3].fname1,'');
	self.additional_lname_3 := if (count(l.additional_lname) >= 3, L.additional_lname[3].lname1, '');
	self.additional_lname_date_last_3 := if (count(l.additional_lname) >= 3, L.additional_lname[3].date_last, '');
	self.chron_address_1 := if (count(L.chronology) >= 1, L.chronology[1].address, '');
	self.chron_city_1 := if (count(L.chronology) >= 1, L.chronology[1].city, '');
	self.chron_st_1 := if (count(L.chronology) >= 1, L.chronology[1].st, '');
	self.chron_zip_1 := if (count(L.chronology) >= 1, L.chronology[1].zip, '');
	self.chron_phone_1 := if (count(L.chronology) >= 1, L.chronology[1].phone, '');
	self.chron_address_2 := if (count(L.chronology) >= 2, L.chronology[2].address, '');
	self.chron_city_2 := if (count(L.chronology) >= 2, L.chronology[2].city, '');
	self.chron_st_2 := if (count(L.chronology) >= 2, L.chronology[2].st, '');
	self.chron_zip_2 := if (count(L.chronology) >= 2, L.chronology[2].zip, '');
	self.chron_phone_2 := if (count(L.chronology) >= 2, L.chronology[2].phone, '');
	self.chron_address_3 := if (count(L.chronology) >= 3, L.chronology[3].address, '');
	self.chron_city_3 := if (count(L.chronology) >= 3, L.chronology[3].city, '');
	self.chron_st_3 := if (count(L.chronology) >= 3, L.chronology[3].st, '');
	self.chron_zip_3 := if (count(L.chronology) >= 3, L.chronology[3].zip, '');
	self.chron_phone_3 := if (count(L.chronology) >= 3, L.chronology[3].phone, '');
	self.did := intformat(L.did,12,1);
	self.transaction_id := intformat(L.transaction_id, 12, 1);
	self.nas_summary := (string)L.nas_summary;
	self.nap_summary := (string)L.nap_summary;
	self.CVI := (String)L.cvi;
	self.additional_score1 := (string)L.additional_score1;
	self.additional_score2 := (string)L.additional_score2;
	self.seq := intformat(L.seq,12,1);
	self.age := if (l.age = '***', '', L.age);
	
	// score fields  Note: score[1] equals a 0-999 score range
	// score fields  Note: score[2] equals a 010-050 score range
	// score fields  Note: score[3] equals a 10-90 score range *** Use as Default ***
	self.score := l.models.scores[3].i;
	self.reason := l.models.scores[3].reason_codes[1].reason_code;
	self.reason2 := l.models.scores[3].reason_codes[2].reason_code;
	self.reason3 := l.models.scores[3].reason_codes[3].reason_code;
	self.reason4 := l.models.scores[3].reason_codes[4].reason_code;
	self := L;

end;

j_f := JOIN(resu,p_f,LEFT.acctno=RIGHT.accountnumber,normit(LEFT,RIGHT));

output(j_f);
output(j_f,,'~tfuerstenberg::out::sbbank2_ciid_fd_missout',CSV(QUOTE('"')), overwrite);
output(j_f(errorcode<>''),,'~tfuerstenberg::out::sbbank_ciid_fd_errors2',CSV(QUOTE('"')), overwrite);
