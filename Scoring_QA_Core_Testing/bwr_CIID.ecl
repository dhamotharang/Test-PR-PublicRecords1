//#workunit('name','Consumer IID Process');
#option ('hthorMemoryLimit', 1000);


import Models, risk_indicators, riskwise;

prii_layout := RECORD
      
  string accountnumber;       
  string addr;       
  string addrsuffix;       
  string city;       
  string dateofbirth;       
  string dlnumber;       
  string dlstate;       
  string firstname;                     
  string homephone;                     
  string lastname;                      
  string middlename;                    
  string postdir;                       
  string predir;                        
  string primname;                      
  string primrange;                     
  string secrange;                      
  string ssn;                           
  string state;                         
  string streetaddress;                 
  string unitdesignation;               
  string unparsedfullname;              
  string zip;                            

END;

f := DATASET('~ak::in::iid_20180122::input',prii_layout,csv(quote('"')));
// f := choosen(DATASET('~ak::in::iid_20180122::input',prii_layout,csv(quote('"'))),5);

output(f);

layout_soap := record
	STRING AccountNumber;
	STRING FirstName;
	STRING MiddleName;
	STRING LastName;
	STRING NameSuffix;
	STRING StreetAddress;
	string PrimRange;
	string PreDir;
	string Primname;
	string AddrSuffix;
	string PostDir;
	string UnitDesignation;
	string SecRange;
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
	string DataRestrictionMask;
	integer HistoryDateYYYYMM;
	string neutral_gateway := '';	
	dataset(Models.Layout_Score_Chooser) scores;
	
	boolean OfacOnly;
	integer OFACversion;
	boolean IncludeOfac;
	boolean IncludeAdditionalWatchLists;
	real GlobalWatchlistThreshold;
	boolean PoBoxCompliance;
	boolean IncludeMSoverride;
	boolean IncludeCLoverride;
	boolean IncludeDLVerification;
	string44 PassportUpperLine;
	string44 PassportLowerLine;
	string6 Gender;
	integer DOBradius;
  boolean usedobfilter;
	
	boolean ExactFirstNameMatch;
	boolean ExactFirstNameMatchAllowNicknames;
	boolean ExactLastNameMatch;
	boolean ExactPhoneMatch;
	boolean ExactSSNMatch;

	boolean IncludeAllRiskIndicators;
	
	dataset(risk_indicators.layouts.Layout_DOB_Match_Options) DOBMatchOptions;

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
	
	self.DataRestrictionMask := '0000000000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																								// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data

	self.PoBoxCompliance := false;
	self.IncludeMSoverride := false;
	self.IncludeCLoverride := false;

	self.OfacOnly := false;
	self.OFACversion := 2;
	self.IncludeOfac := true;

  self.IncludeAdditionalWatchLists := false;
	self.GlobalWatchlistThreshold := 0.84;
	self.usedobfilter := false;
  self.DOBradius := 2;
	
	self.IncludeDLVerification := false;
	self.PassportUpperLine := '';
	self.PassportLowerLine := '';
	self.Gender := '';
	
	self.historydateyyyymm := '999999';

	self.ExactFirstNameMatch := false;
	self.ExactFirstNameMatchAllowNicknames := false;
	self.ExactLastNameMatch := false;
	self.ExactPhoneMatch := false;
	self.ExactSSNMatch := false;

	self.IncludeAllRiskIndicators := false;
	
	// possible input options 'FuzzyCCYYMMDD','FuzzyCCYYMM''ExactCCYYMMDD''ExactCCYYMM''RadiusCCYY', if using the radius, then 0-3 is the range
	// self.DOBMatchOptions := dataset([{'RadiusCCYY','3'}], risk_indicators.layouts.Layout_DOB_Match_Options);

	// only use if you have a 4 byte year on input and you want to use Fuzzy Logic
	// self.DateOfBirth := if (le.DateOfBirth='','',le.DateOfBirth[1..4]+'0000');

	SELF := le;
	self := [];
end;

p_f := project(f, t_f(left, counter));
output(p_f, named('CIID_Input'));

dist_dataset := PROJECT(p_f,TRANSFORM(layout_soap,SELF := LEFT));

