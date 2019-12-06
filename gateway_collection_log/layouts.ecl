import Targus;

export layouts := MODULE

  export raw_xml_in := RECORD
    string date_added;
    string Lexid_in;
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
    string Lexid_in;
    string transaction_id;
    string global_id;
    string esp_method;
    data request_data;    // decoded
    string request_format;
    data response_data;   // decoded
    string response_format;
  end;
	
	export BaseLayout := record
	   string8   process_date;
	   unsigned4 seq;
		 string    esp_method;
     unsigned6 lexid_in;
		 string20  transaction_id;
		 data      request_data;    // decoded
     string    request_format;
     data      response_data;   // decoded
     string    response_format;
     string8   date_added;      // YYYYMMDD
     string8   time_added;      // HHMMSS
     unsigned4 global_sid;
     unsigned8 record_sid;		 
		 recordof(targus.Layout_Targus_out) temp_response_data1 {XPATH('TargusComprehensiveResponseEx')};
     string    cln_request_data; 
     string    cln_response_data; 		 
		 //Request common layout
		 unsigned6 request_did;
	   qstring9  request_ssn;
	   qstring8  request_dob;
	   qstring10 request_phone10;
	   qstring5  request_title;
	   qstring20 request_fname;
	   qstring20 request_mname;
	   qstring20 request_lname;
	   qstring5  request_suffix;
	   qstring10 request_prim_range;
	   qstring2  request_predir;
	   qstring28 request_prim_name;
	   qstring4  request_addr_suffix;
	   qstring2  request_postdir;
	   qstring10 request_unit_desig;
	   qstring8  request_sec_range;
	   qstring25 request_p_city_name;
	   qstring2  request_st;
	   qstring5  request_z5;
	   qstring4  request_zip4;
     qstring120 request_email:=''; 
		 string6 	 request_err_addr 	 	:= ''; // for address cleaner error messages ONLY 
		 unsigned	 request_err_search 	:= 0;  // standard search errors; can contain ONLY standard error codes (or combination of thereof)
		 integer	 request_error_code 	:= 0;
     boolean   requestis_suppressed := false;
		 // response common layout
		 unsigned1 response_section_id := 0;
     unsigned6 response_did;
	   qstring9  response_ssn;
	   qstring8  response_dob;
	   qstring10 response_phone10;
	   qstring5  response_title;
	   qstring20 response_fname;
	   qstring20 response_mname;
	   qstring20 response_lname;
	   qstring5  response_suffix;
	   qstring10 response_prim_range;
	   qstring2  response_predir;
	   qstring28 response_prim_name;
	   qstring4  response_addr_suffix;
	   qstring2  response_postdir;
	   qstring10 response_unit_desig;
	   qstring8  response_sec_range;
	   qstring25 response_p_city_name;
	   qstring2  response_st;
	   qstring5  response_z5;
	   qstring4  response_zip4;
     qstring120 response_email:='';
		 string6 	response_err_addr 	 	:= ''; // for address cleaner error messages ONLY 
		 unsigned	response_err_search 	:= 0;  // standard search errors; can contain ONLY standard error codes (or combination of thereof)
		 integer	response_error_code 	:= 0;
     boolean  responseis_suppressed := false;

  end;
	

end;
