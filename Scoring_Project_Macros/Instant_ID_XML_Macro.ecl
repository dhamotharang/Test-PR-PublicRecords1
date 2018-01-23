 // #workunit('name','Consumer IID Process');
// #option ('hthorMemoryLimit', 1000);

EXPORT Instant_ID_XML_Macro (roxie_ip,Gateway_dummy, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro

import ut, Risk_Indicators, riskwise, models;

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String roxieIP := roxie_ip ; 
// gateways := Gateway;
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;


// gateways := Gateway;
Gateway := DATASET([], Gateway.Layouts.Config);

include_internal_extras:=true;

//*********custom settings**********

DPPA:=Scoring_Project_PIP.User_Settings_Module.IID_Scores_V0_XML_Generic_settings.DPPA;
GLB:=Scoring_Project_PIP.User_Settings_Module.IID_Scores_V0_XML_Generic_settings.GLB;
DRM:=Scoring_Project_PIP.User_Settings_Module.IID_Scores_V0_XML_Generic_settings.DRM;

	HistoryDate := 999999;

  // unsigned1	DPPAPurpose:= 3;//CHANGED FROM '' TO 3 
  // unsigned1	GLBPurpose:= 1;//CHANGED FROM '' TO 1
	// STRING DataRestrictionMask := '';
	// UNSIGNED1 BSversion := 41;
	// boolean isFCRA := false;

//**********************************

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
	integer historydateyyyymm;
END;

//==================  input file layout  ========================
layout_input := RECORD
    Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
END;

f1 := IF(no_of_records = 0, dataset( Infile_name, layout_input, thor), choosen(dataset (Infile_name, layout_input, thor), no_of_records));

f := distribute(f1, hash64(AccountNumber));

Layout_Attributes_In := RECORD
	string name;
END;

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
	SELF.old_account_number := (string)le.AccountNumber;
	SELF.Accountnumber := (STRING)le.AccountNumber;	
	SELF.DPPAPurpose := DPPA;
	SELF.GLBPurpose := GLB;
	
	self.DataRestrictionMask := DRM;	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																								// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data

	self.PoBoxCompliance := false;
	self.IncludeMSoverride := false;
	self.IncludeCLoverride := false;
	self.usedobfilter := false;
  self.DOBradius := 2;

	self.OfacOnly := false;
	self.OFACversion := 2;
	self.IncludeOfac := true;
	self.IncludeAdditionalWatchLists := false;
	self.GlobalWatchlistThreshold := 0.84;
	
	self.IncludeDLVerification := false;
	self.PassportUpperLine := '';
	self.PassportLowerLine := '';
	self.Gender := '';
	
self.HistoryDateYYYYMM := HistoryDate;

	self.ExactFirstNameMatch := false;
	self.ExactFirstNameMatchAllowNicknames := false;
	self.ExactLastNameMatch := false;
	self.ExactPhoneMatch := false;
	self.ExactSSNMatch := false;

	self.IncludeAllRiskIndicators := false;
	
	// possible input options 'FuzzyCCYYMMDD','FuzzyCCYYMM''ExactCCYYMMDD''ExactCCYYMM''RadiusCCYY', if using the radius, then 0-3 is the range
	// self.DOBMatchOptions := dataset([{'RadiusCCYY','3'}], risk_indicators.layouts.Layout_DOB_Match_Options);

	SELF := le;
	self := [];
end;

p_f := project(f, t_f(left, counter));
//output(p_f, named('CIID_Input'));

dist_dataset := PROJECT(p_f,TRANSFORM(layout_soap,SELF := LEFT));


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
				DATASET(xlayout), RETRY(3), TIMEOUT(120),
				PARALLEL(threads), onFail(myFail(LEFT)));
				

//GLOBAL OUTPUT LAYOUT
Global_output_lay:= RECORD	 
Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_InstantId_Global_Layout;			 
END;
Global_output_lay normit(resu L, p_f R) := transform
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
	self.did := (integer)intformat(L.did,12,1);
	self.transaction_id := (integer)intformat(L.transaction_id, 12, 1);
	self.nas_summary := L.nas_summary;
	self.nap_summary := L.nap_summary;
	self.CVI := L.cvi;
	self.additional_score1 :=L.additional_score1;
	self.additional_score2 := L.additional_score2;
	self.seq := (integer)intformat(L.seq,12,1);
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
  self := [];
end;



j_f := JOIN(resu,p_f,LEFT.acctno=RIGHT.accountnumber,normit(LEFT,RIGHT));


      
      // final_layout := record
      // recordof(j_f);
      	// #if(include_internal_extras)
      		// RiskProcessing.layout_internal_extras;
      	// #end	
      // end;	
      
      
      Global_output_lay xform1(j_f l, dist_dataset r) := TRANSFORM
      	#if(include_internal_extras)
      		self.DID := l.did; 
      		self.historydate := (string)r.HistoryDateYYYYMM;
      		self.FNamePop := r.firstname<>'';
      		self.LNamePop := r.lastname<>'';
      		self.AddrPop := r.streetaddress<>'';
      		self.SSNLength := (string)(length(trim(r.ssn,left,right))) ;
      		self.DOBPop := r.dateofbirth<>'';
      		self.EmailPop := r.email<>'';
      		self.IPAddrPop := r.ipaddress<>'';
      		self.HPhnPop := r.homephone<>'';
      	#end;
      	self := l;
      	self := [];
      	
      	end;
      	
      	final_output:=join(j_f,dist_dataset,left.acctno=(string)right.accountnumber ,xform1(left, right));	

//output(j_f);
//output(j_f,,'~tfuerstenberg::out::acc_750_ciid_out',CSV(heading(single), quote('"')), overwrite);
//output(j_f(errorcode<>''),,'~tfuerstenberg::out::acc750_ciid_error',CSV(QUOTE('"')), overwrite);

// OUTPUT(CHOOSEN(final, eyeball), NAMED('Final_Results'));
op_final := output(final_output,, outfile_name, thor,compressed, OVERWRITE);

return op_final;

endmacro;