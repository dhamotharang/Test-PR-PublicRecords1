import crim_common, Crim, Address, lib_stringlib,ut;

ds := crim.file_ak_statewide(typeperson in ['DEF', 'DFN', 'DFNDT', 'DEFENDANT', 'AKA']);
dsccd := ds(civilcloseddate = '');
input := dsccd(casetype in ['','AS', 'CT', 'DSC', 'FG', 'OCI', 'PIO', 'SMC','A', 'B', 'C','D','F', 'M', 'S', 'Criminal', 'Minor Offense']);

Crim_Common.Layout_In_Court_Offenses tAKCrim(input l) := Transform
string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

string8     getReasonableRange(string newDateIn) 
:=    map((newDateIn[1..2] between '19' and '20') and 
			(newDateIn < ut.GetDate) => newDateIn,'');

self.process_date 				:= Crim_Common.Version_In_Arrest_Offenses;
self.offender_key 				:= '9' + l.casenum; //+hash(l.offense);
self.vendor 					:= '9';
self.state_origin 				:= 'AK';
self.source_file 				:= 'AK Statewide';
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
self.court_case_number 			:= l.casenum;
self.court_cd 					:= '';
self.court_desc 				:= '';
self.court_appeal_flag 			:= '';
self.court_final_plea 			:= '';
self.court_off_code 			:= '';
self.court_off_desc_1 			:= l.offense;
self.court_off_desc_2			:= '';
self.court_off_type_cd 			:= '';
self.court_off_type_desc 		:= '';
self.court_off_lev 				:= l.CrimType;
self.court_statute 				:= '';
self.court_additional_statutes 	:= '';
self.court_statute_desc 		:= l.statute;
self.court_disp_date 			:= '';
self.court_disp_code 			:= '';
self.court_disp_desc_1	 		:= regexreplace('[0-9]',l.CrimDispos,'');
self.court_disp_desc_2 			:= 'Closed Date: '+fSlashedMDYtoCYMD(l.CrimClosedDate);
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

pAKCrim := project(input,tAKCrim(left));

fAKOffend:= dedup(sort(distribute(pAKCrim,hash(offender_key)),
									offender_key,off_comp,court_case_number,court_statute_desc,court_off_desc_1,source_file,local),
									offender_key,off_comp,court_case_number,court_statute_desc,court_off_desc_1,local,left)
									// :PERSIST('~thor_dell400::persist::Crim_AK_Offenses')
									;

export map_AK_Offenses	:= fAKOffend;

