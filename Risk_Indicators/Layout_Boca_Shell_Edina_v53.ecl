includeADLFields := FALSE; // If you set this to TRUE, make sure you set it to TRUE in Risk_Indicators.ToEdina_v4!

layout_counts := RECORD
    unsigned2 counttotal;
    unsigned2 countday;  // new for shell 5.0
    unsigned2 countweek;	// new for shell 5.0
    unsigned2 count01;
    unsigned2 count03;
    unsigned2 count06;
    unsigned2 count12;
    unsigned2 count24;
   END;

layout_inquiries_edina := RECORD
	string8 first_log_date;
	string8 last_log_date;
	integer2 inquiry_addr_ver_ct;
	integer2 inquiry_fname_ver_ct;
	integer2 inquiry_lname_ver_ct;
	integer2 inquiry_ssn_ver_ct;
	integer2 inquiry_dob_ver_ct;
	integer2 inquiry_phone_ver_ct;
	integer2 inquiry_email_ver_ct;  // new for shell 5.0
	layout_counts inquiries;
	layout_counts auto;
	layout_counts banking;
	layout_counts collection;
	layout_counts communications;
	layout_counts highriskcredit;
	layout_counts mortgage;
	layout_counts other;
	layout_counts prepaidCards;  // new for shell 5.0
	layout_counts QuizProvider;  // new for shell 5.0
	layout_counts retail;
	layout_counts retailPayments;// new for shell 5.0
	layout_counts StudentLoans;// new for shell 5.0
	layout_counts Utilities;// new for shell 5.0
	
   unsigned2 inquiryperadl;
		unsigned2	inq_peradl_count_day	;
		unsigned2	inq_peradl_count_week	;
		unsigned2	inq_peradl_count01	;
		unsigned2	inq_peradl_count03	;
		unsigned2	inq_peradl_count06	;
		
   unsigned2 inquiryssnsperadl;
		unsigned2	inq_ssnsperadl_count_day	;
		unsigned2	inq_ssnsperadl_count_week	;
		unsigned2	inq_ssnsperadl_count01	;
		unsigned2	inq_ssnsperadl_count03	;
		unsigned2	inq_ssnsperadl_count06	;	
		
   unsigned2 inquiryaddrsperadl;
		unsigned2	inq_addrsperadl_count_day	;
		unsigned2	inq_addrsperadl_count_week	;
		unsigned2	inq_addrsperadl_count01	;
		unsigned2	inq_addrsperadl_count03	;
		unsigned2	inq_addrsperadl_count06	;
		
   unsigned2 inquirylnamesperadl;
		unsigned2	inq_lnamesperadl_count_day	;
		unsigned2	inq_lnamesperadl_count_week	;
		unsigned2	inq_lnamesperadl_count01	;
		unsigned2	inq_lnamesperadl_count03	;
		unsigned2	inq_lnamesperadl_count06	;
		
   unsigned2 inquiryfnamesperadl;
		unsigned2	inq_fnamesperadl_count_day	;
		unsigned2	inq_fnamesperadl_count_week	;
		unsigned2	inq_fnamesperadl_count01	;
		unsigned2	inq_fnamesperadl_count03	;
		unsigned2	inq_fnamesperadl_count06	;
		
   unsigned2 inquiryphonesperadl;
		unsigned2	inq_phonesperadl_count_day	;
		unsigned2	inq_phonesperadl_count_week	;
		unsigned2	inq_phonesperadl_count01	;
		unsigned2	inq_phonesperadl_count03	;
		unsigned2	inq_phonesperadl_count06	;
		
   unsigned2 inquirydobsperadl;
		unsigned2	inq_dobsperadl_count_day	;
		unsigned2	inq_dobsperadl_count_week	;
		unsigned2	inq_dobsperadl_count01	;
		unsigned2	inq_dobsperadl_count03	;
		unsigned2	inq_dobsperadl_count06	;
		
   unsigned2 inquiryperssn;
		unsigned2	inq_perssn_count_day	;
		unsigned2	inq_perssn_count_week	;
		unsigned2	inq_perssn_count01	;
		unsigned2	inq_perssn_count03	;
		unsigned2	inq_perssn_count06	;
		
   unsigned2 inquiryadlsperssn;
		unsigned2	inq_adlsperssn_count_day	;
		unsigned2	inq_adlsperssn_count_week	;
		unsigned2	inq_adlsperssn_count01	;
		unsigned2	inq_adlsperssn_count03	;
		unsigned2	inq_adlsperssn_count06	;
		
   unsigned2 inquirylnamesperssn;
		unsigned2	inq_lnamesperssn_count_day	;
		unsigned2	inq_lnamesperssn_count_week	;
		unsigned2	inq_lnamesperssn_count01	;
		unsigned2	inq_lnamesperssn_count03	;
		unsigned2	inq_lnamesperssn_count06	;
		
   unsigned2 inquiryaddrsperssn;
		unsigned2	inq_addrsperssn_count_day	;
		unsigned2	inq_addrsperssn_count_week	;
		unsigned2	inq_addrsperssn_count01	;
		unsigned2	inq_addrsperssn_count03	;
		unsigned2	inq_addrsperssn_count06	;
		
   unsigned2 inquirydobsperssn;
		unsigned2	inq_dobsperssn_count_day	;
		unsigned2	inq_dobsperssn_count_week	;
		unsigned2	inq_dobsperssn_count01	;
		unsigned2	inq_dobsperssn_count03	;
		unsigned2	inq_dobsperssn_count06	;
		
   unsigned2 inquiryperaddr;
		unsigned2	inq_peraddr_count_day	;
		unsigned2	inq_peraddr_count_week	;
		unsigned2	inq_peraddr_count01	;
		unsigned2	inq_peraddr_count03	;
		unsigned2	inq_peraddr_count06	;
	
   unsigned2 inquiryadlsperaddr;
		unsigned2	inq_adlsperaddr_count_day	;
		unsigned2	inq_adlsperaddr_count_week	;
		unsigned2	inq_adlsperaddr_count01	;
		unsigned2	inq_adlsperaddr_count03	;
		unsigned2	inq_adlsperaddr_count06	;
	
   unsigned2 inquirylnamesperaddr;
		unsigned2	inq_lnamesperaddr_count_day	;
		unsigned2	inq_lnamesperaddr_count_week	;
		unsigned2	inq_lnamesperaddr_count01	;
		unsigned2	inq_lnamesperaddr_count03	;
		unsigned2	inq_lnamesperaddr_count06	;
	
   unsigned2 inquiryssnsperaddr;
		unsigned2	inq_ssnsperaddr_count_day	;
		unsigned2	inq_ssnsperaddr_count_week	;
		unsigned2	inq_ssnsperaddr_count01	;
		unsigned2	inq_ssnsperaddr_count03	;
		unsigned2	inq_ssnsperaddr_count06	;
	
   unsigned2 inquiryperphone;
		unsigned2	inq_perphone_count_day	;
		unsigned2	inq_perphone_count_week	;
		unsigned2	inq_perphone_count01	;
		unsigned2	inq_perphone_count03	;
		unsigned2	inq_perphone_count06	;
	
   unsigned2 inquiryadlsperphone;
		unsigned2	inq_adlsperphone_count_day	;
		unsigned2	inq_adlsperphone_count_week	;
		unsigned2	inq_adlsperphone_count01	;
		unsigned2	inq_adlsperphone_count03	;
		unsigned2	inq_adlsperphone_count06	;
	
	 unsigned2 inquiryemailsperADL;
		unsigned2	inq_emailsperadl_count_day	;
		unsigned2	inq_emailsperadl_count_week	;
		unsigned2	inq_emailsperadl_count01	;
		unsigned2	inq_emailsperadl_count03	;
		unsigned2	inq_emailsperadl_count06	;
	
   unsigned2 inquiryADLsperEmail;
		unsigned2	inq_adlsperemail_count_day	;
		unsigned2	inq_adlsperemail_count_week	;
		unsigned2	inq_adlsperemail_count01	;
		unsigned2	inq_adlsperemail_count03	;
		unsigned2	inq_adlsperemail_count06	;

		string8 am_first_seen_date;
		string8 am_last_seen_date;
		string8 cm_first_seen_date;
		string8 cm_last_seen_date;
		string8 om_first_seen_date;
		string8 om_last_seen_date;
	
		risk_indicators.layouts.layout_best_pii_inquiries;
  END;
	
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
	
	
	boolean dirty_address;
	boolean not_verified;
	boolean owned_not_occupied;
	integer non_relative_ADLs;
	integer occupancy_index;
	
	// advo fields
		string1		Address_Vacancy_Indicator		;
		string1		Throw_Back_Indicator			;
		string1		Seasonal_Delivery_Indicator		;
		string1		DND_Indicator					;
		string1		College_Indicator				;
		string1		Drop_Indicator					;
		string1		Residential_or_Business_Ind		;
		string1		Mixed_Address_Usage				;
	//
	
	Layout_Address_AVM_edina;
	decimal5_2 fips_fc_index;
	decimal5_2 geo11_fc_index;
	decimal5_2 geo12_fc_index;
	UNSIGNED1 source_count;

	string100 addr_sources := '';
	string200 addr_sources_first_seen_date := '';
	string100 addr_sources_recordcount := '';
	
	BOOLEAN eda_sourced;
	BOOLEAN applicant_owned;
	BOOLEAN occupant_owned;
	BOOLEAN family_owned;
	UNSIGNED1 NAProp;
	UNSIGNED4 purchase_date;
	UNSIGNED4 built_date;
	UNSIGNED4 purchase_amount;
	UNSIGNED4 mortgage_amount;
	UNSIGNED4 mortgage_date;
	string5   mortgage_type;
	string4   type_financing;
	string8   first_td_due_date;
	UNSIGNED4 market_total_value;
	UNSIGNED4 assessed_total_value;
	UNSIGNED4 date_first_seen;
	UNSIGNED4 date_last_seen;
	string4 standardized_land_use_code;
	string4	assessed_value_year;

	// address risk fields
		unsigned2 occupants_1yr;
		unsigned2 turnover_1yr_in;
		unsigned2 turnover_1yr_out;
		unsigned2 N_Vacant_Properties;
		unsigned2	N_Business_Count;
		unsigned2 N_SFD_Count;
		unsigned2 N_MFD_Count;
		unsigned4 N_ave_building_age;
		unsigned4 N_ave_purchase_amount;
		unsigned4 N_ave_mortgage_amount;
		unsigned4 N_ave_assessed_amount;
		unsigned8 N_ave_building_area;
		unsigned8	N_ave_price_per_sf;
		unsigned8 N_ave_no_of_stories_count;
		unsigned8 N_ave_no_of_rooms_count;
		unsigned8 N_ave_no_of_bedrooms_count;
		unsigned8 N_ave_no_of_baths_count;	
	//
	
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
	
	integer1 occupancy_index;  

	// advo fields
		string1		Address_Vacancy_Indicator		;
		string1		Throw_Back_Indicator			;
		string1		Seasonal_Delivery_Indicator		;
		string1		DND_Indicator					;
		string1		College_Indicator				;
		string1		Drop_Indicator					;
		string1		Residential_or_Business_Ind		;
		string1		Mixed_Address_Usage				;
	//
	Layout_Address_AVM_edina;
	decimal5_2 fips_fc_index;
	decimal5_2 geo11_fc_index;
	decimal5_2 geo12_fc_index;
	UNSIGNED1 source_count;
	
	string100 addr_sources := '';
	string200 addr_sources_first_seen_date := '';
	string100 addr_sources_recordcount := '';
	
	BOOLEAN eda_sourced;
	BOOLEAN applicant_owned;
	BOOLEAN occupant_owned;
	BOOLEAN family_owned;
	UNSIGNED1 NAProp;
	UNSIGNED4 purchase_date;
	UNSIGNED4 built_date;
	UNSIGNED4 purchase_amount;
	UNSIGNED4 mortgage_amount;
	UNSIGNED4 mortgage_date;
	string5 mortgage_type;
	string4 type_financing;	
	string8 first_td_due_date;
	UNSIGNED4 market_total_value;
	UNSIGNED4 assessed_total_value;
	UNSIGNED4 date_first_seen;
	UNSIGNED4 date_last_seen;
		string4 standardized_land_use_code;
	string4	assessed_value_year;
	boolean hr_address;
	// address risk fields
		unsigned2 occupants_1yr;
		unsigned2 turnover_1yr_in;
		unsigned2 turnover_1yr_out;
		unsigned2 N_Vacant_Properties;
		unsigned2	N_Business_Count;
		unsigned2 N_SFD_Count;
		unsigned2 N_MFD_Count;
		unsigned4 N_ave_building_age;
		unsigned4 N_ave_purchase_amount;
		unsigned4 N_ave_mortgage_amount;
		unsigned4 N_ave_assessed_amount;
		unsigned8 N_ave_building_area;
		unsigned8	N_ave_price_per_sf;
		unsigned8 N_ave_no_of_stories_count;
		unsigned8 N_ave_no_of_rooms_count;
		unsigned8 N_ave_no_of_bedrooms_count;
		unsigned8 N_ave_no_of_baths_count;	
	//	
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
	// advo fields
		string1		Address_Vacancy_Indicator		;
		string1		Throw_Back_Indicator			;
		string1		Seasonal_Delivery_Indicator		;
		string1		DND_Indicator					;
		string1		College_Indicator				;
		string1		Drop_Indicator					;
		string1		Residential_or_Business_Ind		;
		string1		Mixed_Address_Usage				;
	//
	Layout_Address_AVM_edina;
	decimal5_2 fips_fc_index;
	decimal5_2 geo11_fc_index;
	decimal5_2 geo12_fc_index;
	
	UNSIGNED1 source_count;
	
	string100 addr_sources := '';
	string200 addr_sources_first_seen_date := '';
	string100 addr_sources_recordcount := '';
	
	BOOLEAN eda_sourced;
	BOOLEAN applicant_owned;
	BOOLEAN occupant_owned;
	BOOLEAN family_owned;
 	UNSIGNED1 NAProp;
	UNSIGNED4 purchase_date;
	UNSIGNED4 built_date;
	UNSIGNED4 purchase_amount;
	UNSIGNED4 mortgage_amount;
	UNSIGNED4 mortgage_date;
	string5 mortgage_type;
	string4 type_financing;
	string8 first_td_due_date;
	UNSIGNED4 market_total_value;
	UNSIGNED4 assessed_total_value;
	UNSIGNED4 date_first_seen;
	UNSIGNED4 date_last_seen;
	string4 standardized_land_use_code;
	string4	assessed_value_year;
	BOOLEAN HR_Address;
		// address risk fields from shell 4.0
		unsigned2 occupants_1yr;
		unsigned2 turnover_1yr_in;
		unsigned2 turnover_1yr_out;
		unsigned2 N_Vacant_Properties;
		unsigned2	N_Business_Count;
		unsigned2 N_SFD_Count;
		unsigned2 N_MFD_Count;
		unsigned4 N_ave_building_age;
		unsigned4 N_ave_purchase_amount;
		unsigned4 N_ave_mortgage_amount;
		unsigned4 N_ave_assessed_amount;
		unsigned8 N_ave_building_area;
		unsigned8	N_ave_price_per_sf;
		unsigned8 N_ave_no_of_stories_count;
		unsigned8 N_ave_no_of_rooms_count;
		unsigned8 N_ave_no_of_bedrooms_count;
		unsigned8 N_ave_no_of_baths_count;	
	//	
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

