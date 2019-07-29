EXPORT Layouts := module
export request_input := record
string acctno;
string did;
string bdid;
string date_last_seen;
string source;
string subject_first_name;
string subject_last_name;
string company_name;
string company_address;
string company_city;
string company_state;
string company_zip;
string company_phone1;
string company_phone2;
string company_description;
string parent_company_name;
string parent_company_address;
string parent_company_city;
string parent_company_state;
string parent_company_zip;
string parent_company_phone;
string prof_license;
string prof_license_status;
string email1;string email2;
string email3;
string addl_wpl_comp_name_1;
string addl_wpl_comp_address1_1;
string addl_wpl_comp_address2_1;
string addl_wpl_comp_city_1;
string addl_wpl_comp_state_1;
string addl_wpl_comp_zip_1;
string addl_wpl_phone1_1;
string addl_wpl_phone2_1;
string addl_wpl_comp_name_2;
string addl_wpl_comp_address1_2;
string addl_wpl_comp_address2_2;
string addl_wpl_comp_city_2;
string addl_wpl_comp_state_2;
string addl_wpl_comp_zip_2;
string addl_wpl_phone1_2;
string addl_wpl_phone2_2;
string spouse_first_name;
string spouse_last_name;
string spouse_company_name;
string spouse_company_address;
string spouse_company_city;
string spouse_company_state;
string spouse_company_zip;
string spouse_company_phone1;
string spouse_company_phone2;
string spouse_company_description;
string spouse_parent_company_name;
string spouse_parent_company_address;
string spouse_parent_company_city;
string spouse_parent_company_state;
string spouse_parent_company_zip;
string spouse_parent_company_phone;
string spouse_prof_license;
string spouse_prof_license_status;
string spouse_email1;
string spouse_email2;
string spouse_email3;
end;

export request_input_fixed := record
string15 acctno;
string15 did;
string15 bdid;
string8 date_last_seen;
string2 source;
string20 subject_first_name;
string20 subject_last_name;
string120 company_name;
string70 company_address;
string25 company_city;
string5 company_state;
string5 company_zip;
string17 company_phone1;
string10 company_phone2;
string255 company_description;
string120 parent_company_name;
string70 parent_company_address;
string25 parent_company_city;
string2 parent_company_state;
string5 parent_company_zip;
string10 parent_company_phone;
string60 prof_license;
string45 prof_license_status;
string200 email1;
string200 email2;
string200 email3;
string120 addl_wpl_comp_name_1;
string70 addl_wpl_comp_address1_1;
string70 addl_wpl_comp_address2_1;
string25 addl_wpl_comp_city_1;
string2 addl_wpl_comp_state_1;
string5 addl_wpl_comp_zip_1;
string17 addl_wpl_phone1_1;
string10 addl_wpl_phone2_1;
string120 addl_wpl_comp_name_2;
string70 addl_wpl_comp_address1_2;
string70 addl_wpl_comp_address2_2;
string25 addl_wpl_comp_city_2;
string2 addl_wpl_comp_state_2;
string5 addl_wpl_comp_zip_2;
string17 addl_wpl_phone1_2;
string10 addl_wpl_phone2_2;
string20 spouse_first_name;
string20 spouse_last_name;
string120 spouse_company_name;
string70 spouse_company_address;
string25 spouse_company_city;
string2 spouse_company_state;
string5 spouse_company_zip;
string17 spouse_company_phone1;
string10 spouse_company_phone2;
string255 spouse_company_description;
string120 spouse_parent_company_name;
string70 spouse_parent_company_address;
string25 spouse_parent_company_city;
string2 spouse_parent_company_state;
string5 spouse_parent_company_zip;
string10 spouse_parent_company_phone;
string60 spouse_prof_license;
string45 spouse_prof_license_status;
string200 spouse_email1;
string200 spouse_email2;
string200 spouse_email3;
string50 filename ;
string15 jobid := '';
end;

export response_input := record
string customer_client_code; //LN Assigned Client Code (10 digit alpha numeric)
string date_submitted; //Date record was sent to vendor (format MMDDYYYY)
string Account_number; //Client Account number
string SSN; //SSN from client input
string client_input_address; //Address from client input
string client_input_city; //City from client input
string client_input_state; //State from client input
string client_input_zip; // Zip from client input
string subject_first_name; // 
string subject_last_name;
string company_name;
string company_address;
string company_city;
string company_state;
string company_zip;
string company_phone1;
string company_phone2;
string phone_1_status; 
//Status codes apply for phone1 and phone2
							//A.	Valid Number 
							//B.	Prior Correct Number 
							//C.	Not at this Number 
							//D.	Wrong Number 
							//E.	Left Message For Call Back/No Returned Call
							//F.	Disconnected Numbers
							//G.	Fax Sent With No Response 
							//H.	Fax Line On All Attempts
							//I.	Not Enough Info Provided
							//J.	Machine On All Attempts 
							//K.	No Answer or Machine With No Identification 
							//Z.    Duplicate Record Found Within Same File
string phone1_notes;
string phone_2_status; 
string phone2_notes;
string acctno;
end;

