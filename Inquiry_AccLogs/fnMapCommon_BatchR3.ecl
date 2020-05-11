import ut;

export fnMapCommon_BatchR3 := module

export clean := function


N := inquiry_acclogs.test_count; /* n - to test a sample set, 0 to run all */

NullSet := inquiry_acclogs.fncleanfunctions.nullset;

///////////////////////////////////////////////////////////////////////////////////////////

InputFile := choosen(Inquiry_acclogs.File_BatchR3_Logs.Input
																,IF(n > 0, n, choosen:ALL));

inquiry_acclogs.fncleanfunctions.cleanfields(InputFile, cleaned_fields);

Inquiry_AccLogs.File_MBSApp(cleaned_fields, 'BATCHR3', '', outfileBatchR3);

filter_out_fcra := join(outfileBatchR3, inquiry_acclogs.Proc_Prod_R3Monitoring.File_PIDs(~isFcra), left.orig_global_company_id = right.gcid, lookup);

NormFiles := normalize(filter_out_fcra, 2,
													transform(recordof(filter_out_fcra),
																				self.orig_full_name := choose(counter, left.orig_full_name, '');
																				self.orig_personal_phone := choose(counter, left.orig_personal_phone, '');
																				self.orig_work_phone := choose(counter, left.orig_work_phone, '');
																				self.orig_dob := choose(counter, left.orig_dob, '');
																				self.orig_dl := choose(counter, left.orig_dl, '');
																				self.orig_dl_state := choose(counter, left.orig_dl_state, '');
																				self.orig_email := choose(counter, left.orig_email, '');
																				self.orig_ssn := choose(counter, left.orig_ssn, '');
																				self.orig_linkid := choose(counter, left.orig_linkid, '');
																				self.orig_ipaddr := choose(counter, left.orig_ipaddr, '');
																				self.orig_addr1_1 := choose(counter, left.orig_addr1_1, '');
																				self.orig_addr2_1 := choose(counter, left.orig_addr2_1, '');
																				self.orig_city_1 := choose(counter, left.orig_city_1, '');
																				self.orig_st_1 := choose(counter, left.orig_st_1, '');
																				self.orig_zip_1 := choose(counter, left.orig_zip_1, '');

																				self.orig_cname := choose(counter, '', left.orig_cname);
																				self.orig_company_phone := choose(counter, '', left.orig_company_phone);
																				self.orig_ein := choose(counter, '', left.orig_ein);
																				self.orig_charter_number := choose(counter, '', left.orig_charter_number);
																				self.orig_ucc_number := choose(counter, '', left.orig_ucc_number);
																				self.orig_domain_name := choose(counter, '', left.orig_domain_name);
																				self.orig_addr1_2 := choose(counter, '', left.orig_addr1_2);
																				self.orig_addr2_2 := choose(counter, '', left.orig_addr2_2);
																				self.orig_city_2 := choose(counter, '', left.orig_city_1);
																				self.orig_st_2 := choose(counter, '', left.orig_st_1);
																				self.orig_zip_2 := choose(counter, '', left.orig_zip_1);
																				self := left))(orig_cname <> '' or orig_full_name <> '');

