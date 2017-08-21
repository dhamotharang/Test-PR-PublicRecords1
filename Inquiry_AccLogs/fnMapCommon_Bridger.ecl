import ut, address, aid, lib_stringlib, address, did_add, Business_Header_SS;
import standard, header_slimsort, didville, business_header,watchdog, mdr, header;

export fnMapCommon_Bridger := module

export clean := function

n := inquiry_acclogs.test_count; /* n - to test a sample set, 0 to run all */

NullSet := inquiry_acclogs.fncleanfunctions.nullset;

inputfile_mixed := distribute(choosen(inquiry_acclogs.File_Bridger_Logs.input
																	,IF(n > 0, n, choosen:ALL)), random()) // choosen for testing purposes
																		; 		

inputfile := PROJECT(inputfile_mixed, TRANSFORM(Inquiry_Acclogs.Layout_Bridger_Logs.Input_Parsed,
																				SELF.DATETIME := LEFT.DATETIME;
																				SELF.ORIG_TRANSACTION_TYPE := '';
																				SELF.ORIG_GLOBAL_COMPANY_ID := '';
																				SELF.SOURCE_FILE := 'BRIDGER';
																				SELF.ORIG_COMPANY_ID := LEFT.customer_id;
																				SELF.LINKID := LEFT.ID;
																				SELF.ORIG_FNAME := IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field1, '');
																				SELF.ORIG_LNAME := IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field2, '');
																				SELF.ORIG_MNAME := IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field3, '');
																				SELF.ORIG_COMPANY_NAME1 := IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', '', LEFT.field1);
																				SELF.ORIG_ADDR1 := IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field5, LEFT.field2);
																				SELF.ORIG_LASTLINE1 := IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field6, LEFT.field3);
																				SELF.ORIG_CITY1 := IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field7, LEFT.field4);
																				SELF.ORIG_STATE1 := IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field8, LEFT.field5);
																				SELF.ORIG_ZIP1 := IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field9, LEFT.field6);
																				SELF.COMPANY_PHONE := IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', '', LEFT.field7);
																				SELF.EIN := IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', '', LEFT.field8);
																				SELF.GLB_purpose := IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field14, LEFT.field9);
																				SELF.DPPA_purpose := IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field15, LEFT.field10);
																				SELF.FCRA_purpose := IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field16, LEFT.field11);
																				SELF.SSN := IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field4, '');
																				SELF.PERSONAL_PHONE := IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field10, '');
																				SELF.DOB := IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field11, '');
																				SELF.DL := IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field12, '');
																				SELF.DL_STATE := IF(LEFT.ENTITY_TYPE = 'ENTITY_INDIVIDUAL', LEFT.field13, '');
																				SELF.ORIG_FUNCTION_NAME := LEFT.Search_Function_Name;
																				SELF.FUNCTION_DESCRIPTION := LEFT.Search_Function_Name;
																				SELF.ORIG_PRODUCT_ID := '1'; //CHANGE IF NECESSARY!!! NOT SURE!!!
																				SELF.ORIG_REFERENCE_CODE := LEFT.ENTITY_TYPE;
																				SELF := []));
																				
inquiry_acclogs.fncleanfunctions.cleanfields(inputfile, cleaned_fields);

inquiry_acclogs.File_MBSApp(cleaned_fields, 'BRIDGER', '', mbs_outfile)

