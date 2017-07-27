Layout_Name_Verification := RECORD
	UNSIGNED1 adl_score;			
	UNSIGNED1 fname_score;
	UNSIGNED1 lname_score;
	UNSIGNED3 lname_change_date;
	UNSIGNED3 lname_prev_change_date;
	UNSIGNED1 source_count;
	BOOLEAN fname_eda_sourced;
	string2 fname_eda_sourced_type;
	BOOLEAN lname_eda_sourced;
	string2 lname_eda_sourced_type;
	UNSIGNED1 age;
END;

Layout_Address_AVM_edina := RECORD
	string1 avm_land_use_code;
	string8 avm_recording_date;
	string4 avm_assessed_value_year;
	string11 avm_sales_price;  
	string11 avm_assessed_total_value;
	string11 avm_market_total_value;
	unsigned8 avm_tax_assessment_valuation;
	unsigned8 avm_price_index_valuation;
	unsigned8 avm_hedonic_valuation;
	unsigned8 avm_automated_valuation;	
	unsigned8 avm_automated_valuation2;
	unsigned8 avm_automated_valuation3;
	unsigned8 avm_automated_valuation4;
	unsigned8 avm_automated_valuation5;
	unsigned8 avm_automated_valuation6;
	unsigned1 avm_confidence_score;
	unsigned8 avm_median_fips_level;
	unsigned8 avm_median_geo11_level;
	unsigned8 avm_median_geo12_level;
END;

Layout_Address_Information_Edina := RECORD
	UNSIGNED3 address_score;
	BOOLEAN House_Number_match;
	BOOLEAN isBestMatch;
	UNSIGNED4 unit_count;
	unsigned2 lres;
	Layout_Address_AVM_edina;
	decimal5_2 fips_fc_index;
	decimal5_2 geo11_fc_index;
	decimal5_2 geo12_fc_index;
	UNSIGNED1 source_count;
	BOOLEAN eda_sourced;
	BOOLEAN applicant_owned;
	BOOLEAN occupant_owned;
	BOOLEAN family_owned;
	BOOLEAN family_sold;
	BOOLEAN applicant_sold;
	UNSIGNED1 NAProp;
	UNSIGNED4 purchase_date;
	UNSIGNED4 built_date;
	UNSIGNED4 purchase_amount;
	UNSIGNED4 mortgage_amount;
	UNSIGNED4 mortgage_date;
	string5   mortgage_type;
	string4   type_financing;
	string8   first_td_due_date;
	UNSIGNED4 assessed_amount;
	UNSIGNED4 date_first_seen;
	UNSIGNED4 date_last_seen;
	string4 standardized_land_use_code;
	string9 building_area;
	string3 no_of_buildings;
	string5 no_of_stories;
	string5 no_of_rooms;
	string5 no_of_bedrooms;
	string8 no_of_baths;
	string2 no_of_partial_baths;
	string3 garage_type_code;
	string5 parking_no_of_cars;
	string5 style_code;
	string4	assessed_value_year;
	boolean addrPop;
	string2  st;
	string5  zip5;
	string3 county;
	string7 geo_blk;
END;

Layout_Address_Information_Edina1 := RECORD
	UNSIGNED3 address_score;
	BOOLEAN House_Number_match;
	BOOLEAN isBestMatch;
	string1 addr_type;
	unsigned2 lres;
	Layout_Address_AVM_edina;
	decimal5_2 fips_fc_index;
	decimal5_2 geo11_fc_index;
	decimal5_2 geo12_fc_index;
	UNSIGNED1 source_count;
	string50 sources;	// addr history 1 sources on header
	BOOLEAN eda_sourced;
	BOOLEAN applicant_owned;
	BOOLEAN occupant_owned;
	BOOLEAN family_owned;
	BOOLEAN family_sold;
	BOOLEAN applicant_sold;
	UNSIGNED1 NAProp;
	string4 standardized_land_use_code;
	string9 building_area;
	string3 no_of_buildings;
	string5 no_of_stories;
	string5 no_of_rooms;
	string5 no_of_bedrooms;
	string8 no_of_baths;
	string2 no_of_partial_baths;
	string3 garage_type_code;
	string5 parking_no_of_cars;
	string5 style_code;
	string4	assessed_value_year;
	UNSIGNED4 purchase_date;
	UNSIGNED4 built_date;
	UNSIGNED4 purchase_amount;
	UNSIGNED4 mortgage_amount;
	UNSIGNED4 mortgage_date;
	string5 mortgage_type;
	string4 type_financing;	
	string8 first_td_due_date;
	UNSIGNED4 assessed_amount;
	UNSIGNED4 date_first_seen;
	UNSIGNED4 date_last_seen;
	boolean hr_address;
	boolean addrPop;
	string2  st;
	string5  zip5;
	string3 county;
	string7 geo_blk;
