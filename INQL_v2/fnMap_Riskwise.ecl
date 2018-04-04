import ut;

Denorm := record
		string5		sequence_number;
		string20	orig_login_id;
		string20	orig_billing_code;
		string16	orig_transaction_id;
		string20	orig_function_name;
		string10	orig_company_id;
		string50	orig_reference_code;
		string30	orig_fname;
		string30	orig_mname;
		string30	orig_lname;
		string10	orig_name_suffix;
		string60	orig_address;
		string50	orig_city;
		string2	orig_state;
		string9	orig_zip;
		string4	orig_zip4;
		string60	orig_clean_address;
		string50	orig_clean_city;
		string2	orig_clean_state;
		string5	orig_clean_zip;
		string4	orig_clean_zip4;
		string20	orig_phone;
		string20	orig_homephone;
		string20	orig_workphone;
		string9	orig_ssn;
		string	orig_free;
		string	orig_record_count;
		string	orig_price;
		string	orig_revenue;
		string60	orig_full_name;
		string50	orig_business_name;
		string	orig_years;
		string	orig_pricing_error_code;
		string	orig_fcra_purpose;
		string3	orig_result_format;
		string8	orig_dob;
		string32	orig_unique_id;
		string	orig_response_time;
		string8	orig_data_source;
		string255	orig_report_options;
		string80	orig_end_user_name;
		string80	orig_end_user_address_1;
		string80	orig_end_user_address_2;
		string60	orig_end_user_city;
		string2	orig_end_user_state;
		string9	orig_end_user_zip;
		string	orig_login_history_id;
		string2 orig_employment_state; 
		string	orig_end_user_industry_class;
		string32	orig_function_specific_data;
		string20	orig_date_added;
		string	orig_retail_price;
		string4	orig_country_code;
		string30	orig_email;
		string30	orig_dl_number;
		string30	orig_sub_id;
		string	orig_neighbors;
		string	orig_relatives;
		string	orig_associates;
		string	orig_property;
		string1	orig_bankruptcy;
		string	orig_dls;
		string	orig_mvs;
		string15	orig_ip_address;
end;