Layout_Property_Value_edina_ambig := RECORD
	UNSIGNED1 property_total;
END;

Layout_Applicant_Property_Values_edina := RECORD
	Layout_Property_Value_edina 	owned;
	Layout_Property_Value_edina 	sold;
	Layout_Property_Value_edina_ambig 	ambiguous;
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
END;

Layout_Phone_Verification := RECORD
	STRING2 telcordia_type;
	UNSIGNED1 recent_disconnects;
	Layout_Gong_DID 		Gong_DID;
	string2 Insurance_Phone_Verification;
	string2 Experian_Phone_Verification;
END;	

Layout_SSN_Information := RECORD
	UNSIGNED2 namePerSSN_count;
	UNSIGNED3 header_first_seen;
	UNSIGNED3 header_last_seen;
	BOOLEAN utility_sourced;
	string1 inputsocscharflag;
END;

Layout_Input_Validation := RECORD
	BOOLEAN FirstName;
	BOOLEAN LastName;
	BOOLEAN Address;
	STRING1 SSN_Length;	
	integer ssnLookupFlag;
	BOOLEAN DateOfBirth;
	BOOLEAN Email;
	BOOLEAN IPAddress;
	BOOLEAN HomePhone;
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
	string2 reason1;
  string2 reason2;
  string2 reason3;
  string2 reason4;
	string2 reason5;
  string2 reason6;
	unsigned1 DIDCount;	// - The total number of DIDs found	
	unsigned6 DID2;	// - The second DID returned from the DID Append
	unsigned6 DID3;	// - The third DID returned from the DID Append
	STRING20 correctlast;
	string8 correctdob;
	UNSIGNED1 dirsaddr_lastscore;
	STRING2 drlcvalflag;
	STRING10 watchlist_record_number;
	string10 name_addr_phone;
	BOOLEAN non_us_ssn;	
	unsigned4 deceasedDate;
	boolean inputAddrNotMostRecent;
	UNSIGNED1 combo_sec_rangescore;
	STRING1 hriskphoneflag;
	STRING1 hphonetypeflag;	 
	STRING1 phonevalflag;  
	STRING1 hphonevalflag;  
	STRING1 phonezipflag;
	STRING1 PWphonezipflag;  
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
	STRING1 addrvalflag;
	STRING1 dwelltype;
	STRING1 bansflag;
	UNSIGNED2 firstcount;
	UNSIGNED2 lastcount;
	UNSIGNED2 addrcount;
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
	UNSIGNED1 combo_firstcount;
	UNSIGNED1 combo_lastcount;
	UNSIGNED1 combo_addrcount;
	UNSIGNED1 combo_hphonecount;
	UNSIGNED1 combo_ssncount;
	UNSIGNED1 combo_dobcount;
	boolean watchlistHit; 
	Layout_ConsumerFlags_edina							ConsumerFlags;
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
END;

