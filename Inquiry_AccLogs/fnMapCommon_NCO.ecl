import ut;

export fnMapCommon_NCO := module

export clean := function

n := inquiry_acclogs.test_count; /* n - to test a sample set, 0 to run all */

NullSet := inquiry_acclogs.fncleanfunctions.nullset;

pinputfile := choosen(inquiry_acclogs.File_NCO_Logs.input(
													stringlib.stringtouppercase(orig_company_id[1..3]) = 'NCO' and stringlib.stringtouppercase(orig_company_id[1..3]) not in ['','COMPANY_ID'] and
																				(orig_full_name not in nullset or 						// remove records with null names and company names
																				 orig_last_name not in nullset))
																					,IF(n > 0, n, choosen:ALL));

inputfile := distribute(project(pinputfile, transform({string orig_cid, inquiry_acclogs.Layout_NCO_Logs,
															string fullname1 := '';
															string fullname2 := '';
															string line1 := '';
															string line2 := ''},

														self.fullname1 := stringlib.stringcleanspaces(left.orig_first_name + ' ' + left.orig_middle_name + ' ' + left.orig_last_name);
														self.fullname2 :=left.orig_full_name;
														self.line1 := left.orig_addr1_street;
														self.line2 := stringlib.stringcleanspaces(left.orig_addr1_city + ' ' + left.orig_addr1_state + ' ' + left.orig_addr1_zip);
														self.orig_company_id := '1476744';
														self.orig_global_company_id := '8135331';
														self.orig_cid := left.orig_company_id;
														self.orig_link_id := map((unsigned)left.orig_link_id = 0 => '', left.orig_link_id);
														self := left)), random());

inquiry_acclogs.fncleanfunctions.cleanfields(inputfile, cleaned_fields);
Inquiry_AccLogs.File_MBSApp(cleaned_fields, 'NCO', '', outfile); // filter le, gov, healthcare, and disabled

/////// clean file - no company names or 2nd address information used for business reps

reconname := project(outfile, transform(Inquiry_AccLogs.layout_in_common,

							self.orig_full_name1 := stringlib.stringcleanspaces(left.orig_full_name);

							self.SSN := Inquiry_AccLogs.fncleanfunctions.clean_ssn(left.orig_ssn);

							self.PERSONAL_PHONE := Inquiry_AccLogs.fncleanfunctions.clean_phone(left.orig_phone);
							self.WORK_PHONE := Inquiry_AccLogs.fncleanfunctions.clean_phone(left.orig_work_phone);
							self.COMPANY_PHONE := Inquiry_AccLogs.fncleanfunctions.clean_phone(left.orig_company_phone);

							self.DOB := Inquiry_AccLogs.fncleanfunctions.clean_dob(left.orig_dob);

								fixDate := Inquiry_AccLogs.fncleanfunctions.tDateAdded(stringlib.stringfilterout(left.orig_datetime_stamp, '/'));
								fixTime := Inquiry_AccLogs.fncleanfunctions.tTimeAdded(fixDate);
							self.DateTime := fixTime;

							self.orig_company_name1 := left.orig_company_name;
							self.orig_fname := left.orig_first_name;
							self.orig_mname := left.orig_middle_name;
							self.orig_lname := left.orig_last_name;

							self.ORIG_ADDR1 		:= left.line1;
							self.ORIG_LASTLINE1 := left.line2;
							self.ORIG_CITY1 		:= left.orig_addr1_city;
							self.ORIG_STATE1 		:= left.orig_addr1_state;
							self.ORIG_ZIP1 			:= left.orig_addr1_zip;

							self.glb_purpose 		:= left.orig_glb_purpose;
							self.dppa_purpose 	:= left.orig_dppa_purpose;
							self.fcra_purpose 	:= left.orig_fcra_purpose;
							self.sequence_number 	:= left.orig_sequence_nbr;
							self.transaction_type := left.orig_transaction_type;
							self.orig_transaction_code 	:= left.orig_transaction_type;
							self.Function_Description 	:= left.orig_function_name;
							self.domain_name 			:= left.orig_domain_name;
							self.ein 							:= left.orig_fein;
							self.Charter_Number 	:= left.orig_Charter_Number;
							self.ucc_number				:= left.orig_ucc_original_filing_number;
							self.dl 							:= left.orig_dl_num;
							self.dl_state 				:= left.orig_dl_State;
							self.INDUSTRY_1_CODE 	:= left.industry_code_1;
							self.INDUSTRY_2_CODE 	:= left.industry_code_2;
							self.PERSON_ORIG_IP_ADDRESS1 := left.orig_ip_address_executed;
							self.ORIG_IP_ADDRESS2 := left.orig_ip_address_initiated;

							self.source_file 			:= 'NCO';

							self.email_address 		:= left.orig_email_address;
							self.linkid 					:= left.orig_link_id;

							self.stop_monitor 		:= left.orig_stop_monitor;

							self.GLOBAL_COMPANY_ID := left.orig_global_company_id;
							self.COMPANY_ID 			 := left.orig_company_id;

							self := left
							,self := []
							))(orig_full_name1 <> 'NO NAME');// : persist('~persist::nco::clean');

