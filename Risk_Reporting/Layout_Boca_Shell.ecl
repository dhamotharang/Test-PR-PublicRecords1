/* ********************************************************
***********************************************************
** This is a snapshot of the Boca Shell as of 8/25/2012  **
** -- Contains up to Shell 4.1                           **
** -- Modify this layout when new fields need to be      **
**    logged for tracking reports and the customer       **
**    support query.                                     **
***********************************************************
********************************************************* */

import RiskWise, Risk_Indicators;

Layout_Address_Validation :=
RECORD
	BOOLEAN USPS_Deliverable;
	STRING10 Dwelling_Type;
	STRING10 Zip_Type;
	BOOLEAN HR_Address;
	STRING100 HR_Company;
	STRING4 Error_Codes;
	BOOLEAN Corrections;
END;

Layout_Phone_Validation :=
RECORD
	STRING10 telcordia_type;
	BOOLEAN phone_zip_mismatch;
	INTEGER distance;
	BOOLEAN disconnected;
	UNSIGNED1 recent_disconnects;
	BOOLEAN HR_Phone;
	BOOLEAN Corrections;
END;

Layout_SSN_Validation :=
RECORD
	BOOLEAN deceased;
	unsigned4 deceasedDate;
	BOOLEAN valid;
	BOOLEAN issued;
	UNSIGNED4 high_issue_date;
	UNSIGNED4 low_issue_date;
	STRING2 issue_state;
	UNSIGNED1 dob_mismatch;
	string1 inputsocscharflag := '';
	string3 inputsocscode;
END;

Layout_DL_Validation :=
RECORD
	BOOLEAN valid;
	UNSIGNED4 Issue_date;
	UNSIGNED4 Expire_date;
END;

Layout_Name_Verification :=
RECORD
	UNSIGNED1 adl_score;
	UNSIGNED1 fname_score;
	UNSIGNED1 lname_score;
	UNSIGNED3 lname_change_date;
	UNSIGNED3 lname_prev_change_date;
	UNSIGNED1 source_count;
	BOOLEAN fname_credit_sourced;
	BOOLEAN lname_credit_sourced;
	BOOLEAN fname_tu_sourced;
	BOOLEAN lname_tu_sourced;
	BOOLEAN fname_eda_sourced;
	STRING2 fname_eda_sourced_type;
	BOOLEAN lname_eda_sourced;
	STRING2 lname_eda_sourced_type;
	BOOLEAN fname_dl_sourced;
	BOOLEAN lname_dl_sourced;
	BOOLEAN fname_voter_sourced;
	BOOLEAN lname_voter_sourced;
	BOOLEAN fname_utility_sourced;
	BOOLEAN lname_utility_sourced;
	UNSIGNED1 age;
	UNSIGNED1 dob_score;
	STRING20 newest_lname;
	UNSIGNED3 newest_lname_dt_first_seen;
END;


Layout_Address_Verification :=
RECORD
	Risk_Indicators.Layouts.Layout_Address_Informationv3 Input_Address_Information;
	Risk_Indicators.Layout_Applicant_Property_values;
	Risk_Indicators.Layouts.Layout_Recent_Property_Sales Recent_Property_Sales;
	INTEGER distance_in_2_h1;
	INTEGER distance_in_2_h2;
	INTEGER distance_h1_2_h2;
	unsigned1 addr1addr2score;
	unsigned1 addr1addr3score;
	unsigned1 addr2addr3score;
	STRING1 addr_type2;
	STRING1 addr_type3;
	UNSIGNED1 edaMatchLevel;
	UNSIGNED5 activePhone;
	UNSIGNED1 edaMatchLevel2;
	UNSIGNED5 activePhone2;
	UNSIGNED1 edaMatchLevel3;
	UNSIGNED5 activePhone3;
	Risk_Indicators.Layouts.Layout_Address_Informationv3 Address_History_1;
	Risk_Indicators.Layouts.Layout_Address_Informationv3 Address_History_2;

	Risk_Indicators.Layouts.Layout_Addr_Flags Addr_Flags_1;
	Risk_Indicators.Layouts.Layout_Addr_Flags Addr_Flags_2;
END;