clean_out :=  PROJECT(NormFiles,
								TRANSFORM(Inquiry_AccLogs.layout_in_common,

			self.orig_company_name1 := left.orig_cname;
			self.orig_full_name1 := left.orig_full_name;
														self.ORIG_FULL_NAME2 :='';

			self.ORIG_ADDR1				:= map(left.orig_full_name <> '' => stringlib.stringcleanspaces(left.orig_addr1_1) , stringlib.stringcleanspaces(left.orig_addr1_2));
			self.ORIG_CITY1					:= map(left.orig_full_name <> '' => left.orig_city_1 , left.orig_city_2);
			self.ORIG_STATE1					:= map(left.orig_full_name <> '' => left.orig_st_1 , left.orig_st_2);
			self.ORIG_ZIP1						:= map(left.orig_full_name <> '' => left.orig_zip_1 , left.orig_zip_2);
			self.ORIG_LASTLINE1						:= stringlib.stringcleanspaces(self.orig_addr1 + ' ' + self.orig_city1 + ' ' + self.orig_state1 + ' ' + self.orig_zip1);
			self.PERSON_ORIG_IP_ADDRESS1		:= Inquiry_Acclogs.fnCleanFunctions.fraudback(left.description, left.orig_IPADDR);
			self.ORIG_IP_ADDRESS2		:= map(self.PERSON_ORIG_IP_ADDRESS1 = '' => left.orig_IPADDR, '');

			self.GLOBAL_COMPANY_ID := left.orig_global_company_id;
			self.COMPANY_ID := left.orig_company_id;

			self.Sub_Market := left.Sub_Market;
			self.Vertical := left.Vertical;
			self.Industry := left.industry;

			self.allowflags := left.allowflags;

			self.Sequence_Number := left.orig_sequence_number;
			self.Method := 'MONITORING';
			self.Product_Code := left.product_id;
			self.Function_Description := map(left.product_id = '1' => 'ACCURINT MONITORING',
																			 left.product_id = '2' => 'RISKWISE MONITORING',
																			 left.product_id = '5' => 'BANKRUPTCY MONITORING', left.orig_method);
			self.repflag	:= '';

			self.PERSONAL_PHONE := Inquiry_AccLogs.fncleanfunctions.clean_phone(left.orig_personal_phone);
			self.WORK_PHONE := Inquiry_AccLogs.fncleanfunctions.clean_phone(left.orig_work_phone);
			self.COMPANY_PHONE := Inquiry_AccLogs.fncleanfunctions.clean_phone(left.orig_company_phone);
			fixDate := Inquiry_AccLogs.fncleanfunctions.tDateAdded(left.orig_datetime);
			fixTime := Inquiry_AccLogs.fncleanfunctions.tTimeAdded(fixDate);
			self.DateTime := fixTime;
			self.SSN := Inquiry_AccLogs.fncleanfunctions.clean_ssn(left.orig_ssn);
			self.DOB := Inquiry_AccLogs.fncleanfunctions.clean_dob(left.orig_dob);

			self.dl 						:= left.orig_dl;
			self.domain_name 		:= left.orig_domain_name;
			self.ein 						:= left.orig_ein;
			self.charter_number := left.orig_charter_number;
			self.ucc_number 		:= left.orig_ucc_number;
			self.linkid 				:= left.orig_linkid;

			self.source_file := 'BATCHR3';

			self := LEFT;
			self := []));


return clean_out;
end;

export ready_File(dataset(inquiry_acclogs.layout_in_common) AppendForward, string select_source = 'BATCHR3') := function

person_project := project(AppendForward(domain_name + clean_cname1 + ucc_number + ein + charter_number = '' and source_file = select_source),
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
							self.bus_q.ucc_number := left.ucc_number;

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
			// self := left;
			self := []));

///////////////// PROJECT INTO BUSINESS QUERY LAYOUT ///////////////////////////////////////////////////////////////////////////////////////////////////////

bus_project := project(AppendForward(domain_name + clean_cname1 + ucc_number + ein + charter_number <> '' and source_file = select_source),
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
			self.bus_q.Address :=  left.orig_addr1;
			self.bus_q.City :=   left.orig_city1;
			self.bus_q.State :=   left.orig_state1;
			self.bus_q.Zip :=   left.orig_zip1;
			self.bus_q.Company_Phone :=   left.company_phone;
							self.bus_q.domain_name := left.domain_name;
							self.bus_q.ein := left.ein;
							self.bus_q.charter_number := left.Charter_Number;
							self.bus_q.ucc_number := left.UCC_Number;
			self.bus_q.prim_range  :=  left.prim_range ;
			self.bus_q.predir  :=  left.predir;
			self.bus_q.prim_name  :=  left.prim_name;
			self.bus_q.addr_suffix  :=  left.addr_suffix;
			self.bus_q.postdir  :=  left.postdir;
			self.bus_q.unit_desig  :=  left.unit_desig;
			self.bus_q.sec_range  :=  left.sec_range ;
			self.bus_q.v_city_name  :=  left.v_city_name ;
			self.bus_q.st  :=  left.st;
			self.bus_q.zip5  :=  left.zip5 ;
			self.bus_q.zip4  :=  left.zip4 ;
			self.bus_q.addr_rec_type  :=  left.addr_rec_type ;
			self.bus_q.fips_state :=  left.fips_state;
			self.bus_q.fips_county :=  left.fips_county;
			self.bus_q.geo_lat  :=  left.geo_lat ;
			self.bus_q.geo_long  :=  left.geo_long ;
			self.bus_q.cbsa  :=  left.cbsa;
			self.bus_q.geo_blk  :=  left.geo_blk ;
			self.bus_q.geo_match  :=  left.geo_match;
			self.bus_q.err_stat :=  left.err_stat;
			self.bus_q.appended_bdid := left.appendbdid;
			self.bus_q.appended_ein := left.appendtaxid;
			self := []));

return dedup(sort(distribute(person_project + bus_project,
															hash(search_info.Sequence_Number + person_q.lname + bususer_q.lname + bus_q.cname))
															(mbs.company_id + mbs.global_company_id <> ''), record, local), record, local);

end;

end;