Layout_ADL_Information := RECORD
	unsigned1 ssns_per_adl;
	unsigned1 addrs_per_adl;
	unsigned1 phones_per_adl;
	unsigned1 lnames_per_adl := 0;
	UNSIGNED2 adlPerSSN_count;
	unsigned2 adls_per_bestssn := 0;  // from best_flags section
	unsigned1 addrs_per_ssn; 
	unsigned1 addrs_per_bestssn; // from best_flags section
	unsigned1 adls_per_addr_current;
	unsigned1 adls_per_curraddr_current; // from best_flags section
	unsigned1 ssns_per_addr_current;
	unsigned1 ssns_per_curraddr_current;  // from best_flags section
	unsigned1 phones_per_addr_current;
	unsigned1 phones_per_curraddr_current; // from best_flags section
	unsigned1 adls_per_phone_current; 
	unsigned1 adls_per_bestphone_current; // from best_flags section
	unsigned1 ssns_per_adl_created_6months;
	unsigned1 addrs_per_adl_created_6months;
	unsigned1 phones_per_adl_created_6months;
	unsigned1 lnames_per_adl_created_6months := 0;  
	unsigned1 adls_per_ssn_created_6months;	
	unsigned1 adls_per_bestssn_created_6months;	// from best_flags section
	unsigned1 addrs_per_ssn_created_6months;
	unsigned1 addrs_per_bestssn_created_6months; // from best_flags section
	unsigned1 adls_per_addr_created_6months;
	unsigned1 adls_per_curraddr_created_6months;// from best_flags section
	unsigned1 ssns_per_addr_created_6months;
	unsigned1 ssns_per_curraddr_created_6months; // from best_flags section
	unsigned1 phones_per_addr_created_6months;
	unsigned1 phones_per_curraddr_created_6months;  // from best_flags section
	unsigned1 adls_per_phone_created_6months;
	unsigned1 adls_per_bestphone_created_6months;// from best_flags section
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
	integer1 economic_trajectory := 0; 
	integer1 economic_trajectory_index := 0; 
	boolean addrsMilitaryEver := false;  
	boolean isPrison := false;
	boolean address_history_advo_college_hit := false;
	integer unverified_addr_count := 0;  
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
	unsigned4 date_most_recent_sale;
	unsigned1 num_aircraft;
	unsigned1 total_number_derogs;
	unsigned4 date_last_derog;
	unsigned1 arrests;
	unsigned4 date_last_arrest;
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
	unsigned1 relative_vehicle_owned_count;	
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
	string1 COLLEGE_TIER;  
	string3 college_major;
  boolean attended_college;
