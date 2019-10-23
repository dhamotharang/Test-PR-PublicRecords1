import ut, address, aid, lib_stringlib, address, did_add, Business_Header_SS;
import standard, header_slimsort, didville, business_header,watchdog, mdr, header;

export fnMapCommon_Banko(boolean fcra) := module

	export clean := function
		n 				:= INQL_v2.test_count; /* n - to test a sample set, 0 to run all */												
		NullSet 	:= INQL_v2.fncleanfunctions.nullset;
		inputfile := choosen(
									INQL_v2.Files(,fcra).Banko_input(orig_company_id <> '')
								 ,IF(n > 0, n, choosen:ALL)); // choosen for testing purposes

		tinputfile := project(distribute(inputfile, random())
										,transform({string orig_global_company_id := '', recordof(inputfile)}
										,self := left)); 

		INQL_v2.fncleanfunctions.cleanfields(tinputfile, cleaned_fields);
		INQL_v2.File_MBSApp(cleaned_fields, 'BANKO', '', mbs_outfile)

		cleanInput
			:= project(mbs_outfile
					,transform(INQL_v2.Layouts.Common_layout
						,self.PERSON_ORIG_IP_ADDRESS1 := INQL_v2.fnCleanFunctions.fraudback(left.description, left.ORIG_IP_ADDRESS)
						,self.ORIG_IP_ADDRESS2 				:= map(self.PERSON_ORIG_IP_ADDRESS1 = '' => left.ORIG_IP_ADDRESS, '')
						
						,self.ORIG_FULL_NAME1 				:= stringlib.stringfindreplace(
																							stringlib.stringcleanspaces(left.orig_name_first + ' ' + left.orig_name_last)
																							, ',', ', ')
						,self.ORIG_FULL_NAME2 				:= ''
						,self.ORIG_FNAME 							:= left.orig_name_first
						,self.ORIG_MNAME 							:= ''
						,self.ORIG_LNAME 							:= left.orig_name_last
						,self.ORIG_NAMESUFFIX 				:= ''										
						
						,self.ORIG_ADDR1 							:= left.orig_address
						,self.ORIG_LASTLINE1 					:= stringlib.stringcleanspaces(left.orig_CITY + ' ' + left.orig_state + ' ' + left.orig_zip)
						,self.ORIG_CITY1 							:= left.orig_city
						,self.ORIG_STATE1 						:= left.orig_state
						
						,self.ORIG_ZIP1 							:= left.orig_zip
						,fixDate 											:= INQL_v2.fncleanfunctions.tDateAdded(left.orig_date_added);
						 fixTime 											:= INQL_v2.fncleanfunctions.tTimeAdded(fixDate);
						 self.DateTime 								:= fixTime
						,self.SSN 										:= INQL_v2.fncleanfunctions.clean_ssn(left.orig_ssn)
						,self.PERSONAL_PHONE 					:= INQL_v2.fncleanfunctions.clean_phone(left.orig_phone)
						,self.COMPANY_PHONE 					:= INQL_v2.fncleanfunctions.clean_phone(left.orig_phone)
						,self.DOB 										:= INQL_v2.fncleanfunctions.clean_dob(left.orig_dob)
						
						,self.ORIG_COMPANY_NAME1 			:= stringlib.stringcleanspaces(stringlib.stringfindreplace(left.ORIG_BUSINESS_NAME, ',', ', '))
						
						,self.ORIG_GLOBAL_COMPANY_ID 	:= left.ORIG_GLOBAL_COMPANY_ID
						,self.GLOBAL_COMPANY_ID 			:= left.orig_global_company_id
						,self.COMPANY_ID 							:= left.orig_company_id
						,self.INDUSTRY_1_CODE 				:= left.industry_code_1
						,self.INDUSTRY_2_CODE 				:= left.industry_code_2
						,self.TRANSACTION_TYPE 				:= left.orig_transaction_type
						,self.FUNCTION_DESCRIPTION 		:= left.description

						,self.ALLOWFLAGS 							:= left.allowflags
						,self.Login_History_ID 				:= left.orig_login_history_id
						,self.TRANSACTION_ID 					:= left.orig_transaction_id
						,self.SEQUENCE_NUMBER 				:= ''
						,self.METHOD 									:= 'ONLINE'

						,self.FCRA_purpose 						:= left.orig_fcra_purpose
						,self.GLB_purpose  						:= left.orig_glb_purpose
						,self.DPPA_purpose 						:= left.orig_dppa_purpose
						,self.PRODUCT_CODE 						:= LEFT.PRODUCT_ID
						,self.PRIMARY_MARKET_CODE 		:= LEFT.PRIMARY_MARKET_CODE
						,self.SECONDARY_MARKET_CODE 	:= LEFT.SECONDARY_MARKET_CODE
						,self.SUB_MARKET 							:= LEFT.SUB_MARKET
						,self.VERTICAL 								:= LEFT.VERTICAL
						,self.INDUSTRY 								:= LEFT.INDUSTRY
						,self.USE 										:= LEFT.USE

						,self.SOURCE_FILE 						:= 'BANKO';
					
						,self := []
						));// : persist('~persist::banko::clean');

		return cleanInput;
	end;



	export ready_File(dataset(INQL_v2.Layouts.Common_layout) AppendForward, string select_source = 'BANKO') := function

		///////////////// PROJECT INTO PERSON QUERY LAYOUT 
		AF_person := AppendForward(repflag = '' and source_file = select_source);							
		person_project := project(AF_person, 
			transform(INQL_v2.Layouts.Common_ThorAdditions,
				self.source 											:= stringlib.stringtouppercase(left.source_file);
				self.mbs.Company_ID 							:= left.Company_ID;
				self.mbs.Global_Company_ID 				:= left.Global_Company_ID;
				
				self.allow_flags.Allowflags 			:= left.Allowflags;

				self.bus_intel.Sub_market 				:= left.sub_market;
				self.bus_intel.Industry 					:= left.industry;
				self.bus_intel.Primary_Market_Code:= left.Primary_Market_Code;
				self.bus_intel.Secondary_Market_Code := left.Secondary_Market_Code;
				self.bus_intel.Industry_1_Code 		:= left.Industry_1_Code;
				self.bus_intel.Industry_2_Code 		:= left.Industry_2_Code;
				self.bus_intel.Vertical 					:= left.vertical;
				self.bus_intel.Use 								:= left.use;

				self.Permissions.GLB_purpose 			:= left.glb_purpose;
				self.Permissions.DPPA_purpose 		:= left.dppa_purpose;
				self.Permissions.FCRA_purpose 		:= left.fcra_purpose;
				
				self.search_info.DateTime 				:= left.datetime;
				self.search_info.Login_History_ID := left.login_history_id;
				self.search_info.Transaction_ID 	:= left.transaction_id;
				self.search_info.Sequence_Number 	:= left.sequence_number;
				self.search_info.Method 					:= left.method;
				self.search_info.Product_Code 		:= left.product_code;
				self.search_info.Transaction_Type := left.transaction_type;
				self.search_info.Function_Description := left.function_description;
				self.search_info.IPAddr 					:= left.ORIG_IP_ADDRESS2;

				self.bus_q.CName 									:= left.clean_cname1;

				self.person_q.Full_Name 					:= left.orig_full_name1;
				self.person_q.Title 							:= '';
				self.person_q.First_Name 					:= left.orig_fname;
				self.person_q.Middle_Name 				:= left.orig_mname;
				self.person_q.Last_Name 					:= left.orig_lname;
				self.person_q.Address 						:= left.orig_addr1;
				self.person_q.City 								:= left.orig_city1;
				self.person_q.State 							:= left.orig_state1;
				self.person_q.Zip 								:= left.orig_zip1;
				self.person_q.Personal_Phone 			:= left.personal_phone;
				self.person_q.Work_Phone 					:= left.work_phone;
				self.person_q.DOB 								:= left.dob;
				self.person_q.DL 									:= left.dl; // unique id
				self.person_q.DL_St 							:= left.dl_state; // unique id
				self.person_q.Email_Address 			:= left.email_address;
				self.person_q.SSN 								:= left.ssn;
				self.person_q.LinkID 							:= left.linkid;
				self.person_q.IPAddr 							:= left.PERSON_ORIG_IP_ADDRESS1;
				self.person_q.FName 							:= left.fname;
				self.person_q.MName 							:= left.mname;
				self.person_q.LName 							:= left.lname;
				self.person_q.Name_Suffix 				:= left.name_suffix;
				self.person_q.prim_range  				:= left.prim_range;
				self.person_q.predir  						:= left.predir ;
				self.person_q.prim_name  					:= left.prim_name ;
				self.person_q.addr_suffix  				:= left.addr_suffix ;
				self.person_q.postdir  						:= left.postdir;
				self.person_q.unit_desig  				:= left.unit_desig;
				self.person_q.sec_range  					:= left.sec_range;
				self.person_q.v_city_name  				:= left.v_city_name;
				self.person_q.st  								:= left.st;
				self.person_q.zip5  							:= left.zip5;
				self.person_q.zip4  							:= left.zip4;
				self.person_q.addr_rec_type  			:= left.addr_rec_type ;
				self.person_q.fips_state 					:= left.fips_state;
				self.person_q.fips_county 				:= left.fips_county;
				self.person_q.geo_lat  						:= left.geo_lat;
				self.person_q.geo_long  					:= left.geo_long;
				self.person_q.cbsa  							:= left.cbsa;
				self.person_q.geo_blk  						:= left.geo_blk;
				self.person_q.geo_match  					:= left.geo_match;
				self.person_q.err_stat 						:= left.err_stat;
				self.person_q.Appended_SSN 				:= left.appendssn;
				self.person_q.Appended_ADL 				:= left.appendadl;
				self := left;
				self := []));
	
	AF_bususer := AppendForward(repflag <> '' and source_file = select_source);
	bususer_project := project(AF_bususer, 
		transform(INQL_v2.Layouts.Common_ThorAdditions,
				self.source 									:= stringlib.stringtouppercase(left.source_file);
				self.mbs.Company_ID 					:= left.Company_ID;
				self.mbs.Global_Company_ID 		:= left.Global_Company_ID;
				
				self.allow_flags.Allowflags 	:= left.Allowflags;

				self.bus_intel.Sub_market 		:= left.sub_market;
				self.bus_intel.Industry 			:= left.industry;
				self.bus_intel.Primary_Market_Code 	:= left.Primary_Market_Code;
				self.bus_intel.Secondary_Market_Code:= left.Secondary_Market_Code;
				self.bus_intel.Industry_1_Code := left.Industry_1_Code;
				self.bus_intel.Industry_2_Code := left.Industry_2_Code;
				self.bus_intel.Vertical 			:= left.vertical;
				self.bus_intel.Use 						:= left.use;

				self.Permissions.GLB_purpose 	:= left.glb_purpose;
				self.Permissions.DPPA_purpose := left.dppa_purpose;
				self.Permissions.FCRA_purpose := left.fcra_purpose;
				
				self.search_info.DateTime 		:= left.datetime;
				self.search_info.Login_History_ID := left.login_history_id;
				self.search_info.Transaction_ID 	:= left.transaction_id;
				self.search_info.Sequence_Number 	:= left.sequence_number;
				self.search_info.Method 			:= left.method;
				self.search_info.Product_Code := left.product_code;
				self.search_info.Transaction_Type 		:= left.transaction_type;
				self.search_info.Function_Description := left.function_description;
				self.search_info.IPAddr 			:= left.ORIG_IP_ADDRESS2;

				self.bus_q.CName 							:= left.clean_cname1;
				self.bus_q.appended_bdid 			:= left.appendbdid;
				self.bus_q.appended_ein 			:= left.appendtaxid;

				self.bususer_q.Title 					:= '';
				self.bususer_q.First_Name 		:= left.orig_fname;
				self.bususer_q.Middle_Name 		:= left.orig_mname;
				self.bususer_q.Last_Name 			:= left.orig_lname;
				self.bususer_q.Address 				:= left.orig_addr1;
				self.bususer_q.City 					:= left.orig_city1;
				self.bususer_q.State 					:= left.orig_state1;
				self.bususer_q.Zip 						:= left.orig_zip1;
				self.bususer_q.Personal_Phone := left.personal_phone;
				self.bususer_q.DOB 						:= left.dob;
				self.bususer_q.DL 						:= left.dl; // unique id
				self.bususer_q.DL_St 					:= left.dl_state; // unique id
				self.bususer_q.FName 					:= left.fname;
				self.bususer_q.MName 					:= left.mname;
				self.bususer_q.LName 					:= left.lname;
				self.bususer_q.Name_Suffix 		:= left.name_suffix;
				self.bususer_q.prim_range  		:= left.prim_range;
				self.bususer_q.predir  				:= left.predir ;
				self.bususer_q.prim_name  		:= left.prim_name ;
				self.bususer_q.addr_suffix  	:= left.addr_suffix ;
				self.bususer_q.postdir  			:= left.postdir;
				self.bususer_q.unit_desig  		:= left.unit_desig;
				self.bususer_q.sec_range  		:= left.sec_range;
				self.bususer_q.v_city_name  	:= left.v_city_name;
				self.bususer_q.st  						:= left.st;
				self.bususer_q.zip5  					:= left.zip5;
				self.bususer_q.zip4  					:= left.zip4;
				self.bususer_q.addr_rec_type  := left.addr_rec_type ;
				self.bususer_q.fips_state 		:= left.fips_state;
				self.bususer_q.fips_county 		:= left.fips_county;
				self.bususer_q.geo_lat  			:= left.geo_lat;
				self.bususer_q.geo_long  			:= left.geo_long;
				self.bususer_q.cbsa  					:= left.cbsa;
				self.bususer_q.geo_blk  			:= left.geo_blk;
				self.bususer_q.geo_match  		:= left.geo_match;
				self.bususer_q.err_stat 			:= left.err_stat;
				self.bususer_q.Appended_SSN 	:= left.appendssn;
				self.bususer_q.Appended_ADL 	:= left.appendadl;

				self := left;
				self := []));		
	
	all_files := person_project + bususer_project;
	// OUTPUT UPDATES ONLY - 														
	return dedup(sort(distribute(all_files, hash(search_info.Transaction_ID))(mbs.company_id + mbs.global_company_id <> '')																	
							,record, local)
				,record, local);
	end;
															
end;