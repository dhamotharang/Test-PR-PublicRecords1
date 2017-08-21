import Crim_Common, lib_stringlib;

input := crim.File_SC_Greenville(firstname <> 'FirstName' and parytypedescription = 'Defendant');

Crim_Common.Layout_In_Court_Offenses refOK(input l) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_Development;
self.offender_key		:= '2Q'+trim(l.casenumber,left,right)+hash32(l.partiesname);
self.vendor 					:= '2Q';
self.state_origin 				:= 'SC';
self.source_file 				:= 'SC_Greenville_CRIM_COURT';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= if(fSlashedMDYtoCYMD(l.arrestdate) between '19000101' and Crim_Common.Version_Development,
									fSlashedMDYtoCYMD(l.arrestdate), '');
self.num_of_counts 				:= '';
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= '';
self.le_agency_case_number 		:= if(length(l.lawenfcase) > 4, l.lawenfcase, '');
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= trim(if(length(regexreplace('[^a-zA-z]', l.originalcharge, '')) < 5 or ~regexfind('[A-Za-z]' ,l.originalcharge), '', stringlib.stringfilterout(l.originalcharge, '*')), left, right);
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
self.court_desc 				:= '';
self.court_appeal_flag 			:= '';
self.court_final_plea 			:= '';
self.court_off_code 			:= '';
self.court_off_desc_1 			:= trim(if(length(regexreplace('[^a-zA-z]', l.chargedescription, '')) < 5 or ~regexfind('[A-Za-z]' ,l.chargedescription), '', stringlib.stringfilterout(l.chargedescription, '*')), left, right);
self.court_off_desc_2			:= '';
self.court_off_type_cd 			:= '';
self.court_off_type_desc 		:= '';
self.court_off_lev 				:= '';
self.court_statute 				:= '';
self.court_additional_statutes 	:= '';
self.court_statute_desc 		:= '';
self.court_disp_date 			:= if(fSlashedMDYtoCYMD(l.dispositiondate) between '19000101' and Crim_Common.Version_Development,
									fSlashedMDYtoCYMD(l.dispositiondate), '');
self.court_disp_code 			:= '';
self.court_disp_desc_1	 		:= stringlib.stringfindreplace(if(l.disposition in ['Dismissed','Dismissed at Preliminary','Disposed in another court','Disposed in another court - ended','Insuff Evidence at this time to Convict','Insuff Evidence to convict - ended','Judicial Dismissal/Clerk','Nolle Prosse','Plead Guilty/Clerk Criminal','Pled Guilty or Convicted of other charge','Pled guilty to other charged - ended','Pled guilty to other charges','Prosecutorial Discretion','Prosecutorial Discretion -ended','Transferred for Fed Prosecution - ended','Transferred for Federal prosecution','Trial/Guilty/Clerk Criminal','Trial/Not Guilty/Clerk Criminal'], l.disposition, ''), ' - ended', '');
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

pOHCrimtemp := project(input,refOK(left));

Crim_Common.Layout_In_Court_Offenses tOHCrim2(Crim_Common.Layout_In_Court_Offenses l) := Transform

string repLev(string l) := if(~regexfind('( OF +MISD)|( +A +MISD)|( TO +MISD)|( +A +FEL)|( TO +FEL)|( OF +FEL)', stringlib.stringtouppercase(l)),
regexreplace('(\\[M.[1-6]\\] )|(\\[F.[1-6]\\] )|(M.[1-6] )|(M[1-6] )|(MISDEMEANOR)|(misdemeanor)|(Misdemeanor)|(MISD)|(misd)|(Misd)|(FEL\\-[1-6] )|(F.[1-6] )|(F[1-6] )|(FELONY)|(felony)|(Felony)', l, ''), l);

// string1 findmisd(string l) := 
// if(regexfind('', l), 'M', '');

string repDeg(string l) := 
regexreplace('(1st)|(1ST)|(FIRST)|(first)|(First)|(2nd)|(2ND)|(FIRST)|(first)|(First)|(3RD)|(3rd)|(THIRD)|(Third)|(third)|(4th)|(4TH)|(FOURTH)|(Fourth)|(fourth)|(5th)|(5TH)|(FIFTH)|(Fifth)|(fifth)|(6th)|(6TH)|(SIXTH)|(Sixth)|(sixth)', l, '');

self.arr_off_desc_1 := regexreplace('(deg )|(degree)|(DEG )|(DEGREE)',trim(regexreplace('^\\-|\\-$|/$|/ +/' ,trim(repDeg(repLev(trim(l.arr_off_desc_1, left, right))), left, right), ''), left, right) + ' ', '');
self.court_off_desc_1 := regexreplace('(deg )|(degree)|(DEG )|(DEGREE)',trim(regexreplace('^\\-|\\-$|/$|/ +/' ,trim(repDeg(repLev(trim(l.court_off_desc_1, left, right))), left, right), ''), left, right) + ' ', '');

self := l;
end;

refFile := project(pOHCrimtemp,tOHCrim2(left));

dedFile:= dedup(sort(distribute(refFile,hash(offender_key)),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_lev,court_off_desc_1, -court_disp_date, -court_disp_desc_1,local),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_lev,court_off_desc_1, local):
									PERSIST('~thor_dell400::persist::Crim_SC_Greenville_Offenses');

export Map_SC_Greenville_Offenses := dedFile;