END;

Layout_Address_Information_Edina2 := RECORD
	UNSIGNED3 address_score;
	BOOLEAN House_Number_match;
	BOOLEAN isBestMatch;
	string1 addr_type;
	unsigned2 lres; 
	UNSIGNED1 source_count;
	string50 sources;	// addr history 2 sources on header
	BOOLEAN eda_sourced;
	BOOLEAN applicant_owned;
	BOOLEAN occupant_owned;
	BOOLEAN family_owned;
	BOOLEAN family_sold;
	BOOLEAN applicant_sold;
	UNSIGNED1 NAProp;
	UNSIGNED4 purchase_date;
	UNSIGNED4 built_date;
	UNSIGNED4 purchase_amount;
	UNSIGNED4 mortgage_amount;
	UNSIGNED4 mortgage_date;
	string5 mortgage_type;
	string4 type_financing;
	string8 first_td_due_date;
	UNSIGNED4 assessed_amount;
	UNSIGNED4 date_first_seen;
	UNSIGNED4 date_last_seen;
	BOOLEAN HR_Address;
	boolean addrPop;
	string2  st;
	string5  zip5;
	string3 county;
	string7 geo_blk;
END;

Layout_Property_Value_edina := RECORD
	UNSIGNED2 property_total;
	UNSIGNED5 property_owned_purchase_total;
	UNSIGNED2 property_owned_purchase_count;
	UNSIGNED5 property_owned_assessed_total;
	UNSIGNED2 property_owned_assessed_count;
END;

Layout_Applicant_Property_Values_edina := RECORD
	Layout_Property_Value_edina 	owned;
	Layout_Property_Value_edina 	sold;
	Layout_Property_Value_edina 	ambiguous;
END;

Layout_Recent_Property_Sales := RECORD
	unsigned8 sale_price1;
	unsigned8 sale_date1;	
	unsigned8 prev_purch_price1;
	unsigned8 prev_purch_date1;
	unsigned8 sale_price2;
	unsigned8 sale_date2;
	unsigned8 prev_purch_price2;
	unsigned8 prev_purch_date2;
END;

Layout_Address_Verification := RECORD
	Layout_Address_Information_Edina 					Input_Address_Information;
	Layout_Applicant_Property_values_edina;	
	Layout_Recent_Property_Sales 							Recent_Property_Sales;
	INTEGER2 distance_in_2_h1;
	INTEGER2 distance_in_2_h2;
	INTEGER2 distance_h1_2_h2;
	unsigned1 addr1addr2score;
	unsigned1 addr1addr3score;
	unsigned1 addr2addr3score;
	Layout_Address_Information_Edina1 				Address_History_1;
	Layout_Address_Information_Edina2 				Address_History_2;
END;

Layout_Gong_DID := RECORD
	string8 gong_adl_dt_first_seen_full;
	string8 gong_adl_dt_last_seen_full;
	unsigned2 gong_did_phone_ct;
	unsigned2 gong_did_addr_ct;
	unsigned2 gong_did_first_ct;
	unsigned2 gong_did_last_ct;	
END;

Layout_Phone_Verification := RECORD
	STRING2 telcordia_type;
	UNSIGNED1 recent_disconnects;
	Layout_Gong_DID 		Gong_DID;
END;	

Layout_SSN_Information := RECORD
	UNSIGNED2 namePerSSN_count;
	UNSIGNED3 credit_first_seen;
	UNSIGNED3 credit_last_seen;
	UNSIGNED3 header_first_seen;
	UNSIGNED3 header_last_seen;
	BOOLEAN utility_sourced;
	string1 inputsocscharflag;
END;