END;

Layout_Professional_License := RECORD
	boolean professional_license_flag;
	string60 license_type;
	string150 jobCategory;
	string1 plCategory;
	string2 proflic_Source;  
	unsigned2 sanctions_count := 0;
	unsigned4 sanctions_date_first_seen := 0;
	unsigned4 sanctions_date_last_seen := 0;
	string50 most_recent_sanction_type := '';
END;

Layout_Vehicles_Edina := RECORD
	UNSIGNED1 current_count;
	UNSIGNED1 historical_count;
END;

Layout_Watercraft := RECORD
	unsigned1 watercraft_count;
END;

Layout_RV_Scores := RECORD
	string3 bankcardV3;
	string3 retailV3;
	string3 autoV3;
	string3 telecomV3;
	string3 msbV3;
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
	string3 bankcardv5 := '';
	string3 reason1bv5 := '';
	string3 reason2bv5 := '';
	string3 reason3bv5 := '';
	string3 reason4bv5 := '';
	string3 reason5bv5 := '';  
	string3 autov5 := '';
	string3 reason1av5 := '';
	string3 reason2av5 := '';
	string3 reason3av5 := '';
	string3 reason4av5 := '';
	string3 reason5av5 := '';
	string3 telecomv5 := '';
	string3 reason1tv5 := '';
	string3 reason2tv5 := '';
	string3 reason3tv5 := '';
	string3 reason4tv5 := '';
	string3 reason5tv5 := '';
	string3 msbv5 := '';
	string3 reason1mv5 := '';
	string3 reason2mv5 := '';
	string3 reason3mv5 := '';
	string3 reason4mv5 := '';
	string3 reason5mv5 := '';
	string3 prescreenv5 := '';
