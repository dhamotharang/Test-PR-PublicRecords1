import risk_indicators;

export Layout_Final := record
     string12 		bdid := '';
	string3 		score := '';
	string12	 	account;
	string120 	company_name;
	string120		alt_company_name;
	string10  	prim_range;
	string2   	predir;
	string28  	prim_name;
	string4   	addr_suffix;
	string2   	postdir;
	string10  	unit_desig;
	string8   	sec_range;
	string25  	p_city_name;
	string2   	st;
	string5   	z5;
	string4   	zip4;
	string10  	lat := '';
	string11  	long := '';
	string1   	addr_type; // ?
	string4   	addr_status; // ?
	string9   	fein := '';
	string10  	phone10 := '';
	string45		ip_addr := '';
	string20		rep_fname;
	string20		rep_mname;
	string20		rep_lname;
	string5		rep_name_suffix;
	string20		rep_alt_lname;
	string10  	rep_prim_range;
	string2   	rep_predir;
	string28  	rep_prim_name;
	string4   	rep_addr_suffix;
	string2   	rep_postdir;
	string10  	rep_unit_desig;
	string8   	rep_sec_range;
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
	/* ----- DONE -------- */
	string1		CnameMatchflag		:= '';
	string1		AddrMatchFlag		:= '';
	string1		CityMatchFlag		:= '';
	string1		StateMatchFlag		:= '';
	string1		ZipMatchFlag		:= '';
	string1		PhoneMatchFlag		:= '';
	string1		FeinMatchFlag		:= '';
	//Verification Fields -- closest matching info
	/* ----- DONE -------- */
	string1		verNotRecentFlag	:= '';
	STRING120 	vercmpy 			:= '';
	STRING50 		veraddr 			:= '';
	STRING30 		vercity 			:= '';
	STRING2 		verstate 			:= '';
	STRING5 		verzip 			:= '';
	STRING10 		verphone 			:= '';
	STRING9 		verfein 			:= '';
	// BNAP (score 0-6) -- Name/Addr/Phone score
	/* ----- DONE -------- */
	string1		BNAP_Indicator		:= '';
	// BNAT (score 0-7) -- Name/Addr/Fein score
	/* ----- DONE -------- */
	string1		BNAT_Indicator 	:= '';
	// BNAS (score 0-3) -- Name/Addr/SSN score
	/* ----- DONE -------- */
	string1		BNAS_Indicator 	:= '';
	// BVI (score 0-8) -- Business Verification Index
	/* ----- DONE -------- */
	string2		BVI				:= '';
	// AR2BI (score 00 - 50) -- Authd Rep Rel to Bus Indicator
	string2		AR2BI			:= '';
	// 'additional scores' fields
	/* ----- DONE -------- */
	string3		additional_score_1 	:= '';
	string3		additional_score_2 	:= '';
	// Potential Risk Indicators
	/* ----- DONE -------- */
	dataset(risk_indicators.Layout_Desc)	PRIs;
	//Best Info
	/* ----- DONE -------- */
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
	//Phone Match Addr
	/* ----- DONE -------- */
	string120		PhoneMatchCompany	:= '';
	string50		phoneMatchAddr		:= '';
	string30		PhoneMatchCity		:= '';
	string2		phoneMatchState	:= '';
	string5		phoneMatchZip		:= '';
	string4		phoneMatchZip4		:= '';
	//FEIN Match Addr
	/* ------- Done --------- */
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
	/*-------- PARTLY DONE ------------*/
	string1		BAddrType			:= ''; // ?
	string1		BPhoneType 		:= ''; // ?	
	//Bankruptcy Info (count is later, with other counts)
	/* --------- DONE ------------- */
	string120		RecentBkName		:= '';
	string50		RecentBkAddr		:= '';
	string30		RecentBkCity		:= '';
	string2		RecentBkState		:= '';
	string5		RecentBkZip		:= '';
	string4		RecentBkZip4		:= '';
	string5		RecentBktype		:= '';
	string8		RecentBkDate		:= '';
	//Lien/Judgement Info (count is later)
	/* --------- DONE ------------- */
	string120		RecentLienName		:= '';
	string50		RecentLienAddr		:= '';
	string30		RecentLienCity		:= '';
	string2		RecentLienState	:= '';
	string5		RecentLienZip		:= '';
	string4		RecentLienZip4		:= '';
	string8		RecentLienDate		:= '';
	string4		ReleasedLienCount	:= '';
	string4		UnreleasedLienCount	:= '';
	//  BDID source record dates and counts
	/* ----- DONE -------- */
	string8	 	dt_first_seen_min 	:= '';     // min for all base records
	string8	 	dt_last_seen_max 	:= '';     // max for all base records
	// OFAC/Watchlist Info
	/* ----- DONE -------- */
	STRING60 		watchlist_table 	:= '';
	STRING10 		watchlist_record_number := '';
	STRING120	 	watchlist_cmpy 	:= '';
	STRING50 		watchlist_address 	:= '';
	STRING30 		watchlist_city 	:= '';
	STRING2 		watchlist_state 	:= '';
	STRING9 		watchlist_zip 		:= '';
	STRING30 		watchlist_country 	:= '';
	string4 		watchlist_num_with_name := '';
	//Representative Indicators
	/* --------- DONE --------------*/
	string20		RepFNameVerify		:= '';
	string20		RepLNameVerify		:= '';
	string50		RepAddrVerify		:= '';
	string30		RepCityVerify		:= '';
	string2		RepStateVerify		:= '';
	string5		RepZipVerify		:= '';
	string4		RepZip4Verify		:= '';
	string10		RepPhoneVerify		:= '';
	string1		RepSSNVerify		:= ''; // (Y/N only)
	string1		RepDOBVerify		:= ''; // (Y/N only)
	string2		RepNAS_Score		:= ''; // Name_Addr_SSN
	string2		RepNAP_Score		:= ''; // Name_Addr_Phone
	string2		RepCVI			:= ''; // comp. verification index
	string3		Rep_Additional_score1 := '';
	string3		Rep_Additional_Score2 := '';
	//Rep PRI/Followups
	/* ------- DONE ---------- */
	dataset(risk_indicators.Layout_Desc)	Rep_PRIs;
	dataset(risk_indicators.Layout_Desc)	Rep_Followups; 
	// Rep Best Info
	/* -------- Done ----------*/
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
	/* ----- DONE -------- */
	STRING1 		areacodesplitflag 	:= '';
	STRING8 		areacodesplitdate 	:= '';
	STRING3 		altareacode 		:= '';
	// phone search name and addr
	/* ----- DONE -------- */
	string20		RepPhoneFname		:= '';
	string20		RepPhoneLname		:= '';
	string50		RepPhoneAddr1		:= '';
	string30		RepPhoneCity		:= '';
	string2		RepPhoneState		:= '';
	string5		RepPhoneZip		:= '';
	string4		RepPhoneZip4		:= '';
	string10		RepPhoneFromAddr	:= '';
	// Rep SSN Info
	/* ------ Done ---------*/
	string8		RepSSNEarlyDate	:= '';
	string8		RepSSNLateDate		:= '';
	string2		RepSSNIssueState	:= '';
	// Rep OFAC/Watchlist Info
	/* ------ Done ---------*/
	STRING60 		RepWatchlist_table 			:= '';
	STRING10 		RepWatchlist_record_number 	:= '';
	STRING20	 	RepWatchlist_lname 			:= '';
	STRING20	 	RepWatchlist_fname 			:= '';
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
	/* ------- DONE ----------- */
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
	/* ------------ DONE -----------*/
	string20		Alt_Fname_1				:= '';
	string20		Alt_Lname_1				:= '';
	string8		Alt_Date_Last_Seen_1		:= '';
	string20		Alt_Fname_2				:= '';
	string20		Alt_Lname_2				:= '';
	string8		Alt_Date_Last_Seen_2		:= '';
	string20		Alt_Fname_3				:= '';
	string20		Alt_Lname_3				:= '';
	string8		Alt_Date_Last_Seen_3		:= '';
end;	
