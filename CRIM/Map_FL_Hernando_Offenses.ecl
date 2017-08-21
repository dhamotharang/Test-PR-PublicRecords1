import crim_common, Crim, Address;

d := crim.File_FL_Hernando(name<>'Name');

Crim_Common.Layout_In_Court_Offenses tLACrim(d input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

string		fCleanVerdict(string pverdict)
:= regexreplace('\\/'+'[0-9]+|'+'-',pverdict,'');

self.process_date 				:= Crim_Common.Version_In_Arrest_Offenses;
self.offender_key 				:= '2T'+trim(input.caseno,left,right)+fSlashedMDYtoCYMD(trim(input.datefiled,left,right))+hash(regexreplace('AKA',input.name,''));
self.vendor 					:= '2T';
self.state_origin 				:= 'FL';
self.source_file 				:= 'FL HERNANDO CRIM CT';
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
self.pros_assgn 				:= if(regexfind('NO ATTORNEY AT THIS TIME', trim(input.prosecutingattorney,left,right),0)<>'',
									trim(input.prosecutingattorney,left,right),
									'');
self.pros_chg_rej 				:= '';
self.pros_off_code 				:= '';
self.pros_off_desc_1 			:= '';
self.pros_off_desc_2 			:= '';
self.pros_off_type_cd 			:= '';
self.pros_off_type_desc 		:= '';
self.pros_off_lev 				:= '';
self.pros_act_filed 			:= '';
self.court_case_number 			:= trim(input.caseno,left,right);
self.court_cd 					:= '';
self.court_desc 				:= '';
self.court_appeal_flag 			:= '';
self.court_final_plea 			:= regexreplace('[0-9]+|\\/|-',input.status,'');/*if(regexfind('NOT GUILTY',trim(input.status,left,right),0)<>'',
									fCleanVerdict(trim(input.status,left,right)),
									if(regexfind('GUILTY',trim(input.status,left,right),0)<>'', 
									fCleanVerdict(trim(input.status,left,right)),
									''));*/
self.court_off_code 			:= '';
self.court_off_desc_1 			:= regexreplace('1ST DEGREE|FIRST DEGREE|2ND DEGREE|SECOND DEGREE|3RD DEGREE|THIRD DEGREE',
									trim(input.statutedescription,left,right),
									'');
self.court_off_desc_2			:= '';
self.court_off_type_cd 			:= '';
self.court_off_type_desc 		:= '';
self.court_off_lev 				:= if(trim(input.casetype,left,right) in ['F','M','T'],
									trim(input.casetype,left,right),
									'');
self.court_statute 				:= regexreplace('99999999999999',trim(input.statuteno,left,right),'');
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

pFLCrim := project(d,tLACrim(left));

fFLOffend:= dedup(sort(distribute(pFLCrim,hash(offender_key)),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,source_file,local),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::Crim_FL_Hernando_Offenses_Clean');

export map_FL_Hernando_Offenses	:= fFLOffend;