export response_input_fixed := record
string20 customer_client_code; //LN Assigned Client Code (10 digit alpha numeric)
string8 date_submitted; //Date record was sent to vendor (format MMDDYYYY)
string20 Account_number; //Client Account number
string9 SSN; //SSN from client input
string70 client_input_address; //Address from client input
string25 client_input_city; //City from client input
string2 client_input_state; //State from client input
string5 client_input_zip; // Zip from client input
string20 subject_first_name; // 
string20 subject_last_name;
string120 company_name;
string70 company_address;
string25 company_city;
string2 company_state;
string5 company_zip;
string17 company_phone1;
string10 company_phone2;
string1 phone_1_status; 
//Status codes apply for phone1 and phone2
							//A.	Valid Number 
							//B.	Prior Correct Number 
							//C.	Not at this Number 
							//D.	Wrong Number 
							//E.	Left Message For Call Back/No Returned Call
							//F.	Disconnected Numbers
							//G.	Fax Sent With No Response 
							//H.	Fax Line On All Attempts
							//I.	Not Enough Info Provided
							//J.	Machine On All Attempts 
							//K.	No Answer or Machine With No Identification 
							//Z.    Duplicate Record Found Within Same File
string120 phone1_notes;
string1 phone_2_status; 
string120 phone2_notes;
string15 acctno;
string50 filename ;
string15 jobid := '';
end;

export Base := record
unsigned6 acctno;
unsigned6 did;
unsigned6 bdid;
string8 date_last_seen;
string2 source;
string20 subject_first_name;
string20 subject_last_name;
string120 company_name;
string70 company_address;
string25 company_city;
string5 company_state;
string5 company_zip;
string17  company_phone1;
string10  company_phone2;
string255 company_description;
string120 parent_company_name;
string70 parent_company_address;
string25 parent_company_city;
string2 parent_company_state;
string5 parent_company_zip;
string10 parent_company_phone;
string60 prof_license;
string45 prof_license_status;
string200 email1;
string200 email2;
string200 email3;
string120 addl_wpl_comp_name_1;
string70 addl_wpl_comp_address1_1;
string70 addl_wpl_comp_address2_1;
string25 addl_wpl_comp_city_1;
string2 addl_wpl_comp_state_1;
string5 addl_wpl_comp_zip_1;
string17 addl_wpl_phone1_1;
string10 addl_wpl_phone2_1;
string120 addl_wpl_comp_name_2;
string70 addl_wpl_comp_address1_2;
string70 addl_wpl_comp_address2_2;
string25 addl_wpl_comp_city_2;
string2 addl_wpl_comp_state_2;
string5 addl_wpl_comp_zip_2;
string17 addl_wpl_phone1_2;
string10 addl_wpl_phone2_2;
string20 spouse_first_name;
string20 spouse_last_name;
string120 spouse_company_name;
string70 spouse_company_address;
string25 spouse_company_city;
string2 spouse_company_state;
string5 spouse_company_zip;
string17 spouse_company_phone1;
string10 spouse_company_phone2;
string255 spouse_company_description;
string120 spouse_parent_company_name;
string70 spouse_parent_company_address;
string25 spouse_parent_company_city;
string2 spouse_parent_company_state;
string5 spouse_parent_company_zip;
string10 spouse_parent_company_phone;
string60 spouse_prof_license;
string45 spouse_prof_license_status;
string200 spouse_email1;
string200 spouse_email2;
string200 spouse_email3;

// response
string20 response_customer_client_code; //LN Assigned Client Code (10 digit alpha numeric)
string8 response_date_submitted; //Date record was sent to vendor (format M[M]D[D]YYYY)
string8 response_date_submitted_reformat; //Date record was sent to vendor (format MMDDYYYY)
string20 response_Account_number; //Client Account number
string9 response_SSN; //SSN from client input
string17 response_company_phone1;
string10 response_company_phone2;
string1 response_phone_1_status; 
//Status codes apply for phone1 and phone2
							//A.	Valid Number 
							//B.	Prior Correct Number 
							//C.	Not at this Number 
							//D.	Wrong Number 
							//E.	Left Message For Call Back/No Returned Call
							//F.	Disconnected Numbers
							//G.	Fax Sent With No Response 
							//H.	Fax Line On All Attempts
							//I.	Not Enough Info Provided
							//J.	Machine On All Attempts 
							//K.	No Answer or Machine With No Identification 
							//Z.    Duplicate Record Found Within Same File
string120 response_phone1_notes;
string8 response_phone1_notes_date;
string1 response_phone_2_status; 
string120 response_phone2_notes;
string8 response_phone2_notes_date;
string120 response_InputFileNamestring ;
unsigned4 dt_vendor_last_reported;
unsigned4 dt_vendor_first_reported;
string120 response_file_name;
unsigned jobid;
	//CCPA-22 CCPA new fields
	UNSIGNED4 global_sid := 0;
	UNSIGNED8 record_sid := 0;

end;

export KeyBuild := record
Base and not [response_date_submitted,response_InputFileNamestring,  response_file_name,jobid ];
end;

export KeyBuildNorm := record
unsigned6 bdid;
unsigned1 phone_pos;
string17 response_company_phone;
string1 response_phone_status; 
string8 response_phone_notes_date;
unsigned4 dt_vendor_last_reported;
unsigned4 dt_vendor_first_reported;
end;
end;