Layout_Phone_Verification :=
RECORD
	UNSIGNED1 phone_score;
	Layout_Phone_Validation;
	Risk_Indicators.Layouts.Layout_Gong_DID gong_did;
	string50 phone_sources;
END;	

Layout_DL_Verification :=
RECORD
	UNSIGNED1 NADL;
END;

Layout_SSN_Information :=
RECORD
	UNSIGNED1 ssn_score;
	UNSIGNED2 namePerSSN_count;
	UNSIGNED2 adlPerSSN_count;
	BOOLEAN credit_sourced;
	UNSIGNED3 credit_first_seen;
	UNSIGNED3 credit_last_seen;
	UNSIGNED1 header_count;
	UNSIGNED3 header_first_seen;
	UNSIGNED3 header_last_seen;
	BOOLEAN tu_sourced;
	BOOLEAN voter_sourced;
	BOOLEAN utility_sourced;
	BOOLEAN bk_sourced;
	BOOLEAN other_sourced;
	Layout_SSN_Validation Validation;
END;

Layout_Input_Validation :=
RECORD
	BOOLEAN FirstName;
	BOOLEAN LastName;
	BOOLEAN Address;
	BOOLEAN SSN;
	STRING1 SSN_Length;
	BOOLEAN DateOfBirth;
	BOOLEAN Email;
	BOOLEAN IPAddress;
	BOOLEAN HomePhone;
	BOOLEAN WorkPhone;
END;

Layout_Available_Sources :=
RECORD
	BOOLEAN DL;
	BOOLEAN Voter;
END;

Layout_InstantID_Results :=
RECORD
	INTEGER1 NAS_Summary;
	INTEGER1 NAP_Summary;
	STRING1 NAP_Type;
	STRING1 NAP_Status;
	INTEGER1 CVI;
	// base reason codes to be used in custom scores
	string2 reason1 := '';
	string2 reason2 := '';
	string2 reason3 := '';
	string2 reason4 := '';
	string2 reason5 := '';
	string2 reason6 := '';
	
	unsigned1 DIDCount := 0;	// - The total number of DID’s found	
	unsigned6 DID2 := 0;	// - The second DID returned from the DID Append
	unsigned6 DID3 := 0;	// - The third DID returned from the DID Append

	STRING50 DID2_Sources := '';	// - RC_Sources for DID2
	STRING50 DID2_FNameSources := '';	// - FName_Sources for DID2
	STRING50 DID2_LNameSources := '';	// - LName_Sources for DID2
	STRING50 DID2_AddrSources := '';	// - Addr_Sources for DID2
	STRING50 DID2_SocsSources := '';	// - SSN_Sources for DID2
	unsigned3 DID2_CreditFirstSeen := 0;	// - Credit_First_Seen for DID2
	unsigned3 DID2_CreditLastSeen := 0;	// - Credit_Last_Seen for DID2
	unsigned3 DID2_HeaderFirstSeen := 0;	// - Header_First_Seen for DID2
	unsigned3 DID2_HeaderLastSeen := 0;	// - Header_Last_Seen for DID2
	unsigned1 did2_criminal_count;
	unsigned1 did2_felony_count;
	unsigned1 did2_liens_recent_unreleased_count;
	unsigned1 did2_liens_historical_unreleased_count;
	unsigned1 did2_liens_recent_released_count;
	unsigned1 did2_liens_historical_released_count;

	STRING50 DID3_Sources := '';	// - RC_Sources for DID3
	STRING50 DID3_FNameSources := '';	//  FName_Sources for DID3
	STRING50 DID3_LNameSources := '';	// - LName_Sources for DID3
	STRING50 DID3_AddrSources := '';	// - Addr_Sources for DID3
	STRING50 DID3_SocsSources := '';	// - SSN_Sources for DID3
	unsigned3 DID3_CreditFirstSeen := 0;	//  - Credit_First_Seen for DID3
	unsigned3 DID3_CreditLastSeen := 0;	// - Credit_Last_Seen for DID3
	unsigned3 DID3_HeaderFirstSeen := 0;	// - Header_First_Seen for DID3
	unsigned3 DID3_HeaderLastSeen := 0;	// - Header_Last_Seen for DID3
	unsigned1 did3_criminal_count;
	unsigned1 did3_felony_count;
	unsigned1 did3_liens_recent_unreleased_count;
	unsigned1 did3_liens_historical_unreleased_count;
	unsigned1 did3_liens_recent_released_count;
	unsigned1 did3_liens_historical_released_count;
	
	// fields to support reason code and follow-up action calculations
	boolean non_us_ssn := false;
	STRING1 hriskphoneflag := '';
	STRING1 hphonetypeflag := '';	 // pw hriskphoneflag
	STRING1 wphonetypeflag := '';  
	STRING1 phonevalflag := '';  
	STRING1 hphonevalflag := '';  // pw phonevalflag
	STRING1 wphonevalflag := '';
	STRING1 phonezipflag := '';
	STRING1 PWphonezipflag := '';  // pw phonezipflag
	BOOLEAN phonedissflag := false;
	BOOLEAN wphonedissflag := false;
	UNSIGNED1 phoneverlevel := 0;
	STRING1 phonever_type := '';
	STRING1 hriskaddrflag := '';
	STRING1 pullidflag := '';
	STRING1 decsflag := '';
	STRING1 socsdobflag := '';
	STRING1 PWsocsdobflag := '';
	STRING1 socsvalflag := '';
	STRING1 PWsocsvalflag := '';
	STRING1 socsRCISflag := '';
	STRING8 socllowissue := '';
	STRING8 soclhighissue := '';
	STRING2 soclstate := '';
	UNSIGNED1 socsverlevel := 0;
	STRING1 areacodesplitflag := '';
	STRING8 areacodesplitdate := '';
	STRING3 altareacode := '';
	STRING1 reverse_areacodesplitflag := '';

	STRING1 addrvalflag := '';
	STRING1 dwelltype := '';

	STRING1 bansflag := '';

