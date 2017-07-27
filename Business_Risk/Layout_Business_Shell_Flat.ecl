// this layout will be used to give business shell results to Jorge
// has sensitive information removed like ssn, last name, fein, etc

biid_layout := record
		string8		seq := '';
		string12  	bdid := '';
		string3	 	score := '';
		string30	 	account := '';
		string120 	company_name := '';
		string120		alt_company_name := '';
		string65 addr1 := '';   
		string10  	prim_range := '';
		string2   	predir := '';
		string28  	prim_name := '';
		string4   	addr_suffix := '';
		string2   	postdir := '';
		string10  	unit_desig := '';
		string8   	sec_range := '';
		string25  	p_city_name := '';
		string25		v_city_name := '';
		string2   	st := '';
		string5   	z5 := '';
		string4   	zip4 := '';
		string5		orig_z5 := '';
		string10  	lat := '';
		string11  	long := '';
		string1   	addr_type := ''; 
		string4   	addr_status := '';
		string3 		county := '';
		string7 		geo_blk := '';
		//string9   	fein := '';
		string10  	phone10 := '';
		string45		ip_addr := '';
		string20		rep_fname := '';
		string20		rep_mname := '';
		//string20		rep_lname := '';
		string5		rep_name_suffix := '';
		//string20		rep_alt_lname := '';
		string65 rep_addr1 := '';
		string10  	rep_prim_range := '';
		string2   	rep_predir := '';
		string28  	rep_prim_name := '';
		string4   	rep_addr_suffix := '';
		string2   	rep_postdir := '';
		string10  	rep_unit_desig := '';
		string8   	rep_sec_range := '';
		string25  	rep_p_city_name := '';
		string2   	rep_st := '';
		string5   	rep_z5 := '';
		string4   	rep_zip4 := '';
		string25		rep_orig_city := '';
		string2		rep_orig_st := '';
		string5		rep_orig_z5 := '';
		string10		rep_lat := '';
		string11		rep_long := '';
		string1		rep_addr_type := '';
		string4		rep_addr_status := '';
		string3 		rep_county := '';
		string7 		rep_geo_blk := '';
		//string9		rep_ssn := '';
		string8		rep_dob := '';
		string10		rep_phone := '';
		string3		rep_age := '';
		//string25		rep_dl_num := '';
		string2		rep_dl_state := '';
		string100		rep_email := '';
		string2 		rep_country := '';
	//end of layout_input

	// layout_output fields
		STRING32 		riskwiseid 		:= '';
		string1		CnameMatchflag		:= '';
		string1		AddrMatchFlag		:= '';
		string1		CityMatchFlag		:= '';
		string1		StateMatchFlag		:= '';
		string1		ZipMatchFlag		:= '';
		string1		PhoneMatchFlag		:= '';
		string1		FeinMatchFlag		:= '';
		string1		verNotRecentFlag	:= ''; // make this y/n from the string1 in biid
		STRING120 	vercmpy 			:= '';
		STRING50 		veraddr 			:= '';
		STRING25 		vercity 			:= '';
		STRING2 		verstate 			:= '';
		STRING5 		verzip 			:= '';
		STRING4     	verzip4			:= '';
		string20		vercounty 		:= '';
		STRING10 		verphone 			:= '';
		///STRING9 		verfein 			:= '';
		string3		feinscore 		:= '';  // cast scores from integer to string
		string3		addrscore 		:= '';
		string3		phonescore 		:= '';
		string3		cnamescore 		:= '';
		string1		addrMiskeyFlag		:= ''; // make this y/n from the string1 in biid
		string1		cmpyMiskeyFlag		:= ''; // make this y/n from the string1 in biid
		string2	CmpyFound			 := '';
		string2	AddrFound			 := '';
		string2	PhoneFound		 := '';
		string2	phonecmpycount 	 := '';
		string2	phoneaddrcount 	 := '';
		string2	cmpyaddrcount 	 	 := '';
		string2	phonecmpyaddrcount	 := '';
		string1		BNAP_Indicator		:= '';
		string1		phoneMiskeyFlag	:= '';
		string1		BNAT_Indicator 	:= '';
		string1		feinMiskeyFlag		:= '';
		string1		multisrcaddr		:= '';
		string1		multisrcaddrp		:= '';
		string1		multisrccmpy		:= '';
		string1		multisrccmpyp		:= '';
		string1		BNAS_Indicator 	:= '';
		string2		BVI				:= '';
		string2		AR2BI			:= '';
		string1		company_status		:= '';
		string3		additional_score_1 	:= '';
		string3		additional_score_2 	:= '';
		string4		PRI1				:= '';
		string4		PRI2				:= '';
		string4		PRI3				:= '';
		string4		PRI4				:= '';
		string4		PRI5				:= '';
		string4		PRI6				:= '';
		string4		PRI7				:= '';
		string4		PRI8				:= '';
		string120		bestCompanyName	:= '';
		string3 		bestCompanyNamescore := '';
		string50		bestAddr			:= '';
		string25		bestCity			:= '';
		string2		bestState			:= '';
		string5		bestZip			:= '';
		string4		bestZip4			:= '';
		string3		bestAddrScore		:= '';
		//string9		bestFEIN			:= '';
		string3		bestFEINScore		:= '';
		string10		bestPhone			:= '';
		string3		bestPhoneScore		:= '';
		//Phone Match Addr
		/* ----- DONE -------- */
		string20 		PhoneMatchFirst	:= '';
		//string20		PhoneMatchLast		:= '';
		string120		PhoneMatchCompany	:= '';
		string50		phoneMatchAddr		:= '';
		string25		PhoneMatchCity		:= '';
		string2		phoneMatchState	:= '';
		string5		phoneMatchZip		:= '';
		string4		phoneMatchZip4		:= '';
		string10		CmpyPhoneFromAddr	:= '';
		//FEIN Match Addr
		/* ------- Done --------- */
		string120		FEINMatchCompany1	:= '';
		string50		FEINMatchAddr1		:= '';
		string25		FEINMatchCity1		:= '';
		string2		FEINMatchState1	:= '';
		string5		FEINMatchZip1		:= '';
		string4		FEINMatchZip4_1	:= '';
		string120		FEINMatchCompany2	:= '';
		string50		FEINMatchAddr2		:= '';
		string25		FEINMatchCity2		:= '';
		string2		FEINMatchState2	:= '';
		string5		FEINMatchZip2		:= '';
		string4		FEINMatchZip4_2	:= '';
		string120		FEINMatchCompany3	:= '';
		string50		FEINMatchAddr3		:= '';
		string25		FEINMatchCity3		:= '';
		string2		FEINMatchState3	:= '';
		string5		FEINMatchZip3		:= '';
		string4		FEINMatchZip4_3	:= '';
		//Business Addr and Phone Type and Validity Flags
		/*-------- PARTLY DONE ------------*/
		string1		BAddrType			:= ''; // ?
		string1		BPhoneType 		:= ''; // ?
		string1		TelcordiaPhoneType  := '';
		string1 		addrvalidflag 		:= '';
		string1 		feinvalidflag		:= '';
		string1		phonevalidflag		:= '';
		string1		wrongphoneflag		:= '';
		string1 		hriskphoneflag		:= '';
		string1 		hriskaddrflag		:= '';
		string1		resAddrFlag		:= '';
		string1		resPhoneFlag		:= '';
		string1		phonedisflag		:= '';
		string1		phonezipmismatch	:= '';
		string6		hrisksic			:= '';
		//Bankruptcy Info 
		/* --------- DONE ------------- */
		string1 		bkfeinflag 		:= '';  // bankrupt fein
		string1 		bkbdidflag 		:= '';  // bankrupt bdid
		string3		bankruptcy_count	:= '';
		string120		RecentBkName		:= '';
		string50		RecentBkAddr		:= '';
		string25		RecentBkCity		:= '';
		string2		RecentBkState		:= '';
		string5		RecentBkZip		:= '';
		string4		RecentBkZip4		:= '';
		string5		RecentBktype		:= '';
		string8		RecentBkDate		:= '';
		//Lien/Judgement Info (count is later)
		/* --------- DONE ------------- */
		string1		lienbdidflag		:= '';
		string3		UnreleasedLienCount := '';
		string3		ReleasedLienCount	:= '';
		string120		RecentLienName		:= '';
		string50		RecentLienAddr		:= '';
		string25		RecentLienCity		:= '';
		string2		RecentLienState	:= '';
		string5		RecentLienZip		:= '';
		string4		RecentLienZip4		:= '';
		string8		RecentLienDate		:= '';
		string50		RecentLienType		:= '';			
		string3	 	numucc			:= '';  // number of ucc filings
		string16		lien_total		:= '';  // sum of all liens and judgements, released and unreleased
		
		//  BDID source record dates and counts
		/* ----- DONE -------- */
		string8 	dt_first_seen_min 	:= '';     // min for all base records
		string8 	dt_last_seen_max 	:= '';     // max for all base records
		/*
		string8 	dt_vendor_first_reported_min := ''; // min for all base records
		string8 	dt_first_seen_Y 	:= '';	// min for a current YP record
		string8 	dt_last_seen_Y 	:= '';	// max for a current YP record
		string8 	dt_first_seen_G 	:= '';	// min for a current Gong record
		string8 	dt_last_seen_G 	:= '';	// max for a current Gong record
		string8 	dt_first_seen_C	:= '';	// min for a Corporate record
		string8 	dt_last_seen_C 	:= '';	// max for a Corporate record
		*/
		// OFAC/Watchlist Info
		/* ----- DONE -------- */
		STRING60 		watchlist_table 	:= '';
		STRING10 		watchlist_record_number := '';
		STRING120   watchlist_program :='';
		STRING120	 	watchlist_cmpy 	:= '';
		STRING50 		watchlist_address 	:= '';
		STRING25 		watchlist_city 	:= '';
		STRING2 		watchlist_state 	:= '';
		STRING9 		watchlist_zip 		:= '';
		STRING30 		watchlist_country 	:= '';
		//INTEGER 		watchlist_num_with_name := '';
		string20		watchlist_fname	:= '';  
		string20		watchlist_lname	:= '';  
		
		//Representative Indicators
		/* --------- DONE --------------*/
		string12		RepDID			:= '';
		
		// modelers still want to see this as 2 fields instead of 1, so changing just the flat layout for now
		string1		repFNameVerFlag	:= '';
		string1		repLNameVerFlag	:= '';
		// string1		repNameVerFlag	:= '';
		
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
		string20  	RepCountyVerify := '';
		string1		RepPhoneVerFlag	:= '';
		string10		RepPhoneVerify		:= '';
		string1		RepSSNVerFlag		:= '';
		string9		RepSSNVerify		:= '';
		string1		RepDobVerFlag		:= '';
		string8		RepDOBVerify		:= ''; 
		string2		RepNAS_Score		:= ''; // Name_Addr_SSN
		string2		RepNAP_Score		:= ''; // Name_Addr_Phone
		string2		RepCVI			:= ''; // comp. verification index
		string3		Rep_Additional_score1 := '';
		string3		Rep_Additional_Score2 := '';
		//Rep PRI/Followups
		/* ------- DONE ---------- */
		//dataset(risk_indicators.Layout_Desc)	Rep_PRIs;
		string4		Rep_PRI1				:= '';
		string4		Rep_PRI2				:= '';
		string4		Rep_PRI3				:= '';
		string4		Rep_PRI4				:= '';
		string4		Rep_PRI5				:= '';
		string4		Rep_PRI6				:= '';
		//dataset(risk_indicators.Layout_Desc)	Rep_Followups;
		string4		Rep_FollowUp1			:= '';
		string4		Rep_FollowUp2			:= '';
		string4		Rep_FollowUp3			:= '';
		string4		Rep_FollowUp4			:= '';
		// Rep Best Info
		/* -------- Done ----------*/
		string20		RepBestFname		:= '';
		//string20		RepBestLname		:= '';
		string50		RepBestAddr1		:= '';
		string10		RepBestPrimRange	:= '';
		string28		RepBestPrimName	:= '';
		string8		RepBestSecRange	:= '';
		string25		RepBestCity		:= '';
		string2		RepBestState		:= '';
		string5		RepBestZip		:= '';
		string4		RepBestZip4		:= '';
		string8		RepBestDOB		:= '';
		//string9		RepBestSSN		:= '';
		string10		RepBestPhone		:= '';
		// area code split info
		/* ----- DONE -------- */
		STRING1 		areacodesplitflag 	:= '';
		STRING8 		areacodesplitdate 	:= '';
		STRING3 		altareacode 		:= '';
		string1		reverse_areacodesplitflag := '';
		string1 		zipclass			:= '';
		// phone search name and addr
		/* ----- DONE -------- */
		string20		RepPhoneFname		:= '';
		//string20		RepPhoneLname		:= '';
		string50		RepPhoneAddr1		:= '';
		string25		RepPhoneCity		:= '';
		string2		RepPhoneState		:= '';
		string5		RepPhoneZip		:= '';
		string4		RepPhoneZip4		:= '';
		string10		RepPhoneFromAddr	:= '';
		// Rep SSN Info
		/* ------ Done ---------*/
		string8		RepSSNEarlyDate	:= '';
		string8		RepSSNLateDate		:= '';
		string2		RepSSNIssueState	:= '';
		string1		RepDeceasedSSN		:= '';
		string1   RepSSNExists := '';

		// Rep OFAC/Watchlist Info
		/* ------ Done ---------*/
		STRING60 		RepWatchlist_table 			:= '';
		STRING10 		RepWatchlist_record_number 	:= '';
		STRING120      RepWatchlist_Program := '';
		STRING20	 	RepWatchlist_lname 			:= '';
		STRING20	 	RepWatchlist_fname 			:= '';
		STRING50 		RepWatchlist_address 		:= '';
		STRING25 		RepWatchlist_city 			:= '';
		STRING2 		RepWatchlist_state 			:= '';
		STRING9 		RepWatchlist_zip 			:= '';
		STRING30 		RepWatchlist_country 		:= '';
		//INTEGER 		RepWatchlist_num_with_name 	:= '';
		STRING50 		RepWatchlist_entity_name		:= '';
		// home/business phone/addr distances  
		string10		homePhoneLat				:= '';
		string11		homePhoneLong				:= '';
		string10		BusPhoneLat				:= '';
		string11		BusPhoneLong				:= '';
		string10		homeAddrLat				:= '';
		string11		homeAddrLong				:= '';
		string5		homePhoneZip				:= '';
		string5		busPhoneZip				:= '';
		string4		dist_HomeAddr_BusAddr		:= '';
		string4		dist_HomePhone_BusAddr		:= '';
		string4		dist_HomeAddr_BusPhone		:= '';
		string4 	 	dist_HomePhone_BusPhone		:= '';
		string4		dist_HomePhone_HomeAddr		:= '';
		string4		dist_BusPhone_BusAddr		:= '';
		// Address History Information
		/* ------- DONE ----------- */
		string50		Hist_Addr_1				:= '';
		string25		Hist_City_1				:= '';
		string2		Hist_State_1				:= '';
		string5		Hist_Zip_1				:= '';
		string4		Hist_Zip4_1				:= '';
		string10		Hist_Phone_1				:= '';
		string6		Hist_Date_Last_Seen_1		:= '';
		string50		Hist_Addr_2				:= '';
		string25		Hist_City_2				:= '';
		string2		Hist_State_2				:= '';
		string5		Hist_Zip_2				:= '';
		string4		Hist_Zip4_2				:= '';
		string10		Hist_Phone_2				:= '';
		string6		Hist_Date_Last_Seen_2		:= '';
		string50		Hist_Addr_3				:= '';
		string25		Hist_City_3				:= '';
		string2		Hist_State_3				:= '';
		string5		Hist_Zip_3				:= '';
		string4		Hist_Zip4_3				:= '';
		string10		Hist_Phone_3				:= '';
		string6		Hist_Date_Last_Seen_3		:= '';
		// Alt Name Info
		/* ------------ DONE -----------*/
		string20		Alt_Fname_1				:= '';
		string20		Alt_Lname_1				:= '';
		string6		Alt_Date_Last_Seen_1		:= '';
		string20		Alt_Fname_2				:= '';
		string20		Alt_Lname_2				:= '';
		string6		Alt_Date_Last_Seen_2		:= '';
		string20		Alt_Fname_3				:= '';
		string20		Alt_Lname_3				:= '';
		string6		Alt_Date_Last_Seen_3		:= '';
		//
		string1		deceasedTIN				:= '';
		
		// Rep Addr, Phone Type, Validity, and Miskey Flags
		string1  	rep_hriskphoneflag	:= '';
		string1	rep_phonevalflag	:= '';
		string1	rep_phonezipmismatch	:= '';
		string1 	rep_hriskaddrflag	:= '';
		STRING1 	rep_socsdobflag := '';
		STRING1 	rep_socsvalflag := '';
		STRING1   rep_drlcvalflag := '';
		STRING1 	rep_addrvalflag := '';
		STRING1 	rep_dwelltype := '';
		STRING1 	rep_bansflag := '';
		string1 	rep_socsmiskeyflag := '';
		string1	rep_phonemiskeyflag := '';
		string1 	rep_addrmiskeyflag := '';
		string2 rep_firstcount := '';
		string2 rep_lastcount := '';
		string2 rep_addrcount := '';
		string2 rep_hphonecount := '';
		string2 rep_ssncount := '';
		string2 rep_dobcount := '';
		string2 rep_numelever := '';
		STRING1 	rep_phonever_type := '';
		string2 rep_header_firstcount := '';
		string2 rep_header_lastcount := '';
		string2 rep_header_addrcount := '';
		string2 rep_header_ssncount := '';
		string2 addrcount := '';  
		string2 cmpycount := '';  
		string2 feincount := '';
		string2 wphonecount := ''; 	
		STRING8 rep_correctdob := '';
		//STRING9 rep_correctssn := '';
		STRING50 rep_correctaddr := '';
		STRING10 rep_correcthphone := '';
		//STRING20 rep_correctlast := '';
		string3 Rep_dirsaddr_lastscore := '';
		STRING1 	rep_areacodesplitflag := '';
		STRING8 	rep_areacodesplitdate := '';
		string1	rep_reverse_areacodesplitflag := '';
		STRING3 	rep_altareacode := '';
		string3 rep_firstscore := '';
		string3 rep_lastscore := '';
		string3 rep_addrscore := '';
		string3 rep_phonescore := '';
		string3 rep_socsscore := '';
		string3 rep_dobscore := '';
		STRING30 	rep_hriskcmpy := '';	
		STRING6 	rep_hrisksic := '';
		string8 	rep_bansdatefiled := '';
		string1	rep_phonedissflag := '';
		string1 	rep_phonetype := '';
		string1 	rep_zipclass := '';	
		
		string1	goodstanding := 'A';
		string1 rep_inputAddrNotMostRecent := '';
		string3 rep_inputsocscode := '';
		string8 sic_code := '';
		string8 naics_code := '';
		string105 business_description := '';
		
	// end of layout_output
	
	// new flags added so that the actual fein, ssn and last names aren't output in the file for security reasons
	string1 bestfein_flag := '';  // if bestfein=fein, set to Y
	string1 repbestssn_flag := ''; // if bestfein=fein, set to Y
	string1 repbestlname_flag := ''; // if bestfein=fein, set to Y
	string1 repbestlname_alt_flag := ''; // if bestfein=fein, set to Y
