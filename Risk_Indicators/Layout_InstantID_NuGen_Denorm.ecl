/*2016-05-21T00:42:41Z (Kevin Huls)
Automated reinstate from 2016-05-19T17:50:17Z
*/
import riskwise;

export Layout_InstantID_NuGen_Denorm := 
RECORD
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
	STRING45 ip_address := '';

	STRING10  phone10;
	STRING10  wphone10;
	STRING100 employer_name := '';
	STRING20  lname_prev := '';
// field 2: transaction id assigned by us
	string12 transaction_id;
// field 3-8: consumer id verification
	STRING20 verfirst;
	STRING20 verlast;
	STRING65 veraddr;
	STRING25 vercity;
	STRING2  verstate;
	STRING5  verzip;
	string4	 verzip4;
	string12 verDPBC;
	
	STRING9  verssn;
	STRING8  verdob;
	STRING10 verhphone;

	STRING1  verify_addr;
	STRING1  verify_dob;
	STRING1  valid_ssn;
// field 9
	string3 NAS_Summary;
// field 10
	string3 NAP_Summary;
	STRING1  NAP_Type;
	STRING1  NAP_Status;
// field 11
	string3 CVI;
	string3 additional_score1;
	string3 additional_score2;
// field 14-19: risk indicators
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
// field 19-22: potential follow-up actions
	string4  fua_1;
	string150 fua_desc_1;
	string4  fua_2;
	string150 fua_desc_2;
	string4  fua_3;
	string150 fua_desc_3;
	string4  fua_4;
	string150 fua_desc_4;
// field 23-27
	STRING20 corrected_lname;
	STRING8  corrected_dob;
	STRING10 corrected_phone;
	STRING9  corrected_ssn;
	STRING65 corrected_address;
// field 27-28: area code split
	STRING3  area_code_split;			
	STRING8  area_code_split_date;
// field 29-33: phone lookup info
	STRING20 phone_fname;					
	STRING20 phone_lname;
	STRING65 phone_address;
	STRING25 phone_city;
	STRING2  phone_st;
	STRING5  phone_zip;
// field 34: tele from a name-address
	STRING10 name_addr_phone;			
// field 35-37: ssn issuance info
	STRING6  ssa_date_first;
	STRING6  ssa_date_last;
	STRING2  ssa_state;
	STRING20 ssa_state_name;
// field 38-54: chronological address history
	// 38-44: current info
	STRING20  current_fname;
	STRING20  current_lname;
	STRING65  Chron_Address_1;
	STRING25  Chron_City_1;
	STRING2   Chron_St_1;
	STRING5   Chron_Zip_1;
	STRING4		Chron_Zip4_1;
	STRING12		Chron_dpbc_1;
	STRING50  Chron_phone_1;
	string6  Chron_dt_first_seen_1;
	string6  Chron_dt_last_seen_1;
	
	STRING65  Chron_Address_2;
	STRING25  Chron_City_2;
	STRING2   Chron_St_2;
	STRING5   Chron_Zip_2;
	STRING4		Chron_Zip4_2;
	STRING12		Chron_dpbc_2;
	STRING50  Chron_phone_2;
	string6  Chron_dt_first_seen_2;
	string6  Chron_dt_last_seen_2;
	STRING65  Chron_Address_3;
	STRING25  Chron_City_3;
	STRING2   Chron_St_3;
	STRING5   Chron_Zip_3;
	STRING4		Chron_Zip4_3;
	STRING12		Chron_dpbc_3;
	STRING50  Chron_phone_3;
	string6  Chron_dt_first_seen_3;
	string6  Chron_dt_last_seen_3;
	
// field 55-60: additional last names
	string20	additional_fname_1;
	string20	additional_lname_1;
	string8	additional_lname_date_last_1;
	string20	additional_fname_2;
	string20	additional_lname_2;
	string8	additional_lname_date_last_2;
	string20	additional_fname_3;
	string20	additional_lname_3;
	string8	additional_lname_date_last_3;