// This section purely support Boca Shell
	STRING50 sources := '';
	
	UNSIGNED2 firstcount := 0;
	UNSIGNED2 lastcount := 0;
	UNSIGNED2 addrcount := 0;
	UNSIGNED2 wphonecount := 0;
	UNSIGNED2 socscount := 0;

	UNSIGNED2 numelever := 0;

	UNSIGNED2 phonefirstcount := 0;	// added for fname_eda_sourced_type testing
	UNSIGNED2 phonelastcount := 0;
	UNSIGNED2 phoneaddrcount := 0;
	UNSIGNED2 phonephonecount := 0;

	UNSIGNED2 phoneaddr_firstcount := 0;	// added for lname_eda_sourced_type testing
	UNSIGNED2 phoneaddr_lastcount := 0;
	UNSIGNED2 phoneaddr_addrcount := 0;
	UNSIGNED2 phoneaddr_phonecount := 0;

	UNSIGNED2 utiliaddr_lastcount := 0;
	UNSIGNED2 utiliaddr_addrcount := 0;
	UNSIGNED2 utiliaddr_phonecount := 0;

	STRING15 verfirst := '';
	STRING20 verlast := '';

	BOOLEAN socsmiskeyflag := false;
	BOOLEAN hphonemiskeyflag := false;
	BOOLEAN addrmiskeyflag := false;

	STRING1 addrcommflag := '';
	STRING6 hrisksic := '';
	STRING6 hrisksicphone := '';
	STRING30 hriskcmpy := '';
	STRING30 hriskcmpyphone := '';

	UNSIGNED3 disthphoneaddr := 0;
	UNSIGNED3 disthphonewphone := 0;
	UNSIGNED3 distwphoneaddr := 0;

	STRING8 correctdob := '';
	STRING9 correctssn := '';
	STRING10 correcthphone := '';
	STRING20 correctlast := '';

	STRING15 dirsfirst := '';
	STRING20 dirslast := '';
	string10 dirs_prim_range := '';
	string2  dirs_predir:= '';
	string28 dirs_prim_name:= '';
	string4  dirs_suffix:= '';
	string2  dirs_postdir:= '';
	string10 dirs_unit_desig:= '';
	string8  dirs_sec_range:= '';
	STRING30 dirscity := '';
	STRING2 dirsstate := '';
	STRING9 dirszip := '';
	STRING50 dirscmpy := '';

	STRING10 dirsaddr_phone := '';

	UNSIGNED1 dirsaddr_lastscore := 0;	

	STRING10 utiliphone := '';
	
	STRING1 phonetype := '';

	STRING1 ziptypeflag := '';  
	string1 zipclass := '';

	STRING2 drlcvalflag := '';
	STRING1 drlcsoundx := '';  // all these drlc soundex fields are actually flags
	STRING1 drlcfirst := '';
	STRING1 drlclast := '';
	STRING1 drlcmiddle := '';
	STRING1 drlcsocs := '';
	STRING1 drlcdob := '';
	STRING1 drlcgender := '';

	STRING1 statezipflag := '';
	STRING1 cityzipflag := '';

	string10 chronoprim_range := '';
	string2  chronopredir:= '';
	string28 chronoprim_name:= '';
	string4  chronosuffix:= '';
	string2  chronopostdir:= '';
	string10 chronounit_desig:= '';
	string8  chronosec_range:= '';
	STRING30 chronocity := '';
	STRING2 chronostate := '';
	STRING9 chronozip := '';

	STRING10 chronophone := '';
	UNSIGNED5 chronoActivePhone := 0;
	UNSIGNED1 chronoMatchLevel := 0;
	
	STRING50 chrono_sources := '';
	
	Risk_Indicators.Layouts.Layout_Addr_Flags chrono_addr_flags;
	
	string10 chronoprim_range2 := '';
	string2  chronopredir2 := '';
	string28 chronoprim_name2 := '';
	string4  chronosuffix2 := '';
	string2  chronopostdir2 := '';
	string10 chronounit_desig2 := '';
	string8  chronosec_range2 := '';
	STRING30 chronocity2 := '';
	STRING2 chronostate2 := '';
	STRING9 chronozip2 := '';

	STRING10 chronophone2 := '';
	UNSIGNED5 chronoActivePhone2 := 0;
	UNSIGNED1 chronoMatchLevel2 := 0;
	
	STRING50 chrono_sources2 := '';
	
	Risk_Indicators.Layouts.Layout_Addr_Flags chrono_addr_flags2;

	string10 chronoprim_range3 := '';
	string2  chronopredir3 := '';
	string28 chronoprim_name3 := '';
	string4  chronosuffix3 := '';
	string2  chronopostdir3 := '';
	string10 chronounit_desig3 := '';
	string8  chronosec_range3 := '';
	STRING30 chronocity3 := '';
	STRING2 chronostate3 := '';
	STRING9 chronozip3 := '';

	STRING10 chronophone3 := '';
	UNSIGNED5 chronoActivePhone3 := 0;
	UNSIGNED1 chronoMatchLevel3 := 0;
	
	STRING50 chrono_sources3 := '';
	
	Risk_Indicators.Layouts.Layout_Addr_Flags chrono_addr_flags3;
	
	UNSIGNED3 chronodate_first := 0;
	UNSIGNED3 chronodate_first2 := 0;
	UNSIGNED3 chronodate_first3 := 0;

	STRING20 altlast := '';
	STRING20 altlast2 := '';
	boolean altlastPop := false;
	boolean altlast2Pop := false;
	
	BOOLEAN lastssnmatch := true;
	BOOLEAN lastssnmatch2 := true;
	BOOLEAN firstssnmatch := true;
	BOOLEAN ssnexists := true;
	
	STRING15 combo_first := '';
	STRING20 combo_last := '';
	string10 combo_prim_range := '';
	string2  combo_predir:= '';
	string28 combo_prim_name:= '';
	string4  combo_suffix:= '';
	string2  combo_postdir:= '';
	string10 combo_unit_desig:= '';
	string8  combo_sec_range:= '';
	STRING30 combo_city := '';
	STRING2 combo_state := '';
	STRING9 combo_zip := '';
	STRING10 combo_hphone := '';
	STRING9 combo_ssn := '';
	STRING8 combo_dob := '';
	STRING50 combo_cmpy := '';
	
	UNSIGNED1 combo_firstscore := 0;
	UNSIGNED1 combo_lastscore := 0;
	UNSIGNED1 combo_addrscore := 0;
	UNSIGNED1 combo_sec_rangescore := 0;
	UNSIGNED1 combo_hphonescore := 0;
	UNSIGNED1 combo_ssnscore := 0;
	UNSIGNED1 combo_dobscore := 0;
	UNSIGNED1 combo_cmpyscore := 0;
	
	UNSIGNED1 combo_firstcount := 0;
	UNSIGNED1 combo_lastcount := 0;
	UNSIGNED1 combo_addrcount := 0;
	UNSIGNED1 combo_hphonecount := 0;
	UNSIGNED1 combo_ssncount := 0;
	UNSIGNED1 combo_dobcount := 0;
	UNSIGNED1 combo_cmpycount := 0;
	
	STRING60 watchlist_table := '';
	STRING10 watchlist_record_number := '';
	STRING20 watchlist_fname := '';
	STRING20 watchlist_lname := '';
	STRING50 watchlist_address := '';
	STRING30 watchlist_city := '';
	STRING2 watchlist_state := '';
	STRING9 watchlist_zip := '';
	BOOLEAN watchlistHit := false;

	STRING50 watchlist_entity_name := '';
	
	STRING30 wphonename := '';
	STRING50 wphoneaddr := '';
	STRING30 wphonecity := '';
	STRING2 wphonestate := '';
	STRING9 wphonezip := '';
	
	string10 name_addr_phone := '';
	boolean inputAddrNotMostRecent := false;
	string1 publish_code := '';
	
	string9 BestSSN := '';
	unsigned8 iid_flags := 0;
	
	boolean DL_searched := false;
	boolean any_DL_found := false;
	boolean dl_exists := false;
	unsigned1 DL_score := 255;
	string20 verified_DL := '';
	
