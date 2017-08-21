import address;

export layout_bankruptcy_main_temp :=  record
    string8		process_date;
    string50   	TMSID ;
    string1	   	source;
    string12   	id;
    string10   	seq_number;
    string8    	date_created;
    string8    	date_modified;
    string5    	court_code;
    string50   	court_name;
    string40   	court_location;
    string7    	case_number;
    string25   	orig_case_number;
    string8    	date_filed;
    string12   	filing_status;
    string3    	orig_chapter;
    string8    	orig_filing_date;
    string5    	assets_no_asset_indicator;
    string1	   	filer_type;
    string8    	meeting_date;
    string8    	meeting_time;
    string90   	address_341;
    string8    	claims_deadline;
    string8    	complaint_deadline;
    string35   	judge_name;
    string5    	judges_identification;
    string2    	filing_jurisdiction ;
    string20   	assets := '';
    string20   	liabilities := '';
    string1    	CaseType := '';
    string1    	AssocCode:= '';
	string25   	SplitCase := '';	
    string25   	FiledInError := '';
	string8    	date_last_seen ; 
    string8    	date_first_seen ;
	string8    	date_vendor_first_reported := '';
    string8    	date_vendor_last_reported := '';
    string8	   	reopen_date;
    string8    	case_closing_date;
    string8    	dateReclosed := '';	
    string50	trusteeName;
    string90	trusteeAddress;
    string25	trusteeCity;
    string2		trusteeState;
    string5		trusteeZip;
    string4		trusteeZip4;
    string10	trusteePhone;
    string12	trusteeID;
    string12	caseID;
    string8		barDate;
	string7		transferIn;
	address.Layout_Clean_Name;
	address.Layout_Clean182;
	string12	DID  := '';
	string9		app_SSN := '';	
	string8    	status_date;
	string30   	status_type;
	string30   	description := '';	
	string8    	filing_date;
 end;