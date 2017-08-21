import Crim_Common;

d := crim.File_CO_Denver;

Crim_Common.Layout_In_Court_Offenses tCOCrim(d input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offenses;
self.offender_key 				:= '1J'+hash(trim(input.case_num,left,right)+trim(input.id,left,right)+fSlashedMDYtoCYMD(input.dob)+regexreplace('AKA',input.firstname,'')+regexreplace('AKA',input.lastname,''));
self.vendor 					:= '1J';
self.state_origin 				:= 'CO';
self.source_file 				:= 'CO DENVER CRIM CT';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= if(fSlashedMDYtoCYMD(input.violation_dt)[1..2] between '19' and '20' and fSlashedMDYtoCYMD(input.violation_dt)[1..8] ~in ['19010101','19000101'],
									fSlashedMDYtoCYMD(input.violation_dt),
									'');
self.arr_date 					:= '';
self.num_of_counts 				:= '';
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= '';
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= if(length(trim(input.offense_descr,left,right))>4 and regexfind('[0-9]+',trim(input.offense_descr,left,right)[1..2],0)='',
									regexreplace('1DEGREE|'+'1ST|'+'2ND|'+'3RD|'+'DEG|'+'DEGREE|'+' - ',input.offense_descr,''),
									'');
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= '';
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
self.court_case_number 			:= input.case_num;
self.court_cd 					:= '';
self.court_desc 				:= '';
self.court_appeal_flag 			:= '';
self.court_final_plea 			:= '';
self.court_off_code 			:= '';
self.court_off_desc_1 			:= '';
self.court_off_desc_2			:= '';
self.court_off_type_cd 			:= '';
self.court_off_type_desc 		:= '';
self.court_off_lev 				:= '';
self.court_statute 				:= '';
self.court_additional_statutes 	:= '';
self.court_statute_desc 		:= '';
self.court_disp_date 			:= '';
self.court_disp_code 			:= '';
self.court_disp_desc_1	 		:= regexreplace('[0-9]',input.disposition,'');
self.court_disp_desc_2 			:= '';
self.sent_date 					:= '';
self.sent_jail 					:= if(regexfind('REMANDED TO JAIL|'+'JAIL TIME TO BE SERVED|'+'JAIL TIME IMPOSED',trim(input.sent_descr,left,right),0)<>'' and (length(trim(input.sent_value,left,right)) between 1 and 3) and trim(input.sent_value,left,right)<>'0' and regexfind('\\.',trim(input.sent_value,left,right),0) = '' and regexfind('YEAR',trim(input.sent_units,left,right),0)<>'',
									trim(input.sent_value,left,right)+' Years',
									if(regexfind('REMANDED TO JAIL|'+'JAIL TIME TO BE SERVED|'+'JAIL TIME IMPOSED',trim(input.sent_descr,left,right),0)<>'' and (length(trim(input.sent_value,left,right)) between 1 and 3) and trim(input.sent_value,left,right)<>'0' and regexfind('\\.',trim(input.sent_value,left,right),0) = '' and regexfind('MONT',trim(input.sent_units,left,right),0)<>'',
									trim(input.sent_value,left,right)+' Months',
									if(regexfind('REMANDED TO JAIL|'+'JAIL TIME TO BE SERVED|'+'JAIL TIME IMPOSED',trim(input.sent_descr,left,right),0)<>'' and (length(trim(input.sent_value,left,right)) between 1 and 3) and trim(input.sent_value,left,right)<>'0' and regexfind('\\.',trim(input.sent_value,left,right),0) = '' and regexfind('DAY',trim(input.sent_units,left,right),0)<>'',
									trim(input.sent_value,left,right)+' Days',
									'')));
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

pCOCrim := project(d,tCOCrim(left));

fCOOffend:= dedup(sort(distribute(pCOCrim,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::Crim_CO_Denver_Offenses_Clean');

export map_CO_Denver_Offenses	:= fCOOffend;
