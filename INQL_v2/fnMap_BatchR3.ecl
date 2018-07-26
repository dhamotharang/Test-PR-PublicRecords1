import ut, lib_word, Data_Services;

File_PIDs := dataset(Data_Services.foreign_r3 + 'thor_10_219::base::account_monitoring::prod::inquirytracking::pidmapping',
			{string pid, string product_id, string company_id, string gcid, boolean isFcra}, csv(separator('|'))); // new layout, waiting on file

EXPORT fnMap_BatchR3(boolean fcra = false, unsigned logType = 0) := function
	
	n := INQL_v2.test_count; /* n - to test a sample set, 0 to run all */

	InputFile := choosen(INQL_v2.Standardize_input(fcra, logType).BatchR3, IF(n > 0, n, choosen:ALL));
	
	INQL_v2.fncleanfunctions.cleanfields(InputFile, cleaned_fields);
	INQL_v2.File_MBSApp(cleaned_fields, 'BATCHR3', '', outfileBatchR3); 

	filter_out_fcra := join(outfileBatchR3, File_PIDs(~fcra), left.orig_global_company_id = right.gcid, lookup);

	NormFiles := normalize(filter_out_fcra, 2, transform(recordof(filter_out_fcra),
			self.orig_full_name 			:= choose(counter, left.orig_full_name, '');
			self.orig_personal_phone 	:= choose(counter, left.orig_personal_phone, '');
			self.orig_work_phone 			:= choose(counter, left.orig_work_phone, '');
			self.orig_dob 						:= choose(counter, left.orig_dob, '');
			self.orig_dl 							:= choose(counter, left.orig_dl, '');
			self.orig_dl_state 				:= choose(counter, left.orig_dl_state, '');
			self.orig_email 					:= choose(counter, left.orig_email, '');
			self.orig_ssn 						:= choose(counter, left.orig_ssn, '');
			self.orig_linkid 					:= choose(counter, left.orig_linkid, '');
			self.orig_ipaddr 					:= choose(counter, left.orig_ipaddr, '');
			self.orig_addr1_1 				:= choose(counter, left.orig_addr1_1, '');
			self.orig_addr2_1 				:= choose(counter, left.orig_addr2_1, '');
			self.orig_city_1 					:= choose(counter, left.orig_city_1, '');
			self.orig_st_1 						:= choose(counter, left.orig_st_1, '');
			self.orig_zip_1 					:= choose(counter, left.orig_zip_1, '');
			
			self.orig_cname 					:= choose(counter, '', left.orig_cname);
			self.orig_company_phone 	:= choose(counter, '', left.orig_company_phone);
			self.orig_ein 						:= choose(counter, '', left.orig_ein);
			self.orig_charter_number 	:= choose(counter, '', left.orig_charter_number);
			self.orig_ucc_number 			:= choose(counter, '', left.orig_ucc_number);
			self.orig_domain_name 		:= choose(counter, '', left.orig_domain_name);
			self.orig_addr1_2 				:= choose(counter, '', left.orig_addr1_2);
			self.orig_addr2_2 				:= choose(counter, '', left.orig_addr2_2);
			self.orig_city_2 					:= choose(counter, '', left.orig_city_1);
			self.orig_st_2 						:= choose(counter, '', left.orig_st_1);
			self.orig_zip_2 					:= choose(counter, '', left.orig_zip_1);
			self := left))(orig_cname <> '' or orig_full_name <> ''); 

	cleanInput :=  PROJECT(NormFiles, TRANSFORM(INQL_v2.Layouts.Common_layout,										
			self.orig_company_name1 	:= left.orig_cname;
			self.orig_full_name1 			:= left.orig_full_name;
			self.ORIG_FULL_NAME2 			:='';
			self.ORIG_ADDR1								:= map(left.orig_full_name <> '' => stringlib.stringcleanspaces(left.orig_addr1_1) , stringlib.stringcleanspaces(left.orig_addr1_2));
			self.ORIG_CITY1								:= map(left.orig_full_name <> '' => left.orig_city_1 , left.orig_city_2);
			self.ORIG_STATE1							:= map(left.orig_full_name <> '' => left.orig_st_1 , left.orig_st_2);
			self.ORIG_ZIP1								:= map(left.orig_full_name <> '' => left.orig_zip_1 , left.orig_zip_2);
			self.ORIG_LASTLINE1						:= stringlib.stringcleanspaces(self.orig_addr1 + ' ' + self.orig_city1 + ' ' + self.orig_state1 + ' ' + self.orig_zip1);
			self.PERSON_ORIG_IP_ADDRESS1	:= INQL_v2.fnCleanFunctions.fraudback(left.description, left.orig_IPADDR);
			self.ORIG_IP_ADDRESS2					:= map(self.PERSON_ORIG_IP_ADDRESS1 = '' => left.orig_IPADDR, '');
			
			self.GLOBAL_COMPANY_ID 	:= left.orig_global_company_id;
			self.COMPANY_ID 				:= left.orig_company_id;

			self.Sub_Market := left.Sub_Market;
			self.Vertical 	:= left.Vertical;
			self.Industry 	:= left.industry;

			self.allowflags := left.allowflags;
			
			self.Sequence_Number 	:= left.orig_sequence_number;
			self.Method 					:= 'MONITORING';
			self.Product_Code 		:= left.product_id;
			self.Function_Description := map(left.product_id = '1' => 'ACCURINT MONITORING',
																			 left.product_id = '2' => 'RISKWISE MONITORING',
																			 left.product_id = '5' => 'BANKRUPTCY MONITORING', left.orig_method);
			self.repflag	:= '';
				
			self.PERSONAL_PHONE := INQL_v2.fncleanfunctions.clean_phone(left.orig_personal_phone);
			self.WORK_PHONE 		:= INQL_v2.fncleanfunctions.clean_phone(left.orig_work_phone);
			self.COMPANY_PHONE 	:= INQL_v2.fncleanfunctions.clean_phone(left.orig_company_phone);
			fixDate := INQL_v2.fncleanfunctions.tDateAdded(left.orig_datetime);
			fixTime := INQL_v2.fncleanfunctions.tTimeAdded(fixDate);
			self.DateTime := fixTime;														
			self.SSN := INQL_v2.fncleanfunctions.clean_ssn(left.orig_ssn);
			self.DOB := INQL_v2.fncleanfunctions.clean_dob(left.orig_dob);
      self.TRANSACTION_ID := left.orig_transaction_id;
			self.dl 						:= left.orig_dl;
			self.domain_name 		:= left.orig_domain_name;
			self.ein 						:= left.orig_ein;
			self.charter_number := left.orig_charter_number;
			self.ucc_number 		:= left.orig_ucc_number;
			self.linkid 				:= left.orig_linkid;
			
			self.source_file := 'BATCHR3';

			self := LEFT;
			self := []));

	return if(logType = 4, cleanInput, dataset([], INQL_v2.Layouts.Common_layout));
	
END;