END;

Layout_FD_Scores := RECORD
	string3 fraudpoint;

	string3 fraudpointV2;
	string2 reason1FPV2;
	string2 reason2FPV2;
	string2 reason3FPV2;
	string2 reason4FPV2;
	string2 reason5FPV2;
	string2 reason6FPV2;
	
	string3 fraudpoint_V3;
	string1 StolenIdentityIndex_V3;
	string1 SyntheticIdentityIndex_V3;
	string1 ManipulatedIdentityIndex_V3;
	string1 VulnerableVictimIndex_V3;
	string1 FriendlyFraudIndex_V3;
	string1 SuspiciousActivityIndex_V3;
	string2 reason1FP_V3;
	string2 reason2FP_V3;
	string2 reason3FP_V3;
	string2 reason4FP_V3;
	string2 reason5FP_V3;
	string2 reason6FP_V3;
	
	string3 fraudpoint_V3_fdn;
	string1 StolenIdentityIndex_V3_fdn;
	string1 SyntheticIdentityIndex_V3_fdn;
	string1 ManipulatedIdentityIndex_V3_fdn;
	string1 VulnerableVictimIndex_V3_fdn;
	string1 FriendlyFraudIndex_V3_fdn;
	string1 SuspiciousActivityIndex_V3_fdn;
	string3 reason1FP_V3_fdn;
	string3 reason2FP_V3_fdn;
	string3 reason3FP_V3_fdn;
	string3 reason4FP_V3_fdn;
	string3 reason5FP_V3_fdn;
	string3 reason6FP_V3_fdn;		
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
	Layout_Liens_Info 	liens_unreleased_other_lj;
	Layout_Liens_Info 	liens_released_other_lj;
	Layout_Liens_Info 	liens_unreleased_other_tax;
	Layout_Liens_Info 	liens_released_other_tax;
	Layout_Liens_Info 	liens_unreleased_small_claims;
	Layout_Liens_Info 	liens_released_small_claims;
	Layout_Liens_Info liens_unreleased_suits;  
	Layout_Liens_Info liens_released_suits; 
end;

Layout_Derogs_edina := RECORD
	BOOLEAN bankrupt;
	UNSIGNED4 date_last_seen;
	STRING1 filing_type;
	STRING35 disposition;	
	UNSIGNED1 filing_count;
	UNSIGNED1 bk_dismissed_recent_count;  
	UNSIGNED1 bk_dismissed_historical_count;
	string3 bk_chapter;
	UNSIGNED1 bk_disposed_recent_count;
	UNSIGNED1 bk_disposed_historical_count;
	UNSIGNED1 liens_recent_unreleased_count;
	UNSIGNED1 liens_historical_unreleased_count;
	UNSIGNED1 liens_recent_released_count;
	UNSIGNED1 liens_historical_released_count;
	string8 last_liens_unreleased_date;
	layout_liens Liens;
	// risk_indicators.Layouts_Derog_Info.LNJ_attrs LnJ_attributes;  // new JuLi fields for 5.2
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
	unsigned2 count30;
	unsigned2 count90;
	unsigned2 count180;
	unsigned2 count12;
	unsigned2 count24;
	unsigned2 count36;
	unsigned2 count60;
