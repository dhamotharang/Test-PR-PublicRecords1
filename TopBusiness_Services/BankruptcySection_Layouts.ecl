import iesp, BIPV2;

export BankruptcySection_Layouts := module;

	export rec_OptionsLayout := record
		boolean lnbranded;
		boolean internal_testing;
		string1 businessReportFetchLevel;
		string32 ApplicationType;
	end;
	
	export rec_input := record
		string25 acctno;			
		iesp.share.t_BusinessIdentity;
	end;
	
	export rec_bkLayout := record
		  string2   source;
      string50  source_docid;  // length???
			BIPV2.IDlayouts.l_header_ids;
		  // Bankruptcy specific fields: 
  		string50  TMSID; //needed as a separate field if it is stored in source_docid???
	    string7   case_number;
      string3   chapter;
	    string8   date_filed;
			string8   status_date;
			string30  status;
			string30  StatusRaw;
			//string8   RawInformationDate;
	    string12  filing_status;
		  string2   filing_jurisdiction;
	    string5   court_code;
	    string50  court_name;
	    string40  court_location;
	    string1   casetype;
	    string20  assets;
	    string20  liabilities;
	    string35  disposition;
	    string8   disposed_date; 
	    string8   case_closing_date; 
	    string25  orig_case_number;
	    string3   orig_chapter;
	    string8   orig_filing_date;
		  string15  orig_filing_type;
			string15  filer_type;
			string1   party_type;
			string15  filing_type;			
			 string10 SSN;// {xpath('SSN')};
	string12 DID;// {Xpath('DID')};
	string30 Comment;// {Xpath('Comment')};
	string30 FilingStatus;// (Xpath('FilingStatus')};

	end;
	
	export rec_partylayout := record
	    BIPV2.IDlayouts.l_header_ids;
  		string50  TMSID; //needed for suppression by tmsid
			string2   source;
      string50  source_docid;  // length???
			string10  source_party;
			string5   court_code;
			//string50  court_name;
			string25  orig_case_number;
			string2   party_type;
			string2   debtor_type;
			string12  DID;
			string9   app_SSN;
			string9 	ssn;
			string9   app_tax_id;
			string9   taxId; 
			//string3   debtor_seq;
			//string2   name_type; 
			//string200 orig_name; 
			//string50	orig_fname ;
			//string30	orig_mname ;
			//string50	orig_lname ;
			//string5 	orig_name_suffix;
			string5   title;
			string20  fname;
			string20  mname;
			string20  lname;
			string5   name_suffix;
			//string3   name_score;
			string150 cname; 
			//string150 orig_company;
			//string80	orig_addr1;
			//string80	orig_addr2;
			//string80  orig_city;
			//string2   orig_st; 
			//string5   orig_zip5; 
			//string4   orig_zip4;
			string10  prim_range;
			string2   predir;
			string28  prim_name;
			string4   addr_suffix;
			string2   postdir;		
			string10  unit_desig;
			string8   sec_range;
			string25  p_city_name;
			string25  v_city_name;
			string2   st;
			string5   zip;
			string4   zip4;
			// other msa/geo address.Layout_Clean182 fields???
			string10  phone; 
			string4	  timezone;
			// string30  status;
			// string8   status_date;		
			
			// string15  orig_filing_type;
			// string15  filer_type;
			
			 // self.orig_filing_type    := map(
					// right.filing_type = '' => 'INDIVIDUAL',
					// 'BUSINESS');
	end;
	
	export rec_bankruptcy_record_ext := record
    BIPV2.IDlayouts.l_header_ids;
		string1 party_type;
		iesp.TopbusinessReport.t_topbusinessBankruptcy;					
  end;		
		
	export rec_final := record
		string25 acctno;
		iesp.topbusinessReport.t_topbusinessBankruptcySection;
	end;
	
end;