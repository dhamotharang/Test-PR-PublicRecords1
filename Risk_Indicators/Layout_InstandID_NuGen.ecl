/*2016-05-21T00:42:10Z (Kevin Huls)
Automated reinstate from 2016-05-19T17:50:17Z
*/
import models, riskwise, iesp;

r	:= risk_indicators.Layout_Desc;

export Layout_InstandID_NuGen := 
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
	DATASET(layouts.layout_desc_plus_seq) ri {MAXCOUNT(iesp.Constants.FI.MaxCVIRiskIndicators)};												
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
	DATASET(Layout_AddressHistory) Chronology {maxcount(3)};
// field 55-60: additional last names
	DATASET(Layout_LastNames) Additional_Lname  {maxcount(3)};
// field 61-59 watchlists
	STRING60 Watchlist_Table;
	STRING120 Watchlist_Program;
	STRING10 Watchlist_Record_Number;
	UNICODE20 Watchlist_fname;
	UNICODE20 Watchlist_lname;
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
	UNICODE200 Watchlist_Entity_Name;
	DATASET(Models.layouts.Layout_Model_IID) models {maxcount(3)};
	riskwise.layouts.red_flags_online_layout Red_Flags;
	UNSIGNED1 RecordCount;
	
	string3 SubjectSSNCount := '';
	string20 verDL := '';
	string8 deceasedDate := '';
	string8 deceasedDOB := '';
	string15 deceasedFirst := '';
	string20 deceasedLast := '';
	dataset(layouts.layout_watchlists_plus_seq) watchlists {maxcount(7)};	
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
  DATASET(layouts.layout_desc_plus_seq) cviCustomScore_ri {MAXCOUNT(iesp.Constants.FI.MaxCVIRiskIndicators)};                                                                                                                                                                                     
  DATASET(r) cviCustomScore_fua {maxcount(4)};

	//new for Emerging Identities
	BOOLEAN  EmergingID;
	STRING1  AddressSecondaryRangeMismatch;
	BOOLEAN  StandardizedAddress;
	STRING65 StreetAddress1;	//cleaned address 1
	STRING65 StreetAddress2;  //cleaned address 2
	STRING20 CountyName;	
	
			unsigned2	royalty_type_code_targus;
		string20 		royalty_type_targus; 			
   	unsigned2 	royalty_count_targus; 			 
   	unsigned2 	non_royalty_count_targus;  
		string20 		count_entity_targus := ''; 
		
		unsigned2	royalty_type_code_insurance; 	
		string20 		royalty_type_insurance; 			
   	unsigned2 	royalty_count_insurance; 			
   	unsigned2 	non_royalty_count_insurance;  
		string20 		count_entity_insurance := ''; 

END;