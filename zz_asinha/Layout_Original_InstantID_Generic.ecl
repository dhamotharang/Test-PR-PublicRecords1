Export Layout_Original_InstantID_Generic := module

import models, Risk_Indicators, Business_Risk, ut, riskwise, riskview, RiskProcessing, iESP, Address_Shell, Business_Risk_BIP;

r	:= risk_indicators.Layout_Desc;

 Layout_InstandID_NuGen := 
RECORD, MAXLENGTH(24100)
	STRING30 AcctNo;
// new field:
	unsigned6 did;
// field 1: all input
	Risk_Indicators.Layout_Input - did - score - historydate - historydatetimestamp;
// field 2: transaction id assigned by us
	unsigned6 transaction_id;
// field 3-8: consumer id verification
	STRING20 verfirst;
	STRING20 verlast;
	STRING65 veraddr;
	// parsed verified address
	STRING10 VerPrimRange;
	STRING2  VerPreDir;
	STRING28 VerPrimName;
	STRING4  VerAddrSuffix;
	STRING2  VerPostDir;
	STRING10 VerUnitDesignation;
	STRING8  VerSecRange;
	STRING25 vercity;
	STRING2 verstate;
	STRING5 verzip;
	STRING20 vercounty;
	STRING4 verzip4;
	STRING12 verDPBC;
	STRING9 verssn;
	STRING8 verdob;
	STRING10 verhphone;

	STRING1 verify_addr;
	STRING1 verify_dob;
	STRING1 valid_ssn;
// field 9
	INTEGER1 NAS_Summary;
// field 10
	INTEGER1 NAP_Summary;
	STRING1 NAP_Type;
	STRING1 NAP_Status;
// field 11
	string3 CVI; 
	INTEGER1 additional_score1;
	INTEGER1 additional_score2;
// field 14-19: risk indicators
	DATASET(Risk_Indicators.layouts.layout_desc_plus_seq) ri {MAXCOUNT(iesp.Constants.FI.MaxCVIRiskIndicators)};												
// field 19-22: potential follow-up actions
	DATASET(r) fua {maxcount(4)};
// field 23-27
	STRING20 corrected_lname;
	STRING8 corrected_dob;
	STRING10 corrected_phone;
	STRING9 corrected_ssn;
	STRING65 corrected_address;
	// parsed verified address
	STRING10 CorrectedPrimRange;
	STRING2  CorrectedPreDir;
	STRING28 CorrectedPrimName;
	STRING4  CorrectedAddrSuffix;
	STRING2  CorrectedPostDir;
	STRING10 CorrectedUnitDesignation;
	STRING8  CorrectedSecRange;
// field 27-28: area code split
	STRING3 area_code_split;			
	STRING8 area_code_split_date;
// field 29-33: phone lookup info
	STRING20 phone_fname;					
	STRING20 phone_lname;
	STRING65 phone_address;
	// parsed phone address
	STRING10 PhonePrimRange;
	STRING2  PhonePreDir;
	STRING28 PhonePrimName;
	STRING4  PhoneAddrSuffix;
	STRING2  PhonePostDir;
	STRING10 PhoneUnitDesignation;
	STRING8  PhoneSecRange;
	STRING25 phone_city;
	STRING2 phone_st;
	STRING5 phone_zip;
// field 34: tele from a name-address
	STRING10 name_addr_phone;			
// field 35-37: ssn issuance info
	STRING8 ssa_date_first;
	STRING8 ssa_date_last;
	STRING2 ssa_state;
	STRING20 ssa_state_name;
// field 38-54: chronological address history
	// 38-44: current info
	STRING20 current_fname;
	STRING20 current_lname;
	DATASET(Risk_Indicators.Layout_AddressHistory) Chronology {maxcount(3)};
// field 55-60: additional last names
	DATASET(Risk_Indicators.Layout_LastNames) Additional_Lname  {maxcount(3)};
// field 61-59 watchlists
	STRING60 Watchlist_Table;
	STRING120 Watchlist_Program;
	STRING10 Watchlist_Record_Number;
	STRING20 Watchlist_fname;
	STRING20 Watchlist_lname;
	STRING65 Watchlist_address;
	// parsed watchlist address
	STRING10 WatchlistPrimRange;
	STRING2  WatchlistPreDir;
	STRING28 WatchlistPrimName;
	STRING4  WatchlistAddrSuffix;
	STRING2  WatchlistPostDir;
	STRING10 WatchlistUnitDesignation;
	STRING8  WatchlistSecRange;
	STRING25 Watchlist_city;
	STRING2 Watchlist_state;
	STRING5 Watchlist_zip;
	STRING30 Watchlist_contry;
	STRING200 Watchlist_Entity_Name;
	DATASET(Models.layouts.Layout_Model_IID) models {maxcount(3)};
	riskwise.layouts.red_flags_online_layout Red_Flags;
	UNSIGNED1 RecordCount;
	
	string3 SubjectSSNCount := '';
	string20 verDL := '';
	string8 deceasedDate := '';
	string8 deceasedDOB := '';
	string15 deceasedFirst := '';
	string20 deceasedLast := '';
	dataset(Risk_Indicators.layouts.layout_watchlists_plus_seq) watchlists {maxcount(7)};	
	string1 passportValidated := '';
	string44 PassportUpperLine := '' ;
	string44 PassportLowerLine := '' ;
	string6 Gender;
	string1 dobmatchlevel := '';	
	
	unsigned8 iid_flags := 0;

	BOOLEAN addressPOBox := false;	// previously in nugen_plus layout because it was only for flexid, now used in CIID as well
	BOOLEAN addressCMRA := false;		// previously in nugen_plus layout because it was only for flexid, now used in CIID as well
	
	BOOLEAN SSNFoundForLexID := false;
	STRING3 cviCustomScore := '';
	STRING1 InstantIDVersion := '';
	
	STRING128 cviCustomScore_name := '';
  DATASET(Risk_Indicators.layouts.layout_desc_plus_seq) cviCustomScore_ri {MAXCOUNT(iesp.Constants.FI.MaxCVIRiskIndicators)};                                                                                                                                                                                     
  DATASET(r) cviCustomScore_fua {maxcount(4)};

END;
	
EXPORT NONFCRA_InstantId_Global_Layout := record
	
	Layout_InstandID_NuGen - ri - fua -Chronology - Additional_Lname - Red_Flags -watchlists ;
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
			STRING200 Watchlist_country;
		
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
			// new fields added for the R1 2010 enhancement
		 	string1  Chron_addr_1_isBest;
   	string1  Chron_addr_2_isBest;
   	string1  Chron_addr_3_isBest;
		
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
	  	// instantid enhancements 3/24/2011	
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
   	// STRING10 WatchlistPrimRange;
   	// STRING2  WatchlistPreDir;
   	// STRING28 WatchlistPrimName;
   	// STRING4  WatchlistAddrSuffix;
   	// STRING2  WatchlistPostDir;
   	// STRING10 WatchlistUnitDesignation;
   	// STRING8  WatchlistSecRange;
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
	 RiskProcessing.layout_internal_extras;
	 
	 end;

End;
