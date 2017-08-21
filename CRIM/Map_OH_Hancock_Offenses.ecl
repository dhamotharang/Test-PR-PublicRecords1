import Crim_Common;

dfilter := crim.Map_OH_Hancock_Combined(name<>'Name');
d 		:= dfilter(firstName<>'');

Crim_Common.Layout_In_Court_Offenses tOHCrim(d input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offenses;
self.offender_key 				:= '2H'+fSlashedMDYtoCYMD(input.case_filed)+hash(trim(input.name,left,right));
self.vendor 					:= '2H';
self.state_origin 				:= 'OH';
self.source_file 				:= 'OH HANCOCK CRIM CT';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= if(fSlashedMDYtoCYMD(input.offense_dt)<>'00000000',
									fSlashedMDYtoCYMD(input.offense_dt),
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
self.court_off_desc_1 			:= if(regexfind('[A-Z]|'+'[a-z]',trim(input.charge_descr,left,right),0)<>'' and
									regexfind('[0-9]+',trim(input.charge_descr[1..4],left,right),0)='',
									trim(input.charge_descr,left,right),
									'');
self.court_off_desc_2			:= '';
self.court_off_type_cd 			:= '';
self.court_off_type_desc 		:= '';
self.court_off_lev 				:= if(regexfind('Felony',trim(input.degree,left,right),0)<>'',
									'F',
									if(regexfind('Misdem',trim(input.degree,left,right),0)<>'',
									'M',
									if(regexfind('Infrac',trim(input.degree,left,right),0)<>'',
									'I',
									if(regexfind('Traff',trim(input.degree,left,right),0)<>'',
									'T',
									if(regexfind('Violat',trim(input.degree,left,right),0)<>'',
									'V',
									'')))));
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

pOHCrim := project(d,tOHCrim(left))(off_date + court_off_lev + court_off_desc_1 + court_off_lev <> '');

fOHOffend:= dedup(sort(distribute(pOHCrim,hash(offender_key)),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,source_file,local),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::Crim_OH_Hancock_Offenses_Clean');

export map_OH_Hancock_Offenses	:= fOHOffend;
