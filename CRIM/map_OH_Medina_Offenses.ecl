import Crim_Common;

d := crim.File_OH_Medina;

Crim_Common.Layout_In_Court_Offenses tOHCrim(d input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offenses;
self.offender_key				:= '1N'+hash(trim(input.case_num,left,right)+fSlashedMDYtoCYMD(trim(input.case_filed,left,right))+trim(input.defendant,all));
self.vendor 					:= '1N';
self.state_origin 				:= 'OH';
self.source_file 				:= 'OH MEDINA CRIM CT';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= '';
self.num_of_counts 				:= '';
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= '';
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= '';
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
self.court_case_number 			:= '';
self.court_cd 					:= '';
self.court_desc 				:= '';
self.court_appeal_flag 			:= '';
self.court_final_plea 			:= '';
self.court_off_code 			:= '';
self.court_off_desc_1 			:= if(length(trim(input.charge,left,right))>4,
									regexreplace('\\(F1\\)|'+'\\(F2\\)|'+'\\(F3\\)|'+'\\(F4\\)|'+'\\(F5\\)|'+  
									'F1|'+'F2|'+'F3|'+'F4|'+'F5|'+'\\(M1\\)|'+'\\(M2\\)|'+'\\(M3\\)|'+'\\(M4\\)|'+  
									'\\(F-1\\)|'+'\\(F-2\\)|'+'\\(F-3\\)|'+'\\(F-4\\)|'+'\\(F-5\\)|'+  
									'F-1|'+'F-2|'+'F-3|'+'F-4|'+'F-5|'+'\\(M5\\)|'+'M1|'+'M2|'+'M3|'+'M4|'+'M5|'+
									'\\(M-1\\)|'+'\\(M-2\\)|'+'\\(M-3\\)|'+'\\(M-4\\)|'+
									'M-1|'+'M-2|'+'M-3|'+'M-4|'+'M-5|'+'(MISD.)|'+'(MISD)|'+ 
									'\\(F\\)|'+'[0-9]+ CTS.|'+'[0-9]+ COUNTS|'+'1 CT.|'+'CT. [0-9]+|'+
									'CT. II|'+'CT. III|'+'CT. IV|'+'FOUR COUNTS|'+'[0-9]+.[0-9]+|'+'W/|'+'CT.|'+'VII|'+'-',
									StringLib.StringToUpperCase(trim(input.charge,left,right)),''),
									'');
self.court_off_desc_2			:= '';
self.court_off_type_cd 			:= '';
self.court_off_type_desc 		:= '';
self.court_off_lev 				:= if(trim(input.case_subtype,left,right)[1] in ['F','M','T'],
									trim(input.case_subtype[1],left,right),
									'');
self.court_statute 				:= trim(input.ChargeCode,left,right);
self.court_additional_statutes 	:= '';
self.court_statute_desc 		:= '';
self.court_disp_date 			:= '';
self.court_disp_code 			:= '';
self.court_disp_desc_1	 		:= if(regexfind('GUILTY',trim(input.sentences,left,right),0)<>'' and
									regexfind('NOT GUILTY',trim(input.sentences,left,right),0)='',
									trim(input.sentences,left,right),
									'');
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

pOHCrim := project(d,tOHCrim(left));

fOHOffend:= dedup(sort(distribute(pOHCrim,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,court_off_code,court_off_desc_1,source_file,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,court_off_code,court_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::Crim_OH_Medina_Offenses_Clean');

export map_OH_Medina_Offenses	:= fOHOffend;
