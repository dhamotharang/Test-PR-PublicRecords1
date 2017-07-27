import BankruptcyV2,MDR;

export Bankruptcy_AsMasters := module(Interface_AsMasters.Unlinked.Default)

   shared base_main       := BankruptcyV2.file_bankruptcy_main_v3;   // main bankruptcy case & trustee info
   shared base_search     := BankruptcyV2.file_bankruptcy_search_v3; // debtors & attorneys

  // Extract relationship data
	export dataset(Layout_Relationship.Unlinked) As_Relationship_Master := function
	
		filtered := base_search(tmsid != '' and cname != '');
		
		debtors := filtered(name_type = 'D' and debtor_type != '');
		attorneys := filtered(name_type[1] = 'A');
		
		codebtors := join(debtors,debtors,
			left.tmsid = right.tmsid and
			(left.debtor_type != right.debtor_type or left.debtor_seq != right.debtor_seq),
			transform(Layout_Relationship.Unlinked,
				self.source_1 := MDR.sourceTools.src_Bankruptcy,
				self.source_docid_1 := left.tmsid,
				self.source_party_1 := trim(left.name_type) + trim(left.debtor_type) + trim(left.debtor_seq),
				self.role_1 := 'Bankruptcy Co-debtor',
				self.source_2 := MDR.sourceTools.src_Bankruptcy,
				self.source_docid_2 := right.tmsid,
				self.source_party_2 := trim(right.name_type) + trim(right.debtor_type) + trim(right.debtor_seq),
				self.role_2 := 'Bankruptcy Co-debtor'));
		
		clientattorney := join(debtors,attorneys,
			left.tmsid = right.tmsid,
			transform(Layout_Relationship.Unlinked,
				self.source_1 := MDR.sourceTools.src_Bankruptcy,
				self.source_docid_1 := left.tmsid,
				self.source_party_1 := trim(left.name_type) + trim(left.debtor_type) + trim(left.debtor_seq),
				self.role_1 := 'Client',
				self.source_2 := MDR.sourceTools.src_Bankruptcy,
				self.source_docid_2 := right.tmsid,
				self.source_party_2 := trim(right.name_type) + trim(right.debtor_type) + trim(right.debtor_seq),
				self.role_2 := 'Attorney'));
		
		return dedup(dedup(codebtors + clientattorney,record,all,local),record,all);
	
	end;
	
	export dataset(Layout_Contacts.Unlinked) As_Contact_Master := function

		company_filtered := base_search(tmsid != '' and cname != '');
		person_filtered := base_search(tmsid != '' and lname != '');
		
		codebtors := join(
			company_filtered(name_type = 'D' and debtor_type != ''),
			person_filtered(name_type = 'D' and debtor_type != ''),
			left.tmsid = right.tmsid,
			transform(Layout_Contacts.Unlinked,
				self.source := MDR.sourceTools.src_Bankruptcy,
				self.source_docid := left.tmsid,
				self.source_party := trim(left.name_type) + trim(left.debtor_type) + trim(left.debtor_seq),
 				self.date_first_seen := (unsigned4) left.date_first_seen,
				self.date_last_seen  := (unsigned4) left.date_last_seen,
				self.ssn := right.ssn,
				self.name_prefix := right.title,
				self.name_first := right.fname,
				self.name_middle := right.mname,
				self.name_last := right.lname,
				self.name_suffix := right.name_suffix,
				self.city_name := right.p_city_name,
				self.state := right.st,
				self.position_title := 'OWNER',
				self.position_type := 'C',
				self.email := '',
				self := right));
		
		attorneyclient := join(
			company_filtered(name_type = 'D' and debtor_type != ''),
			person_filtered(name_type[1] = 'A'),
			left.tmsid = right.tmsid,
			transform(Layout_Contacts.Unlinked,
				self.source := MDR.sourceTools.src_Bankruptcy,
				self.source_docid := left.tmsid,
				self.source_party := trim(left.name_type) + trim(left.debtor_type) + trim(left.debtor_seq),
 				self.date_first_seen := (unsigned4) left.date_first_seen,
				self.date_last_seen  := (unsigned4) left.date_last_seen,
				self.ssn := right.ssn,
				self.name_prefix := right.title,
				self.name_first := right.fname,
				self.name_middle := right.mname,
				self.name_last := right.lname,
				self.name_suffix := right.name_suffix,
				self.city_name := right.p_city_name,
				self.state := right.st,
				self.position_title := 'ATTORNEY',
				self.position_type := 'O',
				self.email := '',
				self := right));
		
		return codebtors + attorneyclient;
				
	end;
	
	// Extract company_name/address/phone data for the linking layout.
  export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
		
		filtered := base_search(process_date != '' and case_number != '' and cname != '');
		
		extract := normalize(filtered,if(left.v_city_name != left.p_city_name,2,1),
		  transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_Bankruptcy,
				self.source_docid    := left.tmsid, 
				self.source_party    := trim(left.name_type) + trim(left.debtor_type) + trim(left.debtor_seq),
 				self.date_first_seen := (unsigned4) left.date_first_seen,
				self.date_last_seen  := (unsigned4) left.date_last_seen,
				self.company_name    := stringlib.StringToUpperCase(left.cname),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid             := 0,
				self.prim_range      := left.prim_range,
				self.predir          := left.predir,
				self.prim_name       := left.prim_name,
				self.addr_suffix     := left.addr_suffix,
				self.postdir         := left.postdir,
				self.unit_desig      := left.unit_desig,
				self.sec_range       := left.sec_range,
				self.city_name       := choose(counter,left.p_city_name,left.v_city_name),
				self.state           := left.st,
				self.zip             := left.zip,
				self.county_fips     := left.county[3..5],
				self.msa             := left.msa,
				self.phone           := left.phone,
				// all other fields blank because they are not on the bankruptcy base search file
				self.fein            := left.tax_id,
				self.url             := '',
				self.duns            := '',
				self.experian        := '',
				self.zoom := '',
				self.incorp_state    := '',
				self.incorp_number   := '',
		));

    // Can't extract company_names from trustee fields on the mainv3 file because
		// the trustee name is not classified as either a person or company because the vast 
		// majority (or all?) of trustees are people.
	
		return extract;

	end;

  // Extract data for the Bankruptcy Main Unlinked layout.
	export dataset(Layout_Bankruptcy.Main.Unlinked) As_Bankruptcy_Master := function
	   		
		filtered := base_main(process_date != '' and case_number != ''); // and ???

		extract := project(filtered,
		  transform(Layout_Bankruptcy.Main.Unlinked,
				self.source := MDR.sourceTools.src_Bankruptcy,
				self.source_docid        := left.tmsid,
				self.tmsid               := left.tmsid, // ???
				self.case_number         := left.case_number;
        self.chapter             := left.orig_chapter;  //???
	      self.date_filed          := left.date_filed;
	      self.filing_status       := left.filing_status;
		    self.filing_jurisdiction := left.filing_jurisdiction;
				self.court_code          := left.court_code;
	      self.court_name          := left.court_name;
	      self.court_location      := left.court_location;
	      self.casetype            := left.casetype;
	      self.assets              := left.assets; //???
	      self.liabilities         := left.liabilities; //???
	      self.disposition         := ''; // left.???;
	      self.disposed_date       := ''; // left.???; 
	      self.case_closing_date   := left.case_closing_date; 
	      self.orig_case_number    := left.orig_case_number;
	      self.orig_chapter        := left.orig_chapter;
	      self.orig_filing_date    := left.orig_filing_date;
		    self.orig_filing_type    := ''; // left.???
			));

		return dedup(dedup(extract,record,all,local),record,all);

	end;

  // Extract data for the Bankruptcy Party layout.
	export dataset(Layout_Bankruptcy.Party) As_Bankruptcy_Master_Party := function
	   		
		// First extract debtors & attorneys from the search file
		filtered_search := base_search(process_date != '' and case_number != ''); // and ???

		extract_search := join(dedup(base_main,court_code,orig_case_number,tmsid,all),filtered_search,
			left.tmsid = right.tmsid,
		  transform(Layout_Bankruptcy.Party,
				self.court_code   := left.court_code;
				self.orig_case_number := left.orig_case_number;
        self.party_type   := right.name_type;  //???
	      self.debtor_type  := right.debtor_type;
        self.DID          := right.DID;
        self.app_SSN      := right.app_ssn;
        self.ssn          := right.ssn;
        self.app_tax_id   := right.app_tax_id;
        self.tax_id       := right.tax_id; 
		    self.title        := right.title;
	      self.fname        := right.fname;
	      self.mname        := right.mname;
	      self.lname        := right.lname;
	      self.name_suffix  := right.name_suffix;
        self.cname        := right.cname; 
			  self.prim_range   := right.prim_range;
				self.predir       := right.predir;
				self.prim_name    := right.prim_name;
				self.addr_suffix  := right.addr_suffix;
				self.postdir      := right.postdir;
				self.unit_desig   := right.unit_desig;
				self.sec_range    := right.sec_range;
				self.p_city_name  := right.p_city_name;
				self.v_city_name  := right.v_city_name;
				self.st           := right.st;
				self.zip          := right.zip;
        self.zip4         := right.zip4;
        self.phone        := right.phone; 
		    self.timezone     := ''; // ???
			));

		// Next extract trustee info from the main file
		filtered_main := base_main(process_date != '' and case_number != '' and trusteename != '');

		extract_main := project(filtered_main,
		  transform(Layout_Bankruptcy.Party,
				self.court_code   := left.court_code;
				self.orig_case_number := left.orig_case_number;
        self.party_type   := 'TR'; //??? OR Constants.party_type_trustee ???
	      self.debtor_type  := '';
        self.DID          := left.DID;
        self.app_SSN      := left.app_ssn;
        self.ssn          := '';
        self.app_tax_id   := '';
        self.tax_id       := '';
		    self.title        := left.title;
	      self.fname        := left.fname;
	      self.mname        := left.mname;
	      self.lname        := left.lname;
	      self.name_suffix  := left.name_suffix;
        self.cname        := '';
			  self.prim_range   := left.prim_range;
				self.predir       := left.predir;
				self.prim_name    := left.prim_name;
				self.addr_suffix  := left.addr_suffix;
				self.postdir      := left.postdir;
				self.unit_desig   := left.unit_desig;
				self.sec_range    := left.sec_range;
				self.p_city_name  := left.p_city_name;
				self.v_city_name  := left.v_city_name;
				self.st           := left.st;
				self.zip          := left.zip;
        self.zip4         := left.zip4;
        self.phone        := left.trusteephone; 
		    self.timezone     := ''; // ???
			));

		return extract_search + extract_main;

	end;

  // Extract bankruptcy financial fields for the Financial Unlinked layout.
	export dataset(Layout_Finance.Unlinked) As_Finance_Master := function

		filtered := base_main(process_date != '' and case_number != '' and 
		                      (assets !='' or liabilities !=''));
		
		extract := project(filtered,
			transform(Layout_Finance.Unlinked,
				self.source := MDR.sourceTools.src_Bankruptcy,
				self.source_docid     := left.tmsid; 
	      self.TotalAssets      := (integer) left.assets; //???
	      self.TotalLiabilities := (integer) left.liabilities; //???
				self := [])); 
					
		return extract;

  end;