// field 61-59 watchlists
	STRING60  Watchlist_Table;
	STRING120 Watchlist_Program;
	STRING10  Watchlist_Record_Number;
	UNICODE20  Watchlist_fname;
	UNICODE20  Watchlist_lname;
	STRING65  Watchlist_address;
	STRING25  Watchlist_city;
	STRING2   Watchlist_state;
	STRING5   Watchlist_zip;
	STRING30  Watchlist_contry;
	UNICODE200 Watchlist_Entity_Name;
	string3 fd_score1;
	string3 fd_score2;
	string3 fd_score3;
	string4	fd_Reason1;
	string100	fd_Desc1;
	string4	fd_Reason2;
	string100	fd_Desc2;
	string4	fd_Reason3;
	string100	fd_Desc3;
	string4	fd_Reason4;
	string100	fd_Desc4;
	riskwise.layouts.red_flags_batch_layout;
	
	string20 vercounty;
	
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
	UNICODE20  Watchlist_fname_2;
	UNICODE20  Watchlist_lname_2;
	STRING65  Watchlist_address_2;
	STRING25  Watchlist_city_2;
	STRING2   Watchlist_state_2;
	STRING5   Watchlist_zip_2;
	STRING30  Watchlist_contry_2;
	UNICODE200 Watchlist_Entity_Name_2;
	STRING60  Watchlist_Table_3;
	STRING120 Watchlist_Program_3;
	STRING10  Watchlist_Record_Number_3;
	UNICODE20  Watchlist_fname_3;
	UNICODE20  Watchlist_lname_3;
	STRING65  Watchlist_address_3;
	STRING25  Watchlist_city_3;
	STRING2   Watchlist_state_3;
	STRING5   Watchlist_zip_3;
	STRING30  Watchlist_contry_3;
	UNICODE200 Watchlist_Entity_Name_3;
	STRING60  Watchlist_Table_4;
	STRING120 Watchlist_Program_4;
	STRING10  Watchlist_Record_Number_4;
	UNICODE20  Watchlist_fname_4;
	UNICODE20  Watchlist_lname_4;
	STRING65  Watchlist_address_4;
	STRING25  Watchlist_city_4;
	STRING2   Watchlist_state_4;
	STRING5   Watchlist_zip_4;
	STRING30  Watchlist_contry_4;
	UNICODE200 Watchlist_Entity_Name_4;
	STRING60  Watchlist_Table_5;
	STRING120 Watchlist_Program_5;
	STRING10  Watchlist_Record_Number_5;
	UNICODE20  Watchlist_fname_5;
	UNICODE20  Watchlist_lname_5;
	STRING65  Watchlist_address_5;
	STRING25  Watchlist_city_5;
	STRING2   Watchlist_state_5;
	STRING5   Watchlist_zip_5;
	STRING30  Watchlist_contry_5;
	UNICODE200 Watchlist_Entity_Name_5;
	STRING60  Watchlist_Table_6;
	STRING120 Watchlist_Program_6;
	STRING10  Watchlist_Record_Number_6;
	UNICODE20  Watchlist_fname_6;
	UNICODE20  Watchlist_lname_6;
	STRING65  Watchlist_address_6;
	STRING25  Watchlist_city_6;
	STRING2   Watchlist_state_6;
	STRING5   Watchlist_zip_6;
	STRING30  Watchlist_contry_6;
	UNICODE200 Watchlist_Entity_Name_6;
	STRING60  Watchlist_Table_7;
	STRING120 Watchlist_Program_7;
	STRING10  Watchlist_Record_Number_7;
	UNICODE20  Watchlist_fname_7;
	UNICODE20  Watchlist_lname_7;
	STRING65  Watchlist_address_7;
	STRING25  Watchlist_city_7;
	STRING2   Watchlist_state_7;
	STRING5   Watchlist_zip_7;
	STRING30  Watchlist_contry_7;
	UNICODE200 Watchlist_Entity_Name_7;
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
	
	// fraudpoint 2.0 release
	STRING1 StolenIdentityIndex := '';
	STRING1 SyntheticIdentityIndex := '';
	STRING1 ManipulatedIdentityIndex := '';
	STRING1 VulnerableVictimIndex := '';
	STRING1 FriendlyFraudIndex := '';
	STRING1 SuspiciousActivityIndex := '';
	
	STRING4	fd_Reason5;
	STRING100	fd_Desc5;
	STRING4	fd_Reason6;
	STRING100	fd_Desc6;
	
	BOOLEAN SSNFoundForLexID := FALSE;
	BOOLEAN addressPOBox := FALSE;
	BOOLEAN addressCMRA := FALSE;
	
	STRING3 cviCustomScore := '';
	STRING1 InstantIDVersion := '';
	
	//new for Emerging Identities
	BOOLEAN  EmergingID;
	STRING1  AddressSecondaryRangeMismatch;
	BOOLEAN  StandardizedAddress;
	STRING65 StreetAddress1;	//cleaned address 1
	STRING65 StreetAddress2;  //cleaned address 2
	STRING20 CountyName;
	
	
END;