END;

header_verification_summary := RECORD
   qstring100 ver_sources;
   qstring100 ver_sources_nas;
   qstring200 ver_sources_first_seen_date;
   qstring200 ver_sources_last_seen_date;
   qstring100 ver_sources_recordcount;
   qstring100 ver_fname_sources;
   qstring200 ver_fname_sources_first_seen_date;
   qstring100 ver_fname_sources_recordcount;
   qstring100 ver_lname_sources;
   qstring200 ver_lname_sources_first_seen_date;
   qstring100 ver_lname_sources_recordcount;
   qstring100 ver_addr_sources;
   qstring200 ver_addr_sources_first_seen_date;
   qstring100 ver_addr_sources_recordcount;
   qstring100 ver_ssn_sources;
   qstring200 ver_ssn_sources_first_seen_date;
   qstring100 ver_ssn_sources_recordcount;
   qstring100 ver_dob_sources;
   qstring200 ver_dob_sources_first_seen_date;
   qstring100 ver_dob_sources_recordcount;
	 unsigned3 header_build_date;
  END;

layout_virtual_fraud := record
	integer1  hi_risk_ct;
	integer1  lo_risk_ct;
	integer1  LexID_phone_hi_risk_ct;
	integer1  LexID_phone_lo_risk_ct;
	integer1  AltLexID_Phone_hi_risk_ct;
	integer1  AltLexID_Phone_lo_risk_ct;
	integer1  LexID_addr_hi_risk_ct;
	integer1  LexID_addr_lo_risk_ct;
	integer1  AltLexID_addr_hi_risk_ct;
	integer1  AltLexID_addr_lo_risk_ct;
	integer1  LexID_ssn_hi_risk_ct;
	integer1  LexID_ssn_lo_risk_ct;
	integer1  AltLexID_ssn_hi_risk_ct;
	integer1  AltLexID_ssn_lo_risk_ct;
end;


layout_pii_stability := record
	unsigned1	link_candidate_cnt	;
	unsigned1	link_wgt_dob_npos_cnt	;
	unsigned1	link_wgt_fname_npos_cnt	;
	unsigned1	link_wgt_lname_npos_cnt	;
	unsigned1	link_wgt_phone_npos_cnt	;
	unsigned1	link_wgt_prim_name_npos_cnt	;
	unsigned1	link_wgt_prim_range_npos_cnt	;
	unsigned1	link_wgt_ssn4_npos_cnt	;
	unsigned1	link_wgt_ssn5_npos_cnt	;
	unsigned1	link_wgt_dob_nneg_cnt	;
	unsigned1	link_wgt_fname_nneg_cnt	;
	unsigned1	link_wgt_lname_nneg_cnt	;
	unsigned1	link_wgt_phone_nneg_cnt	;
	unsigned1	link_wgt_prim_name_nneg_cnt	;
	unsigned1	link_wgt_prim_range_nneg_cnt	;
	unsigned1	link_wgt_ssn4_nneg_cnt	;
	unsigned1	link_wgt_ssn5_nneg_cnt	;
	unsigned1	link_wgt_dob_nzero_cnt	;
	unsigned1	link_wgt_fname_nzero_cnt	;
	unsigned1	link_wgt_lname_nzero_cnt	;
	unsigned1	link_wgt_phone_nzero_cnt	;
	unsigned1	link_wgt_prim_name_nzero_cnt	;
	unsigned1	link_wgt_prim_range_nzero_cnt	;
	unsigned1	link_wgt_ssn4_nzero_cnt	;
	unsigned1	link_wgt_ssn5_nzero_cnt	;
	string15	link_max_weight_element	;
	string15	link_min_weight_element	;
end;
/* Exclude VOO attributes from the Edina shell layout until they are approved for release...
// slimmed down version of VOO attributes they were interested in for MS-39
Layout_VOOAttributes := RECORD
	String2 	AddressReportingHistoryIndex;
	String2 	AddressSearchHistoryIndex;
	String2 	AddressUtilityHistoryIndex;
	String2 	AddressOwnershipHistoryIndex;
	String2 	AddressPropertyTypeIndex;
	String2 	RelativesConfirmingAddressIndex;
	String2 	AddressOwnerMailingAddressIndex;
	String2 	PriorAddressMoveIndex;
	String2 	PriorResidentMoveIndex;
	String2 	OccupancyOverride;
	String2 	InferredOwnershipTypeIndex;
	String5   OtherOwnedPropertyProximity;
END;
*/
Layout_corr_risk_summary := RECORD
		//these fields added in BS 5.3 and are based off of converted source code versus the raw source code
	string50   corrssnname_sources;
	qstring200 corrssnname_firstseen;
	qstring200 corrssnname_lastseen;
	// string100	 corrssnname_source_cnt;
	string50   corrssnaddr_sources;
	qstring200 corrssnaddr_firstseen;
	qstring200 corrssnaddr_lastseen;
	// string100	 corrssnaddr_source_cnt;
	string50   corraddrname_sources;
	qstring200 corraddrname_firstseen;
	qstring200 corraddrname_lastseen;
	// string100	 corraddrname_source_cnt;
	string50   corraddrphone_sources;
	qstring200 corraddrphone_firstseen;
	qstring200 corraddrphone_lastseen;
	// string100	 corraddrphone_source_cnt;
	string50   corrphonelastname_sources;
	qstring200 corrphonelastname_firstseen;
	qstring200 corrphonelastname_lastseen;
	// string100	 corrphonelastname_source_cnt;
	string50   corrnamedob_sources;
	qstring200 corrnamedob_firstseen;
	qstring200 corrnamedob_lastseen;
	// string100	 corrnamedob_source_cnt;
	string50   corraddrdob_sources;
	qstring200 corraddrdob_firstseen;
	qstring200 corraddrdob_lastseen;
	// string100	 corraddrdob_source_cnt;
	string50   corrssndob_sources;
	qstring200 corrssndob_firstseen;
	qstring200 corrssndob_lastseen;
	// string100	 corrssndob_source_cnt;
	string50   corrssnphone_sources;
	qstring200 corrssnphone_firstseen;
	qstring200 corrssnphone_lastseen;
	// string100	 corrssnphone_source_cnt;
	string50   corrdobphone_sources;
	qstring200 corrdobphone_firstseen;
	qstring200 corrdobphone_lastseen;
	// string100	 corrdobphone_source_cnt;
