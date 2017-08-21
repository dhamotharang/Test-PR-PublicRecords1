import Crim_Common;

input := crim.File_SC_York(parytypedescription = 'Defendant');

Crim_Common.Layout_In_Court_Offenses refOK(input l) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

case_filing_dt		:= if(fSlashedMDYtoCYMD(l.fileddate) between '19000101' and Crim_Common.Version_Development,
							fSlashedMDYtoCYMD(l.fileddate),
							'');
							
self.process_date 				:= Crim_Common.Version_In_Arrest_Offenses;
self.vendor 					:= '2X';
self.state_origin 				:= 'SC';
self.source_file 				:= 'SC_YORK_CRIM_COURT';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= if(fSlashedMDYtoCYMD(l.arrestdate) between '19000101' and Crim_Common.Version_Development,
									fSlashedMDYtoCYMD(l.arrestdate), '');
self.num_of_counts 				:= '';
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= '';
self.le_agency_case_number 		:= if(regexfind('[0-9]', l.LawEnfCase), l.LawEnfCase, '');
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
self.court_case_number 			:= trim(l.casenumber,left,right);
self.court_cd 					:= '';
self.court_desc 				:= l.CourtAgency;
self.court_appeal_flag 			:= '';
self.court_final_plea 			:= '';
self.court_off_code 			:= if(stringlib.stringfind(l.ChargeDescription, '-', 1) > 0, l.ChargeDescription[1..stringlib.stringfind(l.ChargeDescription, '-', 1)-1], '');
self.court_off_desc_1 			:= regexreplace('^(Traffic/)|^(Traffic +/)' , trim(if(stringlib.stringfind(l.ChargeDescription, '-', 1) > 0, l.ChargeDescription[stringlib.stringfind(l.ChargeDescription, '-', 1)+1..60], l.ChargeDescription), left, right), '');
self.court_off_desc_2			:= '';
self.court_off_type_cd 			:= '';
self.court_off_type_desc 		:= '';
self.court_off_lev 				:= '';
self.court_statute 				:= '';
self.court_additional_statutes 	:= '';
self.court_statute_desc 		:= '';
self.court_disp_date 			:= if(fSlashedMDYtoCYMD(l.DispositionDt) between '19000101' and Crim_Common.Version_Development,fSlashedMDYtoCYMD(l.DispositionDt) ,'' );
self.court_disp_code 			:= '';
self.court_disp_desc_1	 		:= l.disposition;
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

self.offender_key		:= '2X'+ l.id + case_filing_dt;
end;

prefFile := project(input,refOK(left));

Crim_Common.Layout_In_Court_Offenses cleanup(Crim_Common.Layout_In_Court_Offenses l) := transform
self.court_off_desc_1 := if(length(regexreplace('[^A-Za-z]', l.court_off_desc_1, '')) > 5, l.court_off_desc_1, '');
self := l;
end;

refFile := project(prefFile,cleanup(left));


dedFile:= dedup(sort(distribute(refFile,hash(offender_key)),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,-court_off_lev,court_off_desc_1, -court_disp_date, -court_disp_desc_1,local),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_desc_1, local):
									PERSIST('~thor_dell400::persist::Crim_SC_YORK_Offenses');

export Map_SC_YORK_Offenses := dedFile;