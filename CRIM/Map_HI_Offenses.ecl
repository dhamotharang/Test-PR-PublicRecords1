import crim_common, Crim, Address, lib_stringlib;

/*F  FELONY  
FA FELONY A  
FB FELONY B  
FC FELONY C  
JV JUVENILE VIOLATION  
MD MISDEMEANOR  
PM PETTY MISDEMEANOR  
SO STATUS OFFENSE  
VL VIOLATION  
*/

disp := dataset([{'AAP','Arraignment and Plea'},
{'GLP','Guilty'},
{'DPJ','Dismissed'},
{'DWO','Dismissed'},
{'GLT','Guilty'},
{'MOO','Moot'},
{'RFC','Remanded to Family Court'},
{'RSC','Reschedule Appearance'}, 
{'NCP','Nole Contendre (no contest) Plea Accepted'},
{'RFC','Referred to Family Court'},
{'ACC','Assigned Civil Calendar'},
{'ACQ','Motion for Judgment or Acquittal'},
{'CLC','Calendar Call'},
{'CNF','In Chambers Conference'},
{'COP','Change of Plea'},
{'CPX','Complex Litigation Designation'},
{'CSL','CS Counseling'},
{'DAG','Deferred Acceptance of Guilty Plea'},
{'DNC','Deferred Acceptance of Nolo Contendere'},
{'DSM','Motion to Dismiss'},
{'FFC','Filing of Formal Complaint'},
{'FOP','For Payment'},
{'FOR','For Refund'},
{'HMT','Hearing on Motion and/or Trial'},
{'HRG','Hearing'},
{'JRT','Jury Trial'},
{'JWT','Jury Waived Trial'},
{'NPQ','Motion to Nolle Prosequi'},
{'PET','Petitions'},
{'POA','Perfection of Appeal'},
{'POC','Proof of Compliance'},
{'PRS','CS Pre-sentence'},
{'PSM','Penal Summons'},
{'PTC','Pretrial Conference'},
{'RBW','Return of Bench Warrant'},
{'RES','Re-sentencing'},
{'SCF','Settlement Conference'},
{'SEN','Sentencing'},
{'STC','Status Conference'},
{'TRL','Trial'},
{'WVI','Waiver of Indictment'}], {string code, string desc});

input := crim.File_HI(regexfind('[0-9]', caseid));

Crim_Common.Layout_In_Court_Offenses refOK(input l) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_Development;
self.offender_key		:= '2S'+trim(l.caseid,left,right) + l.PartySequence;
self.vendor				:= '2S';
self.state_origin		:= 'HI';
self.source_file		:= 'HI_AOC_CRIM_COURT';
self.off_comp 					:= l.Crim_CountSequence;
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= if(fSlashedMDYtoCYMD(stringlib.stringfindreplace(l.arrestdate, '-', '/')) between '19010101' and Crim_Common.Version_Development,fSlashedMDYtoCYMD(stringlib.stringfindreplace(l.arrestdate, '-', '/')),'');
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
self.pros_assgn_cd 				:= l.prosecutorid;
self.pros_assgn 				:= l.prosecutor;
self.pros_chg_rej 				:= '';
self.pros_off_code 				:= '';
self.pros_off_desc_1 			:= '';
self.pros_off_desc_2 			:= '';
self.pros_off_type_cd 			:= '';
self.pros_off_type_desc 		:= '';
self.pros_off_lev 				:= '';
self.pros_act_filed 			:= '';
self.court_case_number 			:= trim(l.caseid,left,right);
self.court_cd 					:= '';
self.court_desc 				:= '';
self.court_appeal_flag 			:= '';
self.court_final_plea 			:= if(l.disp_plea = 'G', 'Guilty', '');
self.court_off_desc_1 			:= if(length(regexreplace('[^A-Za-z]', l.Filing_CauseOfAction, '')) > 6, l.Filing_CauseOfAction, '');
self.court_off_desc_2			:= '';
self.court_off_code 			:= '';
self.court_off_type_cd 			:= '';
self.court_off_type_desc 		:= '';
self.court_off_lev 				:= if(l.Filing_OffSvr[1..1] = 'M', 'M', if(l.Filing_OffSvr in ['PM', 'VL', 'F'], l.Filing_OffSvr, 
									if(l.Filing_OffSvr[1..1] = 'F', 'F'+regexreplace('D',regexreplace('C',regexreplace('B',regexreplace('A',l.Filing_OffSvr[2..2], '1'), '2'), '3'), '4')
									, '')));
