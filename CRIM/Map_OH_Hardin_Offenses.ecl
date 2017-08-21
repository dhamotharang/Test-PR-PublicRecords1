import Crim_Common;

d 		:= Crim.Map_OH_Hardin_Combined(Defendant<>'' and Defendant<>'Last_Name' and Defendant<>'Defendant' and Description<>'Description');

Crim_Common.Layout_In_Court_Offenses tOHCrim(d input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offenses;
self.offender_key 				:= '2V'+hash(fSlashedMDYtoCYMD(input.filed_date)+trim(input.case_number,left,right)+trim(input.section_number,left,right));
self.vendor 					:= '2V';
self.state_origin 				:= 'OH';
self.source_file 				:= 'OH HARDIN CRIM CT';
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
self.court_case_number 			:= trim(input.case_number,left,right);
self.court_cd 					:= '';
self.court_desc 				:= '';
self.court_appeal_flag 			:= '';
self.court_final_plea 			:= '';
self.court_off_code 			:= '';
self.court_off_desc_1 			:= trim(input.description,left,right);
self.court_off_desc_2			:= '';
self.court_off_type_cd 			:= '';
self.court_off_type_desc 		:= '';
self.court_off_lev 				:= if(length(input.degree)=2 and input.degree[1..1] in ['M','m','F','f'],
									input.degree,
									'');
self.court_statute 				:= if(length(trim(input.section_number,left,right))>4,
									trim(input.section_number,left,right),
									'');
self.court_additional_statutes 	:= '';
self.court_statute_desc 		:= '';
self.court_disp_date 			:= '';
self.court_disp_code 			:= '';
self.court_disp_desc_1	 		:= if(regexfind('NOT GUILTY',trim(input.sentencing_information,left,right),0)<>'',
									'NOT GUILTY',
									if(regexfind('GUILTY',trim(input.sentencing_information,left,right),0)<>'',
									'GUILTY',
									if(regexfind('PLEAD GUILTY|GUILTY PLEA|PLEAD G|PLEAD "G',trim(input.sentencing_information,left,right),0)<>'',
									'PLEAD GUILTY',
									if(regexfind('ACQUITTAL',trim(input.sentencing_information,left,right),0)<>'',
									'ACQUITTAL',
									''))));
self.court_disp_desc_2 			:= '';
self.sent_date 					:= fSlashedMDYtoCYMD(input.sentencing_date);
self.sent_jail 					:= if(regexfind('DAYS JAIL',input.sentencing_information,0)<>'' and 
									regexfind('SUSPEND|PROBATION|CREDIT',input.sentencing_information,0)='',
									regexreplace('\\.|\\,',
									input.sentencing_information[DataLib.StringFind(input.sentencing_information, 'DAYS JAIL',1)-4..DataLib.StringFind(input.sentencing_information, 'DAYS JAIL',1)+8],
									''),'');
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
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,source_file,local),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::Crim_OH_Hardin_Offenses_Clean');

export map_OH_Hardin_Offenses	:= fOHOffend;