end;

prs_layout := record
	//unsigned3 zip := '';
	//qstring28 prim_name := '';
	//qstring10 prim_range := '';
	string8 bdid_per_addr := '';
	string8 apts := '';
	string8 ppl := '';
	string8 r_phone_per_addr := '';
	string8 b_phone_per_addr := '';
	string8 dnb_emps := '';
	string8 irs5500_emps := '';
	string8 domainss := '';
	// string3 sources := '';
	// string3 company_name_score := '';
	// string3 combined_score := '';
	// string8 gong_yp_cnt := '';
	// string8 current_corp_cnt := '';
	string8 dt_first_seen_min := '';   // min for all base records
	string8 dt_last_seen_max := '';    // max for all base records
	string8 dt_vendor_first_reported_min := ''; // min for all base records
	string8 dt_first_seen_Y := ''; // min for a current YP record
	string8 dt_last_seen_Y := ''; // max for a current YP record
	string8 dt_first_seen_G := '';// min for a current Gong record
	string8 dt_last_seen_G := '';// max for a current Gong record
	string8 dt_first_seen_C := '';// min for a Corporate record
	string8 dt_last_seen_C := '';// max for a Corporate record
	string8 dt_first_seen_BR := '';// min for a Business Registration record
	string8 dt_last_seen_BR := '';// max for a Business Registration record
	string8 dt_first_seen_UCC := '';// min for a UCC record
	string8 dt_last_seen_UCC := '';// max for a UCC record
	string8 dt_first_seen_D := '';// min for a D&B record
	string8 dt_last_seen_D := '';// max for a D&B record
	string8 dt_first_seen_I := '';// min for a IRS5500 record
	string8 dt_last_seen_I := '';// max for a IRS5500 record
	string8 dt_first_seen_ST := '';// min for a Sales Tax record
	string8 dt_last_seen_ST := '';// max for a Sales Tax record
	string8 dt_last_seen_B := '';// max for a Bankruptcy record
	string8 dt_last_seen_LJ := '';// max for a Liens Judgment record
	string8 dt_first_seen_BM := '';// min for a BBB member record
	string8 dt_last_seen_BM := '';// max for a BBB member record
	string8 dt_first_seen_BN := '';// min for a BBB non-member record
	string8 dt_last_seen_BN := '';// max for a BBB non-member record
	string8 dt_first_seen_IA := '';// min for a InfoUSA record
	string8 dt_last_seen_IA := '';// max for a InfoUSA record
	string8 dt_first_seen_DC := '';// min for a DCA record
	string8 dt_last_seen_DC := '';// max for a DCA record
	string8 dt_first_seen_EB := '';// min for a Experian Business Header record
	string8 dt_last_seen_EB := '';// max for a Experian Business Header record
	// Gong indicators
	string1 gong_current_record_flag := 'N';  
	string8 gong_deletion_date := '';
	string4 gong_disc_cnt6 := '';
	string4 gong_disc_cnt12 := '';
	string4 gong_disc_cnt18 := '';
	// source record counts
	string4 cnt_base := ''; // base record count
	string4 cnt_AE := ''; // Experian Vehicles
	string4 cnt_AF := ''; // ATF Firearms and Explosives
	string4 cnt_AT := ''; // Accurint Trade Show
	string4 cnt_AW := ''; // Watercraft
	string4 cnt_B  := ''; // Bankruptcy
	string4 cnt_BM := ''; // BBBB Members
	string4 cnt_BN := ''; // BBB Non-Members
	string4 cnt_BR := ''; // Business Registration
	string4 cnt_C  := ''; // Corporate
	string4 cnt_CU := ''; // Credit Unions
	string4 cnt_D  := ''; // Dun & Bradstreet
	string4 cnt_DC := ''; // DCA - Directory of Corporate Affiliations
	string4 cnt_DE := ''; // DEA
	string4 cnt_E  := ''; // Edgar
	string4 cnt_EB := ''; // Experian Business Header
	string4 cnt_ED := ''; // Employee Directories
	string4 cnt_F  := ''; // Fictitious Business Names
	string4 cnt_FA := ''; // FAA Aircraft Registrations
	string4 cnt_FC := ''; // FCC Radio Licenses
	string4 cnt_FD := ''; // FDIC
	string4 cnt_FF := ''; // Florida FBN
	string4 cnt_FN := ''; // Florida Non-Profit
	string4 cnt_GB := ''; // Gong Business
	string4 cnt_GG := ''; // Gong Government
	string4 cnt_I  := ''; // IRS 5500
	string4 cnt_IA := ''; // INFOUSA ABIUS(USABIZ)
	string4 cnt_ID := ''; // INFOUSA DEAD COMPANIES
	string4 cnt_IF := ''; // INFOUSA FBNS
	string4 cnt_II := ''; // INFOUSA IDEXEC
	string4 cnt_IN := ''; // IRS Non-Profit
	string4 cnt_LJ := ''; // Liens and Judgments
	string4 cnt_LB := ''; // Lobbyists
	string4 cnt_LP := ''; // LN Property
	string4 cnt_MD := ''; // Medical Information Directory
	string4 cnt_MV := ''; // Motor Vehicles
	string4 cnt_PL := ''; // Professional Licenses
	string4 cnt_PR := ''; // Property File
	string4 cnt_SB := ''; // SEC Broker/Dealer
	string4 cnt_SK := ''; // SK&A Medical Professionals
	string4 cnt_ST := ''; // State Sales Tax
	string4 cnt_U  := ''; // UCC
	string4 cnt_V  := ''; // Vickers
	string4 cnt_W  := ''; // Domain Registrations (WHOIS)
	string4 cnt_WC := ''; // State Workers Comp
	string4 cnt_WT := ''; // Wither and Die
	string4 cnt_Y  := ''; // Yellow Pages
	string3 PRScore := '';
	string8 PRScore_date := '';
	string3 busreg_flag := '';
	string3 corp_flag := '';
	string3 dnb_flag := '';
	string3 irs5500_flag := '';
	string3 st_flag := '';
	string3 ucc_flag := '';
	string3 yp_flag := '';
	string3 tier1srcs := '';
	string3 t1scr5 := '';
	string3 currphn := '';
	string3 currcorp := '';
	string3 currbr := '';
	string3 currdnb := '';
	string3 currucc := '';
	string3 curry := '';
	string3 currt1cnt := '';
	string3 currt1src4 := '';
	string4 year_lj := '';
	string3 lj := '';
	string3 ustic := '';
	string3 t1x := '';
	// string4 OFAC_cnt := '';
end;

export Layout_Business_Shell_Flat := record
	biid_layout biid;
	prs_layout prs;
	string6 history_date;
	// string1 lf;
end;