END;

//new for BS 5.3 - these count fields must be defined as integer due to returning -1 in them when the offset archive date ends up being invalid or when DID is not found
Layout_credit_derived_perf := RECORD
	integer acc_logs_collection_count12_6mos;
	integer acc_logs_collection_count12_12mos; 
	integer acc_logs_collection_count12_24mos; 
	integer acc_logs_highriskcredit_count12_6mos;
	integer acc_logs_highriskcredit_count12_12mos; 
	integer acc_logs_highriskcredit_count12_24mos; 
	integer impulse_count12_6mos;
	integer impulse_count12_12mos; 
	integer impulse_count12_24mos; 
	integer bjl_criminal_count12_6mos;
	integer bjl_criminal_count12_12mos; 
	integer bjl_criminal_count12_24mos; 
	integer bjl_liens_unreleased_count12_6mos;
	integer bjl_liens_unreleased_count12_12mos; 
	integer bjl_liens_unreleased_count12_24mos; 
	integer bjl_bk_count12_6mos;
	integer bjl_bk_count12_12mos; 
	integer bjl_bk_count12_24mos; 
	integer bjl_eviction_count12_6mos;
	integer bjl_eviction_count12_12mos; 
	integer bjl_eviction_count12_24mos; 
	string8	archive_date_6mo;		//history date + 6 months
	string8	archive_date_12mo;	//history date + 1 year
	string8	archive_date_24mo;	//history date + 2 years

END;

//new for BS 5.3 - PII corroboration counters based off of verified elements against inquiry keys
Layout_inq_PII_corroboration := RECORD
	integer	inq_corrnameaddr	;
	integer	inq_corrnameaddr_adl	;
	integer	inq_corrnamessn	;
	integer	inq_corrnamessn_adl	;
	integer	inq_corrnamephone	;
	integer	inq_corrnamephone_adl	;
	integer	inq_corraddrssn	;
	integer	inq_corraddrssn_adl	;
	integer	inq_corrdobaddr	;
	integer	inq_corrdobaddr_adl	;
	integer	inq_corraddrphone	;
	integer	inq_corraddrphone_adl	;
	integer	inq_corrdobssn	;
	integer	inq_corrdobssn_adl	;
	integer	inq_corrphonessn	;
	integer	inq_corrphonessn_adl	;
	integer	inq_corrdobphone	;
	integer	inq_corrdobphone_adl	;
	integer	inq_corrnameaddrssn	;
	integer	inq_corrnameaddrssn_adl	;
	integer	inq_corrnamephonessn	;
	integer	inq_corrnamephonessn_adl	;
	integer	inq_corrnameaddrphnssn	;
	integer	inq_corrnameaddrphnssn_adl	;
END;

//new for BS 5.3 - PII tumblings in Inquiries
Layout_inq_PII_tumblings := RECORD
	integer	inq_ssnsperadl_1subs	;
	integer	inq_phnsperadl_1subs	;
	integer	inq_primrangesperadl_1subs	;
	integer	inq_dobsperadl_1subs	;
	integer	inq_fnamesperadl_1subs	;
	integer	inq_lnamesperadl_1subs	;
	integer	inq_dobsperadl_daysubs	;
	integer	inq_dobsperadl_mosubs	;
	integer	inq_dobsperadl_yrsubs	;
	integer	inq_ssnsperadl_1dig	;
	integer	inq_phnsperadl_1dig	;
	integer	inq_primrangesperadl_1dig	;
	integer	inq_dobsperadl_1dig	;
	integer	inq_primrangesperssn_1dig	;
	integer	inq_dobsperssn_1dig	;
	integer	inq_ssnsperaddr_1dig	;
END;

