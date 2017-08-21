import Crim_Common, Address, Lib_date;

d	:= ArrestLogs.file_GA_Bibb;

fBibb := d(trim(d.Name,left,right)<>'Name');

Crim_Common.Layout_In_Court_Offenses tBibb(fBibb input) := Transform

pre_offense := trim(regexreplace('FELONY|(FELONY)|MISD|(MISD)|DEGREE|DEG|1ST|2ND|3RD',input.charge[6..DataLib.StringFind(input.charge,'{',1) - 1],''), LEFT);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key 				:= 'F1'+hash(trim(input.id[2..9],all)+
									LIB_Date.Date_MMDDYY_I2(regexreplace('-',input.arrest_dt,''))+
									input.name);
self.vendor 					:= 'F1';//NEED TO UPDATE
self.state_origin 				:= 'GA';
self.source_file 				:= '(CV)GA-BibbCtyArr';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= if(length(regexreplace('-',input.arrest_dt,''))=8 and
									regexreplace('-',input.arrest_dt,'')[5..8]+regexreplace('-',input.arrest_dt,'')[1..4] < Crim_Common.Version_In_Arrest_Offenses,
									regexreplace('-',input.arrest_dt,'')[5..8]+regexreplace('-',input.arrest_dt,'')[1..4],
									if(length(regexreplace('-',input.arrest_dt,''))<8 and (string)LIB_Date.Date_MMDDYY_I2(regexreplace('-',input.arrest_dt,''))<>'0' and
									(string)LIB_Date.Date_MMDDYY_I2(regexreplace('-',input.arrest_dt,'')) < Crim_Common.Version_In_Arrest_Offenses,
									(string)LIB_Date.Date_MMDDYY_I2(regexreplace('-',input.arrest_dt,'')),
									''));
self.num_of_counts 				:= '';
self.le_agency_cd 				:= input.arrest_agency[1];
self.le_agency_desc 			:= input.arrest_agency[3..25];
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= if(regexfind('\\(',pre_offense), pre_offense[1..DataLib.StringFind(pre_offense,'(',1) - 1], pre_offense);
//self.arr_off_desc_1 			:= trim(regexreplace('FELONY|(FELONY)|MISD|(MISD)|DEGREE|DEG|1ST|2ND|3RD',input.charge[6..DataLib.StringFind(input.charge,'{',1) - 1],''), LEFT);
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= '';
self.arr_statute 				:= '';
self.arr_statute_desc 			:= '';
self.arr_disp_date 				:= '';
self.arr_disp_code 				:= '';
self.arr_disp_desc_1 			:= '';
self.arr_disp_desc_2 			:= if(input.bond_amt ~in['$ 0',''],
								     'BOND AMT '+input.bond_amt,
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

pBibb := project(fBibb,tBibb(left));

//arrOut:= pBibb + ArrestLogs.FileAbinitioOffenses(vendor='');

dd_arrOut:= dedup(sort(distribute(pBibb,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::ArrestLogs_GA_Bibb_Offenses');

export Map_GA_BibbOffenses := dd_arrOut;