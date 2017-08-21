import Crim_Common, Address, Lib_date,ut;

d	:= ArrestLogs.file_CA_Fresno.cmbnd;

fRegional := d(trim(d.Name,left,right)<>'name');

Crim_Common.Layout_In_Court_Offenses tRegional(fRegional input) := Transform
string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

string8     getReasonableRange(string newDateIn) 
:=    map((newDateIn[1..2] between '19' and '20') and 
			(newDateIn < ut.GetDate) => newDateIn,'');
			
self.process_date 				:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key 				:= 'E4'+trim(input.Book_Num,left,right)+(string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',input.Book_Dt,''));
self.vendor 					:= 'E4';//NEED TO UPDATE
self.state_origin 				:= 'CA';
self.source_file 				:= '(CV)CA-FresnoCtyArr';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= map(length(input.arrest_dt) = 8 =>
							if((string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',input.arrest_dt,''))<>'0',
							if((string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',input.arrest_dt,'')) < Crim_Common.Version_In_Arrest_Offender and
							  length(input.arrest_dt)>2, 
							  (string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',input.arrest_dt,'')),
							  ''),'')
							,length(input.arrest_dt) = 10 =>
							  getReasonableRange(fSlashedMDYtoCYMD(input.arrest_dt))
							  ,'');
self.num_of_counts 				:= '';
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= input.arrest_agency;
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= if(regexfind('[A-Z]',input.description[2],0)<>'' and
									regexfind('[0-9]+',input.description[3],0)='' and
									regexfind('[0-9]+',input.description[4],0)='' and
									regexfind('[0-9]+',input.description[5],0)='',
									input.description,
									'');
self.arr_off_desc_2 			:= if(trim(input.bail_amount,left,right) ~in['0',''] and
									regexfind('[0-9]+',input.bail_amount,0)<>'' and
									regexfind('[A-Z]+',input.bail_amount,0)='',
									'BAIL AMT $ '+input.bail_amount,
									'');
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= if(input.level[1] in ['F','M','I','T'],
									input.level[1],
									'');
self.arr_statute 				:= '';
self.arr_statute_desc 			:= '';
self.arr_disp_date 				:= '';
self.arr_disp_code 				:= '';
self.arr_disp_desc_1 			:= input.Hold_Type;
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
self.sent_date 					:= map(length(input.sentence_date) = 8 =>
							if((string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',input.sentence_date,''))<>'0',
							if((string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',input.sentence_date,'')) < Crim_Common.Version_In_Arrest_Offender and
							  length(input.sentence_date)>2, 
							  (string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',input.sentence_date,'')),
							  ''),'')
							,length(input.sentence_date) = 10 =>
							  getReasonableRange(fSlashedMDYtoCYMD(input.sentence_date))
							  ,'');
self.sent_jail 					:= if(regexfind('[a-zA-Z]',input.sentence_days)
									,stringlib.stringtouppercase(input.sentence_days)
									,if(input.sentence_days<>'',input.sentence_days + ' DAYS',''));
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

pRegional := project(fRegional,tRegional(left));

//arrOut:= pRegional + ArrestLogs.FileAbinitioOffenses(vendor='');

dd_arrOut:= dedup(sort(distribute(pRegional,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::ArrestLogs_CA_Fresno_Offenses');

export Map_CA_FresnoOffenses := dd_arrOut;