/* !!!!!!!!!!!!!!!!! REMOVE NULLS and MAKE ALL CAPS FOR EASY JOINING !!!!!!!!!!!!!!!!!!!!! */					
removeNulls := project(mbs_outfile, transform(inquiry_acclogs.Layout_In_Common,

								self.orig_full_name1 := stringlib.stringcleanspaces(left.orig_fname + ' ' + left.orig_mname + ' ' + left.orig_lname);
								self.orig_lastline1 := stringlib.stringcleanspaces(left.orig_CITY1 + ' ' + left.orig_state1 + ' ' + left.orig_zip1);

								self.ssn := 		Inquiry_AccLogs.fncleanfunctions.clean_ssn(left.ssn);
								self.personal_phone := Inquiry_AccLogs.fncleanfunctions.clean_phone(left.PERSONAL_PHONE);
								self.work_phone := Inquiry_AccLogs.fncleanfunctions.clean_phone(left.COMPANY_phone);
								
								self.dob := 		Inquiry_AccLogs.fncleanfunctions.clean_dob(left.dob);
							
									fixDate := Inquiry_AccLogs.fncleanfunctions.tDateAdded(left.datetime);
									fixTime := Inquiry_AccLogs.fncleanfunctions.tTimeAdded(fixDate);
								self.DateTime := fixTime;	

								self.DL := left.dl; 
								self.DL_STATE := left.dl_state; 
								self.LinkID := left.LINKID;

								self.GLOBAL_COMPANY_ID := left.orig_global_company_id;
								self.COMPANY_ID := left.orig_company_id;
						
								self.Industry_1_Code 		:= left.Industry_Code_1;
								self.Industry_2_Code 		:= left.Industry_Code_2;

								self.Transaction_ID 		:= LEFT.DATETIME;
								self.Product_Code 			:= left.ORIG_PRODUCT_ID;
								self.Function_Description := map(left.description <> '' => left.description, left.orig_function_name);
								
								self.method := '';
								
								self.source_file := 'BRIDGER';
								self := left;
								self := []))(orig_lname + orig_company_name1 + orig_full_name1 <> '');// : persist('~persist::riskwise::clean');

return removenulls;
end;


export ready_File(dataset(inquiry_acclogs.Layout_In_Common) AppendForward, string select_source = 'BRIDGER') := function

///////////////// PROJECT INTO PERSON QUERY LAYOUT 
							
person_project := project(AppendForward(ORIG_REFERENCE_CODE = 'ENTITYINDIVIDUAL' and source_file = select_source), 
		transform(inquiry_acclogs.Layout.Common_ThorAdditions,
			self.source := stringlib.stringtouppercase(left.source_file);
			self.mbs.Company_ID := IF(left.Company_ID <> '', LEFT.company_id, LEFT.orig_company_id);
			self.mbs.Global_Company_ID := left.Global_Company_ID;
			
			self.allow_flags.Allowflags := left.Allowflags;

			self.bus_intel.Sub_market := left.sub_market;
			self.bus_intel.Industry := left.industry;
			self.bus_intel.Primary_Market_Code := left.Primary_Market_Code;
			self.bus_intel.Secondary_Market_Code := left.Secondary_Market_Code;
			self.bus_intel.Industry_1_Code := left.Industry_1_Code;
			self.bus_intel.Industry_2_Code := left.Industry_2_Code;
			self.bus_intel.Vertical := left.vertical;
			self.bus_intel.Use := left.use;

			
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
			self := left;
			self := []));

bus_project := project(AppendForward(ORIG_REFERENCE_CODE <> 'ENTITYINDIVIDUAL' and source_file = select_source), 
		transform(inquiry_acclogs.Layout.Common_ThorAdditions,
			self.source := stringlib.stringtouppercase(left.source_file);
			self.mbs.Company_ID := IF(left.Company_ID <> '', LEFT.company_id, LEFT.orig_company_id);
			self.mbs.Global_Company_ID := left.Global_Company_ID;
			
			self.allow_flags.Allowflags := left.Allowflags;

			self.bus_intel.Sub_market := left.sub_market;
			self.bus_intel.Industry := left.industry;
			self.bus_intel.Primary_Market_Code := left.Primary_Market_Code;
			self.bus_intel.Secondary_Market_Code := left.Secondary_Market_Code;
			self.bus_intel.Industry_1_Code := left.Industry_1_Code;
			self.bus_intel.Industry_2_Code := left.Industry_2_Code;
			self.bus_intel.Vertical := left.vertical;
			self.bus_intel.Use := left.use;

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
			
update_records := bus_project + person_project;

return dedup(sort(distribute(update_records, hash(search_info.Transaction_ID))(mbs.company_id + mbs.global_company_id <> ''), 
												record, local), record, local);
end;		

end;