import Crim_Common;

d := crim.File_TN_Hamilton(trim(name,left,right)<>'' and regexfind('[0-9][0-9]',name,0)='');

Crim_Common.Layout_In_Court_Offenses tTNCrim(d input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offenses;
self.offender_key 				:= '2U'+trim(input.casenumber,left,right)+fSlashedMDYtoCYMD(input.filing_dt);
self.vendor 					:= '2U';
self.state_origin 				:= 'TN';
self.source_file 				:= 'TN HAMILTON CRIM CT';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= if(fSlashedMDYtoCYMD(trim(input.offensedate,left,right))[1..4] >= '1800' and 
									fSlashedMDYtoCYMD(trim(input.offensedate,left,right))<=stringlib.GetDateYYYYMMDD(),
									fSlashedMDYtoCYMD(trim(input.offensedate,left,right)),
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
self.court_off_desc_1 			:= if(regexfind('[A-Z]',trim(input.charge,left,right),0)<>'' and
									length(regexreplace('1ST|2ND|3RD|[4-9]TH|OFF.|OFFENSE|OFFENCE|DEGREE|TCA|F.T.S.|000|395 3M|[0-9]+'+'\\-'+'[0-9]+'+'\\-'+'[0-9]+|'+'[0-9]+'+'\\.'+'[0-9]+[A-Z]+ |'+'[0-9][0-9][0-9][0-9][0-9][0-9]+|'+'[0-9]+'+'\\.'+'[0-9]+|\\.',StringLib.StringToUpperCase(trim(input.charge,left,right)),''))>5 and
									regexfind('[A-Z]',regexreplace('\\-',regexreplace('1ST|2ND|3RD|[4-9]TH|OFF.|OFFENSE|OFFENCE|DEGREE|TCA|F.T.S.|000|395 3M|[0-9]+'+'\\-'+'[0-9]+'+'\\-'+'[0-9]+|'+'[0-9]+'+'\\.'+'[0-9]+[A-Z]+ |'+'[0-9][0-9][0-9][0-9][0-9][0-9]+|'+'[0-9]+'+'\\.'+'[0-9]+|\\.',StringLib.StringToUpperCase(trim(input.charge,left,right)),''),''),0)<>'',
									regexreplace('$\\.',regexreplace('1ST|2ND|3RD|[4-9]TH|OFF.|OFFENSE|OFFENCE|DEGREE|TCA|F.T.S.|000|395 3M|[0-9]+'+'\\-'+'[0-9]+'+'\\-'+'[0-9]+|'+'[0-9]+'+'\\.'+'[0-9]+[A-Z]+ |[0-9][0-9][0-9][0-9][0-9][0-9]+|'+'[0-9]+'+'\\.'+'[0-9]+|\\.|'+'3958F1|'+'39-16- 609-|'+'396,7',StringLib.StringToUpperCase(trim(input.charge,left,right)),''),''),
									'');
self.court_off_desc_2			:= if(regexfind('\\$'+'0.00',trim(input.fine,left,right),0)='' and
									regexfind('\\$',trim(input.fine,left,right),0)<>'',
									trim(input.fine,left,right)+' '+'FINE',
									'');
self.court_off_type_cd 			:= '';
self.court_off_type_desc 		:= '';
self.court_off_lev 				:= '';
self.court_statute 				:= '';
self.court_additional_statutes 	:= '';
self.court_statute_desc 		:= '';
self.court_disp_date 			:= if(fSlashedMDYtoCYMD(trim(input.disposition_dt,left,right))[1..2] >= '19' and 
									fSlashedMDYtoCYMD(trim(input.disposition_dt,left,right))<=stringlib.GetDateYYYYMMDD(),
									fSlashedMDYtoCYMD(trim(input.disposition_dt,left,right)),
									'');
self.court_disp_code 			:= '';
self.court_disp_desc_1	 		:= if(regexfind('AMENDED|BOUND OVER|DISMISSED|DIVERSION|GUILTY|REVOCATION',StringLib.StringToUpperCase(trim(input.disposition,left,right)),0)<>'',
									StringLib.StringToUpperCase(trim(input.disposition,left,right)),
									'');
self.court_disp_desc_2 			:= '';
self.sent_date 					:= '';
self.sent_jail 					:= if(regexfind('Suspended|Probation|\\$',trim(input.sentence,left,right),0)='',
									regexreplace(', Costs Waived',regexreplace('Judgment of',regexreplace('in the County Jail',regexreplace('in the County Workhouse',trim(input.sentence,left,right),''),''),''),''),
									'');
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

pTNCrim := project(d,tTNCrim(left));

fTNOffend:= dedup(sort(distribute(pTNCrim,hash(offender_key)),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,source_file,local),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::Crim_TN_Hamilton_Offenses_Clean');

export map_TN_Hamilton_Offenses	:= fTNOffend;
