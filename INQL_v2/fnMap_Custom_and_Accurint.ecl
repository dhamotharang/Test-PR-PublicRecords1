import ut;

//1) Only for Accurint - Filter out first 200 transactions entered before November,6th for company_id = 6706483
//2) Get company_id gc_id from "MBS" file
//3) Get orig_company_id, orig_global_company_id, description orig_function_name,
//   unique_id_code, allowflags from "UniqueId and Transaction_desc" file
//4) clean fields
//5) project into common layout

EXPORT fnMap_Custom_and_Accurint(boolean fcra = false, unsigned logType = 0) := function
		
		n := INQL_v2.test_count; /* n - to test a sample set, 0 to run all */
		stdIn := choosen(map(logType = 2 => INQL_v2.Standardize_input(fcra, logType).Custom, 
												// logs[1] = 'F' => FraudDefenseNetwork.Files().temp.glb5,
												INQL_v2.Standardize_input(fcra, logType).Accurint
												)(orig_company_id <> '') ,IF(n > 0, n, choosen:ALL));
														
		addglobal_input := project(stdIn
												,transform({string orig_global_company_id := '', recordof(stdIn) - [orig_END_USER_ID, orig_LOGINID, orig_BILLING_CODE]},
														self.orig_global_company_id := if(logType = 2 and left.orig_company_id = '1216650', '496741', '');
														self.orig_company_id := if(logType = 2 and left.orig_company_id = '1216650', left.orig_billing_code, left.orig_company_id);
														self := left
														)
												);		
		
		INQL_v2.File_MBSApp(addglobal_input, 'ACCURINT', '', outAccurint); /* distributes in MBS macro by random */
		INQL_v2.File_MBSApp(addglobal_input, 'CUSTOM', '', outCustom); /* distributes in MBS macro by random */
		
		outfile := if(logType = 2, outCustom, outAccurint);
		/* /////////////////// Clean UP /////////////////// */
		INQL_v2.fncleanfunctions.cleanfields(outfile, cleaned_fields);

		cleanInput := project(cleaned_fields, transform(INQL_v2.Layouts.Common_layout,
			self.ORIG_FULL_NAME1 := stringlib.stringcleanspaces(stringlib.stringfindreplace(
										map(left.orig_fname + left.orig_mname + left.orig_lname = '' => 
										left.orig_full_name,
										stringlib.stringcleanspaces(left.orig_fname + ' ' + left.orig_mname + ' ' + left.orig_lname))
										, ',', ', '));
			self.ORIG_FULL_NAME2 	:= '';
			self.ORIG_FNAME 			:= left.orig_fname;
			self.ORIG_MNAME 			:= left.orig_mname;
			self.ORIG_LNAME 			:= left.orig_lname;
			self.ORIG_NAMESUFFIX 	:= '';
			
			self.ORIG_COMPANY_NAME1 := stringlib.stringcleanspaces(stringlib.stringfindreplace(left.ORIG_BUSINESS_NAME, ',', ', '));
			
			self.ORIG_ADDR1 		:= left.orig_address;
			self.ORIG_LASTLINE1 := stringlib.stringcleanspaces(left.orig_CITY + ' ' + left.orig_state + ' ' + left.orig_zip + left.orig_zip4);
			self.ORIG_CITY1 		:= left.orig_city;
			self.ORIG_STATE1 		:= left.orig_state;
			self.ORIG_ZIP1 			:= left.orig_zip + left.orig_zip4;
			
			self.SOURCE_FILE 		:= if(logType = 2, 'CUSTOM', 'ACCURINT');			
			//TBD
			self.PERSON_ORIG_IP_ADDRESS1 := '';//INQL_v2.fnCleanFunctions.fraudback(left.description, left.ORIG_IP_ADDRESS);
			
			self.ORIG_IP_ADDRESS2 := map(self.PERSON_ORIG_IP_ADDRESS1 = '' => left.ORIG_IP_ADDRESS, '');
			
			self.GLB_purpose := left.orig_glb_purpose;
													//http://webdev.br.seisint.com/documentation/BPS/glb_mappings.html
			self.DPPA_purpose := left.orig_dl_purpose;
													//http://webdev.br.seisint.com/documentation/BPS/dppa_mappings.html
			self.FCRA_purpose := '0';
			
			self.PRODUCT_CODE := '1';
			self.TRANSACTION_TYPE := left.orig_transaction_type;
			//TBD
			self.FUNCTION_DESCRIPTION := '';//left.description;

			self.ALLOWFLAGS := left.allowflags;
			self.Login_History_ID := left.orig_login_history_id;
			self.TRANSACTION_ID := left.orig_transaction_id;
			self.SEQUENCE_NUMBER := '';
			self.METHOD := map(left.orig_transaction_code = '110'=> 'ONLINE',
												 left.orig_transaction_code = '163' => 'XML', '');
					
			self.PERSONAL_PHONE := INQL_v2.fncleanfunctions.clean_phone(left.orig_phone);
			self.COMPANY_PHONE 	:= INQL_v2.fncleanfunctions.clean_phone(left.orig_phone);
			self.SSN 						:= INQL_v2.fncleanfunctions.clean_ssn(left.orig_ssn);
			self.DOB 						:= INQL_v2.fncleanfunctions.clean_dob(left.orig_dob);

			self.DL 						:= map(left.unique_id_code = '11' => left.orig_unique_id, '');
			self.DOMAIN_NAME 		:= map(left.unique_id_code = '10' => left.orig_unique_id, '');
			self.EIN 						:= map(left.unique_id_code in ['27','13'] => left.orig_unique_id, '');
			self.CHARTER_NUMBER := map(left.unique_id_code = '5' => left.orig_unique_id, '');
			self.UCC_NUMBER 		:= map(left.unique_id_code = '9' => left.orig_unique_id, '');
			self.LINKID 				:= map(left.unique_id_code = '29' => left.orig_unique_id, '');
			
			fixDate := INQL_v2.fncleanfunctions.tDateAdded(left.orig_dateadded);
			fixTime := INQL_v2.fncleanfunctions.tTimeAdded(fixDate);
			self.DateTime := fixTime;
			
			self.GLOBAL_COMPANY_ID 	:= left.orig_global_company_id;
			self.COMPANY_ID 				:= left.orig_company_id;
			self.INDUSTRY_1_CODE 		:= left.industry_code_1;
			self.INDUSTRY_2_CODE 		:= left.industry_code_2;
            
      self := left; 
			self := []
			));			
		
		return if(logType in [1,2], cleanInput, dataset([], INQL_v2.Layouts.Common_layout));
		
END;