END;

Layout_Velocity_Information := 
RECORD
	// counts per ADL
	unsigned1 ssns_per_adl := 0;
	unsigned1 addrs_per_adl := 0;
	unsigned1 phones_per_adl := 0;
	unsigned1 dobs_per_adl := 0; 															// new for fraudpoint 2.0
	unsigned1 ssns_per_adl_created_6months := 0;
	unsigned1 addrs_per_adl_created_6months := 0;
	unsigned1 phones_per_adl_created_6months := 0;
	unsigned1 dobs_per_adl_created_6months := 0; 							// new for fraudpoint 2.0
	unsigned1 ssns_per_adl_seen_18months := 0;
	unsigned1 ssns_per_adl_multiple_use := 0; 								// new for fraudpoint 2.0 
	unsigned1 ssns_per_adl_multiple_use_non_relative := 0;  	// new for fraudpoint 2.0
	unsigned1 lnames_per_adl := 0;
	unsigned1 lnames_per_adl30 := 0;	
	unsigned1 lnames_per_adl90 := 0;
	unsigned1 lnames_per_adl180 := 0;
	unsigned1 lnames_per_adl12 := 0;
	unsigned1 lnames_per_adl24 := 0;
	unsigned1 lnames_per_adl36 := 0;
	unsigned1 lnames_per_adl60 := 0;
	unsigned1 invalid_ssns_per_adl := 0;
	unsigned1 invalid_phones_per_adl := 0;
	unsigned1 invalid_addrs_per_adl := 0;
	unsigned1 invalid_ssns_per_adl_created_6months := 0;
	unsigned1 invalid_phones_per_adl_created_6months := 0;
	unsigned1 invalid_addrs_per_adl_created_6months := 0;
	unsigned1 dl_addrs_per_adl := 0;
	unsigned1 vo_addrs_per_adl := 0;
	unsigned1 pl_addrs_per_adl := 0;


	// counts per SSN	
	unsigned1 addrs_per_ssn := 0; 
	unsigned1 adls_per_ssn_created_6months := 0;	
	unsigned1 addrs_per_ssn_created_6months := 0;
	unsigned1 adls_per_ssn_seen_18months := 0;	
	unsigned1 lnames_per_ssn := 0;  													// new for fraudpoint 2.0
	unsigned1 lnames_per_ssn_created_6months := 0;  					// new for fraudpoint 2.0
	unsigned1 addrs_per_ssn_multiple_use := 0;  							// new for fraudpoint 2.0
	unsigned1 adls_per_ssn_multiple_use := 0;  								// new for fraudpoint 2.0
	unsigned1 adls_per_ssn_multiple_use_non_relative := 0;  	// new for fraudpoint 2.0
	
	// counts per Address
	unsigned1 adls_per_addr := 0;
	unsigned1 ssns_per_addr := 0;
	unsigned1 phones_per_addr := 0;
	unsigned1 adls_per_addr_created_6months := 0;
	unsigned1 ssns_per_addr_created_6months := 0;
	unsigned1 phones_per_addr_created_6months := 0;
	unsigned1 adls_per_addr_multiple_use := 0;  							// new for fraudpoint 2.0
	unsigned1 ssns_per_addr_multiple_use := 0;  							// new for fraudpoint 2.0
	unsigned1 phones_per_addr_multiple_use := 0;  						// new for fraudpoint 2.0
	unsigned1 suspicious_adls_per_addr_created_6months := 0;  // new for fraudpoint 2.0
	
	// counts per phone
	unsigned1 adls_per_phone := 0; 
	unsigned1 adls_per_phone_created_6months := 0;
	unsigned1 adls_per_phone_multiple_use := 0;  							// new for fraudpoint 2.0
	unsigned1 addrs_per_phone := 0;  													// new for fraudpoint 2.0
	unsigned1 addrs_per_phone_created_6months := 0;  					// new for fraudpoint 2.0

