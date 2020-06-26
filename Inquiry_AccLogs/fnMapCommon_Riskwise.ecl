import ut;

export fnMapCommon_Riskwise := module

export clean := function

n := inquiry_acclogs.test_count; /* n - to test a sample set, 0 to run all */

NullSet := inquiry_acclogs.fncleanfunctions.nullset;

inputfile := distribute(choosen(inquiry_acclogs.File_Riskwise_Logs.input
																	,IF(n > 0, n, choosen:ALL)), random()) // choosen for testing purposes
																		;

inquiry_acclogs.fncleanfunctions.cleanfields(inputfile, cleaned_fields);

/* !!!!!!!!!!!!!!!!! NORMALIZE INPUT FILE !!!!!!!!!!!!!!!!!!!!! */
normInputFile := normalize(cleaned_fields, 2, transform({inquiry_acclogs.Layout_Riskwise_Logs.denorm,
																										string orig_transaction_type := '',
																										string orig_global_company_id := ''},
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

inquiry_acclogs.File_MBSApp(normInputFile, 'RISKWISE', '', mbs_outfile)

/* !!!!!!!!!!!!!!!!! REMOVE NULLS and MAKE ALL CAPS FOR EASY JOINING !!!!!!!!!!!!!!!!!!!!! */
removeNulls := project(mbs_outfile, transform(inquiry_acclogs.Layout_In_Common,

								self.orig_company_name1 := left.orig_business_name;
								self.orig_full_name1 := stringlib.stringcleanspaces(left.orig_fname + ' ' + left.orig_mname + ' ' + left.orig_lname);
								self.orig_full_name2 := left.orig_full_name;
								self.orig_addr1 := left.orig_address;
								self.orig_lastline1 := stringlib.stringcleanspaces(left.orig_CITY + ' ' + left.orig_state + ' ' + left.orig_zip + left.orig_zip4);

								self.repflag	:= '';

								self.ssn := 		Inquiry_AccLogs.fncleanfunctions.clean_ssn(left.orig_ssn);
								self.personal_phone := Inquiry_AccLogs.fncleanfunctions.clean_phone(left.orig_homephone);
								self.work_phone := Inquiry_AccLogs.fncleanfunctions.clean_phone(left.orig_workphone);

								self.dob := 		Inquiry_AccLogs.fncleanfunctions.clean_dob(left.orig_dob);

									fixDate := Inquiry_AccLogs.fncleanfunctions.tDateAdded(left.orig_date_added);
									fixTime := Inquiry_AccLogs.fncleanfunctions.tTimeAdded(fixDate);
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
								self.PERSON_ORIG_IP_ADDRESS1 := Inquiry_Acclogs.fnCleanFunctions.fraudback(left.description, left.ORIG_IP_ADDRESS);
								self.ORIG_IP_ADDRESS2 := map(self.PERSON_ORIG_IP_ADDRESS1 = '' => left.ORIG_IP_ADDRESS, '');
								self.Sub_Market 				:= left.sub_market;
								self.Vertical 					:= left.vertical;

								self.method := '';

								self.source_file := 'RISKWISE';
								self := left;
								self := []))(orig_lname + orig_company_name1 + orig_full_name1 <> '');// : persist('~persist::riskwise::clean');

return removenulls;
end;


export ready_File(dataset(inquiry_acclogs.Layout_In_Common) AppendForward, string select_source = 'RISKWISE') := function

///////////////// PROJECT INTO PERSON QUERY LAYOUT

person_project := project(AppendForward(repflag = '' and source_file = select_source),
		transform(inquiry_acclogs.Layout.Common,
			self.mbs.Company_ID := left.Company_ID;
			self.mbs.Global_Company_ID := left.Global_Company_ID;

			self.allow_flags.Allowflags := left.Allowflags;

			self.bus_intel.Sub_market := left.sub_market;
			self.bus_intel.Industry := left.industry;
			self.bus_intel.Primary_Market_Code := left.Primary_Market_Code;
			self.bus_intel.Secondary_Market_Code := left.Secondary_Market_Code;
			self.bus_intel.Industry_1_Code := left.Industry_1_Code;
			self.bus_intel.Industry_2_Code := left.Industry_2_Code;
			self.bus_intel.Vertical := left.vertical;

			self.Permissions.GLB_purpose := left.glb_purpose;
			self.Permissions.DPPA_purpose := left.dppa_purpose;
			self.Permissions.FCRA_purpose := left.fcra_purpose;

			self.search_info.DateTime := left.datetime;
			self.search_info.Login_History_ID := left.login_history_id;
			self.search_info.Transaction_ID := left.transaction_id;
			self.search_info.Sequence_Number := left.sequence_number;
			self.search_info.Method := left.method;
			self.search_info.Product_Code := left.product_code;
			self.search_info.Transaction_Type := left.transaction_type;
			self.search_info.Function_Description := left.function_description;
			self.search_info.IPAddr := left.ORIG_IP_ADDRESS2;

			self.bus_q.CName := left.clean_cname1;

			self.person_q.Full_Name :=  left.orig_full_name1;
			self.person_q.Title := '';
			self.person_q.First_Name :=  left.orig_fname;
			self.person_q.Middle_Name :=  left.orig_mname;
			self.person_q.Last_Name :=  left.orig_lname;
			self.person_q.Address :=  left.orig_addr1;
			self.person_q.City :=   left.orig_city1;
			self.person_q.State :=   left.orig_state1;
			self.person_q.Zip :=   left.orig_zip1;
			self.person_q.Personal_Phone :=   left.personal_phone;
			self.person_q.Work_Phone := left.work_phone;
			self.person_q.DOB :=  left.dob;
			self.person_q.DL :=  left.dl; // unique id
			self.person_q.DL_St := left.dl_state; // unique id
			self.person_q.Email_Address := left.email_address;
			self.person_q.SSN :=  left.ssn;
			self.person_q.LinkID := left.linkid;
			self.person_q.IPAddr := left.PERSON_ORIG_IP_ADDRESS1;
			self.person_q.FName :=  left.fname;
			self.person_q.MName :=  left.mname;
			self.person_q.LName :=  left.lname;
			self.person_q.Name_Suffix :=  left.name_suffix;
			self.person_q.prim_range  :=   left.prim_range;
			self.person_q.predir  :=   left.predir ;
			self.person_q.prim_name  :=   left.prim_name ;
			self.person_q.addr_suffix  :=   left.addr_suffix ;
			self.person_q.postdir  :=   left.postdir;
			self.person_q.unit_desig  :=   left.unit_desig;
			self.person_q.sec_range  :=   left.sec_range;
			self.person_q.v_city_name  :=   left.v_city_name;
			self.person_q.st  :=   left.st;
			self.person_q.zip5  :=   left.zip5;
			self.person_q.zip4  :=   left.zip4;
			self.person_q.addr_rec_type  :=   left.addr_rec_type ;
			self.person_q.fips_state :=   left.fips_state;
			self.person_q.fips_county :=   left.fips_county;
			self.person_q.geo_lat  :=   left.geo_lat;
			self.person_q.geo_long  :=   left.geo_long;
			self.person_q.cbsa  :=   left.cbsa;
			self.person_q.geo_blk  :=   left.geo_blk;
			self.person_q.geo_match  :=   left.geo_match;
			self.person_q.err_stat :=   left.err_stat;
			self.person_q.Appended_SSN := left.appendssn;
			self.person_q.Appended_ADL := left.appendadl;
			self := []));

bususer_project := project(AppendForward(repflag <> '' and source_file = select_source),
			transform(inquiry_acclogs.Layout.Common,

			self.mbs.Company_ID := left.Company_ID;
			self.mbs.Global_Company_ID := left.Global_Company_ID;

			self.allow_flags.Allowflags := left.Allowflags;

			self.bus_intel.Sub_market := left.sub_market;
			self.bus_intel.Industry := left.industry;
			self.bus_intel.Primary_Market_Code := left.Primary_Market_Code;
			self.bus_intel.Secondary_Market_Code := left.Secondary_Market_Code;
			self.bus_intel.Industry_1_Code := left.Industry_1_Code;
			self.bus_intel.Industry_2_Code := left.Industry_2_Code;
			self.bus_intel.Vertical := left.vertical;

			self.Permissions.GLB_purpose := left.glb_purpose;
			self.Permissions.DPPA_purpose := left.dppa_purpose;
			self.Permissions.FCRA_purpose := left.fcra_purpose;

			self.search_info.DateTime := left.datetime;
			self.search_info.Login_History_ID := left.login_history_id;
			self.search_info.Transaction_ID := left.transaction_id;
			self.search_info.Sequence_Number := left.sequence_number;
			self.search_info.Method := left.method;
			self.search_info.Product_Code := left.product_code;
			self.search_info.Transaction_Type := left.transaction_type;
			self.search_info.Function_Description := left.function_description;
			self.search_info.IPAddr := left.ORIG_IP_ADDRESS2;

			self.bus_q.CName := left.clean_cname1;
							self.bus_q.domain_name := left.domain_name;
							self.bus_q.ein := left.ein;
							self.bus_q.charter_number := left.Charter_Number;
							self.bus_q.ucc_number := left.UCC_Number;

			self.bususer_q.Title := '';
			self.bususer_q.First_Name := left.orig_fname;
			self.bususer_q.Middle_Name := left.orig_mname;
			self.bususer_q.Last_Name := left.orig_lname;
			self.bususer_q.Address := left.orig_addr1;
			self.bususer_q.City :=  left.orig_city1;
			self.bususer_q.State :=  left.orig_state1;
			self.bususer_q.Zip :=  left.orig_zip1;
			self.bususer_q.Personal_Phone :=  left.personal_phone;
			self.bususer_q.DOB := left.dob;
			self.bususer_q.DL := left.dl; // unique id
			self.bususer_q.DL_St := left.dl_state; // unique id
			self.bususer_q.FName := left.fname;
			self.bususer_q.MName := left.mname;
			self.bususer_q.LName := left.lname;
			self.bususer_q.Name_Suffix := left.name_suffix;
			self.bususer_q.prim_range  :=  left.prim_range;
			self.bususer_q.predir  :=  left.predir ;
			self.bususer_q.prim_name  :=  left.prim_name ;
			self.bususer_q.addr_suffix  :=  left.addr_suffix ;
			self.bususer_q.postdir  :=  left.postdir;
			self.bususer_q.unit_desig  :=  left.unit_desig;
			self.bususer_q.sec_range  :=  left.sec_range;
			self.bususer_q.v_city_name  :=  left.v_city_name;
			self.bususer_q.st  :=  left.st;
			self.bususer_q.zip5  :=  left.zip5;
			self.bususer_q.zip4  :=  left.zip4;
			self.bususer_q.addr_rec_type  :=  left.addr_rec_type ;
			self.bususer_q.fips_state :=  left.fips_state;
			self.bususer_q.fips_county :=  left.fips_county;
			self.bususer_q.geo_lat  :=  left.geo_lat;
			self.bususer_q.geo_long  :=  left.geo_long;
			self.bususer_q.cbsa  :=  left.cbsa;
			self.bususer_q.geo_blk  :=  left.geo_blk;
			self.bususer_q.geo_match  :=  left.geo_match;
			self.bususer_q.err_stat :=  left.err_stat;
			self.bususer_q.Appended_SSN := left.appendssn;
			self.bususer_q.Appended_ADL := left.appendadl;

			self := []));

update_records := bususer_project + person_project;

return dedup(sort(distribute(update_records, hash(search_info.Transaction_ID))(mbs.company_id + mbs.global_company_id <> ''),
												record, local), record, local);
end;

end;
