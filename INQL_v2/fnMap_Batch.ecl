import ut, lib_word;

EXPORT fnMap_Batch(boolean fcra = false, unsigned logType = 0) := function

	n := INQL_v2.test_count; /* n - to test a sample set, 0 to run all */																
	rblankRefCode := choosen(INQL_v2.Standardize_input(fcra,logType).Batch(length(orig_address1_z5 + orig_address1_z4) < 12), IF(n > 0, n, choosen:ALL));
 blankRefCode  := project(rblankRefCode,
                    transform(INQL_v2.Layouts.rBatch_In_Ext - INQL_v2.Layouts.rBatch_In_PIIs,
													         self := left
																	   )
																	 );
													
	INQL_v2.fncleanfunctions.cleanfields(blankRefCode, cleaned_fields);
	INQL_v2.File_MBSApp(cleaned_fields, 'BATCH', '', mbs_outfile) 

	/* !!!!!!!!!!!!!!!!! CLEAN NAMES, ADDRESSES, PHONES, SSN, etc !!!!!!!!!!!!!!!!!!!!! */					

	cleanInput := project(mbs_outfile, transform(INQL_v2.Layouts.Common_layout,																
				self.ORIG_FULL_NAME1
					:= map(left.orig_FULL_NAME <> '' => left.orig_FULL_NAME, 
								left.orig_first_name + left.orig_middle_name + left.orig_last_name <> '' => stringlib.stringcleanspaces(left.orig_first_name + ' ' + left.orig_middle_name + ' ' + left.orig_last_name),
								stringlib.stringfind(left.orig_function_name, 'MODELS.ITA_BATCH_SERVICE', 1) > 0 => left.orig_reference_code,
								stringlib.stringfind(left.orig_function_name, 'MODELS.ITABATCHSERVICE', 1) > 0 => left.orig_reference_code,
								'');
				self.ORIG_FULL_NAME2 :='';
				
				line1 := map(left.orig_address1_addressline1 <> '' => left.orig_address1_addressline1,
											stringlib.stringcleanspaces(left.orig_address1_prim_range + ' ' + 
														left.orig_address1_predir + ' ' +
														left.orig_address1_prim_name + ' ' +
														left.orig_address1_suffix + ' ' +
														left.orig_address1_postdir + ' ' +
														left.orig_address1_unit_desig + ' ' +
														left.orig_address1_sec_range));
				line2 := map(left.orig_address1_addressline2 <> '' => left.orig_address1_addressline2, 
											stringlib.stringcleanspaces(left.orig_address1_city + ' ' + 
														left.orig_address1_st + ' ' +
														left.orig_address1_z5 + ' ' +
														left.orig_address1_z4));
																	
				self.ORIG_ADDR1 		:= line1;
				self.ORIG_LASTLINE1 := line2;
				self.ORIG_CITY1 		:= left.orig_address1_city;
				self.ORIG_STATE1 		:= left.orig_address1_st;
				self.ORIG_ZIP1 			:= left.orig_address1_z5 + left.orig_address1_z4;

				self.SSN 						:= INQL_v2.fncleanfunctions.clean_ssn(left.orig_ssn);

				self.WORK_PHONE 		:= INQL_v2.fncleanfunctions.clean_phone(left.orig_work_phone);
				self.PERSONAL_PHONE := INQL_v2.fncleanfunctions.clean_phone(left.orig_phone);
				self.COMPANY_PHONE 	:= INQL_v2.fncleanfunctions.clean_phone(left.orig_company_phone);
										
				self.DOB 						:= INQL_v2.fncleanfunctions.clean_dob(left.orig_dob);

				fixTime 						:= INQL_v2.fncleanfunctions.tTimeAdded(left.orig_datetime_stamp[1..8] + ' ' + left.orig_datetime_stamp[9..16]);
				self.DateTime 			:= fixTime;			
												 
				self.DL 						:= left.orig_dl_num; 
				self.DL_State 			:= left.orig_dl_state; 
				self.Email_Address 	:= left.orig_email_address;
				self.LinkID 				:= left.orig_did;
				self.domain_name 		:= left.orig_domain_name;
				self.ein 						:= left.orig_fein,
				self.charter_number := left.orig_charter_number,
				self.ucc_number 		:= left.orig_ucc_original_filing_number,

				self.orig_fname := left.orig_first_name;
				self.orig_mname := left.orig_middle_name;
				self.orig_lname := left.orig_last_name;
				
				self.GLOBAL_COMPANY_ID 	:= left.orig_global_company_id;
				self.COMPANY_ID 				:= left.orig_company_id;
				
				self.orig_company_name1 := map(LIB_Word.Word(left.orig_company_name,2) <> '' => left.orig_company_name,
																			 left.orig_company_name = left.orig_last_name => '',
																			 left.orig_company_name);
				self.Industry_1_Code 		:= left.Industry_Code_1;
				self.Industry_2_Code 		:= left.Industry_Code_2;
				self.method 						:= left.orig_method;
				self.Transaction_ID 		:= left.orig_job_id;
				self.Sequence_number 		:= left.orig_sequence_number;
				self.Product_Code 			:= if(left.product_id = '', '1', left.product_id);
				self.Function_Description 		:= left.orig_function_name;
				self.PERSON_ORIG_IP_ADDRESS1 	:= left.orig_ip_address_executed;
				self.ORIG_IP_ADDRESS2 				:= left.orig_ip_address_initiated;
				self.repflag	:= '';
				
				self.login_history_id 	:= left.orig_login_history_id;
				self.transaction_type 	:= left.orig_transaction_type;
				self.job_id 						:= left.orig_job_id;
				
				self.GLB_purpose 				:= MAP(left.orig_glb_purpose = ''=> '1', left.orig_glb_purpose);
				self.DPPA_purpose 			:= MAP(left.orig_dl_purpose = ''=> '3', left.orig_dl_purpose);
				self.FCRA_purpose 			:= left.orig_fcra_purpose;

				self.source_file 				:= 'BATCH';
				self := left,
				self := []));
		
		return if(logType = 3, cleanInput, dataset([], INQL_v2.Layouts.Common_layout));
END;