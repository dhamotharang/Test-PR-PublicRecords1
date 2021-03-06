import address; 
export layout_bankruptcy_search_v3_supp := record
  
//  string1    source;
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
	address.Layout_Clean_Name;
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
	address.Layout_Clean182;
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
 end; 