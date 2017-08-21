import Crim_Common, Address, Lib_date;

d	:= ArrestLogs.file_CO_Weld_new;

ArrestLogs.Layout_CO_Weld sWeld(d input) := Transform
self := input;
end;

rWeld := project(d, sWeld(left));

d2	:= ArrestLogs.file_CO_Weld+rWeld;

fWeld := d2(trim(d2.Name,left,right)<>'Name'); 


Crim_Common.Layout_In_Court_Offenses tWeld(fWeld input) := Transform

self.process_date 				:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key 				:= (string)'D9'+(integer)hash(trim(input.name,all))+lib_date.Date_MMDDYY_I2(regexreplace('/',input.arrested,''));
self.vendor 					:= 'D9';//NEED TO UPDATE
self.state_origin 				:= 'CO';
self.source_file 				:= '(CV)CO-WeldCtyArr';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= if((string)lib_date.Date_MMDDYY_I2(regexreplace('/',input.arrested,'')) < Crim_Common.Version_In_Arrest_Offender
									and lib_date.Date_MMDDYY_I2(regexreplace('/',input.arrested,''))[1..2] in ['19','20'],
									(string)lib_date.Date_MMDDYY_I2(regexreplace('/',input.arrested,'')),'');
self.num_of_counts 				:= '';//(string)input.num_ofcounts;
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= regexreplace('CO0|'+'[0-9]|'+'COCSP|'+'OTHER AGENCY|'+'PAROLE',trim(input.arrest_agency,left,right),'');
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= if(regexfind('^[ ]|'+'^[0-9]',input.offense),
                             if(regexfind('/',input.offense),regexreplace('DEGREE|'+'FIRST|'+'SECOND|'+'THIRD|'+'DEG.|'+'DEG|'+'1ST|'+'2ND|'+'3RD|'+'for   ',
									                            input.offense[stringlib.stringfind(input.offense,' ',1)+1..stringlib.stringfind(input.offense,'/',1)-1],''),
																							regexreplace('DEGREE|'+'FIRST|'+'SECOND|'+'THIRD|'+'DEG.|'+'DEG|'+'1ST|'+'2ND|'+'3RD|'+'for   ',
									                            input.offense[stringlib.stringfind(input.offense,' ',1)+1..30],'')),
									           if(regexfind('/',input.offense),regexreplace('DEGREE|'+'FIRST|'+'SECOND|'+'THIRD|'+'DEG.|'+'DEG|'+'1ST|'+'2ND|'+'3RD|'+'for   ',
									                            input.offense[1..stringlib.stringfind(input.offense,'/',1)-1],''),
                                              regexreplace('DEGREE|'+'FIRST|'+'SECOND|'+'THIRD|'+'DEG.|'+'DEG|'+'1ST|'+'2ND|'+'3RD|'+'for   ',
									                            input.offense[1..30],'')));
																							
////////////////////////Original arr_off_desc_1 ///////////////////////////////////
//self.arr_off_desc_1 			:= regexreplace('DEGREE|'+'FIRST|'+'SECOND|'+'THIRD|'+'DEG.|'+'DEG|'+'1ST|'+'2ND|'+'3RD|'+'for   ',
//									input.offense[stringlib.stringfind(input.offense,' ',1)+1..28],
//									'');

self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= '';
self.arr_statute 				:= '';
self.arr_statute_desc 			:= '';
self.arr_disp_date 				:= '';
self.arr_disp_code 				:= '';
self.arr_disp_desc_1 			:= '';
self.arr_disp_desc_2 			:= if(input.bail ~in ['$0.00','','NO BAIL'],
									 ('BAIL AMT '+input.bail),
								     '');
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

pWeld := project(fWeld,tWeld(left));

//arrOut:= pWeld + ArrestLogs.FileAbinitioOffenses(vendor='');

dd_arrOut:= dedup(sort(distribute(pWeld,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::ArrestLogs_CO_Weld_Offenses');

export Map_CO_WeldOffenses := dd_arrOut;