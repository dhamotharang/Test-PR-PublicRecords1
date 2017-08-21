import Crim_Common, ArrestLogs, Address, ut;

ds	:= ArrestLogs.File_FL_Dade;

//normalize multiple offenses
	l_normRec	:= RECORD
		string10	PA_BOOK_DATE;
		string40	PA_DEFENDANT;
		string10	PA_DOB;
		string11	PA_CHARGE_CODE;
		string20	PA_CHARGE;
		string		PA_ADDR;
		string3		SEQ;
	END;
	
l_normRec	NormOffense(ds L, INTEGER cnt) := TRANSFORM
	self.pa_charge_code	:= choose(cnt, L.pa_charge_code1, L.pa_charge_code2, L.pa_charge_code3);
	self.pa_charge	:= choose(cnt, L.pa_charge1, L.pa_charge2, L.pa_charge3);
	self.SEQ	:= choose(cnt,IF(trim(L.pa_charge_code1,left,right) <> '' or trim(L.pa_charge1,left,right) <> '','001',''),
													IF(trim(L.pa_charge_code2,left,right) <> '' or trim(L.pa_charge2,left,right) <> '','002',''),
													IF(trim(L.pa_charge_code3,left,right) <> '' or trim(L.pa_charge3,left,right) <> '','003',''));
	self := L;
END;
	
ds_norm	:= normalize(ds, 3, NormOffense(left, counter));

Crim_Common.Layout_In_Arrest_Offenses tDade(ds_norm dInput) := Transform	
UpperName					:= ut.CleanSpacesAndUpper(dInput.PA_DEFENDANT);
ClnDOB						:= ut.date_slashed_MMDDYYYY_to_YYYYMMDD(dInput.pa_dob);
ClnBookDate				:= ut.date_slashed_MMDDYYYY_to_YYYYMMDD(dInput.pa_book_date);
self.process_date	:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key	:= 'AT'+hash(UpperName)+ClnDOB+ClnBookDate;
self.vendor				:= 'AT';//NEED TO UPDATE
self.state_origin	:= 'FL';
self.source_file	:= 'FL-DadeCtyArrest';
self.off_comp 				:= dInput.seq;
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
self.arr_off_code 		:= ut.CleanSpacesAndUpper(dInput.pa_charge_code);
self.arr_off_desc_1 	:= ut.CleanSpacesAndUpper(dInput.pa_charge);
self.arr_off_desc_2 	:= '';
self.arr_off_type_cd 	:= '';
self.arr_off_type_desc 	:= '';
self.arr_off_lev 			:= '';
self.arr_statute 			:= '';
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

pDade := project(ds_norm,tDade(left));

dd_arrOut:= dedup(sort(distribute(pDade,hash(offender_key)),
									offender_key,off_comp,arr_off_code,arr_off_desc_1,local),
									record,local):
									PERSIST('~thor_dell400::persist::ArrestLogs_FL_Dade_Offenses');

EXPORT map_FL_DadeOffenses := dd_arrOut(arr_off_code <> '' or arr_off_desc_1 <> '');