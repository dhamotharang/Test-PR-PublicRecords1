import Crim_Common, Address;

p	:= file_LA_lafayette(name<>'Name');

Crim_Common.Layout_In_Court_Offenses  tLAFAYETTE(p input) := Transform
Semicolon := Stringlib.StringFind(trim(input.Arresting_Agency,right),';', 1);
le_agency := IF(Semicolon>0,input.Arresting_Agency[1..semicolon],input.Arresting_Agency);
self.process_date				:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key				:= 'F8'+HASH(trim(input.ID,left,right));
self.vendor						:= 'F8';
self.state_origin				:= 'LA'; 
self.source_file				:= '(CV)LA-LAFAYETTEArr';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.num_of_counts 				:= '';
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= IF(REGEXFIND('CITY|PD$|F.B.I|^UNIV|^U.S|OFC$',stringlib.StringToUpperCase(le_agency)),le_agency,'');
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= IF(REGEXFIND('[0-9]|PARISH',stringlib.StringToUpperCase(input.Charge)),'',
                                      regexreplace('FIRST DEGREE |'+'SECOND DEGREE |'+'THIRD DEGREE |'+'CT 1 :|'+'CT 2 :|'+'CT1|'+'CT2|'+'TO:',
									    StringLib.StringToUpperCase(input.charge),''));
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= MAP(regexfind('FIRST DEGREE|1ST',stringlib.StringToUpperCase(input.Charge))=>'1ST',
								       regexfind('SECOND DEGREE',stringlib.StringToUpperCase(input.charge))=>'2ND',
								       regexfind('THIRD DEGREE',stringlib.StringToUpperCase(input.charge))=>'3RD',
									  '');
self.arr_statute 				:= '';
self.arr_statute_desc 			:= '';
self.arr_disp_date 				:= '';
self.arr_disp_code 				:= '';
self.arr_disp_desc_1 			:= 'BOOKED';
self.arr_disp_desc_2 			:= '';
self.pros_refer_cd 				:= '';
self.pros_refer 				:= '';
self.pros_assgn_cd 				:= '';
self.pros_assgn 				:= '';
self.pros_chg_rej 				:= '';
self.pros_off_code 				:= '';
self.pros_off_desc_1 			:= '';
self.pros_off_desc_2 			:= '';
self.pros_off_type_cd 			:= '';
self.pros_off_type_desc 		:= '';
self.pros_off_lev 				:= '';
self.pros_act_filed 			:= '';
self.court_case_number 			:= '';
self.court_cd 					:= '';
self.court_desc 				:= '';
self.court_appeal_flag 			:= '';
self.court_final_plea 			:= '';
self.court_off_code 			:= '';
self.court_off_desc_1 			:= '';
self.court_off_desc_2 			:= '';
self.court_off_type_cd 			:= '';
self.court_off_type_desc 		:= '';
self.court_off_lev 				:= '';
self.court_statute 				:= '';
self.court_additional_statutes 	:= '';
self.court_statute_desc 		:= '';
self.court_disp_date 			:= '';
self.court_disp_code 			:= '';
self.court_disp_desc_1	 		:= '';
self.court_disp_desc_2 			:= '';
self.sent_date 					:= '';
self.sent_jail 					:= '';
self.sent_susp_time 			:= '';
self.sent_court_cost 			:= '';
self.sent_court_fine 			:= '';
self.sent_susp_court_fine 		:= '';
self.sent_probation 			:= '';
self.sent_addl_prov_code 		:= '';
self.sent_addl_prov_desc_1 		:= '';
self.sent_addl_prov_desc_2 		:= '';
self.sent_consec 				:= '';
self.sent_agency_rec_cust_ori 	:= '';
self.sent_agency_rec_cust 		:= '';
self.appeal_date 				:= '';
self.appeal_off_disp 			:= '';
self.appeal_final_decision 		:= '';
self.arr_date                   := '';
end;

pLAFAYETTE := project(p,tLAFAYETTE(left));


dd_arrOut:= dedup(sort(distribute(pLAFAYETTE,hash(offender_key)),
									offender_key,le_agency_desc ,arr_off_desc_1, local),
									offender_key,le_agency_desc ,arr_off_desc_1,local,right):
									PERSIST('~thor_dell400::persist::ArrestLogs::LA::LAFAYETTE_Offenses');

export map_la_LAFAYETTEOffenses	:= dd_arrOut;