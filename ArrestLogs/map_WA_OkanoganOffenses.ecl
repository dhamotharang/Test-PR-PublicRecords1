import Crim_Common, ArrestLogs, ut,STD;

ds	:= ArrestLogs.File_WA_Okanogan.raw_out;

	fmtsin := '%m/%d/%y';
	fmtout := '%Y%m%d';

Crim_Common.Layout_In_Arrest_Offenses tOkanogan(ds dInput) := Transform
UpperName					:= REGEXREPLACE('^[^A-Z]|"',ut.CleanSpacesAndUpper(dInput.lfm_name),'');
bookdate_temp     := REGEXREPLACE('"',STD.Date.ConvertDateFormat(dInput.booking_date, fmtsin, fmtout),'');
ClnBookDate				:= if( bookdate_temp <> '-11130',bookdate_temp, '');
// ClnBookDate				:= REGEXREPLACE('"',ut.ConvertDate(dInput.booking_date,fmtsin),'');
self.process_date	:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key	:= 'A7'+ClnBookDate+hash(UpperName);
self.vendor				:= 'A7';
self.state_origin	:= 'WA';
self.source_file	:= 'WA-OkanoganCtyArrest';
self.off_comp 				:= '';
self.off_delete_flag 	:= '';
self.off_date 				:= '';
self.arr_date 				:= ClnBookDate;
self.num_of_counts 		:= '';
self.le_agency_cd 		:= '';
self.le_agency_desc 	:= '';
self.le_agency_case_number := '';
self.traffic_ticket_number := '';
self.traffic_dl_no 		:= '';
self.traffic_dl_st 		:= '';
self.arr_off_code 		:= '';
self.arr_off_desc_1 	:= REGEXREPLACE('"',ut.CleanSpacesAndUpper(dInput.p_addl_charge),'');
self.arr_off_desc_2 	:= '';
self.arr_off_type_cd 	:= '';
self.arr_off_type_desc 	:= '';
self.arr_off_lev 			:= '';
self.arr_statute 			:= '';
self.arr_statute_desc := '';
self.arr_disp_date 		:= ClnBookDate;
self.arr_disp_code 		:= '';
self.arr_disp_desc_1 	:= 'BOOKED';
self.arr_disp_desc_2 	:= '';
self.pros_refer_cd 		:= '';
self.pros_refer 			:= '';
self.pros_assgn_cd 		:= '';
self.pros_assgn 			:= '';
self.pros_chg_rej 		:= '';
self.pros_off_code 		:= '';
self.pros_off_desc_1 	:= '';
self.pros_off_desc_2 	:= '';
self.pros_off_type_cd 	:= '';
self.pros_off_type_desc := '';
self.pros_off_lev 			:= '';
self.pros_act_filed 		:= '';
self.court_case_number 	:= '';
self.court_cd 					:= '';
self.court_desc 				:= '';
self.court_appeal_flag 	:= '';
self.court_final_plea 	:= '';
self.court_off_code 		:= '';
self.court_off_desc_1 	:= '';
self.court_off_desc_2 	:= '';
self.court_off_type_cd 	:= '';
self.court_off_type_desc := '';
self.court_off_lev 			:= '';
self.court_statute 			:= '';
self.court_additional_statutes := '';
self.court_statute_desc := '';
self.court_disp_date 		:= '';
self.court_disp_code 		:= '';
self.court_disp_desc_1	:= '';
self.court_disp_desc_2 	:= '';
self.sent_date 					:= '';
self.sent_jail 					:= '';
self.sent_susp_time 		:= '';
self.sent_court_cost 		:= '';
self.sent_court_fine 		:= '';
self.sent_susp_court_fine 	:= '';
self.sent_probation 				:= '';
self.sent_addl_prov_code 		:= '';
self.sent_addl_prov_desc_1 	:= '';
self.sent_addl_prov_desc_2 	:= '';
self.sent_consec 						:= '';
self.sent_agency_rec_cust_ori := '';
self.sent_agency_rec_cust 		:= '';
self.appeal_date 							:= '';
self.appeal_off_disp 					:= '';
self.appeal_final_decision 		:= '';
END;

pOkanogan := project(ds,tOkanogan(left));

dd_arrOut:= dedup(sort(distribute(pOkanogan,hash(offender_key)),
									offender_key,arr_date,arr_off_desc_1,local),
									record,local):
									PERSIST('~thor_dell400::persist::ArrestLogs_WA_Okanogan_Offenses');

EXPORT map_WA_OkanoganOffenses := dd_arrOut(arr_off_desc_1 <> '');