return reconname;
end;

///////////////// FINAL MAPPING ///////////////////////////////////////////////////////////////////////////////////////////////////////

export ready_File(dataset(inquiry_acclogs.layout_in_common) SSNFile, string select_source = 'NCO') := function

AppendForward := project(SSNFile(source_file = select_source), transform(inquiry_acclogs.Layout.Common,
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
			self.person_q.DL :=  left.dl;
			self.person_q.DL_St := left.dl_state; // unique id
			self.person_q.Email_Address := left.email_address;
			self.person_q.SSN :=  left.ssn;
			self.person_q.LinkID := left.linkid;
			self.person_q.IPAddr := '';
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
			self.person_q.appended_adl := left.appendadl;
			self.person_q.appended_ssn := left.appendssn;

			self.search_info.Start_Monitor := left.datetime[..8];
			self.search_info.Stop_Monitor := left.Stop_Monitor;


			self := left;
			self := []));


prev_base := inquiry_acclogs.File_NCO_Logs_Common;

jnToMBS := 	join(prev_base, dedup(Inquiry_AccLogs.File_MBS.File(id = '8135331' and idflag = 'GCID'), id, all),
													left.mbs.global_company_id = right.id,
													transform(inquiry_acclogs.layout.common,
																			self.mbs.global_company_id := '8135331';
																			self.mbs.company_id := '1476744';
																			self.search_info.product_code := right.product_id;
																			self.allow_flags.allowflags 					:= map(right.allowflags > 0 => right.allowflags, ut.bit_set(0,1) | ut.bit_set(0,13));
																			self.bus_intel.Primary_Market_Code 		:= map(right.mbs_primary_market_code <> '' => right.mbs_primary_market_code, left.bus_intel.primary_market_code);
																			self.bus_intel.Secondary_Market_Code 	:= map(right.mbs_Secondary_Market_Code <> '' => right.mbs_Secondary_Market_Code, left.bus_intel.Secondary_Market_Code);
																			self.bus_intel.Industry_1_Code 				:= map(right.mbs_Industry_Code_1 <> '' => right.mbs_Industry_Code_1, left.bus_intel.Industry_1_Code);
																			self.bus_intel.Industry_2_Code 				:= map(right.mbs_Industry_Code_2 <> '' => right.mbs_Industry_Code_2, left.bus_intel.Industry_2_Code);
																			self.bus_intel.Sub_market							:= if(right.sub_market <> '', right.sub_market, left.bus_intel.sub_market);
																			self.bus_intel.Vertical 							:= if(right.vertical <> '', right.vertical, left.bus_intel.vertical);
																			self.bus_intel.Use 										:= if(right.use <> '', right.use, left.bus_intel.use);
																			self.bus_intel.Industry 							:= if(right.industry <> '', right.industry, left.bus_intel.industry);
																			self := left),
													left outer, lookup);

baseMBS := project(jnToMBS,
									transform(inquiry_acclogs.Layout.Common,
														self := left));

distrNewBase := distribute(baseMBS + AppendForward, hash(search_info.Sequence_Number + search_info.Login_History_ID))(mbs.company_id + mbs.global_company_id <> '');

dedNewBase := dedup(sort(distrNewBase, search_info.Sequence_Number, search_info.Login_History_ID, -search_info.Stop_Monitor, local),
														 search_info.Sequence_Number, search_info.Login_History_ID, local);


return dedNewBase;
end;

end;