Layout_Input_Validation := RECORD
	BOOLEAN FirstName;
	BOOLEAN LastName;
	BOOLEAN Address;
	STRING1 SSN_Length;	// note, this field changed from boolean to actual length per brent s on 7/17/07 // will need to calc
	BOOLEAN DateOfBirth;
	BOOLEAN Email;
	BOOLEAN IPAddress;
	BOOLEAN HomePhone;
	BOOLEAN WorkPhone;
END;

Layout_Available_Sources := RECORD
	BOOLEAN DL;
	BOOLEAN Voter;
END;

Layout_ConsumerFlags_edina :=RECORD
	boolean corrected_flag;
	boolean consumer_statement_flag;
	boolean dispute_flag;
	boolean security_freeze;
	boolean security_alert;
	boolean negative_alert;
	boolean id_theft_flag;
END;

Layout_InstantID_Results := RECORD
	INTEGER1 NAS_Summary;
	INTEGER1 NAP_Summary;
	STRING1 NAP_Type;
	STRING1 NAP_Status;
	INTEGER1 CVI;
	// reason codes to be calculated for edina modeling group
	string2 reason1;
  string2 reason2;
  string2 reason3;
  string2 reason4;
	string2 reason5;
  string2 reason6;
	unsigned1 DIDCount;	// - The total number of DIDÂ’s found	
	unsigned6 DID2;	// - The second DID returned from the DID Append
	unsigned6 DID3;	// - The third DID returned from the DID Append
	STRING50 DID2_Sources;	// - RC_Sources for DID2
	STRING50 DID2_FNameSources;	// - FName_Sources for DID2
	STRING50 DID2_LNameSources;	// - LName_Sources for DID2
	STRING50 DID2_AddrSources;	// - Addr_Sources for DID2
	STRING50 DID2_SocsSources;	// - SSN_Sources for DID2
	unsigned3 DID2_CreditFirstSeen;	// - Credit_First_Seen for DID2
	unsigned3 DID2_CreditLastSeen;	// - Credit_Last_Seen for DID2
	unsigned3 DID2_HeaderFirstSeen;	// - Header_First_Seen for DID2
	unsigned3 DID2_HeaderLastSeen;	// - Header_Last_Seen for DID2
	unsigned1 did2_criminal_count;
	unsigned1 did2_felony_count;
	unsigned1 did2_liens_recent_unreleased_count;
	unsigned1 did2_liens_historical_unreleased_count;
	unsigned1 did2_liens_recent_released_count;
	unsigned1 did2_liens_historical_released_count;
	STRING50 DID3_Sources;	// - RC_Sources for DID3
	STRING50 DID3_FNameSources;	//  FName_Sources for DID3
	STRING50 DID3_LNameSources;	// - LName_Sources for DID3
	STRING50 DID3_AddrSources;	// - Addr_Sources for DID3
	STRING50 DID3_SocsSources;	// - SSN_Sources for DID3
	unsigned3 DID3_CreditFirstSeen;	//  - Credit_First_Seen for DID3
	unsigned3 DID3_CreditLastSeen;	// - Credit_Last_Seen for DID3
	unsigned3 DID3_HeaderFirstSeen;	// - Header_First_Seen for DID3
	unsigned3 DID3_HeaderLastSeen;	// - Header_Last_Seen for DID3
	unsigned1 did3_criminal_count;
	unsigned1 did3_felony_count;
	unsigned1 did3_liens_recent_unreleased_count;
	unsigned1 did3_liens_historical_unreleased_count;
	unsigned1 did3_liens_recent_released_count;
	unsigned1 did3_liens_historical_released_count;
	STRING20 correctlast;
	string8 correctdob;
	UNSIGNED1 dirsaddr_lastscore;
	STRING2 drlcvalflag;
	STRING10 watchlist_record_number;
	string10 name_addr_phone;
	BOOLEAN non_us_ssn;	
	boolean inputAddrNotMostRecent;
	UNSIGNED1 combo_sec_rangescore;
	// added back in for 2.0
	STRING1 hriskphoneflag;
	STRING1 hphonetypeflag;	 // pw hriskphoneflag
	STRING1 wphonetypeflag;  
	STRING1 phonevalflag;  
	STRING1 hphonevalflag;  // pw phonevalflag
	STRING1 wphonevalflag;
	STRING1 phonezipflag;
	STRING1 PWphonezipflag;  // pw phonezipflag
	BOOLEAN wphonedissflag;
	STRING1 hriskaddrflag;
	STRING1 decsflag;
	STRING1 socsdobflag;
	STRING1 PWsocsdobflag;
	STRING1 socsvalflag;
	STRING1 PWsocsvalflag;
	UNSIGNED4 socllowissue;
	UNSIGNED4 soclhighissue;
	STRING2 soclstate;
	STRING1 areacodesplitflag;
	UNSIGNED4 areacodesplitdate;
	STRING3 altareacode;
	STRING1 addrvalflag;
	STRING1 dwelltype;
	STRING1 bansflag;
