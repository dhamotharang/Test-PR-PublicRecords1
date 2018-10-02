import ut, lib_word, Data_Services;

Input_Parsed := RECORD
		STRING DATETIME;
		STRING ORIG_PRODUCT_ID;
		STRING ORIG_TRANSACTION_TYPE;
		STRING ORIG_GLOBAL_COMPANY_ID;
		STRING SOURCE_FILE;
		STRING ORIG_COMPANY_ID;
		STRING LINKID;
		STRING ORIG_FNAME;
		STRING ORIG_LNAME;
		STRING ORIG_MNAME;
		STRING ORIG_COMPANY_NAME1;
		STRING ORIG_ADDR1;
		STRING ORIG_LASTLINE1;
		STRING ORIG_CITY1;
		STRING ORIG_STATE1;
		STRING ORIG_ZIP1;
		STRING COMPANY_PHONE;
		STRING EIN;
		STRING GLB_purpose;
		STRING DPPA_purpose;
		STRING FCRA_purpose;
		STRING SSN;
		STRING PERSONAL_PHONE;
		STRING DOB;
		STRING DL;
		STRING DL_STATE;
		STRING FUNCTION_DESCRIPTION;
		STRING ORIG_FUNCTION_NAME;
		STRING ORIG_REFERENCE_CODE;
		UNSIGNED4 FILEDATE;
END;


EXPORT fnMap_Bridger(boolean fcra = false, unsigned logType = 0) := function
	
	n := INQL_v2.test_count; /* n - to test a sample set, 0 to run all */
	inputfile_mixed := distribute(choosen(INQL_v2.Standardize_input(fcra, logType).Bridger,IF(n > 0, n, choosen:ALL)), random()); // choosen for testing purposes																				

	inputfile := PROJECT(inputfile_mixed, TRANSFORM(Input_Parsed,
			SELF.DATETIME 							:= LEFT.DATETIME;
			SELF.ORIG_TRANSACTION_TYPE 	:= '';
			SELF.ORIG_GLOBAL_COMPANY_ID := '';
			SELF.SOURCE_FILE 					:= 'BRIDGER';
			SELF.ORIG_COMPANY_ID 			:= LEFT.customer_id;
			SELF.LINKID 							:= LEFT.ID;
			SELF.ORIG_FNAME 					:= IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field1, '');
			SELF.ORIG_LNAME 					:= IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field2, '');
			SELF.ORIG_MNAME 					:= IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field3, '');
			SELF.ORIG_COMPANY_NAME1 	:= IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', '', LEFT.field1);
			SELF.ORIG_ADDR1 					:= IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field5, LEFT.field2);
			SELF.ORIG_LASTLINE1 			:= IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field6, LEFT.field3);
			SELF.ORIG_CITY1 					:= IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field7, LEFT.field4);
			SELF.ORIG_STATE1 					:= IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field8, LEFT.field5);
			SELF.ORIG_ZIP1 						:= IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field9, LEFT.field6);
			SELF.COMPANY_PHONE 				:= IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', '', LEFT.field7);
			SELF.EIN 									:= IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', '', LEFT.field8);
			SELF.GLB_purpose 					:= IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field14, LEFT.field9);
			SELF.DPPA_purpose 				:= IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field15, LEFT.field10);
			SELF.FCRA_purpose 				:= IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field16, LEFT.field11);
			SELF.SSN 									:= IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field4, '');
			SELF.PERSONAL_PHONE 			:= IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field10, '');
			SELF.DOB 									:= IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field11, '');
			SELF.DL 									:= IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field12, '');
			SELF.DL_STATE 						:= IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field13, '');
			SELF.ORIG_FUNCTION_NAME 	:= LEFT.Search_Function_Name;
			SELF.FUNCTION_DESCRIPTION := LEFT.Search_Function_Name;
			SELF.ORIG_PRODUCT_ID 			:= '1'; //CHANGE IF NECESSARY!!! NOT SURE!!!
			SELF.ORIG_REFERENCE_CODE 	:= LEFT.ENTITY_TYPE;
			SELF.FILEDATE            	:= LEFT.FILEDATE;
			SELF := []));
																					
	INQL_v2.fncleanfunctions.cleanfields(inputfile, cleaned_fields);
	INQL_v2.File_MBSApp(cleaned_fields, 'BRIDGER', '', mbs_outfile)

	/* !!!!!!!!!!!!!!!!! REMOVE NULLS and MAKE ALL CAPS FOR EASY JOINING !!!!!!!!!!!!!!!!!!!!! */					
	cleanInput := project(mbs_outfile, transform(INQL_v2.Layouts.Common_layout,
			self.orig_full_name1 	:= stringlib.stringcleanspaces(left.orig_fname + ' ' + left.orig_mname + ' ' + left.orig_lname);
			self.orig_lastline1 	:= stringlib.stringcleanspaces(left.orig_CITY1 + ' ' + left.orig_state1 + ' ' + left.orig_zip1);

			self.ssn 						:= INQL_v2.fncleanfunctions.clean_ssn(left.ssn);
			self.personal_phone := INQL_v2.fncleanfunctions.clean_phone(left.PERSONAL_PHONE);
			self.work_phone 		:= INQL_v2.fncleanfunctions.clean_phone(left.COMPANY_phone);
			
			self.dob := INQL_v2.fncleanfunctions.clean_dob(left.dob);
		
			fixDate := INQL_v2.fncleanfunctions.tDateAdded(left.datetime);
			fixTime := INQL_v2.fncleanfunctions.tTimeAdded(fixDate);
			self.DateTime := fixTime;	

			self.DL 			:= left.dl; 
			self.DL_STATE := left.dl_state; 
			self.LinkID 	:= left.LINKID;

			self.GLOBAL_COMPANY_ID 	:= left.orig_global_company_id;
			self.COMPANY_ID 				:= left.orig_company_id;

			self.Industry_1_Code 		:= left.Industry_Code_1;
			self.Industry_2_Code 		:= left.Industry_Code_2;

			self.Transaction_ID 		:= LEFT.DATETIME;
			self.Product_Code 			:= left.ORIG_PRODUCT_ID;
			self.Function_Description := map(left.description <> '' => left.description, left.orig_function_name);
			
			self.method := '';
			
			self.source_file 	:= 'BRIDGER';
			self 							:= left;
			self 							:= []))(orig_lname + orig_company_name1 + orig_full_name1 <> '');

	return if(logType = 6, cleanInput, dataset([], INQL_v2.Layouts.Common_layout));

END;