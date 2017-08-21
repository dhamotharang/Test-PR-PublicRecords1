export Layout_Bankruptcy := module

  export main := module

	  export Unlinked := record
      string2   source;
      string50  source_docid;  // length???
		  // Bankruptcy specific fields: 
  		string50  TMSID; //needed as a separate field if it is stored in source_docid???
	    string7   case_number;
      string3   chapter;
	    string8   date_filed;
			string8   status_date;
			string30  status;
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
		  /* other fields (see below) - TBD, Tim Bernhard is deciding
 	    string8    process_date;
      string1	   source;
      string12   id;
      string10   seq_number;
      string8    date_created;
      string8    date_modified;
		  string1   filer_type;
      string5    assets_no_asset_indicator;
      string8    meeting_date;
      string8    meeting_time;
      string90   address_341;
      string8    claims_deadline;
      string8    complaint_deadline;
      string3    pro_se_ind;
      string5    judges_identification;
		  string35   judge_name;
      string128  record_type;
      string1    corp_flag;
      string1    AssocCode;
	    string8    date_last_seen; 
      string8    date_first_seen;
	    string8    date_vendor_first_reported;
      string8    date_vendor_last_reported;
      string8    converted_date;
      string8	   reopen_date;
      */
    end;

    export Linked := record
      unsigned6 bid;
			string10  source_party;
      Unlinked;
    end;

  end; // end of main module

  export Party := record
		string5   court_code;
		string25  orig_case_number;
    string2   party_type;
	  string2   debtor_type;
    string12  DID;
    string9   app_SSN;
    string9 	ssn;
    string9   app_tax_id;
    string9   tax_id; 
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
	end;

 // status_history - date & type       ???
 // comment_history - filing_date & description     ???

end;