END;

Layout_Source_Verification := RECORD
	unsigned2 EQ_count := 0;
	unsigned2 EN_count := 0;
	unsigned2 TU_count := 0;
	unsigned2 DL_count := 0;
	unsigned2 PR_count := 0;
	unsigned2 V_count := 0;
	unsigned2 EM_count := 0;
	unsigned2 VO_count := 0;
	unsigned2 W_count := 0;
	unsigned2 EM_only_count := 0;
	
	unsigned3 adl_EQfs_first_seen := 0;
	unsigned3 adl_en_first_seen := 0;
	unsigned3 adl_TU_first_seen := 0;
	unsigned3 adl_DL_first_seen := 0;
	unsigned3 adl_PR_first_seen := 0;
	unsigned3 adl_V_first_seen := 0;
	unsigned3 adl_EM_first_seen := 0;
	unsigned3 adl_VO_first_seen := 0;
	unsigned3 adl_EM_only_first_seen := 0;
	unsigned3 adl_W_first_seen := 0;
	
	unsigned3 adl_EQfs_last_seen := 0;
	unsigned3 adl_en_last_seen :=0;
	unsigned3 adl_TU_last_seen := 0;
	unsigned3 adl_DL_last_seen := 0;
	unsigned3 adl_PR_last_seen := 0;
	unsigned3 adl_V_last_seen := 0;
	unsigned3 adl_EM_last_seen := 0;
	unsigned3 adl_VO_last_seen := 0;
	unsigned3 adl_EM_only_last_seen := 0;
	unsigned3 adl_W_last_seen := 0;
	
	// added for nas leveling
	string50 firstnamesources := '';
	string50 lastnamesources := '';
	string50 addrsources := '';
	string50 socssources := '';
	
	STRING50 em_only_sources := '';
	
	unsigned1 num_nonderogs := 0;
	unsigned1 num_nonderogs30 := 0;
	unsigned1 num_nonderogs90 := 0;
	unsigned1 num_nonderogs180 := 0;
	unsigned1 num_nonderogs12 := 0;
	unsigned1 num_nonderogs24 := 0;
	unsigned1 num_nonderogs36 := 0;
	unsigned1 num_nonderogs60 := 0;
