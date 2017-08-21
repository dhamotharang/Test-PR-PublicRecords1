import BankruptcyV2, ut,address; 

pDataset := BankruptcyV2.file_bankruptcy_main_v3;//(process_date = '20141201');

layout_id := {bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp, unsigned8 unique_id} ; 

layout_id tid(pDataset L,unsigned8 cnt) :=
     transform
				
					self.unique_id		:= cnt	;						
					self := L;
		  end;

 In_bk_mainId  := project(pDataset,tid(left,counter));
	
 layout_slim := record, maxlength(32766)
	string8    	process_date;
	string50   	TMSID ;
	string1	   	source;
	string12   	id;
	string10   	seq_number;
	string8    	date_created;
	string8    	date_modified;
	string1    	method_dismiss := '';
	string1     case_status := '';
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
	string20   	assets ;
	string20   	liabilities;
	string1    	CaseType;
	string1    	AssocCode;
	string25 	SplitCase;	
	string25   	FiledInError;
	string8		date_last_seen ; 
	string8		date_first_seen ;
	string8		date_vendor_first_reported := '';
	string8		date_vendor_last_reported := '';
	string8	   	reopen_date;
	string8    	case_closing_date; 
	string8    	dateReclosed;	
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
	string250		trusteeEmail := ''; 			
  string8 		planConfDate := ''; 		
  string8  		confHearDate := ''; 		
	address.Layout_Clean_Name;
	address.Layout_Clean182;
	string12	DID  := '';
	string9		app_SSN := '';
	string1 delete_flag := '';
  unsigned8 unique_id ; 
	//dataset(layout_status)   status;
	//dataset(layout_comments) comments; 
end;

	EXPORT In_bk_main  := project(In_bk_mainId,layout_slim);
	
	
	