// This section purely support Boca Shell
	STRING50 sources;
	UNSIGNED2 firstcount;
	UNSIGNED2 lastcount;
	UNSIGNED2 addrcount;
	UNSIGNED2 wphonecount;
	UNSIGNED2 socscount;
	UNSIGNED2 numelever;
	UNSIGNED2 phonelastcount;
	UNSIGNED2 phoneaddrcount;
	UNSIGNED2 phonephonecount;
	UNSIGNED2 phoneaddr_lastcount;
	UNSIGNED2 phoneaddr_addrcount;
	UNSIGNED2 phoneaddr_phonecount;
	UNSIGNED2 utiliaddr_lastcount;
	UNSIGNED2 utiliaddr_addrcount;
	UNSIGNED2 utiliaddr_phonecount;
	BOOLEAN socsmiskeyflag;
	BOOLEAN hphonemiskeyflag;
	BOOLEAN addrmiskeyflag;
	STRING1 addrcommflag;
	STRING6 hrisksic;
	STRING6 hrisksicphone;
	UNSIGNED3 disthphoneaddr;
	UNSIGNED3 disthphonewphone;
	UNSIGNED3 distwphoneaddr;
	STRING1 phonetype;
	STRING1 ziptypeflag; 
	string1 zipclass;
	STRING1 statezipflag;
	STRING1 cityzipflag;
	boolean altlastPop;	
	boolean altlast2Pop; 	
	BOOLEAN lastssnmatch := true;
	BOOLEAN lastssnmatch2 := true;
	BOOLEAN firstssnmatch := true;	
	UNSIGNED1 combo_firstscore;
	UNSIGNED1 combo_lastscore;
	UNSIGNED1 combo_addrscore;
	UNSIGNED1 combo_hphonescore;
	UNSIGNED1 combo_ssnscore;
	UNSIGNED1 combo_dobscore;
	UNSIGNED1 combo_cmpyscore;
	UNSIGNED1 combo_firstcount;
	UNSIGNED1 combo_lastcount;
	UNSIGNED1 combo_addrcount;
	UNSIGNED1 combo_hphonecount;
	UNSIGNED1 combo_ssncount;
	UNSIGNED1 combo_dobcount;
	UNSIGNED1 combo_cmpycount;
	boolean watchlistHit; 
	Layout_ConsumerFlags_edina							ConsumerFlags;
END;


Layout_Source_Verification := RECORD
	unsigned2 EQ_count;
	unsigned2 EN_count;
	unsigned2 TU_count;
	unsigned2 DL_count;
	unsigned2 PR_count;
	unsigned2 V_count;
	unsigned2 EM_count;
	unsigned2 VO_count;
	unsigned2 W_count;
	unsigned2 EM_only_count;
	unsigned3 adl_EQfs_first_seen;
	unsigned3 adl_EN_first_seen;
	unsigned3 adl_TU_first_seen;
	unsigned3 adl_DL_first_seen;
	unsigned3 adl_PR_first_seen;
	unsigned3 adl_V_first_seen;
	unsigned3 adl_EM_first_seen;
	unsigned3 adl_VO_first_seen;
	unsigned3 adl_EM_only_first_seen;
	unsigned3 adl_W_first_seen;
	unsigned3 adl_EQfs_last_seen;
	unsigned3 adl_en_last_seen;
	unsigned3 adl_TU_last_seen;
	unsigned3 adl_DL_last_seen;
	unsigned3 adl_PR_last_seen;
	unsigned3 adl_V_last_seen;
	unsigned3 adl_EM_last_seen;
	unsigned3 adl_VO_last_seen;
	unsigned3 adl_EM_only_last_seen;
	unsigned3 adl_W_last_seen;
	// added for nas leveling
	string50 firstnamesources;
	string50 lastnamesources;
	string50 addrsources;
	string50 socssources;
	STRING50 em_only_sources;