END;

Layout_Other_Address_Fields := RECORD
	unsigned2 max_lres;
	unsigned2 avg_lres;
	unsigned1 addrs_last_5years := 0;
	unsigned1 addrs_last_10years := 0;
	unsigned1 addrs_last_15years := 0;
	boolean isPrison := false; // this is a flag to identify if any of your addresses are a prison
	boolean hist1_isPrison := false;
	boolean hist2_isPrison := false;
	unsigned1 addrs_last30 := 0;
	unsigned1 addrs_last90 := 0;
	unsigned1 addrs_last12 := 0;
	unsigned1 addrs_last24 := 0;
	unsigned1 addrs_last36 := 0;
	unsigned4 date_first_purchase := 0;
	unsigned4 date_most_recent_purchase := 0;
	unsigned1 num_purchase30 := 0;
	unsigned1 num_purchase90 := 0;
	unsigned1 num_purchase180 := 0;
	unsigned1 num_purchase12 := 0;
	unsigned1 num_purchase24 := 0;
	unsigned1 num_purchase36 := 0;
	unsigned1 num_purchase60 := 0;
	unsigned4 date_most_recent_sale := 0;
	unsigned1 num_sold30 := 0;
	unsigned1 num_sold90 := 0;
	unsigned1 num_sold180 := 0;
	unsigned1 num_sold12 := 0;
	unsigned1 num_sold24 := 0;
	unsigned1 num_sold36 := 0;
	unsigned1 num_sold60 := 0;