EXPORT fnMap_Riskwise(boolean fcra = false, unsigned logType = 0) := function
	
	n := INQL_v2.test_count; /* n - to test a sample set, 0 to run all */
	inputfile := distribute(choosen(INQL_v2.Standardize_input(fcra, logType).Riskwise
																		,IF(n > 0, n, choosen:ALL)), random()) // choosen for testing purposes
																			; 		

	INQL_v2.fncleanfunctions.cleanfields(inputfile, cleaned_fields);

	/* !!!!!!!!!!!!!!!!! NORMALIZE INPUT FILE !!!!!!!!!!!!!!!!!!!!! */
	normInputFile := normalize(cleaned_fields, 2, transform({denorm,
																											string orig_transaction_type := '',
																											string orig_global_company_id := '',
																											unsigned4 filedate}, 
									self.sequence_number 			:= (string)counter;
									self.orig_fname 			:= choose(counter, left.orig_fname, left.orig_fname_2);
									self.orig_mname 			:= choose(counter, left.orig_mname, left.orig_mname_2);
									self.orig_lname 			:= choose(counter, left.orig_lname, left.orig_lname_2);
									self.orig_name_suffix := choose(counter, left.orig_name_suffix, left.orig_name_suffix_2);
									self.orig_address 		:= choose(counter, left.orig_address, left.orig_address_2);
									self.orig_city 				:= choose(counter, left.orig_city, left.orig_city_2);
									self.orig_state 			:= choose(counter, left.orig_state, left.orig_state_2);
									self.orig_zip 				:= choose(counter, left.orig_zip, left.orig_zip_2);
									self.orig_zip4 				:= choose(counter, left.orig_zip4, left.orig_zip4_2);
									self.orig_homephone 	:= choose(counter, left.orig_homephone, left.orig_homephone_2);
									self.orig_workphone 	:= choose(counter, left.orig_workphone, left.orig_workphone_2);
									self.orig_ssn 				:= choose(counter, left.orig_ssn, left.orig_ssn_2);
									self.orig_business_name := choose(counter, if(left.orig_business_name = '', left.orig_business_name_2, left.orig_business_name), 
																														 if(left.orig_business_name_2 = '', left.orig_business_name, left.orig_business_name_2));
									self.orig_dob 				:= choose(counter, left.orig_dob, left.orig_dob_2);
									self.orig_email 			:= choose(counter, left.orig_email, left.orig_email_2);
									self.orig_dl_number 	:= choose(counter, left.orig_dl_number, left.orig_dl_number_2);
									self.orig_full_name		:= choose(counter, left.orig_full_name, '');
									self.orig_phone				:= choose(counter, left.orig_phone, '');
									self.orig_login_id		:= left.orig_login_id;
									self := left));

	INQL_v2.File_MBSApp(normInputFile, 'RISKWISE', '', mbs_outfile)

	/* !!!!!!!!!!!!!!!!! REMOVE NULLS and MAKE ALL CAPS FOR EASY JOINING !!!!!!!!!!!!!!!!!!!!! */					
	cleanInput := project(mbs_outfile, transform(INQL_v2.Layouts.Common_layout,

									self.orig_company_name1 := left.orig_business_name;
									self.orig_full_name1 := stringlib.stringcleanspaces(left.orig_fname + ' ' + left.orig_mname + ' ' + left.orig_lname);
									self.orig_full_name2 := left.orig_full_name;
									self.orig_addr1 := left.orig_address;
									self.orig_lastline1 := stringlib.stringcleanspaces(left.orig_CITY + ' ' + left.orig_state + ' ' + left.orig_zip + left.orig_zip4);
									self.ORIG_CITY1 := left.orig_CITY;
									self.ORIG_STATE1 := left.orig_state;
									self.ORIG_ZIP1 := left.orig_zip+left.orig_zip4;

									self.repflag	:= '';
									self.sequence_number	:= left.sequence_number;

									self.ssn := 		INQL_v2.fncleanfunctions.clean_ssn(left.orig_ssn);
									self.personal_phone := INQL_v2.fncleanfunctions.clean_phone(left.orig_homephone);
									self.work_phone := INQL_v2.fncleanfunctions.clean_phone(left.orig_workphone);
									
									self.dob := 		INQL_v2.fncleanfunctions.clean_dob(left.orig_dob);
								
										fixDate := INQL_v2.fncleanfunctions.tDateAdded(left.orig_date_added);
										fixTime := INQL_v2.fncleanfunctions.tTimeAdded(fixDate);
									self.DateTime := fixTime;	

									self.DL := left.orig_dl_number; 
									self.Email_Address := left.orig_email;
									self.LinkID := left.orig_unique_id;

									self.GLOBAL_COMPANY_ID := left.orig_global_company_id;
									self.COMPANY_ID := left.orig_company_id;
							
									self.Industry_1_Code 		:= left.Industry_Code_1;
									self.Industry_2_Code 		:= left.Industry_Code_2;

									self.FCRA_purpose 			:= left.orig_fcra_purpose;
									self.GLB_purpose  := '1';
									self.DPPA_purpose := '3';
									self.Login_History_ID 	:= left.orig_login_history_id;
									self.Transaction_ID 		:= stringlib.stringtouppercase(left.orig_transaction_id);
									self.Product_Code 			:= left.product_id;
									self.Function_Description := map(left.description <> '' => left.description, left.orig_function_name);
									self.PERSON_ORIG_IP_ADDRESS1 := INQL_v2.fnCleanFunctions.fraudback(left.description, left.ORIG_IP_ADDRESS);				
									self.ORIG_IP_ADDRESS2 := map(self.PERSON_ORIG_IP_ADDRESS1 = '' => left.ORIG_IP_ADDRESS, '');
									self.Sub_Market 				:= left.sub_market;
									self.Vertical 					:= left.vertical;
									
									self.method := '';
									
									self.source_file := 'RISKWISE';
									self := left;
									self := []))(orig_lname + orig_company_name1 + orig_full_name1 <> '');// : persist('~persist::riskwise::clean');

	return if(logType = 7, cleanInput, dataset([], INQL_v2.Layouts.Common_layout));
	
END;