END;

edina_Layout_Input := RECORD
	STRING20 fname;
	STRING120 in_streetAddress;
	STRING25 in_city;
	STRING2 in_state;
	STRING5 in_zipCode;
	STRING25 in_country;
	STRING10 prim_range;
	STRING2  predir;
	STRING28 prim_name;
	STRING4  addr_suffix;
	STRING2  postdir;
	STRING10 unit_desig;
	STRING8  sec_range;
	STRING25 p_city_name;
	STRING2  st;
	STRING5  z5;
	STRING4  zip4;
	STRING10 lat;
	STRING11 long;
	string3 county;
	string7 geo_blk;
	STRING1  addr_type;
	STRING4  addr_status;
	STRING25 country;
	STRING8  dob;
	STRING50 email_address;
	STRING45 ip_address;
	STRING10 phone10;
	STRING10 wphone10;
END;

Layout_ADL_Information := RECORD
	unsigned1 ssns_per_adl;
	unsigned1 addrs_per_adl;
	unsigned1 phones_per_adl;
	UNSIGNED2 adlPerSSN_count;
	unsigned1 addrs_per_ssn; 
	unsigned1 adls_per_addr;
	unsigned1 ssns_per_addr;
	unsigned1 phones_per_addr;
	unsigned1 adls_per_phone; 
	unsigned1 ssns_per_adl_created_6months;
	unsigned1 addrs_per_adl_created_6months;
	unsigned1 phones_per_adl_created_6months;
	unsigned1 adls_per_ssn_created_6months;	
	unsigned1 addrs_per_ssn_created_6months;
	unsigned1 adls_per_addr_created_6months;
	unsigned1 ssns_per_addr_created_6months;
	unsigned1 phones_per_addr_created_6months;
	unsigned1 adls_per_phone_created_6months;
	unsigned1 dl_addrs_per_adl;
	unsigned1 vo_addrs_per_adl;
	unsigned1 pl_addrs_per_adl;
	unsigned1 invalid_phones_per_adl;
	unsigned1 invalid_phones_per_adl_created_6months;
	unsigned1 invalid_ssns_per_adl;
	unsigned1 invalid_ssns_per_adl_created_6months;
	unsigned1 invalid_addrs_per_adl;
	unsigned1 invalid_addrs_per_adl_created_6months;
END;

Layout_Other_Address_Fields := RECORD
	unsigned2 avg_lres;
	unsigned2 max_lres;
	unsigned1 addrs_last_5years;
	unsigned1 addrs_last_10years;
	unsigned1 addrs_last_15years;
	boolean isPrison;
END;

Layout_Property_Value_R := RECORD
	UNSIGNED2 relatives_property_count;
	UNSIGNED2 relatives_property_total;
	UNSIGNED5 relatives_property_owned_purchase_total;
	UNSIGNED2 relatives_property_owned_purchase_count;
	UNSIGNED5 relatives_property_owned_assessed_total;
	UNSIGNED2 relatives_property_owned_assessed_count;
END;

Layout_Relative_Property_Values := RECORD
	Layout_Property_Value_R 	owned;
	Layout_Property_Value_R 	sold;
END;


