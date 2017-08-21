import Crim_Common, Address, Lib_date;

d	:= ArrestLogs.file_FL_Martin;

fMartin := d(trim(d.Name,left,right)<>'name');

Crim_Common.Layout_In_Court_Offenses tMartin(fMartin input) := Transform

self.process_date 				:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key 				:= (string)'E7'+(integer)(hash(trim(input.Name,left,right)+trim(input.Book_Num,left,right)+(string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',input.Book_Dt,''))));
self.vendor 					:= 'E7';//NEED TO UPDATE
self.state_origin 				:= 'FL';
self.source_file 				:= '(CV)FL-MartinCtyArr';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= if((string)LIB_Date.Date_MMDDYY_I2(regexreplace('/| ',input.arrest_dt,''))<>'0',
									if((string)LIB_Date.Date_MMDDYY_I2(regexreplace('/| ',input.arrest_dt,'')) < Crim_Common.Version_In_Arrest_Offender and
									length(regexreplace('/',trim(input.arrest_dt), ''))>5, 
									(string)LIB_Date.Date_MMDDYY_I2(regexreplace('/| ',input.arrest_dt,'')),
									''), 
									'');
self.num_of_counts 				:= '';
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= if(regexfind('COLLINS|'+'OTHER|'+'UNKNOWN|'+'SELF',trim(input.arrestagency,left,right),0)='',
									trim(input.arrestagency,left,right),
									'');
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= if(regexfind('[0-9]',input.charge[stringlib.stringfind(input.charge,' ',1)+1..40],0)='' 
									and regexfind('[A-Z]',input.charge[stringlib.stringfind(input.charge,' ',1)+1..40],0)<>'',
									trim(regexreplace('()|'+'UNKNOWN',StringLib.StringToUpperCase(input.charge),'')[stringlib.stringfind(input.charge,' ',1)+1..40],left,right),
									'');
self.arr_off_desc_2 			:= if(trim(input.bond,left,right) ~in['0','','No Bail'] and
									regexfind('[0-9]+',input.bond,0)<>'' and
									regexfind('[A-Z]+',input.bond,0)='',
									'BOND AMT $ '+input.bond,
									'');
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

pMartin := project(fMartin,tMartin(left));

//arrOut:= pMartin + ArrestLogs.FileAbinitioOffenses(vendor='');

dd_arrOut:= dedup(sort(distribute(pMartin,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::ArrestLogs_FL_Martin_Offenses');

export map_FL_MartinOffenses := dd_arrOut;