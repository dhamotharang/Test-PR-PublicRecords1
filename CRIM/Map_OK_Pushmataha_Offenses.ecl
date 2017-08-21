import Crim_Common;

input := crim.File_OK_PUSHMATAHA(regexfind('[0-9]', casenumber));

String cleanDisp(String s) := FUNCTION
deferred := if(regexfind('DEFERRED', s), 'DEFERRED', s);
// dismissed := if(regexfind('DISMISSED', deferred), 'DISMISSED', deferred);
return if(regexfind('DISMISSED', deferred), 'DISMISSED', deferred);
END;


Crim_Common.Layout_In_Court_Offenses refOK(input l) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

string off_desc(string CountAsFiled)
:= regexreplace(' +', stringlib.stringfindreplace(regexreplace('(\\(FELONY\\))|(\\(MISDEMEANOR\\))|(FELONY)|(MISDEMEANOR)|(\\(MISD\\))|(MISD)' , if(length(CountAsFiled[1..DataLib.StringFind(CountAsFiled, ',',1)-1]) < 7, '',  CountAsFiled[1..DataLib.StringFind(CountAsFiled, ',',1)-1] + ' ') + trim(regexreplace('(\\(FELONY\\))(\\*MISDEMEANOR\\*)|(\\*FELONY\\*)|\\(MISDEMEANOR\\)|(\\(MISD\\))||\\(FELONY\\)',stringlib.stringtouppercase(if(regexfind('in violation of', CountAsFiled), CountAsFiled[DataLib.StringFind(CountAsFiled, ',',1)+1..DataLib.StringFind(CountAsFiled, 'in violation of',1)-3], CountAsFiled)),  ''), left, right), ''), '*', ' '), ' ');

self.process_date 				:= Crim_Common.Version_In_Arrest_Offenses;
self.offender_key		:= '2C'+trim(l.casenumber,left,right)+l.id;
self.vendor 					:= '2C';
self.state_origin 				:= 'OK';
self.source_file 				:= 'OK_PUSHMATAHA_CRIM_COURT';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= if(~regexfind('[^0-9]', fSlashedMDYtoCYMD(l.DateOfOffense)) and fSlashedMDYtoCYMD(l.DateOfOffense) between '19000101' and Crim_Common.Version_Development,
									fSlashedMDYtoCYMD(l.DateOfOffense), '');
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
self.court_case_number 			:= trim(l.casenumber,left,right);
self.court_cd 					:= '';
self.court_desc 				:= '';
self.court_appeal_flag 			:= '';
self.court_final_plea 			:= '';
self.court_off_code 			:= if(off_desc(l.CountAsFiled) <>'' and length(l.CountAsFiled) > 6 and length(l.CountAsFiled[1..DataLib.StringFind(l.CountAsFiled, ',',1)-1]) < 7, l.CountAsFiled[1..DataLib.StringFind(l.CountAsFiled, ',',1)-1], '');
self.court_off_desc_1 			:= trim(if(length(off_desc(l.CountAsFiled)) > 6, off_desc(l.CountAsFiled), ''), left);
self.court_off_desc_2			:= '';
self.court_off_type_cd 			:= '';
self.court_off_type_desc 		:= '';
self.court_off_lev 				:= if(regexfind('MISD', l.CountAsFiled), 'M', if(regexfind('FELO', l.CountAsFiled), 'F', ''));
self.court_statute 				:= l.disposedstatute;
self.court_additional_statutes 	:= '';
self.court_statute_desc 		:= '';
self.court_disp_date 			:= if(~regexfind('[^0-9]', fSlashedMDYtoCYMD(regexreplace('[^0-9/]', l.disposed, ''))[7..8]) and fSlashedMDYtoCYMD(regexreplace('[^0-9/]', l.disposed, '')) between '19000101' and Crim_Common.Version_Development and fSlashedMDYtoCYMD(regexreplace('[^0-9/]', l.disposed, ''))[5..6] <> '00'
									,fSlashedMDYtoCYMD(regexreplace('[^0-9/]', l.disposed, '')),'' );
self.court_disp_code 			:= '';
self.court_disp_desc_1	 		:= cleanDisp(regexreplace('DISMISSED Dismissed- Request of the State', regexreplace('DISMISSED WITH COSTS Dismissed with Cost', if(fSlashedMDYtoCYMD(l.disposed) = '00000000' or ~regexfind('(ACQUITTED)|(DEFERRED)|(DISCHARG)|(DISMISSED)|(Guilty)', l.disposed),'' , trim(regexreplace(' +', regexreplace('CONVICTION', StringLib.StringFilterOut(l.disposed, '0123456789/\\.,'), ''), ' '), left, right)), 'DISMISSED WITH COSTS'), 'DISMISSED'));
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

refFile := project(input,refOK(left));

dedFile:= dedup(sort(distribute(refFile,hash(offender_key)),
									offender_key,off_comp,-court_statute,court_off_code,court_off_lev,court_off_desc_1, -court_disp_date, -court_disp_desc_1,local),
									offender_key,off_comp,court_off_desc_1, local)(court_off_desc_1 <> ''):
									PERSIST('~thor_dell400::persist::Crim_OK_PUSHMATAHA_Offenses');

export Map_OK_PUSHMATAHA_Offenses := dedFile;