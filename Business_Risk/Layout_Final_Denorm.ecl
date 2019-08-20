/*  

IMPORTANT NOTICE TO ANYONE CHANGING THIS LAYOUT ::
	PLEASE NOTE THAT IF YOU CHANGE THIS LAYOUT, TEST THE IMPACT OF SUBSEQUENT LAYOUTS WHICH INHERIT THIS LAYOUT
	2X42 USES THIS LAYOUT, AS WELL AS BUSINESS INSTANTID BATCH.  BOTH OF WHICH ARE STATIC LAYOUTS THAT
	CAN'T CHANGE UNLESS CUSTOMER COMMUNICATION IS SENT !

*/
Import Risk_Indicators, iesp;

Rep_Attributes := RECORD
	STRING32 Name := '';
	STRING128 Value := '';
END;

export Layout_Final_denorm := record
  string12 		bdid := '';
	string3 		score := '';
	string30	 	account;
	string120 	company_name;
	string120		alt_company_name;
	string100		addr1;
	string25  	p_city_name;
	string2   	st;
	string5   	z5;
	string4   	zip4;
	string10  	lat := '';
	string11  	long := '';
	string1   	addr_type; 
	string4   	addr_status; 
	string9   	fein := '';
	string10  	phone10 := '';
	string16		ip_addr := '';
	string20		rep_fname;
	string20		rep_mname;
	string20		rep_lname;
	string5		rep_name_suffix;
	string20		rep_alt_lname;
	string100		rep_addr1;
	string25  	rep_p_city_name;
	string2   	rep_st;
	string5   	rep_z5;
	string4   	rep_zip4;
	string9		rep_ssn;
	string8		rep_dob;
	string10		rep_phone;
	string3		rep_age;
	string25		rep_dl_num;
	string2		rep_dl_state;
	string100		rep_email;
	STRING32 		riskwiseid 		:= '';
	//Y/N indicators of whether basic info was matched
	string1		CnameMatchflag		:= '';
	string1		AddrMatchFlag		:= '';
	string1		CityMatchFlag		:= '';
	string1		StateMatchFlag		:= '';
	string1		ZipMatchFlag		:= '';
	string1		PhoneMatchFlag		:= '';
	string1		FeinMatchFlag		:= '';
	//Verification Fields -- closest matching info
	string1		verNotRecentFlag	:= '';
	STRING120 	vercmpy 			:= '';
	STRING50 		veraddr 			:= '';
	STRING30 		vercity 			:= '';
	STRING2 		verstate 			:= '';
	STRING5 		verzip 			:= '';
	string20		vercounty		:= '';
	STRING10 		verphone 			:= '';
	STRING9 		verfein 			:= '';
	// BNAP (score 0-6) -- Name/Addr/Phone score
	string1		BNAP_Indicator		:= '';
	// BNAT (score 0-7) -- Name/Addr/Fein score
	string1		BNAT_Indicator 	:= '';
	// BNAS (score 0-3) -- Name/Addr/SSN score
	string1		BNAS_Indicator 	:= '';
	// BVI (score 0-8) -- Business Verification Index
	string2		BVI				:= '';
	// AR2BI (score 00 - 50) -- Authd Rep Rel to Bus Indicator
	string2		AR2BI			:= '';
	// 'additional scores' fields
	//string1		company_status		:= '';
	string3		additional_score_1 	:= '';
	string3		additional_score_2 	:= '';
	// Potential Risk Indicators
	string4	PRI_1;
	string100	PRI_Desc_1;
	string4	PRI_2;
	string100	PRI_Desc_2;
	string4	PRI_3;
	string100	PRI_Desc_3;
	string4	PRI_4;
	string100	PRI_Desc_4;
	string4	PRI_5;
	string100	PRI_Desc_5;
	string4	PRI_6;
	string100	PRI_Desc_6;
	string4	PRI_7;
	string100	PRI_Desc_7;
	string4	PRI_8;
	string100	PRI_Desc_8;
	//Best Info
	string120		bestCompanyName	:= '';
	string3	 	bestCompanyNamescore := '';
	string50		bestAddr			:= '';
	string30		bestCity			:= '';
	string2		bestState			:= '';
	string5		bestZip			:= '';
	string4		bestZip4			:= '';
	string3		bestAddrScore		:= '';
	string9		bestFEIN			:= '';
	string3		bestFEINScore		:= '';
	string10		bestPhone			:= '';
	string3		bestPhoneScore		:= '';
	// Addr Match Phone
	string10		AddrMatchPhone		:= '';
	//Phone Match Addr
	string120		PhoneMatchCompany	:= '';
	string50		phoneMatchAddr		:= '';
	string30		PhoneMatchCity		:= '';
	string2		phoneMatchState	:= '';
	string5		phoneMatchZip		:= '';
	string4		phoneMatchZip4		:= '';
	//FEIN Match Addr
	string120		FEINMatchCompany1	:= '';
	string50		FEINMatchAddr1		:= '';
	string30		FEINMatchCity1		:= '';
	string2		FEINMatchState1	:= '';
	string5		FEINMatchZip1		:= '';
	string4		FEINMatchZip4_1	:= '';
	string120		FEINMatchCompany2	:= '';
	string50		FEINMatchAddr2		:= '';
	string30		FEINMatchCity2		:= '';
	string2		FEINMatchState2	:= '';
	string5		FEINMatchZip2		:= '';
	string4		FEINMatchZip4_2	:= '';
	string120		FEINMatchCompany3	:= '';
	string50		FEINMatchAddr3		:= '';
	string30		FEINMatchCity3		:= '';
	string2		FEINMatchState3	:= '';
	string5		FEINMatchZip3		:= '';
	string4		FEINMatchZip4_3	:= '';
	//Business Addr and Phone Type and Validity Flags
	string1		BAddrType			:= ''; // ?
	string1		BPhoneType 		:= ''; // ?	
	//Bankruptcy Info
	string120		RecentBkName		:= '';
	string50		RecentBkAddr		:= '';
	string30		RecentBkCity		:= '';
	string2		RecentBkState		:= '';
	string5		RecentBkZip		:= '';
	string4		RecentBkZip4		:= '';
	string5		RecentBktype		:= '';
	string8		RecentBkDate		:= '';
	string4		TotalBKCount		:= '';
	//Lien/Judgement Info (count is later)
	string120		RecentLienName		:= '';
	string50		RecentLienAddr		:= '';
	string30		RecentLienCity		:= '';
	string2		RecentLienState	:= '';
	string5		RecentLienZip		:= '';
	string4		RecentLienZip4		:= '';
	string8		RecentLienDate		:= '';
	string50		RecentLienType		:= '';
	string4		ReleasedLienCount	:= '';
	string4		UnreleasedLienCount	:= '';
	//  BDID source record dates and counts
	string8	 	dt_first_seen_min 	:= '';     // min for all base records
	string8	 	dt_last_seen_max 	:= '';     // max for all base records
	// OFAC/Watchlist Info
	STRING60 		watchlist_table 	:= '';
	STRING10 		watchlist_record_number := '';
	STRING120   watchlist_program :='';
	UNICODE120	 	watchlist_cmpy 	:= '';
	STRING50 		watchlist_address 	:= '';
	STRING30 		watchlist_city 	:= '';
	STRING2 		watchlist_state 	:= '';
	STRING9 		watchlist_zip 		:= '';
	STRING30 		watchlist_country 	:= '';
	//string4 		watchlist_num_with_name := '';
	//Representative Indicators
	string1		repNameVerFlag	:= '';
	string20		RepFNameVerify		:= '';
	string20		RepLNameVerify		:= '';
	string1		RepAddrVerFlag		:= '';
	string50		RepAddrVerify		:= '';
	string1		RepCityVerFlag		:= '';
	string25		RepCityVerify		:= '';
	string1		RepStateVerFlag	:= '';
	string2		RepStateVerify		:= '';
	string1		RepZipVerFlag		:= '';
	string5		RepZipVerify		:= '';
	string1		RepZip4VerFlag		:= '';
	string4		RepZip4Verify		:= '';
	string20 	RepCountyVerify := '';
	string1		RepPhoneVerFlag	:= '';
	string10		RepPhoneVerify		:= '';
	string1		RepSSNVerFlag		:= '';
	string9		RepSSNVerify		:= '';
	STRING1		RepSSNValid			:= '';
	string1		RepDobVerFlag		:= '';
	string8		RepDOBVerify		:= ''; 
	string2		RepNAS_Score		:= ''; // Name_Addr_SSN
	string2		RepNAP_Score		:= ''; // Name_Addr_Phone
	string2		RepCVI			:= ''; // comp. verification index
	string3		Rep_Additional_score1 := '';
	string3		Rep_Additional_Score2 := '';
	//Rep PRI/Followups
	string4	Rep_PRI_1;
	string100	Rep_PRI_Desc_1;
	string4	Rep_PRI_2;
	string100	Rep_PRI_Desc_2;
	string4	Rep_PRI_3;
	string100	Rep_PRI_Desc_3;
	string4	Rep_PRI_4;
	string100	Rep_PRI_Desc_4;
	string4	Rep_PRI_5;
	string100	Rep_PRI_Desc_5;
	string4	Rep_PRI_6;
	string100	Rep_PRI_Desc_6;
	string4	Rep_Followup_1;
	string150	Rep_Followup_desc_1;
	string4	Rep_Followup_2;
	string150	Rep_Followup_desc_2;
	string4	Rep_Followup_3;
	string150	Rep_Followup_desc_3;
	string4	Rep_Followup_4;
	string150	Rep_Followup_desc_4;
	// Rep Best Info
	string20		RepBestFname		:= '';
	string20		RepBestLname		:= '';
	string50		RepBestAddr1		:= '';
	string30		RepBestCity		:= '';
	string2		RepBestState		:= '';
	string5		RepBestZip		:= '';
	string4		RepBestZip4		:= '';
	string8		RepBestDOB		:= '';
	string9		RepBestSSN		:= '';
	string10		RepBestPhone		:= '';
	// area code split info
	STRING1 		areacodesplitflag 	:= '';
	STRING8 		areacodesplitdate 	:= '';
	STRING3 		altareacode 		:= '';
	// phone search name and addr
	string20		RepPhoneFname		:= '';
	string20		RepPhoneLname		:= '';
	string50		RepPhoneAddr1		:= '';
	string30		RepPhoneCity		:= '';
	string2		RepPhoneState		:= '';
	string5		RepPhoneZip		:= '';
	string4		RepPhoneZip4		:= '';
	string10		RepPhoneFromAddr	:= '';
	// Rep SSN Info
	string8		RepSSNEarlyDate	:= '';
	string8		RepSSNLateDate		:= '';
	string2		RepSSNIssueState	:= '';
	// Rep OFAC/Watchlist Info
	STRING60 		RepWatchlist_table 			:= '';
	STRING10 		RepWatchlist_record_number 	:= '';
	STRING120   REpWatchlist_program :='';
	UNICODE20	 	RepWatchlist_lname 			:= '';
	UNICODE20	 	RepWatchlist_fname 			:= '';
	STRING50 		RepWatchlist_address 		:= '';
	STRING30 		RepWatchlist_city 			:= '';
	STRING2 		RepWatchlist_state 			:= '';
	STRING9 		RepWatchlist_zip 			:= '';
	STRING30 		RepWatchlist_country 		:= '';
	string4 		RepWatchlist_num_with_name 	:= '';
	// home/business phone/addr distances  
	string4		dist_HomeAddr_BusAddr		:= '9999';
	string4		dist_HomePhone_BusAddr		:= '9999';
	string4		dist_HomeAddr_BusPhone		:= '9999';
	string4		dist_HomePhone_BusPhone		:= '9999';
	string4		dist_HomePhone_HomeAddr		:= '9999';
	string4		dist_BusPhone_BusAddr		:= '9999';
	// Address History Information
	string50		Hist_Addr_1				:= '';
	string30		Hist_City_1				:= '';
	string2		Hist_State_1				:= '';
	string5		Hist_Zip_1				:= '';
	string4		Hist_Zip4_1				:= '';
	string10		Hist_Phone_1				:= '';
	string6		Hist_Date_Last_Seen_1		:= '';
	string50		Hist_Addr_2				:= '';
	string30		Hist_City_2				:= '';
	string2		Hist_State_2				:= '';
	string5		Hist_Zip_2				:= '';
	string4		Hist_Zip4_2				:= '';
	string10		Hist_Phone_2				:= '';
	string6		Hist_Date_Last_Seen_2		:= '';
	string50		Hist_Addr_3				:= '';
	string30		Hist_City_3				:= '';
	string2		Hist_State_3				:= '';
	string5		Hist_Zip_3				:= '';
	string4		Hist_Zip4_3				:= '';
	string10		Hist_Phone_3				:= '';
	string6		Hist_Date_Last_Seen_3		:= '';
	// Alt Name Info
	string20		Alt_Fname_1				:= '';
	string20		Alt_Lname_1				:= '';
	string6		Alt_Date_Last_Seen_1		:= '';
	string20		Alt_Fname_2				:= '';
	string20		Alt_Lname_2				:= '';
	string6		Alt_Date_Last_Seen_2		:= '';
	string20		Alt_Fname_3				:= '';
	string20		Alt_Lname_3				:= '';
	string6		Alt_Date_Last_Seen_3		:= '';
	
	string8 sic_code := '';
	string8 naics_code := '';
	string105 business_description := '';
	unsigned1 recordcount := 0;
	
	string1		Hist_Addr_1_isBest		:= '';
	string1		Hist_Addr_2_isBest		:= '';
	string1		Hist_Addr_3_isBest		:= '';
	string3 SubjectSSNCount := '';
	string20 rep_verDL := '';
	string8 rep_deceasedDate := '';
	string8 rep_deceasedDOB := '';
	string15 rep_deceasedFirst := '';
	string20 rep_deceasedLast := '';
	string120 SOS_filing_name := '';
		
	STRING60  Watchlist_Table_2 := '';
	STRING120 Watchlist_Program_2 := '';
	STRING10  Watchlist_Record_Number_2 := '';
	UNICODE20  Watchlist_fname_2 := '';
	UNICODE20  Watchlist_lname_2 := '';
	STRING65  Watchlist_address_2 := '';
	STRING25  Watchlist_city_2 := '';
	STRING2   Watchlist_state_2 := '';
	STRING5   Watchlist_zip_2 := '';
	STRING30  Watchlist_country_2 := '';
	UNICODE200 Watchlist_Cmpy_2 := '';
	STRING60  Watchlist_Table_3 := '';
	STRING120 Watchlist_Program_3 := '';
	STRING10  Watchlist_Record_Number_3 := '';
	UNICODE20  Watchlist_fname_3 := '';
	UNICODE20  Watchlist_lname_3 := '';
	STRING65  Watchlist_address_3 := '';
	STRING25  Watchlist_city_3 := '';
	STRING2   Watchlist_state_3 := '';
	STRING5   Watchlist_zip_3 := '';
	STRING30  Watchlist_country_3 := '';
	UNICODE200 Watchlist_Cmpy_3 := '';
	STRING60  Watchlist_Table_4 := '';
	STRING120 Watchlist_Program_4 := '';
	STRING10  Watchlist_Record_Number_4 := '';
	UNICODE20  Watchlist_fname_4 := '';
	UNICODE20  Watchlist_lname_4 := '';
	STRING65  Watchlist_address_4 := '';
	STRING25  Watchlist_city_4 := '';
	STRING2   Watchlist_state_4 := '';
	STRING5   Watchlist_zip_4 := '';
	STRING30  Watchlist_country_4 := '';
	UNICODE200 Watchlist_Cmpy_4 := '';
	STRING60  Watchlist_Table_5 := '';
	STRING120 Watchlist_Program_5 := '';
	STRING10  Watchlist_Record_Number_5 := '';
	UNICODE20  Watchlist_fname_5 := '';
	UNICODE20  Watchlist_lname_5 := '';
	STRING65  Watchlist_address_5 := '';
	STRING25  Watchlist_city_5 := '';
	STRING2   Watchlist_state_5 := '';
	STRING5   Watchlist_zip_5 := '';
	STRING30  Watchlist_country_5 := '';
	UNICODE200 Watchlist_Cmpy_5 := '';
	STRING60  Watchlist_Table_6 := '';
	STRING120 Watchlist_Program_6 := '';
	STRING10  Watchlist_Record_Number_6 := '';
	UNICODE20  Watchlist_fname_6 := '';
	UNICODE20  Watchlist_lname_6 := '';
	STRING65  Watchlist_address_6 := '';
	STRING25  Watchlist_city_6 := '';
	STRING2   Watchlist_state_6 := '';
	STRING5   Watchlist_zip_6 := '';
	STRING30  Watchlist_country_6 := '';
	UNICODE200 Watchlist_Cmpy_6 := '';
	STRING60  Watchlist_Table_7 := '';
	STRING120 Watchlist_Program_7 := '';
	STRING10  Watchlist_Record_Number_7 := '';
	UNICODE20  Watchlist_fname_7 := '';
	UNICODE20  Watchlist_lname_7 := '';
	STRING65  Watchlist_address_7 := '';
	STRING25  Watchlist_city_7 := '';
	STRING2   Watchlist_state_7 := '';
	STRING5   Watchlist_zip_7 := '';
	STRING30  Watchlist_country_7 := '';
	UNICODE200 Watchlist_Cmpy_7 := '';
	
	STRING60  RepWatchlist_Table_2 := '';
	STRING120 RepWatchlist_Program_2 := '';
	STRING10  RepWatchlist_Record_Number_2 := '';
	UNICODE20  RepWatchlist_fname_2 := '';
	UNICODE20  RepWatchlist_lname_2 := '';
	STRING65  RepWatchlist_address_2 := '';
	STRING25  RepWatchlist_city_2 := '';
	STRING2   RepWatchlist_state_2 := '';
	STRING5   RepWatchlist_zip_2 := '';
	STRING30  RepWatchlist_country_2 := '';
	UNICODE200 RepWatchlist_Entity_Name_2 := '';
	STRING60  RepWatchlist_Table_3 := '';
	STRING120 RepWatchlist_Program_3 := '';
	STRING10  RepWatchlist_Record_Number_3 := '';
	UNICODE20  RepWatchlist_fname_3 := '';
	UNICODE20  RepWatchlist_lname_3 := '';
	STRING65  RepWatchlist_address_3 := '';
	STRING25  RepWatchlist_city_3 := '';
	STRING2   RepWatchlist_state_3 := '';
	STRING5   RepWatchlist_zip_3 := '';
	STRING30  RepWatchlist_country_3 := '';
	UNICODE200 RepWatchlist_Entity_Name_3 := '';
	STRING60  RepWatchlist_Table_4 := '';
	STRING120 RepWatchlist_Program_4 := '';
	STRING10  RepWatchlist_Record_Number_4 := '';
	UNICODE20  RepWatchlist_fname_4 := '';
	UNICODE20  RepWatchlist_lname_4 := '';
	STRING65  RepWatchlist_address_4 := '';
	STRING25  RepWatchlist_city_4 := '';
	STRING2   RepWatchlist_state_4 := '';
	STRING5   RepWatchlist_zip_4 := '';
	STRING30  RepWatchlist_country_4 := '';
	UNICODE200 RepWatchlist_Entity_Name_4 := '';
	STRING60  RepWatchlist_Table_5 := '';
	STRING120 RepWatchlist_Program_5 := '';
	STRING10  RepWatchlist_Record_Number_5 := '';
	UNICODE20  RepWatchlist_fname_5 := '';
	UNICODE20  RepWatchlist_lname_5 := '';
	STRING65  RepWatchlist_address_5 := '';
	STRING25  RepWatchlist_city_5 := '';
	STRING2   RepWatchlist_state_5 := '';
	STRING5   RepWatchlist_zip_5 := '';
	STRING30  RepWatchlist_country_5 := '';
	UNICODE200 RepWatchlist_Entity_Name_5 := '';
	STRING60  RepWatchlist_Table_6 := '';
	STRING120 RepWatchlist_Program_6 := '';
	STRING10  RepWatchlist_Record_Number_6 := '';
	UNICODE20  RepWatchlist_fname_6 := '';
	UNICODE20  RepWatchlist_lname_6 := '';
	STRING65  RepWatchlist_address_6 := '';
	STRING25  RepWatchlist_city_6 := '';
	STRING2   RepWatchlist_state_6 := '';
	STRING5   RepWatchlist_zip_6 := '';
	STRING30  RepWatchlist_country_6 := '';
	UNICODE200 RepWatchlist_Entity_Name_6 := '';
	STRING60  RepWatchlist_Table_7 := '';
	STRING120 RepWatchlist_Program_7 := '';
	STRING10  RepWatchlist_Record_Number_7 := '';
	UNICODE20  RepWatchlist_fname_7 := '';
	UNICODE20  RepWatchlist_lname_7 := '';
	STRING65  RepWatchlist_address_7 := '';
	STRING25  RepWatchlist_city_7 := '';
	STRING2   RepWatchlist_state_7 := '';
	STRING5   RepWatchlist_zip_7 := '';
	STRING30  RepWatchlist_country_7 := '';
	UNICODE200 RepWatchlist_Entity_Name_7 := '';
	
	STRING1	PRI_seq_1;
	STRING1	PRI_seq_2;
	STRING1	PRI_seq_3;
	STRING1	PRI_seq_4;
	STRING1	PRI_seq_5;
	STRING1	PRI_seq_6;
	STRING1	PRI_seq_7;
	STRING1	PRI_seq_8;
	STRING1	Rep_PRI_seq_1;
	STRING1	Rep_PRI_seq_2;
	STRING1	Rep_PRI_seq_3;
	STRING1	Rep_PRI_seq_4;
	STRING1	Rep_PRI_seq_5;
	STRING1	Rep_PRI_seq_6;
	STRING1  Watchlist_seq_1;
	STRING1  Watchlist_seq_2;
	STRING1  Watchlist_seq_3;
	STRING1  Watchlist_seq_4;
	STRING1  Watchlist_seq_5;
	STRING1  Watchlist_seq_6;
	STRING1  Watchlist_seq_7;
	STRING1  RepWatchlist_seq_1;
	STRING1  RepWatchlist_seq_2;
	STRING1  RepWatchlist_seq_3;
	STRING1  RepWatchlist_seq_4;
	STRING1  RepWatchlist_seq_5;
	STRING1  RepWatchlist_seq_6;
	STRING1  RepWatchlist_seq_7;

	DATASET(Rep_Attributes) Attributes{MAXCOUNT(iesp.constants.biid.MAXREPATTRIBUTES)};
	DATASET(risk_indicators.layouts.layout_desc_plus_seq) BusRiskIndicators{MAXCOUNT(iesp.constants.biid.MAXRISKINDICATORS)};
	DATASET(risk_indicators.layouts.layout_desc_plus_seq) RepRiskIndicators{MAXCOUNT(iesp.constants.biid.MAXRISKINDICATORS)};

end;	


/*  

IMPORTANT NOTICE TO ANYONE CHANGING THIS LAYOUT

PLEASE NOTE THAT IF YOU CHANGE THIS LAYOUT, TEST THE IMPACT OF SUBSEQUENT LAYOUTS WHICH INHERIT THIS LAYOUT

2X42 USES THIS LAYOUT, AS WELL AS BUSINESS INSTANTID BATCH.  BOTH OF WHICH ARE STATIC LAYOUTS THAT CAN'T CHANGE UNLESS CUSTOMER COMMUNICATION IS SENT

*/