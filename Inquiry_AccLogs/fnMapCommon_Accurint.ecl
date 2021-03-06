import ut, address, aid, lib_stringlib, address, did_add, Business_Header_SS;
import standard, header_slimsort, didville, business_header,watchdog, mdr, header;

export fnMapCommon_Accurint(string logs = '') := module

export clean := function

n := inquiry_acclogs.test_count; /* n - to test a sample set, 0 to run all */

NullSet := inquiry_acclogs.fncleanfunctions.nullset;

filter_input := choosen(if(logs[1..1] not in ['C','c'], inquiry_acclogs.File_Accurint_logs.input, inquiry_acclogs.File_Custom_logs.input)(orig_company_id <> '')
																				 ,IF(n > 0, n, choosen:ALL)); 											

addglobal_input := project(filter_input, transform({string orig_global_company_id := '', recordof(filter_input) - [orig_END_USER_ID, orig_LOGINID, orig_BILLING_CODE]},
																								self.orig_global_company_id := if(logs = 'CUSTOM' and left.orig_company_id = '1216650', '496741', '');
																								self.orig_company_id := if(logs = 'CUSTOM' and left.orig_company_id = '1216650', left.orig_billing_code, left.orig_company_id);
																								self := left));

Inquiry_AccLogs.File_MBSApp(addglobal_input, 'ACCURINT', '', outfileACCURINT); /* distributes in MBS macro by random */
Inquiry_AccLogs.File_MBSApp(addglobal_input, 'CUSTOM', '', outfileCUSTOM); 

mbs_appended := if(logs = 'CUSTOM', outfileCUSTOM, outfileACCURINT);

/* /////////////////// Clean UP /////////////////// */

inquiry_acclogs.fncleanfunctions.cleanfields(mbs_appended, cleaned_fields);

