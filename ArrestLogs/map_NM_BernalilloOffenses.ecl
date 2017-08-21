import Crim_Common, Address, Gong;

p	:= ArrestLogs.file_NM_Bernalillo;

fBernalillo := p(trim(p.Name,left,right)<>'Name');

Crim_Common.Layout_In_Court_Offenses tBernalillo(fBernalillo input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key 				:= 'AF'+TRIM(input.booking_num, right, left)+input.ID;
self.vendor 					:= 'AF';
self.state_origin 				:= 'NM';
self.source_file 				:= '(CV)NM-BernalilloCtyArr';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= if(fSlashedMDYtoCYMD(input.arrest_dt)[1..2] in ['19','20']
									and fSlashedMDYtoCYMD(input.arrest_dt) < Crim_Common.Version_In_Arrest_Offenses,
									fSlashedMDYtoCYMD(input.arrest_dt),
									'');
self.num_of_counts 				:= '';
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= '';
self.le_agency_case_number 		:= input.booking_num;
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= input.descr2;
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= '';
self.arr_statute 				:= input.statute;
self.arr_statute_desc 			:= '';
self.arr_disp_date 				:= '';
self.arr_disp_code 				:= '';
self.arr_disp_desc_1 			:= 'BOOKED';
self.arr_disp_desc_2 			:= if(input.bond_amt ~in ['0',''],
								     ('BOND AMT '+'$'+Arrestlogs.FormatMoney((integer)input.bond_amt)),
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

pBernalillo := project(fBernalillo,tBernalillo(left));

//gBernalillo := group(pBernalillo,offender_key); 

Crim_Common.Layout_In_Court_Offenses AddSequence(pBernalillo l) := TRANSFORM
//SELF.off_comp := (string)c;
SELF := l;
END;

seqRecs := PROJECT(pBernalillo, AddSequence(LEFT));

arrOut:= seqRecs + ArrestLogs.FileAbinitioOffenses(vendor='AF');
/*
dd_arrOut:= dedup(sort(distribute(arrOut,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,left)
									: PERSIST('~thor_dell400::persist::ArrestLogs_NM_Bernalillo_Offenses');
*/									

dd_arrOut:= dedup(sort(distribute(arrOut,hash(offender_key)),
									offender_key,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,local),
									offender_key,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,left)
									: PERSIST('~thor_dell400::persist::ArrestLogs_NM_Bernalillo_Offenses');
									
export map_NM_BernalilloOffenses := dd_arrOut; 