END;


Layout_RV_Scores := 
RECORD
string3 bankcard;
	string3 retail;
	string3 auto;
	string3 telecom;
	string2 reason1;
	string2 reason2;
	string2 reason3;
	string2 reason4;
	string3 bankcardV2;
	string3 retailV2;
	string3 autoV2;
	string3 telecomV2;
	string3 msbV2;
	string3 prescreenV2;
	string2 reason1V2;
	string2 reason2V2;
	string2 reason3V2;
	string2 reason4V2;
	string3 bankcardV3;
	string2 reason1bV3;
	string2 reason2bV3;
	string2 reason3bV3;
	string2 reason4bV3;
	string3 retailV3;
	string2 reason1rV3;
	string2 reason2rV3;
	string2 reason3rV3;
	string2 reason4rV3;
	string3 autoV3;
	string2 reason1aV3;
	string2 reason2aV3;
	string2 reason3aV3;
	string2 reason4aV3;
	string3 telecomV3;
	string2 reason1tV3;
	string2 reason2tV3;
	string2 reason3tV3;
	string2 reason4tV3;
	string3 msbV3;
	string2 reason1mV3;
	string2 reason2mV3;
	string2 reason3mV3;
	string2 reason4mV3;
	string3 prescreenV3;
	
	string3 bankcardV4;
	string2 reason1bV4;
	string2 reason2bV4;
	string2 reason3bV4;
	string2 reason4bV4;
	string2 reason5bV4;
	string3 retailV4;
	string2 reason1rV4;
	string2 reason2rV4;
	string2 reason3rV4;
	string2 reason4rV4;
	string2 reason5rV4;
	string3 autoV4;
	string2 reason1aV4;
	string2 reason2aV4;
	string2 reason3aV4;
	string2 reason4aV4;
	string2 reason5aV4;
	string3 telecomV4;
	string2 reason1tV4;
	string2 reason2tV4;
	string2 reason3tV4;
	string2 reason4tV4;
	string2 reason5tV4;
	string3 msbV4;
	string2 reason1mV4;
	string2 reason2mV4;
	string2 reason3mV4;
	string2 reason4mV4;
	string2 reason5mV4;
	string3 prescreenV4;
END;

Layout_FD_Scores := 
RECORD
	string3 fd3;
	string3 fd6;
	string2 reason1;
  string2 reason2;
  string2 reason3;
  string2 reason4;
	string3 fraudpoint := '';
	string2 reason1FP := '';
	string2 reason2FP := '';
	string2 reason3FP := '';
	string2 reason4FP := '';
	string2 reason5FP := '';
	string2 reason6FP := '';
	string3 fraudpointV2;
	string1 StolenIdentityIndex;
	string1 SyntheticIdentityIndex;
	string1 ManipulatedIdentityIndex;
	string1 VulnerableVictimIndex;
	string1 FriendlyFraudIndex;
	string1 SuspiciousActivityIndex;
	string2 reason1FPV2;
	string2 reason2FPV2;
	string2 reason3FPV2;
	string2 reason4FPV2;
	string2 reason5FPV2;
	string2 reason6FPV2;
END;