Layout_Attributes := RECORD
	unsigned1 addrs_last30;
	unsigned1 addrs_last90;
	unsigned1 addrs_last12;
	unsigned1 addrs_last24;
	unsigned1 addrs_last36;	
	unsigned4 date_first_purchase;
	unsigned4 date_most_recent_purchase;
	unsigned1 num_purchase30;
	unsigned1 num_purchase90;
	unsigned1 num_purchase180;
	unsigned1 num_purchase12;
	unsigned1 num_purchase24;
	unsigned1 num_purchase36;
	unsigned1 num_purchase60;
	unsigned4 date_most_recent_sale;
	unsigned1 num_sold30;
	unsigned1 num_sold90;
	unsigned1 num_sold180;
	unsigned1 num_sold12;
	unsigned1 num_sold24;
	unsigned1 num_sold36;
	unsigned1 num_sold60;
	unsigned1 num_watercraft30;
	unsigned1 num_watercraft90;
	unsigned1 num_watercraft180;
	unsigned1 num_watercraft12;
	unsigned1 num_watercraft24;
	unsigned1 num_watercraft36;
	unsigned1 num_watercraft60;
	unsigned1 num_aircraft;
	unsigned1 num_aircraft30;
	unsigned1 num_aircraft90;
	unsigned1 num_aircraft180;
	unsigned1 num_aircraft12;
	unsigned1 num_aircraft24;
	unsigned1 num_aircraft36;
	unsigned1 num_aircraft60;
	unsigned1 total_number_derogs;
	unsigned4 date_last_derog;
	unsigned1 felonies30;
	unsigned1 felonies90;
	unsigned1 felonies180;
	unsigned1 felonies12;
	unsigned1 felonies24;
	unsigned1 felonies36;
	unsigned1 felonies60;
	unsigned1 arrests;
	unsigned4 date_last_arrest;
	unsigned1 arrests30;
	unsigned1 arrests90;
	unsigned1 arrests180;
	unsigned1 arrests12;
	unsigned1 arrests24;
	unsigned1 arrests36;
	unsigned1 arrests60;
	unsigned1 num_unreleased_liens30;
	unsigned1 num_unreleased_liens90;
	unsigned1 num_unreleased_liens180;
	unsigned1 num_unreleased_liens12;
	unsigned1 num_unreleased_liens24;
	unsigned1 num_unreleased_liens36;
	unsigned1 num_unreleased_liens60;
	unsigned1 num_released_liens30;
	unsigned1 num_released_liens90;
	unsigned1 num_released_liens180;
	unsigned1 num_released_liens12;
	unsigned1 num_released_liens24;
	unsigned1 num_released_liens36;
	unsigned1 num_released_liens60;
	unsigned1 bankruptcy_count30;
	unsigned1 bankruptcy_count90;
	unsigned1 bankruptcy_count180;
	unsigned1 bankruptcy_count12;
	unsigned1 bankruptcy_count24;
	unsigned1 bankruptcy_count36;
	unsigned1 bankruptcy_count60;
	unsigned1 eviction_count;
	unsigned4 date_last_eviction;
	unsigned1 eviction_count30;
	unsigned1 eviction_count90;
	unsigned1 eviction_count180;
	unsigned1 eviction_count12;
	unsigned1 eviction_count24;
	unsigned1 eviction_count36;
	unsigned1 eviction_count60;
	unsigned1 num_nonderogs;
	unsigned1 num_nonderogs30;
	unsigned1 num_nonderogs90;
	unsigned1 num_nonderogs180;
	unsigned1 num_nonderogs12;
	unsigned1 num_nonderogs24;
	unsigned1 num_nonderogs36;
	unsigned1 num_nonderogs60;
	unsigned1 num_proflic30;
	unsigned1 num_proflic90;
	unsigned1 num_proflic180;
	unsigned1 num_proflic12;
	unsigned1 num_proflic24;
	unsigned1 num_proflic36;
	unsigned1 num_proflic60;
	unsigned1 num_proflic_exp30;
	unsigned1 num_proflic_exp90;
	unsigned1 num_proflic_exp180;
	unsigned1 num_proflic_exp12;
	unsigned1 num_proflic_exp24;
	unsigned1 num_proflic_exp36;
	unsigned1 num_proflic_exp60;
END;

