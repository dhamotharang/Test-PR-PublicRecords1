/*2012-09-17T19:12:42Z (Ken Hill)
111402 -- BIID return all risk indicators
*/
import risk_indicators, iesp;

s := Business_Risk.Layout_SIC_Code;

Rep_Attributes := RECORD
	STRING32 Name := '';
	STRING128 Value := '';
END;

export Layout_Output := record
	Layout_Input;
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
	boolean		verNotRecentFlag	:= false;
	STRING120 	vercmpy 			:= '';
	STRING50 		veraddr 			:= '';
	STRING25 		vercity 			:= '';
	STRING2 		verstate 			:= '';
	STRING5 		verzip 			:= '';
	STRING4     	verzip4			:= '';
	string20 		vercounty := '';
	STRING10 		verphone 			:= '';
	STRING9 		verfein 			:= '';
	unsigned2		feinscore 		:= 0;
	unsigned2		addrscore 		:= 0;
	unsigned2		phonescore 		:= 0;
	unsigned2		cnamescore 		:= 0;
	boolean		addrMiskeyFlag		:= false;
	boolean		cmpyMiskeyFlag		:= false;
		//Counts ~Mindy
	unsigned2	CmpyFound			 := 0;
	unsigned2	AddrFound			 := 0;
	unsigned2	PhoneFound		 := 0;
	unsigned2	phonecmpycount 	 := 0;
	unsigned2	phoneaddrcount 	 := 0;
	unsigned2	cmpyaddrcount 	 	 := 0;
	unsigned2	phonecmpyaddrcount	 := 0;
	
	// BNAP (score 0-6) -- Name/Addr/Phone score
	/* ----- DONE -------- */
	string1		BNAP_Indicator		:= '';
	boolean		phoneMiskeyFlag	:= false;
	// BNAT (score 0-7) -- Name/Addr/Fein score
	/* ----- DONE -------- */
	string1		BNAT_Indicator 	:= '';
	boolean		feinMiskeyFlag		:= false;
	boolean		multisrcaddr		:= false;
	boolean		multisrcaddrp		:= false;
	boolean		multisrccmpy		:= false;
	boolean		multisrccmpyp		:= false;
	// BNAS (score 0-3) -- Name/Addr/SSN score
	/* ----- DONE -------- */
	string1		BNAS_Indicator 	:= '';
	// BVI (score 00-50) -- Business Verification Index
	/* ----- DONE -------- */
	string2		BVI				:= '';
	// AR2BI (score 00 - 50) -- Authd Rep Rel to Bus Indicator
	string2		AR2BI			:= '';
	// 'additional scores' fields
	/* ----- DONE -------- */
	string1		company_status		:= '';
	string3		additional_score_1 	:= '';
	string3		additional_score_2 	:= '';
	// Potential Risk Indicators
	/* ----- DONE -------- */
	//dataset(risk_indicators.Layout_Desc)	PRIs;
	string4		PRI1				:= '';
	string4		PRI2				:= '';
	string4		PRI3				:= '';
	string4		PRI4				:= '';
	string4		PRI5				:= '';
	string4		PRI6				:= '';
	string4		PRI7				:= '';
	string4		PRI8				:= '';
	//Best Info
	/* ----- DONE -------- */
	string120		bestCompanyName	:= '';
	UNSIGNED1 	bestCompanyNamescore := 0;
	string50		bestAddr			:= '';
	string25		bestCity			:= '';
	string2		bestState			:= '';
	string5		bestZip			:= '';
	string4		bestZip4			:= '';
	unsigned1		bestAddrScore		:= 0;
	string9		bestFEIN			:= '';
	unsigned1		bestFEINScore		:= 0;
	string10		bestPhone			:= '';
	unsigned1		bestPhoneScore		:= 0;
	//Phone Match Addr
	/* ----- DONE -------- */
	string20 		PhoneMatchFirst	:= '';
	string20		PhoneMatchLast		:= '';
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
	string2		nxx_type			:= '';
	string1 		addrvalidflag 		:= '';
	string1 		feinvalidflag		:= '';
	string1		phonevalidflag		:= '';
	string1		wrongphoneflag		:= '';
	string1 		hriskphoneflag		:= '';
	string1 		hriskaddrflag		:= '';
	string1		resAddrFlag		:= '';
	string1		resPhoneFlag		:= '';
	boolean		phonedisflag		:= false;
	boolean		phonezipmismatch	:= false;
	string6		hrisksic			:= '';
	//Bankruptcy Info 
	/* --------- DONE ------------- */
	boolean 		bkfeinflag 		:= false;  // bankrupt fein
	boolean 		bkbdidflag 		:= false;  // bankrupt bdid
	unsigned2		bankruptcy_count	:= 0;
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
	boolean		lienbdidflag		:= false;
	unsigned2		UnreleasedLienCount := 0;
	unsigned2		ReleasedLienCount	:= 0;
	string120		RecentLienName		:= '';
	string50		RecentLienAddr		:= '';
	string25		RecentLienCity		:= '';
	string2		RecentLienState	:= '';
	string5		RecentLienZip		:= '';
	string4		RecentLienZip4		:= '';
	string8		RecentLienDate		:= '';
	string50		RecentLienType		:= '';			
	unsigned2 	numucc			:= 0;  // number of ucc filings
	unsigned4		lien_total		:= 0;  // sum of all liens and judgements, released and unreleased
	
	//  BDID source record dates and counts
	/* ----- DONE -------- */
	unsigned4 	dt_first_seen_min 	:= 0;     // min for all base records
	unsigned4 	dt_last_seen_max 	:= 0;     // max for all base records
	/*
	unsigned4 	dt_vendor_first_reported_min := 0; // min for all base records
	unsigned4 	dt_first_seen_Y 	:= 0;	// min for a current YP record
	unsigned4 	dt_last_seen_Y 	:= 0;	// max for a current YP record
	unsigned4 	dt_first_seen_G 	:= 0;	// min for a current Gong record
	unsigned4 	dt_last_seen_G 	:= 0;	// max for a current Gong record
	unsigned4 	dt_first_seen_C	:= 0;	// min for a Corporate record
	unsigned4 	dt_last_seen_C 	:= 0;	// max for a Corporate record
	*/
	// OFAC/Watchlist Info
	/* ----- DONE -------- */
	STRING60 		watchlist_table 	:= '';
	STRING10 		watchlist_record_number := '';
	STRING120   watchlist_program :='';
	UNICODE120	 	watchlist_cmpy 	:= '';
	STRING50 		watchlist_address 	:= '';
	STRING25 		watchlist_city 	:= '';
	STRING2 		watchlist_state 	:= '';
	STRING9 		watchlist_zip 		:= '';
	STRING30 		watchlist_country 	:= '';
	INTEGER 		watchlist_num_with_name := 0;
	UNICODE20		watchlist_fname	:= '';  
	UNICODE20		watchlist_lname	:= ''; 
	boolean inputBusAddrNotMostRecent := false;
	
	//Representative Indicators
	/* --------- DONE --------------*/
	unsigned6		RepDID			:= 0;
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
	string20  RepCountyVerify := '';
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
	string20		RepBestLname		:= '';
	string50		RepBestAddr1		:= '';
	string10		RepBestPrimRange	:= '';
	string28		RepBestPrimName	:= '';
	string8		RepBestSecRange	:= '';
	string25		RepBestCity		:= '';
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
	string1		reverse_areacodesplitflag := '';
	string1 		zipclass			:= '';
	string28		zipcity				:= '';
	// phone search name and addr
	/* ----- DONE -------- */
	string20		RepPhoneFname		:= '';
	string20		RepPhoneLname		:= '';
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
	boolean   RepSSNExists := true;
	// Rep OFAC/Watchlist Info
	/* ------ Done ---------*/
	STRING60 		RepWatchlist_table 			:= '';
	STRING10 		RepWatchlist_record_number 	:= '';
	STRING120   RepWatchlist_Program := '';
	UNICODE20	 	RepWatchlist_lname 			:= '';
	UNICODE20	 	RepWatchlist_fname 			:= '';
	STRING50 		RepWatchlist_address 		:= '';
	STRING25 		RepWatchlist_city 			:= '';
	STRING2 		RepWatchlist_state 			:= '';
	STRING9 		RepWatchlist_zip 			:= '';
	STRING30 		RepWatchlist_country 		:= '';
	INTEGER 		RepWatchlist_num_with_name 	:= 0;
	UNICODE50 		RepWatchlist_entity_name		:= '';
	// home/business phone/addr distances  
	string10		homePhoneLat				:= '';
	string11		homePhoneLong				:= '';
	string10		BusPhoneLat				:= '';
	string11		BusPhoneLong				:= '';
	string10		homeAddrLat				:= '';
	string11		homeAddrLong				:= '';
	string5		homePhoneZip				:= '';
	string5		busPhoneZip				:= '';
	unsigned2		dist_HomeAddr_BusAddr		:= 9999;
	unsigned2		dist_HomePhone_BusAddr		:= 9999;
	unsigned2		dist_HomeAddr_BusPhone		:= 9999;
	unsigned2 	dist_HomePhone_BusPhone		:= 9999;
	unsigned2		dist_HomePhone_HomeAddr		:= 9999;
	unsigned2		dist_BusPhone_BusAddr		:= 9999;
	// Address History Information
	/* ------- DONE ----------- */
	string50		Hist_Addr_1				:= '';
	string25		Hist_City_1				:= '';
	string2		Hist_State_1				:= '';
	string5		Hist_Zip_1				:= '';
	string4		Hist_Zip4_1				:= '';
	string10		Hist_Phone_1				:= '';
	unsigned3		Hist_Date_Last_Seen_1		:= 0;
	string50		Hist_Addr_2				:= '';
	string25		Hist_City_2				:= '';
	string2		Hist_State_2				:= '';
	string5		Hist_Zip_2				:= '';
	string4		Hist_Zip4_2				:= '';
	string10		Hist_Phone_2				:= '';
	unsigned3		Hist_Date_Last_Seen_2		:= 0;
	string50		Hist_Addr_3				:= '';
	string25		Hist_City_3				:= '';
	string2		Hist_State_3				:= '';
	string5		Hist_Zip_3				:= '';
	string4		Hist_Zip4_3				:= '';
	string10		Hist_Phone_3				:= '';
	unsigned3		Hist_Date_Last_Seen_3		:= 0;
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
	boolean 	rep_socsmiskeyflag := false;
	boolean	rep_phonemiskeyflag := false;
	boolean 	rep_addrmiskeyflag := false;
	UNSIGNED1 rep_firstcount := 0;
	UNSIGNED1 rep_lastcount := 0;
	UNSIGNED1 rep_addrcount := 0;
	UNSIGNED1 rep_hphonecount := 0;
	UNSIGNED1 rep_ssncount := 0;
	UNSIGNED1 rep_dobcount := 0;
	unsigned1 rep_numelever := 0;
	STRING1 	rep_phonever_type := '';
	unsigned1 rep_header_firstcount := 0;
	unsigned1 rep_header_lastcount := 0;
	unsigned1 rep_header_addrcount := 0;
	unsigned1 rep_header_ssncount := 0;
	UNSIGNED1 addrcount := 0;  
	UNSIGNED1 cmpycount := 0;  
	UNSIGNED1 feincount := 0;
	UNSIGNED1 wphonecount := 0; 	
	STRING8 rep_correctdob := '';
	STRING9 rep_correctssn := '';
	STRING50 rep_correctaddr := '';
	STRING10 rep_correcthphone := '';
	STRING20 rep_correctlast := '';
	UNSIGNED1 Rep_dirsaddr_lastscore := 0;
	STRING1 	rep_areacodesplitflag := '';
	STRING8 	rep_areacodesplitdate := '';
	string1	rep_reverse_areacodesplitflag := '';
	STRING3 	rep_altareacode := '';
	UNSIGNED1 rep_firstscore := 0;
	UNSIGNED1 rep_lastscore := 0;
	UNSIGNED1 rep_addrscore := 0;
	UNSIGNED1 rep_phonescore := 0;
	UNSIGNED1 rep_socsscore := 0;
	UNSIGNED1 rep_dobscore := 0;
	STRING30 	rep_hriskcmpy := '';	
	STRING6 	rep_hrisksic := '';
	string8 	rep_bansdatefiled := '';
	boolean	rep_phonedissflag := false;
	string1 	rep_phonetype := '';
	string1 	rep_zipclass := '';
	string1	goodstanding := 'A';
	boolean rep_inputAddrNotMostRecent := false;
	string3 rep_inputsocscode := '';
	string8 sic_code := '';
	string8 naics_code := '';
	string105 business_description := '';
	string2   rep_nxx_type  := '';	
	string1 rep_publish_code := '';
	
	unsigned citystatescore := 0;
	unsigned zipscore := 0;
	string1 statezipflag := '';
	string1 cityzipflag := '';
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
	STRING1		Valid_SSN := '';
	DATASET(Rep_Attributes) Attributes{MAXCOUNT(iesp.constants.biid.MAXREPATTRIBUTES)};
	DATASET(risk_indicators.layouts.layout_desc_plus_seq) BusRiskIndicators{MAXCOUNT(iesp.constants.biid.MAXRISKINDICATORS)};
	DATASET(risk_indicators.layouts.layout_desc_plus_seq) RepRiskIndicators{MAXCOUNT(iesp.constants.biid.MAXRISKINDICATORS)};

  unsigned2 royalty_type_code_targus := 0;
  string20  royalty_type_targus := ''; 			
  unsigned2 royalty_count_targus := 0; 			 
  unsigned2 non_royalty_count_targus := 0;  
  string20  count_entity_targus := ''; 

end;	
