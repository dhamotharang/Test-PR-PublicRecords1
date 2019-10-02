import Targus;

export layouts := MODULE

  export raw_xml_in := RECORD
    string date_added;
    string transaction_id;
    string global_id;
    string esp_method;
    String request_data;  // encoded
    string request_format;
    string response_data; // encoded
    string response_format;
  end;

  export decoded_xml_in := record
    integer seq;
    string date_added;
    string transaction_id;
    string global_id;
    string esp_method;
    data request_data;    // decoded
    string request_format;
    data response_data;   // decoded
    string response_format;
  end;
	
	export BaseLayout := record
	   string    process_date;
	   unsigned4 seq;
		 string    esp_method;
		 STRING50  transaction_id;
		 data      request_data;    // decoded
     string    request_format;
     data      response_data;   // decoded
     string    response_format;
     string10  date_added;      // YYYYMMDD
     string10  time_added;      // HHMMSS
     UNSIGNED4 global_sid;
     UNSIGNED8 record_sid;		 
		 
	    // recordof(targus.Layout_Targus_out.response) response {XPATH('TargusComprehensiveResponse')};
			// recordof(targus.Layout_Targus_out) response {XPATH('TargusComprehensiveResponseEx')};
      
		 recordof(targus.Layout_Targus_out) temp_response_data1 {XPATH('TargusComprehensiveResponseEx')};
     string    cln_request_data; 
     string    cln_response_data; 		 
		 //Request common layout
		 UNSIGNED6 request_did;
	   qSTRING9  request_ssn;
	   qSTRING8  request_dob;
	   qstring10 request_phone10;
	   qSTRING5  request_title;
	   qSTRING20 request_fname;
	   qSTRING20 request_mname;
	   qSTRING20 request_lname;
	   qSTRING5  request_suffix;
	   qSTRING10 request_prim_range;
	   qSTRING2  request_predir;
	   qSTRING28 request_prim_name;
	   qSTRING4  request_addr_suffix;
	   qSTRING2  request_postdir;
	   qSTRING10 request_unit_desig;
	   qSTRING8  request_sec_range;
	   qSTRING25 request_p_city_name;
	   qSTRING2  request_st;
	   qSTRING5  request_z5;
	   qSTRING4  request_zip4;
     QSTRING120 request_email:=''; 
		 string6 	 request_err_addr 	 	:= ''; // for address cleaner error messages ONLY 
		 unsigned	 request_err_search 	:= 0;  // standard search errors; can contain ONLY standard error codes (or combination of thereof)
		 integer	 request_error_code 	:= 0;
     boolean   requestis_suppressed := false;
		 // response common layout
		 unsigned1 response_section_id := 0;
     UNSIGNED6 response_did;
	   qSTRING9  response_ssn;
	   qSTRING8  response_dob;
	   qstring10 response_phone10;
	   qSTRING5  response_title;
	   qSTRING20 response_fname;
	   qSTRING20 response_mname;
	   qSTRING20 response_lname;
	   qSTRING5  response_suffix;
	   qSTRING10 response_prim_range;
	   qSTRING2  response_predir;
	   qSTRING28 response_prim_name;
	   qSTRING4  response_addr_suffix;
	   qSTRING2  response_postdir;
	   qSTRING10 response_unit_desig;
	   qSTRING8  response_sec_range;
	   qSTRING25 response_p_city_name;
	   qSTRING2  response_st;
	   qSTRING5  response_z5;
	   qSTRING4  response_zip4;
     QSTRING120 response_email:='';
		 string6 	response_err_addr 	 	:= ''; // for address cleaner error messages ONLY 
		 unsigned	response_err_search 	:= 0;  // standard search errors; can contain ONLY standard error codes (or combination of thereof)
		 integer	response_error_code 	:= 0;
     boolean  responseis_suppressed := false;

  end;
	

end;