Layout_Relative := RECORD
	UNSIGNED1 relative_count;
	UNSIGNED1 relative_bankrupt_count;
	UNSIGNED1 relative_criminal_count;
	UNSIGNED1 relative_felony_count;
	UNSIGNED1 relative_criminal_total;
	UNSIGNED1 relative_felony_total;
	UNSIGNED1 criminal_relative_within25miles;
	UNSIGNED1 criminal_relative_within100miles;
	UNSIGNED1 criminal_relative_within500miles;
	UNSIGNED1 criminal_relative_withinOther;
	Layout_Relative_Property_Values;
	/* *********** Census related aggregates *************** */
	UNSIGNED1 relative_within25miles_count;
	UNSIGNED1 relative_within100miles_count;
	UNSIGNED1 relative_within500miles_count;
	UNSIGNED1 relative_withinOther_count;
	UNSIGNED1 relative_incomeUnder25_count;
	UNSIGNED1 relative_incomeUnder50_count;
	UNSIGNED1 relative_incomeUnder75_count;
	UNSIGNED1 relative_incomeUnder100_count;
	UNSIGNED1 relative_incomeOver100_count;
	UNSIGNED1 relative_homeUnder50_count;
	UNSIGNED1 relative_homeUnder100_count;
	UNSIGNED1 relative_homeUnder150_count;
	UNSIGNED1 relative_homeUnder200_count;
	UNSIGNED1 relative_homeUnder300_count;
	UNSIGNED1 relative_homeUnder500_count;
	UNSIGNED1 relative_homeOver500_count;	
	UNSIGNED1 relative_educationUnder8_count;
	UNSIGNED1 relative_educationUnder12_count;
	UNSIGNED1 relative_educationOver12_count;
	UNSIGNED1 relative_ageUnder20_count;
	UNSIGNED1 relative_ageUnder30_count;
	UNSIGNED1 relative_ageUnder40_count;
	UNSIGNED1 relative_ageUnder50_count;
	UNSIGNED1 relative_ageUnder60_count;
	UNSIGNED1 relative_ageUnder70_count;
	UNSIGNED1 relative_ageOver70_count;
	unsigned1 relative_vehicle_owned_count;	// what is this?
	unsigned1 relatives_at_input_address;
END;

Layout_American_Student := RECORD
	unsigned4 DATE_FIRST_SEEN;
	unsigned4 DATE_LAST_SEEN;
	string2 AGE;
	unsigned4 DOB_FORMATTED;
	string3 CLASS;
	string1 COLLEGE_CODE;
	string1 COLLEGE_TYPE;
	string1 INCOME_LEVEL_CODE;
	string1 FILE_TYPE;
	string25 COLLEGE_NAME;
	string1 COLLEGE_TIER;
END;

Layout_Professional_License := RECORD
	boolean professional_license_flag;
	string60 license_type;
	string150 jobCategory;
	string1 plCategory;
END;

Layout_Vehicles_Edina := RECORD
	UNSIGNED1 current_count;
	UNSIGNED1 historical_count;
END;

Layout_Watercraft := RECORD
	unsigned1 watercraft_count;
END;

Layout_RV_Scores := RECORD
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
END;

Layout_FD_Scores := RECORD
	string3 fd3;
	string3 fd6;
	string2 reason1;
	string2 reason2;
	string2 reason3;
	string2 reason4;
	string3 fraudpoint;
	string2 reason1FP;
	string2 reason2FP;
	string2 reason3FP;
	string2 reason4FP;
	string2 reason5FP;
	string2 reason6FP;
	string3 fraudpointV2;
	string2 reason1FPV2;
	string2 reason2FPV2;
	string2 reason3FPV2;
	string2 reason4FPV2;
	string2 reason5FPV2;
	string2 reason6FPV2;
END;

Layout_Liens_Info := RECORD
	unsigned1 count;
	unsigned4 earliest_filing_date;
	unsigned4 most_recent_filing_date;
	unsigned5 total_amount;
END;

Layout_Liens := RECORD
	Layout_Liens_Info 	liens_unreleased_civil_judgment;
	Layout_Liens_Info 	liens_released_civil_judgment;
	Layout_Liens_Info 	liens_unreleased_federal_tax;
	Layout_Liens_Info 	liens_released_federal_tax;
	Layout_Liens_Info 	liens_unreleased_foreclosure;
	Layout_Liens_Info 	liens_released_foreclosure;
	Layout_Liens_Info 	liens_unreleased_landlord_tenant;
	Layout_Liens_Info 	liens_released_landlord_tenant;
	Layout_Liens_Info 	liens_unreleased_lispendens;
	Layout_Liens_Info 	liens_released_lispendens;
	Layout_Liens_Info 	liens_unreleased_other_lj;
	Layout_Liens_Info 	liens_released_other_lj;
	Layout_Liens_Info 	liens_unreleased_other_tax;
	Layout_Liens_Info 	liens_released_other_tax;
	Layout_Liens_Info 	liens_unreleased_small_claims;
	Layout_Liens_Info 	liens_released_small_claims;
end;