export Layout_Boca_Shell :=
RECORD
	unsigned4 seq;
	unsigned6 did;
	BOOLEAN trueDID;
	string15 adlCategory;
	Risk_Indicators.Layout_Input - historydate			Shell_Input;
	Layout_InstantID_Results 				iid;
	Layout_Source_Verification			Source_Verification;
	Layout_Available_Sources 				Available_Sources;
	Layout_Input_Validation 				Input_Validation;
	Layout_Address_Validation 			Address_Validation;
	//Layout_DL_Validation 					DL_Validation;
	Layout_Name_Verification 				Name_Verification;
	Risk_Indicators.Layouts.Layout_Utility					Utility;
	Layout_Address_Verification 		Address_Verification;
	Layout_Other_Address_Fields			Other_Address_Info;
	Layout_Phone_Verification 			Phone_Verification;
	//Layout_DL_Verification 				DL_Verification;
	Layout_SSN_Information 					SSN_Verification;
	Layout_Velocity_Information			Velocity_Counters;
	Risk_Indicators.Layouts.Layout_Infutor 					Infutor;
	Risk_Indicators.Layouts.Layout_Infutor					Infutor_Phone;
	Risk_Indicators.Layouts.Layout_Impulse					Impulse;
	Risk_Indicators.Layout_Derogs 									BJL;
	Risk_Indicators.Layout_Relatives 								Relatives;
	Risk_Indicators.Layout_Vehicles.Vehicle_Set			Vehicles;
	Riskwise.Layouts.Layout_Watercraft								Watercraft;
	Risk_Indicators.Layouts.Layout_Accident_Data											Accident_Data;
	Riskwise.Layouts.Layout_Aircraft									Aircraft;
	Riskwise.Layouts.Layout_American_Student					Student;			// 1 extra field in here for devshell3
	Riskwise.Layouts.Layout_Professional_License			Professional_License;
	Riskwise.Layouts.Layout_AVM											AVM;	// this will populate layout edina in the address section
	Risk_Indicators.Layouts.Layout_Liens liens;	// new liens fields for boca shell 3
	Layout_RV_Scores								RV_Scores;
	Layout_FD_Scores								FD_Scores;
	string1 wealth_indicator := '';
	unsigned4 reported_dob := 0;  // was previously inferred_dob, now it's reported_dob and inferred_age
	string1 dobmatchlevel;	
	integer inferred_age := 0;	// existing, but do we need anymore?
	string1 mobility_indicator := '';
	unsigned2 lres;	// this will output in layout edina in the address section
	unsigned2 lres2;	// this will output in layout edina in address history 1
	unsigned2 lres3; 	// this will output in layout edina in address history 2
	boolean addrPop;	// this will output in layout edina in the address section
	boolean addrPop2;	// this will output in layout edina in the address section
	boolean addrPop3;	// this will output in layout edina in the address section
	UNSIGNED3	historyDate;
	string4 addrhist1zip4 := '';	// outputting for fraudpoint attributes
	string4 addrhist2zip4 := '';	// outputting for fraudpoint attributes
	string8 gong_ADL_dt_first_seen := '';  // adding for ITA attributes
	string8 gong_ADL_dt_last_seen := '';   // adding for ITA attributes
	unsigned1 total_number_derogs;
	unsigned4 date_last_derog;
	unsigned3 estimated_income;
	Risk_Indicators.Layout_ConsumerFlags						ConsumerFlags;
	Risk_Indicators.iid_constants.adl_based_modeling_flags ADL_Shell_Flags;
	
	// new for shell 4.0
	string1 addr_stability := ''; 
	Risk_Indicators.Layouts.header_verification_summary 		header_summary;
	Risk_Indicators.Layouts.advo_fields 										advo_input_addr;
	Risk_Indicators.Layouts.advo_fields 										advo_addr_hist1;
	Risk_Indicators.Layouts.layout_inquiries 								acc_logs;
	Risk_Indicators.Layouts.layout_employment 							employment;
	Risk_Indicators.Layouts.layout_business_header_summary  business_header_address_summary;
	Risk_Indicators.Layouts.layout_email										email_summary;
	Risk_Indicators.Layouts.layout_address_history_summary 	address_history_summary;
	Risk_Indicators.Layouts.layout_address_risk							addr_risk_summary;	
	Risk_Indicators.Layouts.layout_address_risk							addr_risk_summary2;	
	
	boolean uspis_hotlist;
	
	Risk_Indicators.Layouts.layout_ibehavior 								iBehavior;
END;