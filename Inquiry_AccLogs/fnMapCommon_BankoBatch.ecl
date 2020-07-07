import ut, lib_stringlib;

export fnMapCommon_BankoBatch := module

export clean := function

n := inquiry_acclogs.test_count; /* n - to test a sample set, 0 to run all */

NullSet := inquiry_acclogs.fncleanfunctions.nullset;

inputfile := distribute(choosen(inquiry_acclogs.File_BankoBatch_Logs.input
																		,IF(n > 0, n, choosen:ALL)), random());

inquiry_acclogs.fncleanfunctions.cleanfields(inputfile, cleaned_fields);
Inquiry_AccLogs.File_MBSApp(cleaned_fields,'BANKO', '', outfile);

/////////////////NAME AND BUSINESS CLEAN NEW FILE - REMOVE NULL IDENTIFIERS - ASSIGN UNIQUE ID FIELDS/////////////////////////////////////////////////////////

reconname := project(outfile, transform(inquiry_acclogs.layout_in_common,

														self.ORIG_IP_ADDRESS2 := left.orig_ip_address_executed;
														self.PERSON_ORIG_IP_ADDRESS1 := left.orig_ip_address_initiated;

														self.ORIG_FULL_NAME1 := stringlib.stringcleanspaces(stringlib.stringfindreplace(left.orig_full_name
																												, ',', ', '));
														self.ORIG_FULL_NAME2 := '';
														self.ORIG_FNAME := left.orig_first_name;
														self.ORIG_MNAME := left.orig_middle_name;
														self.ORIG_LNAME := left.orig_last_name;
														self.ORIG_NAMESUFFIX := '';

														self.ORIG_ADDR1 := left.orig_addr1_street;
														self.ORIG_LASTLINE1 := stringlib.stringcleanspaces(left.orig_addr1_CITY + ' ' + left.orig_addr1_state + ' ' + left.orig_addr1_zip);
														self.ORIG_CITY1 := left.orig_addr1_CITY;
														self.ORIG_STATE1 := left.orig_addr1_state;
														self.ORIG_ZIP1 := left.orig_addr1_zip;

														SELF.ORIG_COMPANY_NAME1 := LEFT.ORIG_COMPANY_NAME;

														self.SSN := Inquiry_AccLogs.fncleanfunctions.clean_ssn(left.orig_ssn);
														self.WORK_PHONE := Inquiry_AccLogs.fncleanfunctions.clean_phone(left.orig_work_phone);
														self.PERSONAL_PHONE := Inquiry_AccLogs.fncleanfunctions.clean_phone(left.orig_phone);
														self.COMPANY_PHONE := Inquiry_AccLogs.fncleanfunctions.clean_phone(left.orig_company_phone);
														self.DOB := Inquiry_AccLogs.fncleanfunctions.clean_dob(left.orig_dob);

														fixDate := Inquiry_AccLogs.fncleanfunctions.tDateAdded(stringlib.stringfilterout(left.orig_datetime_stamp, '/'));
														fixTime := Inquiry_AccLogs.fncleanfunctions.tTimeAdded(fixDate);
														self.DateTime := fixTime;

														self.GLOBAL_COMPANY_ID := left.orig_global_company_id;
														self.COMPANY_ID := left.orig_company_id;

														self.method := 'BATCH';

														self.INDUSTRY_1_CODE := left.industry_code_1;
														self.INDUSTRY_2_CODE := left.industry_code_2;
														self.FCRA_purpose := left.orig_fcra_purpose;
														self.GLB_purpose := left.orig_glb_purpose;
														self.DPPA_purpose := left.orig_dppa_purpose;

														self.Login_History_ID := left.orig_login_history_id;
														self.job_id := left.orig_job_id;
														self.sequence_number := left.orig_sequence_nbr;
														self.Product_Code := '5';
														self.Function_Description := left.orig_function_name;
														self.primary_market_code := left.primary_market_code;
														self.secondary_market_code := left.secondary_market_code;
														self.sub_market := left.sub_market;
														self.vertical := left.vertical;
														self.industry := left.industry;
														self.email_address := left.orig_email_address;
														self.dl := left.orig_dl_num;
														self.dl_state := left.orig_dl_state;
														self.domain_name := left.orig_domain_name;
														self.ein := left.orig_fein;
														self.charter_number := left.orig_charter_number;
														self.ucc_number := left.orig_ucc_original_filing_number;
														self.linkid := left.orig_link_id;

														self.source_file := 'BANKOBATCH';

														self := left,
														self := []));

return reconname;
end;




///////////////// FINAL MAPPING ///////////////////////////////////////////////////////////////////////////////////////////////////////

export ready_File(dataset(inquiry_acclogs.layout_in_common) SSNFile, string select_source = 'BANKOBATCH') := function


PersonData := project(SSNFile(source_file = select_source and domain_name + clean_cname1 + ucc_number + ein + charter_number = ''), transform(inquiry_acclogs.Layout.Common,
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

			self.search_info.Start_Monitor := left.datetime[1..8];

			self := left;
			self := []));

BusinessData := project(SSNFile(source_file = select_source and domain_name + clean_cname1 + ucc_number + ein + charter_number <> ''), transform(inquiry_acclogs.Layout.Common,
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

			self.search_info.Start_Monitor := left.datetime[1..8];

			self := left;
			self := []));

previous_data := inquiry_acclogs.File_BankoBatch_Logs_Common;

AppendForward := businessdata + persondata + previous_data;

mapped_file := dedup(sort(distribute(AppendForward, hash(search_info.Sequence_Number)), record, local), record, local);

joinBB := distribute(join(mapped_file,
													table(mapped_file, {search_info.sequence_number, search_info.datetime, search_info.start_monitor}),
														left.search_info.sequence_number = right.sequence_number and
														left.search_info.datetime <> right.datetime,
										transform(inquiry_acclogs.Layout.common,
											pstop_monitor := map((unsigned6)left.search_info.start_monitor > (unsigned6)right.start_monitor => left.search_info.start_monitor,
																					 (unsigned6)right.start_monitor > (unsigned6)left.search_info.start_monitor => right.start_monitor, '');

											self.search_info.stop_monitor := if((unsigned6)pstop_monitor = (unsigned6)left.search_info.start_monitor, '', pstop_monitor),
											self := left), left outer, local), hash(search_info.sequence_number));

srtBB := dedup(sort(joinBB, search_info.sequence_number, -search_info.stop_monitor, local), search_info.sequence_number, local);

return srtBB; // no new files. only run when necessary.
end;

end;
