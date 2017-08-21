import Crim_Common;

d := crim.File_FL_Marion(FirstName<>'FirstName');

Crim_Common.Layout_In_Court_Offenses tFLCrim(d input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offenses;
self.offender_key 				:= '2M'+hash(trim(input.CaseNumber,left,right)+fSlashedMDYtoCYMD(trim(input.FileDate,left,right))+trim(input.LastName,left,right)+trim(input.FirstName,left,right)+trim(input.MiddleName,left,right));
self.vendor 					:= '2M';
self.state_origin 				:= 'FL';
self.source_file 				:= 'FL MARION CRIM CT';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= '';
self.num_of_counts 				:= input.Count_;
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
self.court_case_number 			:= trim(input.CaseNumber,left,right);
self.court_cd 					:= '';
self.court_desc 				:= '';
self.court_appeal_flag 			:= '';
self.court_final_plea 			:= '';
self.court_off_code 			:= '';
self.court_off_desc_1 			:= trim(input.Charge,left,right);
self.court_off_desc_2			:= '';
self.court_off_type_cd 			:= '';
self.court_off_type_desc 		:= '';
self.court_off_lev 				:= MAP(trim(input.Level,left,right) = 'F' and trim(input.degree,left,right) = 'FIRST' 	=> 'F1',
										trim(input.Level,left,right) = 'F' and trim(input.degree,left,right) = 'SECOND' => 'F2',
										trim(input.Level,left,right) = 'F' and trim(input.degree,left,right) = 'THIRD' 	=> 'F3',
										trim(input.Level,left,right) = 'F' and trim(input.degree,left,right) = 'FOURTH' => 'F4',
										trim(input.Level,left,right) = 'M' and trim(input.degree,left,right) = 'FIRST' 	=> 'M1',
										trim(input.Level,left,right) = 'M' and trim(input.degree,left,right) = 'SECOND' => 'M2',
										trim(input.Level,left,right) = 'M' and trim(input.degree,left,right) = 'THIRD' 	=> 'M3',
										trim(input.Level,left,right) = 'M' and trim(input.degree,left,right) = 'FOURTH' => 'M4',
										trim(input.Level,left,right) = 'I' and trim(input.degree,left,right) = 'FIRST' 	=> 'I1',
										trim(input.Level,left,right) = 'I' and trim(input.degree,left,right) = 'SECOND' => 'I2',
										trim(input.Level,left,right) = 'I' and trim(input.degree,left,right) = 'THIRD' 	=> 'I3',
										trim(input.Level,left,right) = 'I' and trim(input.degree,left,right) = 'FOURTH' => 'I4',
										'');
self.court_statute 				:= '';
self.court_additional_statutes 	:= '';
self.court_statute_desc 		:= '';
self.court_disp_date 			:= if(stringlib.GetDateYYYYMMDD() >= fSlashedMDYtoCYMD(input.DispositionDate) and fSlashedMDYtoCYMD(input.DispositionDate)[1..2] between '19' and '20',
										fSlashedMDYtoCYMD(input.DispositionDate),
										'');
self.court_disp_code 			:= '';
self.court_disp_desc_1	 		:= trim(input.Disposition,left,right);
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

pFLCrim := project(d,tFLCrim(left));

fFLOffend:= dedup(sort(distribute(pFLCrim,hash(offender_key)),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,source_file,local),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::Crim_FL_Marion_Offenses_Clean');

export map_FL_Marion_Offenses	:= fFLOffend;
