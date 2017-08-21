import Crim_Common, ArrestLogs,ut,STD;

ds	:= ArrestLogs.File_CA_SantaMonica.raw;

	fmtsin := '%m/%d/%Y';
	fmtout := '%Y%m%d';
	
//filter header/footer records
f_ds	:= ds(REGEXFIND('^[0-9]',booking_date));

Crim_Common.Layout_In_Arrest_Offenses tSantaMonica(f_ds dInput) := Transform
bookdate_temp     := REGEXREPLACE('"',STD.Date.ConvertDateFormat(dInput.booking_date, fmtsin, fmtout),'');
ClnBookDate				:= if( bookdate_temp <> '-11130',bookdate_temp, '');

// ClnBookDate				:= ut.ConvertDate(trim(dInput.booking_date,all));
ClnBookNum				:= REGEXREPLACE('-',trim(dInput.booking_number,all),'');
self.process_date	:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key	:= 'A3'+ClnBookNum;
self.vendor				:= 'A3';
self.state_origin	:= 'CA';
self.source_file	:= 'CA-SantaMonicaCtyArr';
self.off_comp 				:= '';
self.off_delete_flag 	:= '';
self.off_date 				:= '';
self.arr_date 				:= ClnBookDate;
self.num_of_counts 		:= '';
self.le_agency_cd 		:= '';
self.le_agency_desc 	:= 'SANTA MONICA PD';
self.le_agency_case_number := trim(dInput.booking_number,all);
self.traffic_ticket_number := '';
self.traffic_dl_no 		:= '';
self.traffic_dl_st 		:= '';
self.arr_off_code 		:= '';
self.arr_off_desc_1 	:= '';
self.arr_off_desc_2 	:= '';
self.arr_off_type_cd 	:= '';
self.arr_off_type_desc 	:= '';
self.arr_off_lev 			:= '';
self.arr_statute 			:= ut.CleanSpacesAndUpper(dInput.primary_charge);
self.arr_statute_desc := '';
self.arr_disp_date 		:= '';
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

pSantaMonica := project(f_ds,tSantaMonica(left));

dd_arrOut:= dedup(sort(distribute(pSantaMonica,hash(offender_key)),
									offender_key,arr_date,arr_statute,local),
									record,local):
									PERSIST('~thor_dell400::persist::ArrestLogs_CA_SantaMonica_Offenses');

EXPORT map_CA_SantaMonicaOffenses := dd_arrOut(arr_statute <> '');