import Crim_Common, Address, Lib_date;

d	:= ArrestLogs.file_FL_Lake;

fLake := d(trim(d.Name,left,right)<>'name');

Crim_Common.Layout_In_Court_Offenses tLake(fLake input) := Transform

searchpattern := '^(.*)/(.*)/(.*)$';

self.process_date 				:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key 				:= 'E8'+(integer)hash(trim(input.Name,left,right)+if((REGEXFIND(searchpattern, input.book_dt_time, 3))[1..2] in ['19','20'],
									REGEXFIND(searchpattern, input.book_dt_time, 3)[1..4]+
									(string)intformat((integer)REGEXFIND(searchpattern, input.book_dt_time, 1), 2, 1)+
									(string)intformat((integer)REGEXFIND(searchpattern, input.book_dt_time, 2), 2, 1),
									''));
self.vendor 					:= 'E8';//NEED TO UPDATE
self.state_origin 				:= 'FL';
self.source_file 				:= '(CV)FL-LakeCtyArr';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= if((REGEXFIND(searchpattern, input.arrest_dt_time, 3))[1..2] in ['19','20']
									and REGEXFIND(searchpattern, input.arrest_dt_time, 3)[1..4]+
									(string)intformat((integer)REGEXFIND(searchpattern, input.arrest_dt_time, 1), 2, 1)+
									(string)intformat((integer)REGEXFIND(searchpattern, input.arrest_dt_time, 2), 2, 1) < Crim_Common.Version_In_Arrest_Offenses,
									REGEXFIND(searchpattern, input.arrest_dt_time, 3)[1..4]+
									(string)intformat((integer)REGEXFIND(searchpattern, input.arrest_dt_time, 1), 2, 1)+
									(string)intformat((integer)REGEXFIND(searchpattern, input.arrest_dt_time, 2), 2, 1),
									'');
self.num_of_counts 				:= '';
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= if(regexfind('[0-9]+',input.agency,0)='',
									if(trim(input.agency,left,right) ~in['OTHER','UNKNOWN'],
									input.agency,
									'')
									,'');
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= if(length(input.offense)>2,
									input.offense,
									'');
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= if(input.offense_type<>'' and input.offense_type in ['F','M','I','T'],
									trim(input.offense_type,left,right)[1],
									'');
self.arr_statute 				:= '';
self.arr_statute_desc 			:= '';
self.arr_disp_date 				:= '';
self.arr_disp_code 				:= '';
self.arr_disp_desc_1 			:= '';
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

end;

pLake := project(fLake,tLake(left));

//arrOut:= pLake + ArrestLogs.FileAbinitioOffenses(vendor='');

dd_arrOut:= dedup(sort(distribute(pLake,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::ArrestLogs_FL_Lake_Offenses');

export map_FL_LakeOffenses := dd_arrOut;