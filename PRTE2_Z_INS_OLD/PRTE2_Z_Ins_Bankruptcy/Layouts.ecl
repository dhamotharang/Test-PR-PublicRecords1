//--------------------------------------------------------------------
// PRTE2_Bankruptcy.Layouts
// Project on hold.
// CT Bankruptcy are done as part of Alpharetta based simulator CompReport
//--------------------------------------------------------------------

IMPORT PRTE2_Bankruptcy ,PRTE_CSV;

EXPORT Layouts := MODULE

	EXPORT status		:= PRTE_CSV.BK_Key_Layouts.status;
	EXPORT comments	:= PRTE_CSV.BK_Key_Layouts.comments;
	EXPORT main			:= PRTE_CSV.BK_Key_Layouts.mainV3;
	EXPORT search		:= PRTE_CSV.BK_Key_Layouts.searchV3;

//----------------------------------------------------------------------------------------------------------------
// The layouts "Alpha_Check_xxxxxxxxxxx"  are for checking CSV layout at spray proces (comparing to Boca Layout).
//----------------------------------------------------------------------------------------------------------------

	EXPORT Alpha_Check_status := RECORD
		string50 tmsid;
		string8 status_date;
		string30 status_type;
		string10	bug_num;
		string100	cust_name;
	END;

	EXPORT Alpha_Check_comments := RECORD
		string50 tmsid;
		string8 filing_date;
		string30 description;
		string10	bug_num;
		string100	cust_name;
	END;

	EXPORT Alpha_Check_main	:= RECORD
		string8 process_date;
		string50 tmsid;
		string1 source;
		string12 id;
		string10 seq_number;
		string8 date_created;
		string8 date_modified;
		string1 method_dismiss;
		string1 case_status;
		string5 court_code;
		string50 court_name;
		string40 court_location;
		string7 case_number;
		string25 orig_case_number;
		string8 date_filed;
		string12 filing_status;
		string3 orig_chapter;
		string8 orig_filing_date;
		string5 assets_no_asset_indicator;
		string1 filer_type;
		string8 meeting_date;
		string8 meeting_time;
		string90 address_341;
		string8 claims_deadline;
		string8 complaint_deadline;
		string35 judge_name;
		string5 judges_identification;
		string2 filing_jurisdiction;
		string20 assets;
		string20 liabilities;
		string1 casetype;
		string1 assoccode;
		string25 splitcase;
		string25 filedinerror;
		string8 date_last_seen;
		string8 date_first_seen;
		string8 date_vendor_first_reported;
		string8 date_vendor_last_reported;
		string8 reopen_date;
		string8 case_closing_date;
		string8 datereclosed;
		string50 trusteename;
		string90 trusteeaddress;
		string25 trusteecity;
		string2 trusteestate;
		string5 trusteezip;
		string4 trusteezip4;
		string10 trusteephone;
		string12 trusteeid;
		string12 caseid;
		string8 bardate;
		string7 transferin;
		string250 trusteeemail;
		string8 planconfdate;
		string8 confheardate;
		string5 title;
		string20 fname;
		string20 mname;
		string20 lname;
		string5 name_suffix;
		string3 name_score;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 p_city_name;
		string25 v_city_name;
		string2 st;
		string5 zip;
		string4 zip4;
		string4 cart;
		string1 cr_sort_sz;
		string4 lot;
		string1 lot_order;
		string2 dbpc;
		string1 chk_digit;
		string2 rec_type;
		string5 county;
		string10 geo_lat;
		string11 geo_long;
		string4 msa;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
		string12 did;
		string9 app_ssn;
		string1 delete_flag;
		unsigned8  ScrubsBits1;
	END;

	EXPORT Alpha_Check_search := RECORD
		string8		process_date;
		string12	caseID;
		string12	defendantID;
		string12	recID;
		string50	TMSID ;
		string10	seq_number;
		string5		court_code;
		string7		case_number;
		string25	orig_case_number;
		string3		chapter;
		string1		filing_type;
		string1		business_flag;
		string1		corp_flag;
		string8		discharged;
		string35	disposition;
		string3		pro_se_ind;
		string8		converted_date;
		string30	orig_county;	
		string2		debtor_type ;
		string3		debtor_seq;
		string9		ssn ;
		string1		ssnSrc;
		string9		ssnMatch;
		string1		ssnMSrc;
		string1		screen;
		string2		dCode;
		string3		dispType;
		string3		dispReason;
		string8		statusDate;
		string8		holdCase;
		string8		dateVacated;
		string8		dateTransferred;	
		string12	activityReceipt;	
		string9		tax_id ; 
		string2		name_type; 
		string200	orig_name; 
		string50	orig_fname ;
		string30	orig_mname ;
		string50	orig_lname ;
		string5		orig_name_suffix;

	//--------- address.Layout_Clean_Name; ---------
		string5  title;
		string20 fname;
		string20 mname;
		string20 lname;
		string5  name_suffix;
		string3  name_score;
	//----------------------------------------------

		string150	cname; 
		string150	orig_company;
		string80	orig_addr1;
		string80	orig_addr2;
		string80   	orig_city;
		string2    	orig_st; 
		string5    	orig_zip5; 
		string4    	orig_zip4;
		string250   orig_email :='';
		string10 		orig_fax;

	//---------	address.Layout_Clean182; -----------
		string10        prim_range; 	// [1..10]
		string2         predir;		// [11..12]
		string28        prim_name;	// [13..40]
		string4         addr_suffix;  // [41..44]
		string2         postdir;		// [45..46]
		string10        unit_desig;	// [47..56]
		string8         sec_range;	// [57..64]
		string25        p_city_name;	// [65..89]
		string25        v_city_name;  // [90..114]
		string2         st;			// [115..116]
		string5         zip;		// [117..121]
		string4         zip4;		// [122..125]
		string4         cart;		// [126..129]
		string1         cr_sort_sz;	// [130]
		string4         lot;		// [131..134]
		string1         lot_order;	// [135]
		string2         dbpc;		// [136..137]
		string1         chk_digit;	// [138]
		string2         rec_type;	// [139..140]
		string5         county;		// [141..145]
		string10        geo_lat;		// [146..155]
		string11        geo_long;	// [156..166]
		string4         msa;		// [167..170]
		string7         geo_blk;		// [171..177]
		string1         geo_match;	// [178]
		string4         err_stat;	// [179..182]
	//----------------------------------------------

		string10   	phone ; 
		string12   	DID  := '';
		string12   	BDID := '';
		string9    	app_SSN := '';
		string9    	app_tax_id := '';
		string8    	date_first_seen := '';
		string8    	date_last_seen := '';
		string8    	date_vendor_first_reported := '';
		string8    	date_vendor_last_reported := '';
		string35  	dispTypeDesc;
		string35  	srcDesc;
		string35  	srcMtchDesc;
		string35  	screenDesc;
		string35  	dcodeDesc;	
		string8		date_filed; 
		string128	record_type;
		string1 delete_flag := '';

	//----------	bipv2.IDlayouts.l_xlink_ids; ----------	 //Added for BIP project
		unsigned6 DotID			:= 0;
		unsigned2	DotScore	:= 0;
		unsigned2	DotWeight	:= 0;
		unsigned6 EmpID			:= 0;
		unsigned2	EmpScore	:= 0;
		unsigned2	EmpWeight	:= 0;
		unsigned6 POWID			:= 0;
		unsigned2	POWScore	:= 0;
		unsigned2	POWWeight	:= 0;
		unsigned6 ProxID		:= 0;
		unsigned2	ProxScore	:= 0;
		unsigned2	ProxWeight:= 0;
		unsigned6 SELEID		:= 0;
		unsigned2	SELEScore	:= 0;
		unsigned2	SELEWeight:= 0;	
		unsigned6 OrgID			:= 0;
		unsigned2	OrgScore	:= 0;
		unsigned2	OrgWeight	:= 0;
		unsigned6 UltID			:= 0;
		unsigned2	UltScore	:= 0;
		unsigned2	UltWeight	:= 0;	
	//---------------------------------------------------

		unsigned8 source_rec_id := 0;
		unsigned8  ScrubsBits1;
		string10	bug_num;
		string100	cust_name;
	END;


END;