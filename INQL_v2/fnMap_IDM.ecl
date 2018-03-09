import ut;

EXPORT fnMap_IDM(boolean fcra = false, unsigned logType = 0) := function
	
	n := INQL_v2.test_count; /* n - to test a sample set, 0 to run all */
	filter_input := choosen(INQL_v2.Standardize_input(fcra, logType).IDM(ORIG_BILLINGID <> ''), IF(n > 0, n, choosen:ALL)); 											

	addglobal_input := project(filter_input, transform({string orig_company_id := '', string orig_global_company_id := '', string orig_transaction_type := '', recordof(filter_input)},
				self.orig_transaction_type 	:= ''; //will inherit the correct gcid.
				self.orig_global_company_id := left.orig_BILLINGID; //will inherit the correct gcid.
				self.orig_company_id 				:= left.orig_BILLINGID; //will inherit the correct gcid.
				self := left));

	INQL_v2.File_MBSApp(addglobal_input, 'IDM', '', mbs_appended); /* distributes in MBS macro by random */

	/* /////////////////// Clean UP /////////////////// */
	INQL_v2.fncleanfunctions.cleanfields(mbs_appended, cleaned_fields);

	dCleanFIelds := dedup(sort(cleaned_fields, orig_company_id, orig_transaction_id, orig_dateadded, orig_function_name, description, orig_transaction_type),
																						 orig_company_id, orig_transaction_id, orig_dateadded, orig_function_name, description, orig_transaction_type);

	cleanInput := project(dCleanFIelds,	transform(INQL_v2.Layouts.Common_layout,
			self.ORIG_FULL_NAME1 	:= stringlib.stringfindreplace(
																	stringlib.stringcleanspaces(left.orig_fname + ' ' + left.orig_mname + ' ' + left.orig_lname)
																	, ',', ', ');
			self.ORIG_FULL_NAME2 	:= '';
			self.ORIG_FNAME 			:= left.orig_fname;
			self.ORIG_MNAME 			:= left.orig_mname;
			self.ORIG_LNAME 			:= left.orig_lname;
			self.ORIG_NAMESUFFIX 	:= '';
			
			self.ORIG_ADDR1 			:= left.orig_address;
			self.ORIG_LASTLINE1 	:= stringlib.stringcleanspaces(left.orig_CITY + ' ' + left.orig_state + ' ' + left.orig_zip);
			self.ORIG_CITY1 			:= left.orig_city;
			self.ORIG_STATE1 			:= left.orig_state;
			self.ORIG_ZIP1 				:= left.orig_zip;
			
			self.SOURCE_FILE 			:= 'IDM_BLS';
																															
			self.GLB_purpose 			:= left.orig_glb;
													//http://webdev.br.seisint.com/documentation/BPS/glb_mappings.html
			self.DPPA_purpose 		:= left.orig_dppa;
													//http://webdev.br.seisint.com/documentation/BPS/dppa_mappings.html
			self.FCRA_purpose 		:= left.orig_fcra;
			
			self.PRODUCT_CODE 		:= '7'; //if(left.product_id <> '', left.product_id, '7'); //hard coded as 7 for ease of filtering. all prod ids should be 7 in the mbs though 
			self.TRANSACTION_TYPE := left.orig_transaction_type;
			self.FUNCTION_DESCRIPTION := if(left.description = '', left.ORIG_FUNCTION_NAME, left.description);

			self.ALLOWFLAGS 		  := left.allowflags;
			self.TRANSACTION_ID 	:= left.orig_transaction_id;
			self.SEQUENCE_NUMBER  := (string)counter;
			self.METHOD 					:= 'ONLINE';
					
			self.PERSONAL_PHONE 	:= INQL_v2.fncleanfunctions.clean_phone(left.orig_phone);
			self.SSN 							:= INQL_v2.fncleanfunctions.clean_ssn(left.orig_ssn);
			self.DOB 							:= INQL_v2.fncleanfunctions.clean_dob(left.orig_dob);
			self.DL 							:= INQL_v2.fncleanfunctions.fnCleanUp(left.orig_dln);
			self.DL_STATE 				:= INQL_v2.fncleanfunctions.fnCleanUp(left.orig_dln_st);

			self.LINKID := left.orig_adl;
			
			fixDate := INQL_v2.fncleanfunctions.tDateAdded(left.orig_dateadded);
			fixTime := INQL_v2.fncleanfunctions.tTimeAdded(fixDate);
			self.DateTime := fixTime;
			
			self.GLOBAL_COMPANY_ID 	:= if(left.gc_id <> '', left.gc_id, left.orig_global_company_id);
			self.COMPANY_ID 				:= if(left.company_id <> '', left.company_id, left.orig_company_id);
			self.INDUSTRY_1_CODE 		:= left.industry_code_1;
			self.INDUSTRY_2_CODE 		:= left.industry_code_2;
			self := left,
			self := []));																														

	return if(logType = 8, cleanInput, dataset([], INQL_v2.Layouts.Common_layout));
	
END;