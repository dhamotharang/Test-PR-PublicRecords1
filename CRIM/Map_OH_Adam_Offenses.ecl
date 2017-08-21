import lib_stringlib, lib_date, Crim_Common;

input := crim.File_OH_ADAM.crim2(degree <> 'Degree');
input2 := crim.File_OH_ADAM.lexis(plea <> 'Plea');

Crim_Common.Layout_In_Court_Offenses reformat(input l) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offenses;
self.offender_key		:= '2W'+trim(l.case_number,left,right) + hash(l.defendant);
self.vendor 					:= '2W';
self.state_origin 				:= 'OH';
self.source_file 				:= 'OH_ADAMS_CRIM_COURT';
self.court_case_number 			:= trim(l.case_number,left,right);
self.court_off_desc_1 			:= trim(regexreplace(' [0-9]+\\.[0-9A-Za-z]+ ' ,' '+l.Description+' ', ''), left, right);
self.court_off_lev 				:= regexreplace('[^MFT0-9]', l.degree, '');
self.court_statute 				:= l.section_number;
self.court_disp_desc_1	 		:= if(regexfind('SENTE|GUILT|SUSP', l.sentencing_info), 'GUILTY', if(regexfind('DISMISS', l.sentencing_info), 'NoT GUILTY', ''));
self.sent_date 					:= if(fSlashedMDYtoCYMD(stringlib.stringfindreplace(l.sentencing_date, '-', '/')) between '19000101' and Crim_Common.Version_Development,
							fSlashedMDYtoCYMD(stringlib.stringfindreplace(l.sentencing_date, '-', '/')),
							'');
self := [];

end;

prefFile := project(input,reformat(left));

Crim_Common.Layout_In_Court_Offenses reformat2(input2 l) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offenses;
self.offender_key		:= '2W'+trim(l.case_number,left,right) + hash(l.defendant);
self.vendor 					:= '2W';
self.state_origin 				:= 'OH';
self.source_file 				:= 'OH_ADAMS_CRIM_COURT';
self.court_case_number 			:= trim(l.case_number,left,right);
self.court_final_plea			:= l.plea;
self.court_off_desc_1 			:= trim(regexreplace(' [0-9]+\\.[0-9A-Za-z]+ ' ,' '+l.Description+' ', ''), left, right);
self.court_statute 				:= l.section;
self.court_disp_desc_1	 		:= if(l.found = 'D', 'DISMISSED', if(l.found = 'G', 'Guilty', ''));
self.court_disp_date			:= if(fSlashedMDYtoCYMD(stringlib.stringfindreplace(l.dispo_date, '-', '/')) between '19000101' and Crim_Common.Version_Development,
							fSlashedMDYtoCYMD(stringlib.stringfindreplace(l.dispo_date, '-', '/')),
							'');
self.sent_jail				:= regexreplace('^0+', if(regexfind('[1-9]', l.jail_days), regexreplace('[^0-9]',l.jail_days, '') + ' DAY(S)', ''), '');
self.sent_susp_time			:= regexreplace('^0+', if(regexfind('[1-9]', l.jail_susp), regexreplace('[^0-9]',l.jail_susp, '') + ' DAY(S)', ''), '');
self.sent_court_cost		:= regexreplace('^ +0+', (string)intformat((integer)if(regexfind('[1-9]\\.', l.costs) and regexfind('[1-9]', l.costs), regexreplace('[^0-9]', l.costs, ''), ''), 8, 0), '');
self.sent_court_fine		:= regexreplace('^ +0+', (string)intformat((integer)if(regexfind('[1-9]\\.', l.fine_amt) and regexfind('[1-9]', l.fine_amt), regexreplace('[^0-9]', l.fine_amt, ''), ''), 8, 0), '');
self.sent_susp_court_fine	:= regexreplace('^ +0+', (string)intformat((integer)if(regexfind('[1-9]\\.', l.fine_susp) and regexfind('[1-9]', l.fine_susp), regexreplace('[^0-9]', l.fine_susp, ''), ''), 8, 0), '');
self := [];

end;

prefFile2 := project(input2,reformat2(left));


// Crim_Common.Layout_In_Court_Offenses cleanup(Crim_Common.Layout_In_Court_Offenses l) := transform
// self.court_off_desc_1 := if(length(regexreplace('[^A-Za-z]', l.court_off_desc_1, '')) > 5, l.court_off_desc_1, '');
// self := l;
// end;

refFile := preffile2 + prefFile;


dedFile:= dedup(sort(distribute(reffile,hash(offender_key)),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,-court_off_lev,court_off_desc_1, -sent_date, -court_disp_desc_1,local),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_desc_1, local):
									PERSIST('~thor_dell400::persist::Crim_OH_ADAM_Offenses');

export Map_OH_ADAM_Offenses := dedFile;