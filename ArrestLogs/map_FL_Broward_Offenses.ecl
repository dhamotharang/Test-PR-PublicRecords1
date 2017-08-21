import Crim_Common, Address;

p	:= ArrestLogs.file_FL_Broward;//(regexfind('<a href=', trim(Name,left,right)) <> (boolean)'true');

fBroward := p(trim(p.ID,left,right)<>'ID' and
			   trim(p.Name,left,right)<>'Name' and
			   trim(p.Name,left,right)[1..7]<>'<a href' and
			   trim(p.Race,left,right)<>'Race');

Crim_Common.Layout_In_Court_Offenses tBroward(fBroward input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key 				:= 'AI'+input.case_num+input.ID;
self.vendor 					:= 'AI';
self.state_origin 				:= 'FL';
self.source_file 				:= '(CV)FL-BrowardCtyArr';
self.off_comp 					:= input.charge_num;
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= if(fSlashedMDYtoCYMD(input.Arrest_Dt)[1..2] = '19',
									fSlashedMDYtoCYMD(input.Arrest_Dt),
									'');
self.num_of_counts 				:= '';
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= trim(input.arrest_agency,left,right);
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= if(trim(StringLib.StringToUpperCase(input.charge_comment),left,right)<>'',
									regexreplace('FIRST DEGREE |'+'SECOND DEGREE |'+'THIRD DEGREE |'+'CT 1 :|'+'CT 2 :|'+'CT1|'+'CT2|'+'TO:',
									trim(StringLib.StringToUpperCase(input.charge_comment),left,right),''),
									'');
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= if(regexfind('FIRST DEGREE',input.charge_comment) = (boolean)'true', 
									  '1ST',
								   if(regexfind('SECOND DEGREE',input.charge_comment) = (boolean)'true',
									  '2ND',
								   if(regexfind('THIRD DEGREE',input.charge_comment) = (boolean)'true',
									  '3RD',
									  '')));
self.arr_statute 				:= trim(input.statute,left,right);//???
self.arr_statute_desc 			:= trim(input.description,left,right);
self.arr_disp_date 				:= if(fSlashedMDYtoCYMD(input.arrest_dt) < Crim_Common.Version_In_Arrest_Offenses and
									  fSlashedMDYtoCYMD(input.arrest_dt) <>'00000000',
									  fSlashedMDYtoCYMD(input.arrest_dt),
									  '');
self.arr_disp_code 				:= '';
self.arr_disp_desc_1 			:= if(input.Disposition<>'' and input.Disposition<>'NO INFO',
									input.Disposition,
									'');
self.arr_disp_desc_2 			:= if(input.bond_amount ~in ['0',''] and input.bond_type ='BD',
								     ('BOND AMT $'+Arrestlogs.FormatMoney((integer)input.bond_amount)),
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

pBroward := project(fBroward,tBroward(left));

arrOut:= pBroward;
// + ArrestLogs.FileAbinitioOffenses(vendor='AI'); NOT KEEPING HISTORY

dd_arrOut := dedup(sort(distribute(arrOut,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,right):
									PERSIST('~thor_dell400::persist::ArrestLogs_FL_Broward_Offenses');

export map_FL_Broward_Offenses	:= dd_arrOut;