import Crim_Common, Address, Lib_date;

input1 := ArrestLogs.File_CA_Orange.Original;
input2 := ArrestLogs.File_CA_Orange.New;

cmbndLayout := record
input1;
string	Release_Type;
string	Release_Dt;
end;

cmbndLayout t1(input1 L) := transform
self := L;
self := [];
end;

precs1 := project(input1,t1(left));

cmbndLayout t2(input2 L) := transform
self := L;
self := [];
end;

d := project(input2,t2(left))+precs1;

//d	:= ArrestLogs.file_CA_Orange;

fOrange := d(trim(d.race,left,right)<>'Race' and
			regexfind('[A-Z]',trim(d.race,left,right),0)<>'');

Crim_Common.Layout_In_Court_Offenses tOrange(fOrange input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key 				:= 'E5'+input.ID+fSlashedMDYtoCYMD(regexreplace('-',input.arrest_on[1..10],'/'));
self.vendor 					:= 'E5';//NEED TO UPDATE
self.state_origin 				:= 'CA';
self.source_file 				:= '(CV)CA-OrangeCtyArr';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= if(fSlashedMDYtoCYMD(regexreplace('-',input.arrest_on,'/')) < Crim_Common.Version_In_Arrest_Offender and
									fSlashedMDYtoCYMD(regexreplace('-',input.arrest_on,'/')) <> '0' and
									fSlashedMDYtoCYMD(regexreplace('-',input.arrest_on,'/')) <> '00000000', 
									fSlashedMDYtoCYMD(regexreplace('-',input.arrest_on,'/')),
									'');
self.num_of_counts 				:= if(regexfind('[0-9]',input.cnt,0)<>'',
									input.cnt,
									'');
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= if(input.arrest_agency='Other',
									'',
									input.arrest_agency);
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= regexreplace('\\*/|'+'\\*',input.description,'');
self.arr_off_desc_2 			:= if(trim(input.bail_amt2,left,right) ~in['$0.00',''] and
									regexfind('[0-9]+',input.bail_amt2,0)<>'' and
									regexfind('[A-Z]+',input.bail_amt2,0)='',
									'BAIL AMT '+input.bail_amt2,
									'');
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= if(input.degree[1] in ['F','M','I'],
									input.degree[1],
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

pOrange := project(fOrange,tOrange(left));

//arrOut:= pOrange + ArrestLogs.FileAbinitioOffenses(vendor='');

dd_arrOut:= dedup(sort(distribute(pOrange,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::ArrestLogs_CA_Orange_Offenses');

export Map_CA_OrangeOffenses := dd_arrOut;