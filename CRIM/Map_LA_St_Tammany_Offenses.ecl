import Crim_Common;

d := crim.File_LA_St_Tammany(Firstname<>'');

Crim_Common.Layout_In_Court_Offenses tLACrim(d input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

string		fCleanVerdict(string pverdict)
:= regexreplace('\\*|'+'1ST|'+'[0-9]+|'+'\\#|'+'\\(|'+'\\)|'+'-|'+'\\:|'+'\\/',pverdict,'');

self.process_date 				:= Crim_Common.Version_In_Arrest_Offenses;
self.offender_key 				:= '2N'+trim(input.docketno,left,right)+fSlashedMDYtoCYMD(trim(input.filedate,left,right))+hash(regexreplace('AKA',input.lastname,'')+' '+regexreplace('AKA|'+',',input.firstname,''));
self.vendor 					:= '2N';
self.state_origin 				:= 'LA';
self.source_file 				:= 'LA St Tammany CRIM CT';
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
self.pros_assgn 				:= if(~regexfind('(UNKNOWN)|'+'(unknown)|'+'(ASST\\.)|'+'(PROSEC)', trim(input.prosecutingattorney,left,right)),
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
self.court_case_number 			:= trim(input.docketno,left,right);
self.court_cd 					:= '';
self.court_desc 				:= '';
self.court_appeal_flag 			:= '';
self.court_final_plea 			:= if(regexfind('NOT GUILTY',trim(input.plea_verdict,left,right),0)<>'',
									fCleanVerdict(trim(input.plea_verdict,left,right)),
									if(regexfind('GUILTY',trim(input.plea_verdict,left,right),0)<>'', 
									fCleanVerdict(trim(input.plea_verdict,left,right)),
									''));
self.court_off_code 			:= '';
self.court_off_desc_1 			:= if(regexfind('[A-Z]+',trim(input.charge,left,right),0)<>''
									and regexfind('SEE |'+'BILL|'+'DOCKET ',trim(input.charge,left,right),0)=''
									and regexfind('[0-9]+',trim(input.charge,left,right)[1..4],0)='',
									regexreplace('\\(|'+'\\)',regexreplace('&nbsp;|'+'#|'+'1ST|'+'FIRST|'+'2ND|'+'SECOND|'+'TWO|'+
									'SEC0ND|'+'SECND|'+'3RD|'+'THIRD|'+'4TH|'+'FOURTH|'+'5TH|'+'6TH|'+//' [0-9]+$|'+'1$|'+'2$|'+'3$|'+'4$|'+'5$|'+'6$|'+
									' I$|'+' II$|'+' III$|'+' IV$|'+' V$|'+' VI$|'+'DEGREE|'+'OFFENSE|'+'DEG|'+
									'[0-9]+ CTS|'+'[0-9]+ COUNTS|'+'COUNT|'+'COUNTS|'+'DK$',trim(input.charge,left,right),' '),''),
									'');
self.court_off_desc_2			:= '';
self.court_off_type_cd 			:= '';
self.court_off_type_desc 		:= '';
self.court_off_lev 				:= if(trim(input.chargetype,left,right) in ['F','M'],
									trim(input.chargetype,left,right),
									'');
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

pLACrim := project(d,tLACrim(left));

fLAOffend:= dedup(sort(distribute(pLACrim,hash(offender_key)),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,source_file,local),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::Crim_LA_St_Tammany_Offenses_Clean');

export map_LA_St_Tammany_Offenses	:= fLAOffend;