//roxieIP := 'http://roxiebatch.br.seisint.com:9856'; // roxiebatch
roxieIP :=riskwise.shortcuts.core_97_roxieIP; // CoreRoxie

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
				'Risk_Indicators.InstantID', {dist_dataset}, 
				DATASET(xlayout), 
				RETRY(2), TIMEOUT(500), LITERAL,
				XPATH('Risk_Indicators.InstantIDResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(2), onFail(myFail(LEFT)));
				
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
	STRING9  verzip;      // **** changed from string9 to string5
	STRING4  verzip4;     // **** added verzip4 field
	STRING20 vercounty;  // **** added vercounty 2/11/2009	
	STRING9  verssn;
	STRING8  verdob;
	STRING10 verhphone;
	STRING1  verify_addr;
	STRING1  verify_dob;
	STRING1  valid_ssn;
//	field 9
	string3  NAS_Summary;
//	field 10
	string3  NAP_Summary;
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
	STRING4   Chron_Zip4_1;					// **** added zip4
	STRING50  Chron_phone_1;
	string6   Chron_dt_first_seen_1;		// **** added chronology dates
	string6   Chron_dt_last_seen_1;			// **** added chronology dates
	
	STRING65  Chron_Address_2;
	STRING25  Chron_City_2;
	STRING2   Chron_St_2;
	STRING5   Chron_Zip_2;
	STRING4   Chron_Zip4_2;					// **** added zip4
	STRING50  Chron_phone_2;
	string6   Chron_dt_first_seen_2;		// **** added chronology dates
	string6   Chron_dt_last_seen_2;			// **** added chronology dates
	
	STRING65  Chron_Address_3;
	STRING25  Chron_City_3;
	STRING2   Chron_St_3;
	STRING5   Chron_Zip_3;
    STRING4   Chron_Zip4_3;					// **** added zip4
	STRING50  Chron_phone_3;
	string6   Chron_dt_first_seen_3;		// **** added chronology dates
	string6   Chron_dt_last_seen_3;			// **** added chronology dates


//	field 55-60: additional last names
	string20	additional_fname_1;
	string20	additional_lname_1;
	string8	    additional_lname_date_last_1;
	string20	additional_fname_2;
	string20	additional_lname_2;
	string8	    additional_lname_date_last_2;
	string20	additional_fname_3;
	string20	additional_lname_3;
	string8	    additional_lname_date_last_3;
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
	STRING30  Watchlist_country;
	STRING200 Watchlist_Entity_Name;
	
	// new fields added for the R1 2010 enhancement
	string1  Chron_addr_1_isBest;
	string1  Chron_addr_2_isBest;
	string1  Chron_addr_3_isBest;
	string3 SubjectSSNCount := '';
	string20 verDL := '';
	string8 deceasedDate := '';
	string8 deceasedDOB := '';
	string15 deceasedFirst := '';
	string20 deceasedLast := '';
	STRING60  Watchlist_Table_2;
	STRING120 Watchlist_Program_2;
	STRING10  Watchlist_Record_Number_2;
	STRING20  Watchlist_fname_2;
	STRING20  Watchlist_lname_2;
	STRING65  Watchlist_address_2;
	STRING25  Watchlist_city_2;
	STRING2   Watchlist_state_2;
	STRING5   Watchlist_zip_2;
	STRING30  Watchlist_country_2;
	STRING200 Watchlist_Entity_Name_2;
	STRING60  Watchlist_Table_3;
	STRING120 Watchlist_Program_3;
	STRING10  Watchlist_Record_Number_3;
	STRING20  Watchlist_fname_3;
	STRING20  Watchlist_lname_3;
	STRING65  Watchlist_address_3;
	STRING25  Watchlist_city_3;
	STRING2   Watchlist_state_3;
	STRING5   Watchlist_zip_3;
	STRING30  Watchlist_country_3;
	STRING200 Watchlist_Entity_Name_3;
	STRING60  Watchlist_Table_4;
	STRING120 Watchlist_Program_4;
	STRING10  Watchlist_Record_Number_4;
	STRING20  Watchlist_fname_4;
	STRING20  Watchlist_lname_4;
	STRING65  Watchlist_address_4;
	STRING25  Watchlist_city_4;
	STRING2   Watchlist_state_4;
	STRING5   Watchlist_zip_4;
	STRING30  Watchlist_country_4;
	STRING200 Watchlist_Entity_Name_4;
	STRING60  Watchlist_Table_5;
	STRING120 Watchlist_Program_5;
	STRING10  Watchlist_Record_Number_5;
	STRING20  Watchlist_fname_5;
	STRING20  Watchlist_lname_5;
	STRING65  Watchlist_address_5;
	STRING25  Watchlist_city_5;
	STRING2   Watchlist_state_5;
	STRING5   Watchlist_zip_5;
	STRING30  Watchlist_country_5;
	STRING200 Watchlist_Entity_Name_5;
	STRING60  Watchlist_Table_6;
	STRING120 Watchlist_Program_6;
	STRING10  Watchlist_Record_Number_6;
	STRING20  Watchlist_fname_6;
	STRING20  Watchlist_lname_6;
	STRING65  Watchlist_address_6;
	STRING25  Watchlist_city_6;
	STRING2   Watchlist_state_6;
	STRING5   Watchlist_zip_6;
	STRING30  Watchlist_country_6;
	STRING200 Watchlist_Entity_Name_6;
	STRING60  Watchlist_Table_7;
	STRING120 Watchlist_Program_7;
	STRING10  Watchlist_Record_Number_7;
	STRING20  Watchlist_fname_7;
	STRING20  Watchlist_lname_7;
	STRING65  Watchlist_address_7;
	STRING25  Watchlist_city_7;
	STRING2   Watchlist_state_7;
	STRING5   Watchlist_zip_7;
	STRING30  Watchlist_country_7;
	STRING200 Watchlist_Entity_Name_7;
	string1 passportValidated := '';
	
	// instantid enhancements 3/24/2011
	string1 dobmatchlevel := '';
	string4  hri_7;
	string100 hri_desc_7;
	string4  hri_8;
	string100 hri_desc_8;
	string4  hri_9;
	string100 hri_desc_9;
	string4  hri_10;
	string100 hri_desc_10;
	string4  hri_11;
	string100 hri_desc_11;
	string4  hri_12;
	string100 hri_desc_12;
	string4  hri_13;
	string100 hri_desc_13;
	string4  hri_14;
	string100 hri_desc_14;
	string4  hri_15;
	string100 hri_desc_15;
	string4  hri_16;
	string100 hri_desc_16;
	string4  hri_17;
	string100 hri_desc_17;
	string4  hri_18;
	string100 hri_desc_18;
	string4  hri_19;
	string100 hri_desc_19;
	string4  hri_20;
	string100 hri_desc_20;
	// parsed verified address
	STRING10 VerPrimRange;
	STRING2  VerPreDir;
	STRING28 VerPrimName;
	STRING4  VerAddrSuffix;
	STRING2  VerPostDir;
	STRING10 VerUnitDesignation;
	STRING8  VerSecRange;
	// parsed corrected address
	STRING10 CorrectedPrimRange;
	STRING2  CorrectedPreDir;
	STRING28 CorrectedPrimName;
	STRING4  CorrectedAddrSuffix;
	STRING2  CorrectedPostDir;
	STRING10 CorrectedUnitDesignation;
	STRING8  CorrectedSecRange;
	// parsed phone address
	STRING10 PhonePrimRange;
	STRING2  PhonePreDir;
	STRING28 PhonePrimName;
	STRING4  PhoneAddrSuffix;
	STRING2  PhonePostDir;
	STRING10 PhoneUnitDesignation;
	STRING8  PhoneSecRange;
	// parsed chronology address 1
	STRING10 ChronPrimRange1;
	STRING2  ChronPreDir1;
	STRING28 ChronPrimName1;
	STRING4  ChronAddrSuffix1;
	STRING2  ChronPostDir1;
	STRING10 ChronUnitDesignation1;
	STRING8  ChronSecRange1;
	// parsed chronology address 2
	STRING10 ChronPrimRange2;
	STRING2  ChronPreDir2;
	STRING28 ChronPrimName2;
	STRING4  ChronAddrSuffix2;
	STRING2  ChronPostDir2;
	STRING10 ChronUnitDesignation2;
	STRING8  ChronSecRange2;
	// parsed chronology address 3
	STRING10 ChronPrimRange3;
	STRING2  ChronPreDir3;
	STRING28 ChronPrimName3;
	STRING4  ChronAddrSuffix3;
	STRING2  ChronPostDir3;
	STRING10 ChronUnitDesignation3;
	STRING8  ChronSecRange3;
	// parsed watchlist address 1
	STRING10 WatchlistPrimRange;
	STRING2  WatchlistPreDir;
	STRING28 WatchlistPrimName;
	STRING4  WatchlistAddrSuffix;
	STRING2  WatchlistPostDir;
	STRING10 WatchlistUnitDesignation;
	STRING8  WatchlistSecRange;
	// parsed watchlist address 2
	STRING10 WatchlistPrimRange2;
	STRING2  WatchlistPreDir2;
	STRING28 WatchlistPrimName2;
	STRING4  WatchlistAddrSuffix2;
	STRING2  WatchlistPostDir2;
	STRING10 WatchlistUnitDesignation2;
	STRING8  WatchlistSecRange2;
	// parsed watchlist address 3
	STRING10 WatchlistPrimRange3;
	STRING2  WatchlistPreDir3;
	STRING28 WatchlistPrimName3;
	STRING4  WatchlistAddrSuffix3;
	STRING2  WatchlistPostDir3;
	STRING10 WatchlistUnitDesignation3;
	STRING8  WatchlistSecRange3;
	// parsed watchlist address 4
	STRING10 WatchlistPrimRange4;
	STRING2  WatchlistPreDir4;
	STRING28 WatchlistPrimName4;
	STRING4  WatchlistAddrSuffix4;
	STRING2  WatchlistPostDir4;
	STRING10 WatchlistUnitDesignation4;
	STRING8  WatchlistSecRange4;
	// parsed watchlist address 5
	STRING10 WatchlistPrimRange5;
	STRING2  WatchlistPreDir5;
	STRING28 WatchlistPrimName5;
	STRING4  WatchlistAddrSuffix5;
	STRING2  WatchlistPostDir5;
	STRING10 WatchlistUnitDesignation5;
	STRING8  WatchlistSecRange5;
	// parsed watchlist address 6
	STRING10 WatchlistPrimRange6;
	STRING2  WatchlistPreDir6;
	STRING28 WatchlistPrimName6;
	STRING4  WatchlistAddrSuffix6;
	STRING2  WatchlistPostDir6;
	STRING10 WatchlistUnitDesignation6;
	STRING8  WatchlistSecRange6;
	// parsed watchlist address 7
	STRING10 WatchlistPrimRange7;
	STRING2  WatchlistPreDir7;
	STRING28 WatchlistPrimName7;
	STRING4  WatchlistAddrSuffix7;
	STRING2  WatchlistPostDir7;
	STRING10 WatchlistUnitDesignation7;
	STRING8  WatchlistSecRange7;
	
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
	self.Chron_Zip4_1 := if(count(l.chronology) >= 1, l.chronology[1].zip4, '');									// **** added zip4
	self.Chron_dt_first_seen_1 := if(count(l.chronology) >= 1, (string6)l.chronology[1].dt_first_seen, '');			// **** added chronology dates
	self.Chron_dt_last_seen_1 := if(count(l.chronology) >= 1, (string6)l.chronology[1].dt_last_seen, '');			// **** added chronology dates
	self.chron_phone_1 := if (count(L.chronology) >= 1, L.chronology[1].phone, '');
	self.chron_address_2 := if (count(L.chronology) >= 2, L.chronology[2].address, '');
	self.chron_city_2 := if (count(L.chronology) >= 2, L.chronology[2].city, '');
	self.chron_st_2 := if (count(L.chronology) >= 2, L.chronology[2].st, '');
	self.chron_zip_2 := if (count(L.chronology) >= 2, L.chronology[2].zip, '');
	self.Chron_Zip4_2 := if(count(l.chronology) >= 2, l.chronology[2].zip4, '');									// **** added zip4
	self.Chron_dt_first_seen_2 := if(count(l.chronology) >= 2, (string6)l.chronology[2].dt_first_seen, '');			// **** added chronology dates
	self.Chron_dt_last_seen_2 := if(count(l.chronology) >= 2, (string6)l.chronology[2].dt_last_seen, '');			// **** added chronology dates
	self.chron_phone_2 := if (count(L.chronology) >= 2, L.chronology[2].phone, '');
	self.chron_address_3 := if (count(L.chronology) >= 3, L.chronology[3].address, '');
	self.chron_city_3 := if (count(L.chronology) >= 3, L.chronology[3].city, '');
	self.chron_st_3 := if (count(L.chronology) >= 3, L.chronology[3].st, '');
	self.chron_zip_3 := if (count(L.chronology) >= 3, L.chronology[3].zip, '');
	self.Chron_Zip4_3 := if(count(l.chronology) >= 3, l.chronology[3].zip4, '');									// **** added zip4
	self.Chron_dt_first_seen_3 := if(count(l.chronology) >= 3, (string6)l.chronology[3].dt_first_seen, '');			// **** added chronology dates
	self.Chron_dt_last_seen_3 := if(count(l.chronology) >= 3, (string6)l.chronology[3].dt_last_seen, '');			// **** added chronology dates
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
	
	self.Chron_addr_1_isBest := if(l.chronology[1].isBestMatch, 'Y', 'N');
	self.Chron_addr_2_isBest := if(l.chronology[2].isBestMatch, 'Y', 'N');
	self.Chron_addr_3_isBest := if(l.chronology[3].isBestMatch, 'Y', 'N');
	
	SELF.Watchlist_country := l.watchlists[1].watchlist_contry;
	
	SELF.Watchlist_Table_2 := l.watchlists[2].watchlist_table;
	SELF.Watchlist_program_2 :=l.watchlists[2].watchlist_program;
	SELF.Watchlist_Record_Number_2 := l.watchlists[2].watchlist_Record_Number;
	SELF.Watchlist_fname_2 := l.watchlists[2].watchlist_fname;
	SELF.Watchlist_lname_2 := l.watchlists[2].watchlist_lname;
	SELF.Watchlist_address_2 := l.watchlists[2].watchlist_address;
	SELF.Watchlist_city_2 := l.watchlists[2].watchlist_city;
	SELF.Watchlist_state_2 := l.watchlists[2].watchlist_state;
	SELF.Watchlist_zip_2 := l.watchlists[2].watchlist_zip;
	SELF.Watchlist_country_2 := l.watchlists[2].watchlist_contry;
	SELF.Watchlist_Entity_Name_2 := l.watchlists[2].watchlist_Entity_Name;
	
	SELF.Watchlist_Table_3 := l.watchlists[3].watchlist_table;
	SELF.Watchlist_program_3 :=l.watchlists[3].watchlist_program;
	SELF.Watchlist_Record_Number_3 := l.watchlists[3].watchlist_Record_Number;
	SELF.Watchlist_fname_3 := l.watchlists[3].watchlist_fname;
	SELF.Watchlist_lname_3 := l.watchlists[3].watchlist_lname;
	SELF.Watchlist_address_3 := l.watchlists[3].watchlist_address;
	SELF.Watchlist_city_3 := l.watchlists[3].watchlist_city;
	SELF.Watchlist_state_3 := l.watchlists[3].watchlist_state;
	SELF.Watchlist_zip_3 := l.watchlists[3].watchlist_zip;
	SELF.Watchlist_country_3 := l.watchlists[3].watchlist_contry;
	SELF.Watchlist_Entity_Name_3 := l.watchlists[3].watchlist_Entity_Name;
	
	SELF.Watchlist_Table_4 := l.watchlists[4].watchlist_table;
	SELF.Watchlist_program_4 :=l.watchlists[4].watchlist_program;
	SELF.Watchlist_Record_Number_4 := l.watchlists[4].watchlist_Record_Number;
	SELF.Watchlist_fname_4 := l.watchlists[4].watchlist_fname;
	SELF.Watchlist_lname_4 := l.watchlists[4].watchlist_lname;
	SELF.Watchlist_address_4 := l.watchlists[4].watchlist_address;
	SELF.Watchlist_city_4 := l.watchlists[4].watchlist_city;
	SELF.Watchlist_state_4 := l.watchlists[4].watchlist_state;
	SELF.Watchlist_zip_4 := l.watchlists[4].watchlist_zip;
	SELF.Watchlist_country_4 := l.watchlists[4].watchlist_contry;
	SELF.Watchlist_Entity_Name_4 := l.watchlists[4].watchlist_Entity_Name;
	
	SELF.Watchlist_Table_5 := l.watchlists[5].watchlist_table;
	SELF.Watchlist_program_5 :=l.watchlists[5].watchlist_program;
	SELF.Watchlist_Record_Number_5 := l.watchlists[5].watchlist_Record_Number;
	SELF.Watchlist_fname_5 := l.watchlists[5].watchlist_fname;
	SELF.Watchlist_lname_5 := l.watchlists[5].watchlist_lname;
	SELF.Watchlist_address_5 := l.watchlists[5].watchlist_address;
	SELF.Watchlist_city_5 := l.watchlists[5].watchlist_city;
	SELF.Watchlist_state_5 := l.watchlists[5].watchlist_state;
	SELF.Watchlist_zip_5 := l.watchlists[5].watchlist_zip;
	SELF.Watchlist_country_5 := l.watchlists[5].watchlist_contry;
	SELF.Watchlist_Entity_Name_5 := l.watchlists[5].watchlist_Entity_Name;
	
	SELF.Watchlist_Table_6 := l.watchlists[6].watchlist_table;
	SELF.Watchlist_program_6 :=l.watchlists[6].watchlist_program;
	SELF.Watchlist_Record_Number_6 := l.watchlists[6].watchlist_Record_Number;
	SELF.Watchlist_fname_6 := l.watchlists[6].watchlist_fname;
	SELF.Watchlist_lname_6 := l.watchlists[6].watchlist_lname;
	SELF.Watchlist_address_6 := l.watchlists[6].watchlist_address;
	SELF.Watchlist_city_6 := l.watchlists[6].watchlist_city;
	SELF.Watchlist_state_6 := l.watchlists[6].watchlist_state;
	SELF.Watchlist_zip_6 := l.watchlists[6].watchlist_zip;
	SELF.Watchlist_country_6 := l.watchlists[6].watchlist_contry;
	SELF.Watchlist_Entity_Name_6 := l.watchlists[6].watchlist_Entity_Name;
	
	SELF.Watchlist_Table_7 := l.watchlists[7].watchlist_table;
	SELF.Watchlist_program_7 :=l.watchlists[7].watchlist_program;
	SELF.Watchlist_Record_Number_7 := l.watchlists[7].watchlist_Record_Number;
	SELF.Watchlist_fname_7 := l.watchlists[7].watchlist_fname;
	SELF.Watchlist_lname_7 := l.watchlists[7].watchlist_lname;
	SELF.Watchlist_address_7 := l.watchlists[7].watchlist_address;
	SELF.Watchlist_city_7 := l.watchlists[7].watchlist_city;
	SELF.Watchlist_state_7 := l.watchlists[7].watchlist_state;
	SELF.Watchlist_zip_7 := l.watchlists[7].watchlist_zip;
	SELF.Watchlist_country_7 := l.watchlists[7].watchlist_contry;
	SELF.Watchlist_Entity_Name_7 := l.watchlists[7].watchlist_Entity_Name;
	
	// instantid enhancements 3/24/2011
	SELF.hri_7 := if (count(l.ri) >= 7, L.ri[7].hri, '');
	SELF.hri_desc_7 := if (count(l.ri) >= 7, L.ri[7].desc, '');
	SELF.hri_8 := if (count(l.ri) >= 8, L.ri[8].hri, '');
	SELF.hri_desc_8 := if (count(l.ri) >= 8, L.ri[8].desc, '');
	SELF.hri_9 := if (count(l.ri) >= 9, L.ri[9].hri, '');
	SELF.hri_desc_9 := if (count(l.ri) >= 9, L.ri[9].desc, '');
	SELF.hri_10 := if (count(l.ri) >= 10, L.ri[10].hri, '');
	SELF.hri_desc_10 := if (count(l.ri) >= 10, L.ri[10].desc, '');
	SELF.hri_11 := if (count(l.ri) >= 11, L.ri[11].hri, '');
	SELF.hri_desc_11 := if (count(l.ri) >= 11, L.ri[11].desc, '');
	SELF.hri_12 := if (count(l.ri) >= 12, L.ri[12].hri, '');
	SELF.hri_desc_12 := if (count(l.ri) >= 12, L.ri[12].desc, '');
	SELF.hri_13 := if (count(l.ri) >= 13, L.ri[13].hri, '');
	SELF.hri_desc_13 := if (count(l.ri) >= 13, L.ri[13].desc, '');
	SELF.hri_14 := if (count(l.ri) >= 14, L.ri[14].hri, '');
	SELF.hri_desc_14 := if (count(l.ri) >= 14, L.ri[14].desc, '');
	SELF.hri_15 := if (count(l.ri) >= 15, L.ri[15].hri, '');
	SELF.hri_desc_15 := if (count(l.ri) >= 15, L.ri[15].desc, '');
	SELF.hri_16 := if (count(l.ri) >= 16, L.ri[16].hri, '');
	SELF.hri_desc_16 := if (count(l.ri) >= 16, L.ri[16].desc, '');
	SELF.hri_17 := if (count(l.ri) >= 17, L.ri[17].hri, '');
	SELF.hri_desc_17 := if (count(l.ri) >= 17, L.ri[17].desc, '');
	SELF.hri_18 := if (count(l.ri) >= 18, L.ri[18].hri, '');
	SELF.hri_desc_18 := if (count(l.ri) >= 18, L.ri[18].desc, '');
	SELF.hri_19 := if (count(l.ri) >= 19, L.ri[19].hri, '');
	SELF.hri_desc_19 := if (count(l.ri) >= 19, L.ri[19].desc, '');
	SELF.hri_20 := if (count(l.ri) >= 20, L.ri[20].hri, '');
	SELF.hri_desc_20 := if (count(l.ri) >= 20, L.ri[20].desc, '');
	// parsed chronology address 1
	SELF.ChronPrimRange1 := if (count(L.chronology) >= 1, L.chronology[1].primrange, '');
	SELF.ChronPreDir1 := if (count(L.chronology) >= 1, L.chronology[1].predir, '');
	SELF.ChronPrimName1 := if (count(L.chronology) >= 1, L.chronology[1].primname, '');
	SELF.ChronAddrSuffix1 := if (count(L.chronology) >= 1, L.chronology[1].addrsuffix, '');
	SELF.ChronPostDir1 := if (count(L.chronology) >= 1, L.chronology[1].postdir, '');
	SELF.ChronUnitDesignation1 := if (count(L.chronology) >= 1, L.chronology[1].unitdesignation, '');
	SELF.ChronSecRange1 := if (count(L.chronology) >= 1, L.chronology[1].secrange, '');
	// parsed chronology address 2
	SELF.ChronPrimRange2 := if (count(L.chronology) >= 2, L.chronology[2].primrange, '');
	SELF.ChronPreDir2 := if (count(L.chronology) >= 2, L.chronology[2].predir, '');
	SELF.ChronPrimName2 := if (count(L.chronology) >= 2, L.chronology[2].primname, '');
	SELF.ChronAddrSuffix2 := if (count(L.chronology) >= 2, L.chronology[2].addrsuffix, '');
	SELF.ChronPostDir2 := if (count(L.chronology) >= 2, L.chronology[2].postdir, '');
	SELF.ChronUnitDesignation2 := if (count(L.chronology) >= 2, L.chronology[2].unitdesignation, '');
	SELF.ChronSecRange2 := if (count(L.chronology) >= 2, L.chronology[2].secrange, '');
	// parsed chronology address 3
	SELF.ChronPrimRange3 := if (count(L.chronology) >= 3, L.chronology[3].primrange, '');
	SELF.ChronPreDir3 := if (count(L.chronology) >= 3, L.chronology[3].predir, '');
	SELF.ChronPrimName3 := if (count(L.chronology) >= 3, L.chronology[3].primname, '');
	SELF.ChronAddrSuffix3 := if (count(L.chronology) >= 3, L.chronology[3].addrsuffix, '');
	SELF.ChronPostDir3 := if (count(L.chronology) >= 3, L.chronology[3].postdir, '');
	SELF.ChronUnitDesignation3 := if (count(L.chronology) >= 3, L.chronology[3].unitdesignation, '');
	SELF.ChronSecRange3 := if (count(L.chronology) >= 3, L.chronology[3].secrange, '');
	// parsed watchlist address 2
	SELF.WatchlistPrimRange2 := l.watchlists[2].Watchlistprimrange;
	SELF.WatchlistPreDir2 := l.watchlists[2].Watchlistpredir;
	SELF.WatchlistPrimName2 := l.watchlists[2].Watchlistprimname;
	SELF.WatchlistAddrSuffix2 := l.watchlists[2].Watchlistaddrsuffix;
	SELF.WatchlistPostDir2 := l.watchlists[2].Watchlistpostdir;
	SELF.WatchlistUnitDesignation2 := l.watchlists[2].Watchlistunitdesignation;
	SELF.WatchlistSecRange2 := l.watchlists[2].Watchlistsecrange;
	// parsed watchlist address 3
	SELF.WatchlistPrimRange3 := l.watchlists[3].Watchlistprimrange;
	SELF.WatchlistPreDir3 := l.watchlists[3].Watchlistpredir;
	SELF.WatchlistPrimName3 := l.watchlists[3].Watchlistprimname;
	SELF.WatchlistAddrSuffix3 := l.watchlists[3].Watchlistaddrsuffix;
	SELF.WatchlistPostDir3 := l.watchlists[3].Watchlistpostdir;
	SELF.WatchlistUnitDesignation3 := l.watchlists[3].Watchlistunitdesignation;
	SELF.WatchlistSecRange3 := l.watchlists[3].Watchlistsecrange;
	// parsed watchlist address 4
	SELF.WatchlistPrimRange4 := l.watchlists[4].Watchlistprimrange;
	SELF.WatchlistPreDir4 := l.watchlists[4].Watchlistpredir;
	SELF.WatchlistPrimName4 := l.watchlists[4].Watchlistprimname;
	SELF.WatchlistAddrSuffix4 := l.watchlists[4].Watchlistaddrsuffix;
	SELF.WatchlistPostDir4 := l.watchlists[4].Watchlistpostdir;
	SELF.WatchlistUnitDesignation4 := l.watchlists[4].Watchlistunitdesignation;
	SELF.WatchlistSecRange4 := l.watchlists[2].Watchlistsecrange;
	// parsed watchlist address 5
	SELF.WatchlistPrimRange5 := l.watchlists[5].Watchlistprimrange;
	SELF.WatchlistPreDir5 := l.watchlists[5].Watchlistpredir;
	SELF.WatchlistPrimName5 := l.watchlists[5].Watchlistprimname;
	SELF.WatchlistAddrSuffix5 := l.watchlists[5].Watchlistaddrsuffix;
	SELF.WatchlistPostDir5 := l.watchlists[5].Watchlistpostdir;
	SELF.WatchlistUnitDesignation5 := l.watchlists[5].Watchlistunitdesignation;
	SELF.WatchlistSecRange5 := l.watchlists[5].Watchlistsecrange;
	// parsed watchlist address 6
	SELF.WatchlistPrimRange6 := l.watchlists[6].Watchlistprimrange;
	SELF.WatchlistPreDir6 := l.watchlists[6].Watchlistpredir;
	SELF.WatchlistPrimName6 := l.watchlists[6].Watchlistprimname;
	SELF.WatchlistAddrSuffix6 := l.watchlists[6].Watchlistaddrsuffix;
	SELF.WatchlistPostDir6 := l.watchlists[6].Watchlistpostdir;
	SELF.WatchlistUnitDesignation6 := l.watchlists[6].Watchlistunitdesignation;
	SELF.WatchlistSecRange6 := l.watchlists[6].Watchlistsecrange;
	// parsed watchlist address 7
	SELF.WatchlistPrimRange7 := l.watchlists[7].Watchlistprimrange;
	SELF.WatchlistPreDir7 := l.watchlists[7].Watchlistpredir;
	SELF.WatchlistPrimName7 := l.watchlists[7].Watchlistprimname;
	SELF.WatchlistAddrSuffix7 := l.watchlists[7].Watchlistaddrsuffix;
	SELF.WatchlistPostDir7 := l.watchlists[7].Watchlistpostdir;
	SELF.WatchlistUnitDesignation7 := l.watchlists[7].Watchlistunitdesignation;
	SELF.WatchlistSecRange7 := l.watchlists[7].Watchlistsecrange;
	
	self := L;

end;

j_f := JOIN(resu,p_f,LEFT.acctno=RIGHT.accountnumber,normit(LEFT,RIGHT));

output(j_f);
output(j_f,,'~scoringqa::out::exphone_testafter_ciid_out',CSV(heading(single), quote('"')), overwrite);
output(j_f(errorcode<>''),,'~scoringqa::out::exphone_testafter_error',CSV(QUOTE('"')), overwrite);