//new for BS 5.3 - MS-110 fields
Layout_BRM_Derogs := RECORD
	unsigned1	liens_unreleased_count84	;
	unsigned1	liens_released_count84	;
	unsigned1	filing_count120	;
	string8		liens_last_unrel_date84	;
	unsigned4	liens_last_rel_date84	;
	unsigned	liens_unrel_total_amount84	;
	unsigned	liens_unrel_total_amount	;
	unsigned	liens_rel_total_amount84	;
	unsigned	liens_rel_total_amount	;
	unsigned1	bk_dismissed_historical_cnt120	;
	unsigned1	bk_disposed_historical_cnt120	;
	unsigned1	attr_eviction_count84	;	
END;

export Layout_Boca_Shell_Edina_v53 := RECORD
	#if(includeADLFields)
	risk_indicators.iid_constants.adl_based_modeling_flags;
	#end
	integer bsversion;
	string1 isFCRA;	// 2.5 field
	string3 cb_allowed;	// EQ/EN/ALL
	string1 IntendedPurpose;
	string30 AccountNumber;// added
	unsigned4 seq;
	unsigned6 did;
	BOOLEAN trueDID;
	string15 adlCategory;
	BOOLEAN DIDdeceased := false;
	UNSIGNED4 DIDdeceasedDate := 0;
	edina_Layout_Input 																			Shell_Input;
	Layout_InstantID_Results 																iid;
	decimal4_1 source_profile;  					
	integer source_profile_index; 				
	header_verification_summary 														header_summary;
  risk_indicators.layouts.layout_best_pii_flags						best_pii_flags;
	Layout_Available_Sources 																Available_Sources;
	risk_indicators.layouts.layout_business_header_summary  business_header_address_summary;  
	Layout_Input_Validation 																Input_Validation;
	Layout_Name_Verification 																Name_Verification;
	Layout_Utility																					Utility;
	Layout_Address_Verification 														Address_Verification;
	Layout_Other_Address_Fields															Other_Address_Info;
	Layout_Phone_Verification 															Phone_Verification;
	Layout_SSN_Information 																	SSN_Verification;
	Layout_ADL_Information																	Velocity_Counters;
	layout_inquiries_edina              										acc_logs;  	
	risk_indicators.layouts.layout_employment 							employment;  
	Layout_Infutor																					Infutor;
	Layout_Impulse																					Impulse;
	risk_indicators.layouts.layout_email_50									email_summary;  
	Layout_Attributes																				Attributes; 
	layout_pii_stability 																		PII_Stability; 
	layout_virtual_fraud																		Virtual_Fraud;	
	risk_indicators.layouts.layout_test_fraud  							Test_Fraud;
	risk_indicators.layouts.layout_contributory_fraud  			Contributory_Fraud;
	risk_indicators.layouts.layout_fd_attributesv2 -CorrelationRiskLevel -CorrelationSSNNameCount -CorrelationSSNAddrCount -CorrelationAddrNameCount -CorrelationAddrPhoneCount -CorrelationPhoneLastNameCount	fdAttributesv2;	
	Risk_Indicators.Layouts.layout_fp201_attributes 				fpAttributes201;
	Layout_Derogs_edina 																		BJL;
	risk_indicators.layouts.layout_hhid_summary  						hhid_summary;
	Layout_Relative																					Relatives;
	Layout_Vehicles_Edina																		Vehicles;
	Layout_Watercraft																				Watercraft;
	Layout_Accident_Data																		Accident_Data;
	Layout_American_Student																	Student;
	Layout_Professional_License															Professional_License;
	Layout_RV_Scores																				RV_Scores;
	risk_indicators.layouts.layout_riskview_alerts 					riskview_alerts;
	Layout_FD_Scores																				FD_Scores;

	
	string1 wealth_indicator;
	string8 input_dob_age;
	string1 dobmatchlevel;
	integer2 inferred_age;	
	unsigned4 reported_dob;
	string1 mobility_indicator;		 // original addr_stability model
	string1 addr_stability := '';  // new model for shell 4.0, addr_stability_v2
	unsigned5 estimated_income;
	string2 AssetValueIndex := '';  
	string3 AssetIndexPrimaryFactor := '';  
	string2 StabilityIndex := '';  
	string3 StabilityPrimaryFactor := '';  
	string2 AbilityIndex := '';  
	string3 AbilityIndexPrimaryFactor := '';  
	string2 WillingnessIndex := '';  
	string3 WillingnessIndexPrimaryFactor := '';  
	string20	historyDateTimeStamp := '';  
	STRING200 errorcode;

	// Layout_VOOAttributes             VOO_attributes; 
	Layout_corr_risk_summary         corr_risk_summary; 
	Layout_credit_derived_perf       credit_derived_perf; 
	Layout_inq_PII_tumblings     		 inq_PII_tumblings; 
	integer swappedNames;
	Layout_inq_PII_corroboration     inq_PII_corroboration; 
	Layout_BRM_Derogs                BRM_Derogs;
	//MS-159: new business address fields
	integer	bus_addr_only_curr;
	integer	bus_addr_only;
	//MS-71: new BIP header fields
	Risk_Indicators.Layouts.layout_BIP_Header_info BIP_Header;
	//MS-158: new business property fields
	integer bus_property_owned_total;
	integer bus_property_owned_assess_total;
	integer bus_property_owned_assess_count;
	integer bus_property_sold_total;
	integer bus_property_sold_assess_total;
	integer bus_property_sold_assess_count;
	
END;

