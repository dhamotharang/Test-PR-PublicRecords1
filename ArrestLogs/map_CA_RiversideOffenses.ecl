import Crim_Common, Address, Lib_date;

d	:= ArrestLogs.file_CA_Riverside;

fRiverside := d(trim(d.Name,left,right)<>'name');

Crim_Common.Layout_In_Court_Offenses tRiverside(fRiverside input) := Transform

self.process_date 				:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key 				:= 'E6'+trim(input.Book_Num,left,right)+(string)LIB_Date.Date_MMDDYY_I2(input.book_dt[1..2]+input.book_dt[4..5]+input.book_dt[9..10]);
self.vendor 					:= 'E6';//NEED TO UPDATE
self.state_origin 				:= 'CA';
self.source_file 				:= '(CV)CA-RiversideCtyArr';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= if((string)LIB_Date.Date_MMDDYY_I2(input.arrest_dt[1..2]+input.arrest_dt[4..5]+input.arrest_dt[9..10])<>'0',
									if((string)LIB_Date.Date_MMDDYY_I2(input.arrest_dt[1..2]+input.arrest_dt[4..5]+input.arrest_dt[9..10]) < Crim_Common.Version_In_Arrest_Offender, 
									(string)LIB_Date.Date_MMDDYY_I2(input.arrest_dt[1..2]+input.arrest_dt[4..5]+input.arrest_dt[9..10]),
									''),'');
self.num_of_counts 				:= '';
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= if(trim(input.arrest_agency,left,right) ~in['Other','Unknown'],
									input.arrest_agency,
									'');
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= input.charge[stringlib.stringfind(input.charge,' ',3)+1..40];
self.arr_off_desc_2 			:= if(trim(input.bail_amt,left,right) ~in['0','','No Bail'] and
									regexfind('[0-9]+',input.bail_amt,0)<>'' and
									regexfind('[A-Z]+',input.bail_amt,0)='',
									'BAIL AMT $ '+input.bail_amt,
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
self.court_case_number 			:= input.case_num;
self.court_cd 					:= '';
self.court_desc 				:= input.court_name;
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

pRiverside := project(fRiverside,tRiverside(left));

//arrOut:= pRiverside + ArrestLogs.FileAbinitioOffenses(vendor='');

dd_arrOut:= dedup(sort(distribute(pRiverside,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::ArrestLogs_CA_Riverside_Offenses');

export map_CA_RiversideOffenses := dd_arrOut;