FileToCommon := project(cleaned_fields,
										transform(Inquiry_Acclogs.Layout_In_Common,

														// self.REPFLAG	:= map(regexfind('BUSINESS INSTANT ID', left.description) and (left.orig_lname <> '' or left.orig_full_name <> '') => 'Y', '');

														self.ORIG_FULL_NAME1 := stringlib.stringcleanspaces(stringlib.stringfindreplace(
																												map(left.orig_fname + left.orig_mname + left.orig_lname = '' => 
																												left.orig_full_name,
																												stringlib.stringcleanspaces(left.orig_fname + ' ' + left.orig_mname + ' ' + left.orig_lname))
																												, ',', ', '));
														self.ORIG_FULL_NAME2 := '';
														self.ORIG_FNAME := left.orig_fname;
														self.ORIG_MNAME := left.orig_mname;
														self.ORIG_LNAME := left.orig_lname;
														self.ORIG_NAMESUFFIX := '';
														
														self.ORIG_COMPANY_NAME1 := stringlib.stringcleanspaces(stringlib.stringfindreplace(left.ORIG_BUSINESS_NAME, ',', ', '));
														// self.CLEAN_CNAME1 := ut.CleanCompany(left.ORIG_BUSINESS_NAME);
														
														self.ORIG_ADDR1 := left.orig_address;
														self.ORIG_LASTLINE1 := stringlib.stringcleanspaces(left.orig_CITY + ' ' + left.orig_state + ' ' + left.orig_zip + left.orig_zip4);
														self.ORIG_CITY1 := left.orig_city;
														self.ORIG_STATE1 := left.orig_state;
														self.ORIG_ZIP1 := left.orig_zip + left.orig_zip4;
														
														self.SOURCE_FILE := logs;
														
														self.PERSON_ORIG_IP_ADDRESS1 := Inquiry_Acclogs.fnCleanFunctions.fraudback(left.description, left.ORIG_IP_ADDRESS);
														
														self.ORIG_IP_ADDRESS2 := map(self.PERSON_ORIG_IP_ADDRESS1 = '' => left.ORIG_IP_ADDRESS, '');
														
														self.GLB_purpose := left.orig_glb_purpose;
																								//http://webdev.br.seisint.com/documentation/BPS/glb_mappings.html
														self.DPPA_purpose := left.orig_dl_purpose;
																								//http://webdev.br.seisint.com/documentation/BPS/dppa_mappings.html
														self.FCRA_purpose := '0';
														
														self.PRODUCT_CODE := '1';
														self.TRANSACTION_TYPE := left.orig_transaction_type;
														self.FUNCTION_DESCRIPTION := left.description;

														self.ALLOWFLAGS := left.allowflags;
														self.Login_History_ID := left.orig_login_history_id;
														self.TRANSACTION_ID := left.orig_transaction_id;
														self.SEQUENCE_NUMBER := '';
														self.METHOD := map(left.orig_transaction_code = '110'=> 'ONLINE',
																							 left.orig_transaction_code = '163' => 'XML', '');
																
														self.PERSONAL_PHONE := Inquiry_AccLogs.fncleanfunctions.clean_phone(left.orig_phone);
														self.COMPANY_PHONE := Inquiry_AccLogs.fncleanfunctions.clean_phone(left.orig_phone);
														self.SSN := Inquiry_AccLogs.fncleanfunctions.clean_ssn(left.orig_ssn);
														self.DOB := Inquiry_AccLogs.fncleanfunctions.clean_dob(left.orig_dob);

														self.DL := map(left.unique_id_code = '11' => left.orig_unique_id, '');
														self.DOMAIN_NAME := map(left.unique_id_code = '10' => left.orig_unique_id, '');
														self.EIN := map(left.unique_id_code in ['27','13'] => left.orig_unique_id, '');
														self.CHARTER_NUMBER := map(left.unique_id_code = '5' => left.orig_unique_id, '');
														self.UCC_NUMBER := map(left.unique_id_code = '9' => left.orig_unique_id, '');
														self.LINKID := map(left.unique_id_code = '29' => left.orig_unique_id, '');
														
														fixDate := Inquiry_AccLogs.fncleanfunctions.tDateAdded(left.orig_dateadded);
														fixTime := Inquiry_AccLogs.fncleanfunctions.tTimeAdded(fixDate);
														self.DateTime := fixTime;
														
														self.GLOBAL_COMPANY_ID := left.orig_global_company_id;
														self.COMPANY_ID := left.orig_company_id;
														self.INDUSTRY_1_CODE := left.industry_code_1;
														self.INDUSTRY_2_CODE := left.industry_code_2;

														self := left,
														self := []));// : persist(if(logs[..1] in ['C','c'], '~persist::custom::clean', '~persist::accurint::clean'));


return FileToCommon;
end;

///////////////// BDID SSN TAXID DID APPENDS ///////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////// PROJECT INTO PERSON QUERY LAYOUT ///////////////////////////////////////////////////////////////////////////////////////////////////////
export ready_File(dataset(Inquiry_Acclogs.Layout_In_Common) AppendForward, string select_source = logs) := function

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
/* 			// self := left; */
			self := []));

///////////// PROJECT INTO BUSINESS QUERY LAYOUT ///////////////////////////////////////////////////////////////////////////////////////////////////////

bus_project := project(AppendForward(repflag = '' 
																		 and domain_name + clean_cname1 + ucc_number + ein + charter_number <> '' 
																		 and source_file = select_source), 
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

/* 			// self := left; */
			self := []));

///////////// PROJECT INTO BUSINESS USER QUERY LAYOUT ///////////////////////////////////////////////////////////////////////////////////////////////////////
			
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

/* 			// self := left; */
			self := []));

newFiles := person_project +
											bus_project +
											bususer_project;

// prev_base := inquiry_acclogs.file_MBSApp_Base.file(version);

// baseMBS := project(prev_base(source = select_source),
									// transform(inquiry_acclogs.Layout.Common,
														// self := left))(mbs.company_id + mbs.global_company_id <> '');

return dedup(sort(distribute(
											person_project +
											bus_project +
											bususer_project, 
										hash(search_info.Transaction_ID))(mbs.company_id + mbs.global_company_id <> ''), record, local), record, local);

end;
end;