self.court_statute 				:= l.Filing_LawOrdinance;
self.court_additional_statutes 	:= '';
self.court_statute_desc 		:= '';
self.court_disp_date 			:= if(fSlashedMDYtoCYMD(stringlib.stringfindreplace(l.termdate, '-', '/')) between '19010101' and Crim_Common.Version_Development,fSlashedMDYtoCYMD(stringlib.stringfindreplace(l.termdate, '-', '/')),'');
self.court_disp_code 			:= l.disposition;
self.court_disp_desc_1	 		:= '';
self.court_disp_desc_2 			:= '';
self.sent_date 					:= '';
self.sent_jail 					:=  if(regexfind('[^0-9]', l.incarcerationlength) or ~regexfind('[1-9]', l.incarcerationlength),'' ,regexreplace('^0+' ,l.incarcerationlength + ' ' + regexreplace('D',regexreplace('Y',regexreplace('M',regexreplace('H',regexreplace('W',l.incarcerationunit, 'WEEK(S)'), 'HOUR(S)'), 'MONTH(S)'), 'YEAR(S)'), 'DAY(S)'), ''));
self.sent_susp_time 			:=  if(regexfind('[^0-9]', l.SuspendedSentenceLength) or ~regexfind('[1-9]', l.SuspendedSentenceLength),'' ,regexreplace('^0+' ,l.SuspendedSentenceLength + ' ' + regexreplace('D',regexreplace('Y',regexreplace('M',regexreplace('H',regexreplace('W',l.SuspendedSentenceunit, 'WEEK(S)'), 'HOUR(S)'), 'MONTH(S)'), 'YEAR(S)'), 'DAY(S)'), ''));
self.sent_court_cost 			:= '';
self.sent_court_fine 			:= if(regexfind('[^0-9]', l.fineamount) or ~regexfind('[1-9]', l.fineamount),'' ,regexreplace('^0+' ,trim(regexreplace('[^0-9]',if(stringlib.stringfind(l.fineamount, '.', 1) > 0, l.fineamount, l.fineamount+'00'), ''), all), ''));
self.sent_susp_court_fine 		:= '';
self.sent_probation 			:=  if(regexfind('[^0-9]', l.probationlength) or ~regexfind('[1-9]', l.probationlength),'' ,regexreplace('^0+' ,l.probationlength + ' ' + regexreplace('D',regexreplace('Y',regexreplace('M',regexreplace('H',regexreplace('W',l.probationunit, 'WEEK(S)'), 'HOUR(S)'), 'MONTH(S)'), 'YEAR(S)'), 'DAY(S)'), ''));
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

refFile := project(input,refOK(left));

// output(choosen(refFile, 50));

Crim_Common.Layout_In_Court_Offenses joindisp(Crim_Common.Layout_In_Court_Offenses l, disp r) := transform
	self.court_disp_code := if(r.desc <> '', l.court_disp_code, '');
	self.court_disp_desc_1 := if(r.desc <> '', r.desc, '');
	self := l;
end;

jFile := join(refFile, disp, left.court_disp_code = right.code, joindisp(left, right), left outer, lookup);

dedFile:= dedup(sort(distribute(jFile,hash(offender_key)),
									offender_key,off_comp,court_statute,court_off_code,court_off_lev,court_off_desc_1, -court_disp_date,local),
									offender_key,off_comp,court_statute,court_off_code,court_off_lev,court_off_desc_1, local):
									PERSIST('~thor_dell400::persist::Crim_HI_Offense(S)');

export Map_HI_Offenses := dedFile;