end;

/* Bankruptcy V3 base files:
BankruptcyV2.layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp ???

export layout_bankruptcy_main_filing := record, maxlength(32766)
	string8   process_date;
	string50  TMSID ;
	string1	  source;
	string12  id;
	string10  seq_number;
	string8   date_created;
	string8   date_modified;
	string5   court_code;
	string50  court_name;
	string40  court_location;
	string7   case_number;
	string25  orig_case_number;
	string8   date_filed;
	string12  filing_status;
	string3   orig_chapter;
	string8   orig_filing_date;
	string5   assets_no_asset_indicator;
	string1	  filer_type;
	string8   meeting_date;
	string8   meeting_time;
	string90  address_341;
	string8   claims_deadline;
	string8   complaint_deadline;
	string35  judge_name;
	string5   judges_identification;
	string2   filing_jurisdiction ;
	string20  assets ;
	string20  liabilities;
	string1   CaseType;
	string1   AssocCode;
	string25 	SplitCase;	
	string25  FiledInError;
	string8		date_last_seen ; 
	string8		date_first_seen ;
	string8		date_vendor_first_reported := '';
	string8		date_vendor_last_reported := '';
	string8	  reopen_date;
	string8   case_closing_date; 
	string8   dateReclosed;	
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

	dataset(layout_status)   status;
	dataset(layout_comments) comments; 
end;

debtor & attorney info; see BankruptcyV2.layout_bankruptcy_search_v3_supp ------v
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
	string80  orig_city;
	string2   orig_st; 
	string5   orig_zip5; 
	string4   orig_zip4;
	string250 orig_email :='';
	address.Layout_Clean182;
	string10  phone ; 
	string12  DID  := '';
	string12  BDID := '';
	string9   app_SSN := '';
	string9   app_tax_id := '';
	string8   date_first_seen := '';
	string8   date_last_seen := '';
	string8   date_vendor_first_reported := '';
	string8   date_vendor_last_reported := '';
	string35  dispTypeDesc;
	string35  srcDesc;
	string35  srcMtchDesc;
	string35  screenDesc;
	string35  dcodeDesc;	
	string8		date_filed; 
	string128	record_type;
	string1   delete_flag := '';
 end; 
*/
