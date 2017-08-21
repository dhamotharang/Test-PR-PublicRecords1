import Crim_Common, Address, Gong;

p	:= ArrestLogs.file_CA_Placer;

fPlacer := p(trim(p.ID,left,right)<>'ID' and
			   trim(p.Name,left,right)<>'Name' and
			   trim(p.Age,left,right)<>'Age');
			   
Crim_Common.Layout_In_Court_Offenses tPlacer(fPlacer input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offenses;
self.offender_key 				:= 'A8'+trim(input.jailid,left,right)+fSlashedMDYtoCYMD(trim(input.book_dt[1..11],left,right));
self.vendor 					:= 'A8';
self.state_origin 				:= 'CA';
self.source_file 				:= '(CV)CA-PlacerArrest';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= if(fSlashedMDYtoCYMD(trim(input.book_dt[1..11],left,right)) < Crim_Common.Version_In_Arrest_Offender,
									fSlashedMDYtoCYMD(trim(input.book_dt[1..11],left,right)),'');
self.num_of_counts 				:= input.charge[1];
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= if(trim(StringLib.StringToUpperCase(input.Arrest_Agency),left,right)<>'Other',
									trim(StringLib.StringToUpperCase(input.Arrest_Agency),left,right),
									'');
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= regexreplace('.*[H][S][ ]|'+'.*[P][C][ ]|'+'.*[V][S][ ]|'+'.*[V][C][ ]|'+'.*[9][9][9][ ]',input.Charge,'');
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= if(regexfind('FIRST DEGREE|'+'1ST DEG',input.Charge) = (boolean)'true', 
									  '1ST',
								   if(regexfind('SECOND DEGREE|'+'2ND DEG',input.Charge) = (boolean)'true',
									  '2ND',
								   if(regexfind('THIRD DEGREE|'+'3RD DEG',input.Charge) = (boolean)'true',
									  '3RD',
									  '')));
self.arr_statute 				:= '';
self.arr_statute_desc 			:= '';
self.arr_disp_date 				:= '';
self.arr_disp_code 				:= '';
self.arr_disp_desc_1 			:= if(trim(input.bail,left,right)<>'0' and trim(input.bail,left,right)<>'' and trim(input.bail,left,right)<>'$',
								     ('BAIL AMT '+trim(input.bail,left,right)),
								     '');
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

pPlacer := project(fPlacer,tPlacer(left));

arrOut:= pPlacer + ArrestLogs.FileAbinitioOffenses(vendor='A8');

dd_arrOut:= dedup(sort(distribute(arrOut,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::ArrestLogs_CA_Placer_Offenses_test');

export map_CA_PlacerOffenses	:= dd_arrOut;