Layout_Derogs_edina := RECORD
	BOOLEAN bankrupt;
	UNSIGNED4 date_last_seen;
	STRING1 filing_type;
	STRING35 disposition;	// TODO: type?
	UNSIGNED1 filing_count;
	UNSIGNED1 bk_recent_count;
	UNSIGNED1 bk_disposed_recent_count;
	UNSIGNED1 bk_disposed_historical_count;
	UNSIGNED1 liens_recent_unreleased_count;
	UNSIGNED1 liens_historical_unreleased_count;
	UNSIGNED1 liens_recent_released_count;
	UNSIGNED1 liens_historical_released_count;
	string8 last_liens_unreleased_date;
	layout_liens Liens;
	UNSIGNED1 criminal_count;
	UNSIGNED4 last_criminal_date;
	UNSIGNED1 felony_count;
	UNSIGNED4 last_felony_date;
	boolean foreclosure_flag;
	string8 last_foreclosure_date;
END;

Layout_Accident := RECORD
	unsigned1 num_accidents;
	unsigned8 dmgamtaccidents;
	unsigned8 datelastaccident;
	unsigned8 dmgamtlastaccident;
	unsigned1 numaccidents30;
	unsigned1 numaccidents90;
	unsigned1 numaccidents180;
	unsigned1 numaccidents12;
	unsigned1 numaccidents24;
	unsigned1 numaccidents36;
	unsigned1 numaccidents60;
end;

Layout_Accident_Data := RECORD
	Layout_accident 		acc;
	Layout_accident 		atfault;
	Layout_accident 		atfaultda;
END;

Layout_Utility := RECORD
	string50  utili_adl_type; 
	string150 utili_adl_dt_first_seen;
	unsigned1 utili_adl_count;
	string8   utili_adl_earliest_dt_first_seen;
	unsigned1 utili_adl_nap;
	string50  utili_addr1_type; 
	string150 utili_addr1_dt_first_seen;
	unsigned1 utili_addr1_nap;
	string50  utili_addr2_type; 
	string150 utili_addr2_dt_first_seen;
	unsigned1 utili_addr2_nap;
END;

Layout_Infutor := RECORD
	unsigned4 infutor_date_first_seen;
	unsigned4 infutor_date_last_seen;
	unsigned1 infutor_nap;
END;

Layout_Impulse := RECORD
	unsigned2 count;
	unsigned4 first_seen_date;
	unsigned4 last_seen_date;
	string50 siteid;
	unsigned2 count30;
	unsigned2 count90;
	unsigned2 count180;
	unsigned2 count12;
	unsigned2 count24;
	unsigned2 count36;
	unsigned2 count60;
	unsigned5 annual_income;
END;


export Layout_Boca_Shell_Edina := RECORD
	string1 isFCRA;	// 2.5 field
	string3 cb_allowed;	// EQ/EN/ALL
	string30 AccountNumber;// added
	unsigned4 seq;
	unsigned6 did;
	BOOLEAN trueDID;
	string15 adlCategory;
	edina_Layout_Input 									Shell_Input;
	Layout_InstantID_Results 						iid;
	Layout_Source_Verification					Source_Verification;
	Layout_Available_Sources 						Available_Sources;
	Layout_Input_Validation 						Input_Validation;
	Layout_Name_Verification 						Name_Verification;
	Layout_Utility											Utility;
	Layout_Address_Verification 				Address_Verification;
	Layout_Other_Address_Fields					Other_Address_Info;
	Layout_Phone_Verification 					Phone_Verification;
	Layout_SSN_Information 							SSN_Verification;
	Layout_ADL_Information							Velocity_Counters;
	Layout_Infutor											Infutor;
	Layout_Impulse											Impulse;
	Layout_Attributes										Attributes;
	Layout_Derogs_edina 								BJL;
	Layout_Relative											Relatives;
	Layout_Vehicles_Edina								Vehicles;
	Layout_Watercraft										Watercraft;
	Layout_Accident_Data								Accident_Data;
	Layout_American_Student							Student;
	Layout_Professional_License					Professional_License;
	Layout_RV_Scores										RV_Scores;
	Layout_FD_Scores										FD_Scores;
	string1 wealth_indicator;
	string8 input_dob_age;
	string1 dobmatchlevel;
	integer2 inferred_age;	
	unsigned4 reported_dob;
	string1 mobility_indicator;
	unsigned5 estimated_income;
	UNSIGNED3	historyDate;
	STRING200 errorcode;// added
END;