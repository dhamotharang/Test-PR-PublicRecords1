IMPORT Inquiry_AccLogs, BIPV2;

EXPORT Transforms := MODULE

	EXPORT Inquiry_Services.Layouts.Batch_Raw xfrom_toBatchRaw(Inquiry_Services.Layouts.Batch_Raw_Linkid inRec) := TRANSFORM
				
				SELF.primary_market_code 		:= inRec.bus_intel.primary_market_code;
				SELF.secondary_market_code 	:= inRec.bus_intel.secondary_market_code;
				SELF.industry_1_code 				:= inRec.bus_intel.industry_1_code;
				SELF.industry_2_code 				:= inRec.bus_intel.industry_2_code;
				SELF.sub_market 						:= inRec.bus_intel.sub_market;
				SELF.vertical 							:= inRec.bus_intel.vertical;
				SELF.inteluse 							:= inRec.bus_intel.use;
				SELF.industry 							:= inRec.bus_intel.industry;
				SELF.source 								:= inRec.source;
				SELF.fraudpoint_score 			:= inRec.fraudpoint_score;
				SELF.inquiry_dateTime				:= inRec.search_info.datetime;
				SELF.inquiry_transactionID	:= inRec.search_info.transaction_id;
				SELF.inquiry_seqNum					:= inRec.search_info.sequence_number;
																		
				// Person info
				SELF.inquired_person_fname 					:= inRec.person_q.fname;
				SELF.inquired_person_mname 					:= inRec.person_q.mname;
				SELF.inquired_person_lname 					:= inRec.person_q.lname;
				SELF.inquired_person_name_suffix 		:= inRec.person_q.name_suffix;
				SELF.inquired_person_did 						:= inRec.person_q.appended_adl;
				SELF.inquired_person_email_address 	:= inRec.person_q.email_address;
				SELF.inquired_person_personal_phone := inRec.person_q.personal_phone;
				SELF.inquired_person_work_phone 		:= inRec.person_q.work_phone;
				SELF.inquired_person_dob 						:= inRec.person_q.dob;
				SELF.inquired_person_dl 						:= inRec.person_q.dl;
				SELF.inquired_person_dl_st 					:= inRec.person_q.dl_st;
				SELF.inquired_person_ssn 						:= inRec.person_q.appended_ssn;
				SELF.inquired_person_prim_range			:= inRec.person_q.prim_range;
				SELF.inquired_person_predir 				:= inRec.person_q.predir;
				SELF.inquired_person_prim_name 			:= inRec.person_q.prim_name;
				SELF.inquired_person_addr_suffix		:= inRec.person_q.addr_suffix;
				SELF.inquired_person_postdir 				:= inRec.person_q.postdir;
				SELF.inquired_person_unit_desig 		:= inRec.person_q.unit_desig;
				SELF.inquired_person_sec_range 			:= inRec.person_q.sec_range;
				SELF.inquired_person_v_city_name		:= inRec.person_q.v_city_name;
				SELF.inquired_person_st 						:= inRec.person_q.st;
				SELF.inquired_person_zip5 					:= inRec.person_q.zip5;
				SELF.inquired_person_zip4 					:= inRec.person_q.zip4;
				SELF.inquired_person_addr_rec_type 	:= inRec.person_q.addr_rec_type;
				SELF.inquired_person_fips_state 		:= inRec.person_q.fips_state;
				SELF.inquired_person_fips_county 		:= inRec.person_q.fips_county;
														
				// Business Info
				SELF.inquired_business_UltID						:= inRec.UltID;
				SELF.inquired_business_OrgID						:= inRec.OrgID;
				SELF.inquired_business_SeleID						:= inRec.SeleID;
				SELF.inquired_business_ProxID						:= inRec.ProxID;
				SELF.inquired_business_PowID						:= inRec.PowID;
				SELF.inquired_business_EmpID						:= inRec.EmpID;
				SELF.inquired_business_DotID						:= inRec.DotID;
				SELF.inquired_business_bdid							:= inRec.bus_q.appended_bdid;
				SELF.inquired_business_ein							:= inRec.bus_q.appended_ein;
				SELF.inquired_business_company_name 		:= inRec.bus_q.cname;
				SELF.inquired_business_company_phone 		:= inRec.bus_q.company_phone;
				SELF.inquired_business_charter_number 	:= inRec.bus_q.charter_number;
				SELF.inquired_business_ucc_number 			:= inRec.bus_q.ucc_number;
				SELF.inquired_business_domain_name 			:= inRec.bus_q.domain_name;
				SELF.inquired_business_prim_range				:= inRec.bus_q.prim_range;
				SELF.inquired_business_predir 					:= inRec.bus_q.predir;
				SELF.inquired_business_prim_name 				:= inRec.bus_q.prim_name;
				SELF.inquired_business_addr_suffix			:= inRec.bus_q.addr_suffix;
				SELF.inquired_business_postdir 					:= inRec.bus_q.postdir;
				SELF.inquired_business_unit_desig 			:= inRec.bus_q.unit_desig;
				SELF.inquired_business_sec_range 				:= inRec.bus_q.sec_range;
				SELF.inquired_business_v_city_name			:= inRec.bus_q.v_city_name;
				SELF.inquired_business_st 							:= inRec.bus_q.st;
				SELF.inquired_business_zip5 						:= inRec.bus_q.zip5;
				SELF.inquired_business_zip4 						:= inRec.bus_q.zip4;
				SELF.inquired_business_addr_rec_type 		:= inRec.bus_q.addr_rec_type;
				SELF.inquired_business_fips_state 			:= inRec.bus_q.fips_state;
				SELF.inquired_business_fips_county 			:= inRec.bus_q.fips_county;
																		
				// Business user 1
				SELF.inquired_bus_user1_fname 					:= inRec.bususer_q.fname;
				SELF.inquired_bus_user1_mname 					:= inRec.bususer_q.mname;
				SELF.inquired_bus_user1_lname 					:= inRec.bususer_q.lname;
				SELF.inquired_bus_user1_name_suffix 		:= inRec.bususer_q.name_suffix;
				SELF.inquired_bus_user1_did 						:= inRec.bususer_q.appended_adl;
				SELF.inquired_bus_user1_personal_phone 	:= inRec.bususer_q.personal_phone;
				SELF.inquired_bus_user1_dob 						:= inRec.bususer_q.dob;
				SELF.inquired_bus_user1_dl 							:= inRec.bususer_q.dl;
				SELF.inquired_bus_user1_dl_st 					:= inRec.bususer_q.dl_st;
				SELF.inquired_bus_user1_ssn 						:= inRec.bususer_q.appended_ssn;
				SELF.inquired_bus_user1_prim_range			:= inRec.bususer_q.prim_range;
				SELF.inquired_bus_user1_predir 					:= inRec.bususer_q.predir;
				SELF.inquired_bus_user1_prim_name 			:= inRec.bususer_q.prim_name;
				SELF.inquired_bus_user1_addr_suffix			:= inRec.bususer_q.addr_suffix;
				SELF.inquired_bus_user1_postdir 				:= inRec.bususer_q.postdir;
				SELF.inquired_bus_user1_unit_desig 			:= inRec.bususer_q.unit_desig;
				SELF.inquired_bus_user1_sec_range 			:= inRec.bususer_q.sec_range;
				SELF.inquired_bus_user1_v_city_name			:= inRec.bususer_q.v_city_name;
				SELF.inquired_bus_user1_st 							:= inRec.bususer_q.st;
				SELF.inquired_bus_user1_zip5 						:= inRec.bususer_q.zip5;
				SELF.inquired_bus_user1_zip4 						:= inRec.bususer_q.zip4;
				SELF.inquired_bus_user1_addr_rec_type 	:= inRec.bususer_q.addr_rec_type;
				SELF.inquired_bus_user1_fips_state 			:= inRec.bususer_q.fips_state;
				SELF.inquired_bus_user1_fips_county 		:= inRec.bususer_q.fips_county;
																																
				// Business user 2
				SELF.inquired_bus_user2_fname 					:= inRec.bususer_q2.fname;
				SELF.inquired_bus_user2_mname 					:= inRec.bususer_q2.mname;
				SELF.inquired_bus_user2_lname 					:= inRec.bususer_q2.lname;
				SELF.inquired_bus_user2_name_suffix 		:= inRec.bususer_q2.name_suffix;
				SELF.inquired_bus_user2_did 						:= inRec.bususer_q2.appended_adl;
				SELF.inquired_bus_user2_personal_phone 	:= inRec.bususer_q2.personal_phone;
				SELF.inquired_bus_user2_dob 						:= inRec.bususer_q2.dob;
				SELF.inquired_bus_user2_dl 							:= inRec.bususer_q2.dl;
				SELF.inquired_bus_user2_dl_st 					:= inRec.bususer_q2.dl_st;
				SELF.inquired_bus_user2_ssn 						:= inRec.bususer_q2.appended_ssn;
				SELF.inquired_bus_user2_prim_range			:= inRec.bususer_q2.prim_range;
				SELF.inquired_bus_user2_predir 					:= inRec.bususer_q2.predir;
				SELF.inquired_bus_user2_prim_name 			:= inRec.bususer_q2.prim_name;
				SELF.inquired_bus_user2_addr_suffix			:= inRec.bususer_q2.addr_suffix;
				SELF.inquired_bus_user2_postdir 				:= inRec.bususer_q2.postdir;
				SELF.inquired_bus_user2_unit_desig 			:= inRec.bususer_q2.unit_desig;
				SELF.inquired_bus_user2_sec_range 			:= inRec.bususer_q2.sec_range;
				SELF.inquired_bus_user2_v_city_name			:= inRec.bususer_q2.v_city_name;
				SELF.inquired_bus_user2_st 							:= inRec.bususer_q2.st;
				SELF.inquired_bus_user2_zip5 						:= inRec.bususer_q2.zip5;
				SELF.inquired_bus_user2_zip4 						:= inRec.bususer_q2.zip4;
				SELF.inquired_bus_user2_addr_rec_type 	:= inRec.bususer_q2.addr_rec_type;
				SELF.inquired_bus_user2_fips_state 			:= inRec.bususer_q2.fips_state;
				SELF.inquired_bus_user2_fips_county 		:= inRec.bususer_q2.fips_county;

				// Business user 3
				SELF.inquired_bus_user3_fname 					:= inRec.bususer_q3.fname;
				SELF.inquired_bus_user3_mname 					:= inRec.bususer_q3.mname;
				SELF.inquired_bus_user3_lname 					:= inRec.bususer_q3.lname;
				SELF.inquired_bus_user3_name_suffix 		:= inRec.bususer_q3.name_suffix;
				SELF.inquired_bus_user3_did 						:= inRec.bususer_q3.appended_adl;
				SELF.inquired_bus_user3_personal_phone 	:= inRec.bususer_q3.personal_phone;
				SELF.inquired_bus_user3_dob 						:= inRec.bususer_q3.dob;
				SELF.inquired_bus_user3_dl 							:= inRec.bususer_q3.dl;
				SELF.inquired_bus_user3_dl_st 					:= inRec.bususer_q3.dl_st;
				SELF.inquired_bus_user3_ssn 						:= inRec.bususer_q3.appended_ssn;
				SELF.inquired_bus_user3_prim_range			:= inRec.bususer_q3.prim_range;
				SELF.inquired_bus_user3_predir 					:= inRec.bususer_q3.predir;
				SELF.inquired_bus_user3_prim_name 			:= inRec.bususer_q3.prim_name;
				SELF.inquired_bus_user3_addr_suffix			:= inRec.bususer_q3.addr_suffix;
				SELF.inquired_bus_user3_postdir 				:= inRec.bususer_q3.postdir;
				SELF.inquired_bus_user3_unit_desig 			:= inRec.bususer_q3.unit_desig;
				SELF.inquired_bus_user3_sec_range 			:= inRec.bususer_q3.sec_range;
				SELF.inquired_bus_user3_v_city_name			:= inRec.bususer_q3.v_city_name;
				SELF.inquired_bus_user3_st 							:= inRec.bususer_q3.st;
				SELF.inquired_bus_user3_zip5 						:= inRec.bususer_q3.zip5;
				SELF.inquired_bus_user3_zip4 						:= inRec.bususer_q3.zip4;
				SELF.inquired_bus_user3_addr_rec_type 	:= inRec.bususer_q3.addr_rec_type;
				SELF.inquired_bus_user3_fips_state 			:= inRec.bususer_q3.fips_state;
				SELF.inquired_bus_user3_fips_county 		:= inRec.bususer_q3.fips_county;
																																
				// Business user 4
				SELF.inquired_bus_user4_fname 					:= inRec.bususer_q4.fname;
				SELF.inquired_bus_user4_mname 					:= inRec.bususer_q4.mname;
				SELF.inquired_bus_user4_lname 					:= inRec.bususer_q4.lname;
				SELF.inquired_bus_user4_name_suffix 		:= inRec.bususer_q4.name_suffix;
				SELF.inquired_bus_user4_did 						:= inRec.bususer_q4.appended_adl;
				SELF.inquired_bus_user4_personal_phone 	:= inRec.bususer_q4.personal_phone;
				SELF.inquired_bus_user4_dob 						:= inRec.bususer_q4.dob;
				SELF.inquired_bus_user4_dl 							:= inRec.bususer_q4.dl;
				SELF.inquired_bus_user4_dl_st 					:= inRec.bususer_q4.dl_st;
				SELF.inquired_bus_user4_ssn 						:= inRec.bususer_q4.appended_ssn;
				SELF.inquired_bus_user4_prim_range			:= inRec.bususer_q4.prim_range;
				SELF.inquired_bus_user4_predir 					:= inRec.bususer_q4.predir;
				SELF.inquired_bus_user4_prim_name 			:= inRec.bususer_q4.prim_name;
				SELF.inquired_bus_user4_addr_suffix			:= inRec.bususer_q4.addr_suffix;
				SELF.inquired_bus_user4_postdir 				:= inRec.bususer_q4.postdir;
				SELF.inquired_bus_user4_unit_desig 			:= inRec.bususer_q4.unit_desig;
				SELF.inquired_bus_user4_sec_range 			:= inRec.bususer_q4.sec_range;
				SELF.inquired_bus_user4_v_city_name			:= inRec.bususer_q4.v_city_name;
				SELF.inquired_bus_user4_st 							:= inRec.bususer_q4.st;
				SELF.inquired_bus_user4_zip5 						:= inRec.bususer_q4.zip5;
				SELF.inquired_bus_user4_zip4 						:= inRec.bususer_q4.zip4;
				SELF.inquired_bus_user4_addr_rec_type 	:= inRec.bususer_q4.addr_rec_type;
				SELF.inquired_bus_user4_fips_state 			:= inRec.bususer_q4.fips_state;
				SELF.inquired_bus_user4_fips_county 		:= inRec.bususer_q4.fips_county;
																																
				// Business user 5
				SELF.inquired_bus_user5_fname 					:= inRec.bususer_q5.fname;
				SELF.inquired_bus_user5_mname 					:= inRec.bususer_q5.mname;
				SELF.inquired_bus_user5_lname 					:= inRec.bususer_q5.lname;
				SELF.inquired_bus_user5_name_suffix 		:= inRec.bususer_q5.name_suffix;
				SELF.inquired_bus_user5_did 						:= inRec.bususer_q5.appended_adl;
				SELF.inquired_bus_user5_personal_phone 	:= inRec.bususer_q5.personal_phone;
				SELF.inquired_bus_user5_dob 						:= inRec.bususer_q5.dob;
				SELF.inquired_bus_user5_dl 							:= inRec.bususer_q5.dl;
				SELF.inquired_bus_user5_dl_st 					:= inRec.bususer_q5.dl_st;
				SELF.inquired_bus_user5_ssn 						:= inRec.bususer_q5.appended_ssn;
				SELF.inquired_bus_user5_prim_range			:= inRec.bususer_q5.prim_range;
				SELF.inquired_bus_user5_predir 					:= inRec.bususer_q5.predir;
				SELF.inquired_bus_user5_prim_name 			:= inRec.bususer_q5.prim_name;
				SELF.inquired_bus_user5_addr_suffix			:= inRec.bususer_q5.addr_suffix;
				SELF.inquired_bus_user5_postdir 				:= inRec.bususer_q5.postdir;
				SELF.inquired_bus_user5_unit_desig 			:= inRec.bususer_q5.unit_desig;
				SELF.inquired_bus_user5_sec_range 			:= inRec.bususer_q5.sec_range;
				SELF.inquired_bus_user5_v_city_name			:= inRec.bususer_q5.v_city_name;
				SELF.inquired_bus_user5_st 							:= inRec.bususer_q5.st;
				SELF.inquired_bus_user5_zip5 						:= inRec.bususer_q5.zip5;
				SELF.inquired_bus_user5_zip4 						:= inRec.bususer_q5.zip4;
				SELF.inquired_bus_user5_addr_rec_type 	:= inRec.bususer_q5.addr_rec_type;
				SELF.inquired_bus_user5_fips_state 			:= inRec.bususer_q5.fips_state;
				SELF.inquired_bus_user5_fips_county 		:= inRec.bususer_q5.fips_county;
																																
				// Business user 6
				SELF.inquired_bus_user6_fname 					:= inRec.bususer_q6.fname;
				SELF.inquired_bus_user6_mname 					:= inRec.bususer_q6.mname;
				SELF.inquired_bus_user6_lname 					:= inRec.bususer_q6.lname;
				SELF.inquired_bus_user6_name_suffix 		:= inRec.bususer_q6.name_suffix;
				SELF.inquired_bus_user6_did 						:= inRec.bususer_q6.appended_adl;
				SELF.inquired_bus_user6_personal_phone 	:= inRec.bususer_q6.personal_phone;
				SELF.inquired_bus_user6_dob 						:= inRec.bususer_q6.dob;
				SELF.inquired_bus_user6_dl 							:= inRec.bususer_q6.dl;
				SELF.inquired_bus_user6_dl_st 					:= inRec.bususer_q6.dl_st;
				SELF.inquired_bus_user6_ssn 						:= inRec.bususer_q6.appended_ssn;
				SELF.inquired_bus_user6_prim_range			:= inRec.bususer_q6.prim_range;
				SELF.inquired_bus_user6_predir 					:= inRec.bususer_q6.predir;
				SELF.inquired_bus_user6_prim_name 			:= inRec.bususer_q6.prim_name;
				SELF.inquired_bus_user6_addr_suffix			:= inRec.bususer_q6.addr_suffix;
				SELF.inquired_bus_user6_postdir 				:= inRec.bususer_q6.postdir;
				SELF.inquired_bus_user6_unit_desig 			:= inRec.bususer_q6.unit_desig;
				SELF.inquired_bus_user6_sec_range 			:= inRec.bususer_q6.sec_range;
				SELF.inquired_bus_user6_v_city_name			:= inRec.bususer_q6.v_city_name;
				SELF.inquired_bus_user6_st 							:= inRec.bususer_q6.st;
				SELF.inquired_bus_user6_zip5 						:= inRec.bususer_q6.zip5;
				SELF.inquired_bus_user6_zip4 						:= inRec.bususer_q6.zip4;
				SELF.inquired_bus_user6_addr_rec_type 	:= inRec.bususer_q6.addr_rec_type;
				SELF.inquired_bus_user6_fips_state 			:= inRec.bususer_q6.fips_state;
				SELF.inquired_bus_user6_fips_county 		:= inRec.bususer_q6.fips_county;
																																
				// Business user 7
				SELF.inquired_bus_user7_fname 					:= inRec.bususer_q7.fname;
				SELF.inquired_bus_user7_mname 					:= inRec.bususer_q7.mname;
				SELF.inquired_bus_user7_lname 					:= inRec.bususer_q7.lname;
				SELF.inquired_bus_user7_name_suffix 		:= inRec.bususer_q7.name_suffix;
				SELF.inquired_bus_user7_did 						:= inRec.bususer_q7.appended_adl;
				SELF.inquired_bus_user7_personal_phone 	:= inRec.bususer_q7.personal_phone;
				SELF.inquired_bus_user7_dob 						:= inRec.bususer_q7.dob;
				SELF.inquired_bus_user7_dl 							:= inRec.bususer_q7.dl;
				SELF.inquired_bus_user7_dl_st 					:= inRec.bususer_q7.dl_st;
				SELF.inquired_bus_user7_ssn 						:= inRec.bususer_q7.appended_ssn;
				SELF.inquired_bus_user7_prim_range			:= inRec.bususer_q7.prim_range;
				SELF.inquired_bus_user7_predir 					:= inRec.bususer_q7.predir;
				SELF.inquired_bus_user7_prim_name 			:= inRec.bususer_q7.prim_name;
				SELF.inquired_bus_user7_addr_suffix			:= inRec.bususer_q7.addr_suffix;
				SELF.inquired_bus_user7_postdir 				:= inRec.bususer_q7.postdir;
				SELF.inquired_bus_user7_unit_desig 			:= inRec.bususer_q7.unit_desig;
				SELF.inquired_bus_user7_sec_range 			:= inRec.bususer_q7.sec_range;
				SELF.inquired_bus_user7_v_city_name			:= inRec.bususer_q7.v_city_name;
				SELF.inquired_bus_user7_st 							:= inRec.bususer_q7.st;
				SELF.inquired_bus_user7_zip5 						:= inRec.bususer_q7.zip5;
				SELF.inquired_bus_user7_zip4 						:= inRec.bususer_q7.zip4;
				SELF.inquired_bus_user7_addr_rec_type 	:= inRec.bususer_q7.addr_rec_type;
				SELF.inquired_bus_user7_fips_state 			:= inRec.bususer_q7.fips_state;
				SELF.inquired_bus_user7_fips_county 		:= inRec.bususer_q7.fips_county;
																																
				// Business user 8
				SELF.inquired_bus_user8_fname 					:= inRec.bususer_q8.fname;
				SELF.inquired_bus_user8_mname 					:= inRec.bususer_q8.mname;
				SELF.inquired_bus_user8_lname 					:= inRec.bususer_q8.lname;
				SELF.inquired_bus_user8_name_suffix 		:= inRec.bususer_q8.name_suffix;
				SELF.inquired_bus_user8_did 						:= inRec.bususer_q8.appended_adl;
				SELF.inquired_bus_user8_personal_phone 	:= inRec.bususer_q8.personal_phone;
				SELF.inquired_bus_user8_dob 						:= inRec.bususer_q8.dob;
				SELF.inquired_bus_user8_dl 							:= inRec.bususer_q8.dl;
				SELF.inquired_bus_user8_dl_st 					:= inRec.bususer_q8.dl_st;
				SELF.inquired_bus_user8_ssn 						:= inRec.bususer_q8.appended_ssn;
				SELF.inquired_bus_user8_prim_range			:= inRec.bususer_q8.prim_range;
				SELF.inquired_bus_user8_predir 					:= inRec.bususer_q8.predir;
				SELF.inquired_bus_user8_prim_name 			:= inRec.bususer_q8.prim_name;
				SELF.inquired_bus_user8_addr_suffix			:= inRec.bususer_q8.addr_suffix;
				SELF.inquired_bus_user8_postdir 				:= inRec.bususer_q8.postdir;
				SELF.inquired_bus_user8_unit_desig 			:= inRec.bususer_q8.unit_desig;
				SELF.inquired_bus_user8_sec_range 			:= inRec.bususer_q8.sec_range;
				SELF.inquired_bus_user8_v_city_name			:= inRec.bususer_q8.v_city_name;
				SELF.inquired_bus_user8_st 							:= inRec.bususer_q8.st;
				SELF.inquired_bus_user8_zip5 						:= inRec.bususer_q8.zip5;
				SELF.inquired_bus_user8_zip4 						:= inRec.bususer_q8.zip4;
				SELF.inquired_bus_user8_addr_rec_type 	:= inRec.bususer_q8.addr_rec_type;
				SELF.inquired_bus_user8_fips_state 			:= inRec.bususer_q8.fips_state;
				SELF.inquired_bus_user8_fips_county 		:= inRec.bususer_q8.fips_county;
				SELF := inRec;

	END;
															
END;