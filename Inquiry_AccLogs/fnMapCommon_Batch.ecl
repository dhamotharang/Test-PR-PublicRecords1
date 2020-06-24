import ut, lib_stringlib, lib_word;

export fnMapCommon_Batch := module

export clean := function

n := inquiry_acclogs.test_count; /* n - to test a sample set, 0 to run all */

NullSet := inquiry_acclogs.fncleanfunctions.nullset;

inputfile := distribute(choosen(inquiry_acclogs.File_Batch_Logs.input
																				(orig_method <> 'METHOD' and orig_global_company_id <> '')
																				// (orig_last_name not in nullset or
																				 // orig_company_name not in nullset))
																		,IF(n > 0, n, choosen:ALL)), random()) // choosen for testing purposes
																		;

blankRefCode := inputfile(length(orig_address1_z5 + orig_address1_z4) < 12);

inquiry_acclogs.fncleanfunctions.cleanfields(blankRefCode, cleaned_fields);
inquiry_acclogs.File_MBSApp(cleaned_fields, 'BATCH', '', mbs_outfile)

/* !!!!!!!!!!!!!!!!! CLEAN NAMES, ADDRESSES, PHONES, SSN, etc !!!!!!!!!!!!!!!!!!!!! */

outfile := project(mbs_outfile,
										transform(Inquiry_Acclogs.Layout_In_Common,

														self.ORIG_FULL_NAME1 := stringlib.stringcleanspaces(left.orig_first_name + ' ' + left.orig_middle_name + ' ' + left.orig_last_name);
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

														self.ORIG_ADDR1 := line1;
														self.ORIG_LASTLINE1 := line2;
														self.ORIG_CITY1 := left.orig_address1_city;
														self.ORIG_STATE1 := left.orig_address1_st;
														self.ORIG_ZIP1 := left.orig_address1_z5 + left.orig_address1_z4;

														self.SSN := Inquiry_AccLogs.fncleanfunctions.clean_ssn(left.orig_ssn);

														self.WORK_PHONE := Inquiry_AccLogs.fncleanfunctions.clean_phone(left.orig_work_phone);
														self.PERSONAL_PHONE := Inquiry_AccLogs.fncleanfunctions.clean_phone(left.orig_phone);
														self.COMPANY_PHONE := Inquiry_AccLogs.fncleanfunctions.clean_phone(left.orig_company_phone);

														self.DOB := Inquiry_AccLogs.fncleanfunctions.clean_dob(left.orig_dob);

														fixTime := Inquiry_AccLogs.fncleanfunctions.tTimeAdded(left.orig_datetime_stamp[1..8] + ' ' + left.orig_datetime_stamp[9..16]);
														self.DateTime := fixTime;

														self.DL := left.orig_dl_num;
														self.DL_State := left.orig_dl_state;
														self.Email_Address := left.orig_email_address;
														self.LinkID := left.orig_did;
														self.domain_name := left.orig_domain_name;
														self.ein := left.orig_fein,
														self.charter_number := left.orig_charter_number,
														self.ucc_number := left.orig_ucc_original_filing_number,

														self.orig_fname := left.orig_first_name;
														self.orig_mname := left.orig_middle_name;
														self.orig_lname := left.orig_last_name;

														self.GLOBAL_COMPANY_ID := left.orig_global_company_id;
														self.COMPANY_ID := left.orig_company_id;

														self.orig_company_name1 := map(LIB_Word.Word(left.orig_company_name,2) <> '' => left.orig_company_name,
																													 left.orig_company_name = left.orig_last_name => '',
																													 left.orig_company_name);
														self.Industry_1_Code := left.Industry_Code_1;
														self.Industry_2_Code := left.Industry_Code_2;
														self.method := left.orig_method;
														self.Transaction_ID := left.orig_job_id;
														self.Sequence_number := left.orig_sequence_number;
														self.Product_Code := if(left.product_id = '', '1', left.product_id);
														self.Function_Description := left.orig_function_name;
														self.PERSON_ORIG_IP_ADDRESS1 := left.orig_ip_address_executed;
														self.ORIG_IP_ADDRESS2 := left.orig_ip_address_initiated;
														self.repflag	:= '';

														self.login_history_id := left.orig_login_history_id;
														self.transaction_type := left.orig_transaction_type;
														self.job_id := left.orig_job_id;

														self.GLB_purpose := '1'; ////// - default used for other products
														self.DPPA_purpose := '3'; ////// - default used for other products
														self.FCRA_purpose := '';

														self.source_file := 'BATCH';
														self := left,
														self := []));

return outfile;
end;



/* !!!!!!!!!!!!!!!!! FINAL MAPPINGS !!!!!!!!!!!!!!!!!!!!! */

export ready_File(dataset(inquiry_acclogs.layout_in_common) AppendForward, string select_source = 'BATCH') := function

///////////////// PROJECT INTO PERSON QUERY LAYOUT

person_project := project(AppendForward(repflag = '' and domain_name + clean_cname1 + ucc_number + ein + charter_number = '' and source_file = select_source),
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
			self.bus_q.appended_bdid := left.appendbdid;
			self.bus_q.appended_ein := left.appendtaxid;
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

			self := []));

bususer_project := project(AppendForward(repflag <> '' and source_file = select_source), transform(inquiry_acclogs.Layout.Common,

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
			self.bus_q.appended_bdid := left.appendbdid;
			self.bus_q.appended_ein := left.appendtaxid;
							self.bus_q.domain_name := left.domain_name;
							self.bus_q.ein := left.ein;
							self.bus_q.charter_number := left.Charter_Number;
							self.bus_q.ucc_number := left.ucc_number;

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
			self.bususer_q.DL := left.dl;
			self.bususer_q.DL_St := left.dl_state;
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

bus_project := project(AppendForward(repflag = '' and domain_name + clean_cname1 + ucc_number + ein + charter_number <> '' and source_file = select_source),
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


			self := left;
			self := []));


// prev_base := inquiry_acclogs.file_MBSApp_Base.file(version);

// baseMBS := project(prev_base(source = select_source),
									// transform(inquiry_acclogs.Layout.Common,
														// self := left))(mbs.company_id + mbs.global_company_id <> '');

return dedup(sort(distribute(bususer_project + person_project + bus_project,
														hash(search_info.Sequence_Number))(mbs.company_id + mbs.global_company_id <> '')
									, record, local), record, local);

end;

end;
