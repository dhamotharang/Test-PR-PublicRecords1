IMPORT PRTE2_Bankruptcy, BankruptcyV2, bipv2, BankruptcyV3;

EXPORT Layouts := MODULE
	//Input Layouts
	EXPORT Status := RECORD
		STRING50   	TMSID ;
		BankruptcyV2.layout_bankruptcy_main_v3.layout_status;
		STRING10	bug_num;
		STRING10	cust_name;
	END;
	
	EXPORT Comments := RECORD
		STRING50   	TMSID ;
		BankruptcyV2.layout_bankruptcy_main_v3.layout_comments;
		STRING10	bug_num;
		STRING10	cust_name;
	END;
	
	EXPORT Main	:= RECORD
		BankruptcyV2.layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp - [status ,comments];
		STRING10	bug_num;
		STRING10	cust_name;
		STRING8		link_dob;
		STRING9		link_ssn;
	END;
	
	EXPORT Search := RECORD
		BankruptcyV2.layout_bankruptcy_search_v3_supp_bip;
		STRING10	bug_num;
		STRING10	cust_name;
		STRING8	 	link_dob;
		STRING9		link_ssn;
		STRING8		cust_dob;	
		STRING9		cust_ssn;
		STRING9		link_fein;
		STRING8		link_inc_date;
	END;
	
	//Base Layouts
	EXPORT Main_BaseV2 := RECORD //slim version of V3. Using V3 as base file output and will project in V2 layout when needed
		BankruptcyV2.layout_bankruptcy_main.layout_bankruptcy_main_filing;
	END;
	
	EXPORT Main_BaseV3_ext := RECORD,maxlength(32766) //Includes additional fields added by DI
		BankruptcyV2.layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp_excludescrubs;
		STRING10	bug_num;
		STRING10	cust_name;
		STRING8		link_dob;
		STRING9		link_ssn;
	END;
	
	EXPORT Main_BaseV3 := RECORD,maxlength(32766)
		BankruptcyV2.layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp_excludescrubs;
	END;
	
	EXPORT Main_BaseV3_supp := RECORD
		BankruptcyV2.layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp_excludescrubs;
	END;
	
	EXPORT Search_Base_ext := RECORD //Includes additional fields added by DI
		BankruptcyV2.layout_bankruptcy_search_v3_supp_bip - scrubsbits1;
		STRING10	bug_num;
		STRING10	cust_name;
		STRING8	 	link_dob;
		STRING9		link_ssn;
		STRING9		link_fein;
		STRING8		link_inc_date;
	END;
	
	EXPORT Search_Base := RECORD
		BankruptcyV2.layout_bankruptcy_search_v3_supp_bip - scrubsbits1;
	END;
	
	EXPORT WithdrawnStatus_Base := RECORD
		BankruptcyV3.Layout_BankruptcyV3_WithdrawnStatus.wsBase;
		string20 cust_name;
		string10 bug_name;
	END;
	
	//BankruptcyV2 key layouts
	EXPORT lkey_bankruptcyv2_search_tmsid := RECORD
		BankruptcyV2.layout_bankruptcy_search;
		bipv2.IDlayouts.l_xlink_ids;
	END;
	
	EXPORT lkey_bankruptcyv2_ssn := RECORD
		string9 ssn;
		string50 tmsid;
	END;
	
 //BankruptcyV3 Layouts
	EXPORT lkey_ssn4st :=	RECORD
		string4 ssnlast4;
		string2 state;
		string150 lname;
		string50 fname;
		string50 tmsid;
	END;

	EXPORT lkey_ssnmatch := RECORD
		string9 ssnmatch;
		string50 tmsid;
	END;

	EXPORT Key_WithdrawnStatus := record
		BankruptcyV3.Layout_BankruptcyV3_WithdrawnStatus.wsKey;
	END;
	
END;
		