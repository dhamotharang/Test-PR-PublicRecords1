import Crim_Common;

d := crim.File_OH_Hamilton(trim(Name,left,right)[1] ~in ['','+','.','0','1','2','3','4','5','6','7','8','9','0']);

Crim_Common.Layout_In_Court_Offenses tOHCrim(d input) := Transform

searchpattern := '(.*)/(.*)/(.*) (.*) (.*)$';

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offenses;
self.offender_key 				:= '1R'+fSlashedMDYtoCYMD(input.filed_dt)+hash(trim(input.name,all)+input.case_num);
self.vendor 					:= '1R';
self.state_origin 				:= 'OH';
self.source_file 				:= 'OH Hamilton CRIM CT';
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
self.court_off_desc_1 			:= if(regexfind('DESCRIPTION NOT IN FILE',trim(input.counts,left,right),0)='' 
									and regexfind('ORCN|'+'ORNC|'+'OCRN|'+'RCN|'+'CMCN|'+'PRCM|'+'ORN|'+'ORC|'+'ORCM|'+'0RCN',trim(input.counts,left,right),0)<>''
									and length(regexreplace('F $|'+' OR$|'+' OR $|'+'\\ .$|'+' AG $|'+' AF $|'+'\\,|'+'M--|'+'CLE -|'+'--|'+' A$|'+' B$|'+' C$|'+' D$|'+' AB$|'+'-O |'+'-CK |'+'\\/F-|'+'\\/ A|'+'-M-|'+'- A |'+': A |'+'M.VA |'+'RCPE|'+'`|'+
									'CMHA|'+' .CR|'+' .CL|'+' D$|'+' AF |'+' A R$|'+' R. |'+' A R.$|'+' A R $|'+' A B |'+'#|'+'$ , |'+'\\ . |'+'\\. .|'+' RC $|'+'R.C |'+' R.C.|'+'MMM |'+'. A|'+'R.C|'+' RC.|'+'. R.C |'+'A R.C|'+'RC.$|'+
									'. A R.C. |'+' A RC.|'+' A RC $|'+' AA |'+' AC |'+' AF |'+'D OR|'+'C OR|'+'B OR|'+'A OR|'+'\\$'+' A |'+'OR MORE|'+' F$|'+' M$|'+'MMM|'+'MM |'+' M M|'+'UU PROP|'+'M F$|'+'M M F$|'+'UUMV|'+'UUPROP|'+' [A-Z]$|'+' [A-Z] [A-Z]$|'+'\'',
									trim(regexreplace('\\(|'+'\\)|'+'[0-9]+|'+'-|'+'- $',regexreplace('ORCN|'+'ORNC|'+'OCRN|'+'RCN|'+'CMCN|'+'PRCM|'+'ORN|'+'ORC|'+'ORCM|'+'0RCN',
									trim(input.counts,left,right)[stringlib.stringfind(trim(input.counts,left,right),regexfind(searchpattern,trim(input.counts,left,right),2),1)]+
									trim(input.counts,left,right)[stringlib.stringfind(trim(input.counts,left,right),regexfind(searchpattern,trim(input.counts,left,right),2),1)+1..31],''),' '),left,right),''))>5,
									regexreplace('([A-Z][A-Z][A-Z][A-Z]F)$|'+'F $|'+' OR$|'+' OR $|'+'\\ .$|'+' AG $|'+' AF $|'+'\\,|'+'M--|'+'CLE -|'+'--|'+'A$|'+'B$|'+'C$|'+' D$|'+'AB$|'+'-O |'+'-CK |'+'\\/F-|'+'\\/ A|'+'-M-|'+'- A |'+': A |'+'M.VA |'+'RCPE|'+'`|'+'CMHA|'+' .CR|'+' .CL|'+' D$|'+' AF |'+' A R$|'+' R. |'+' A R.$|'+
									' A R $|'+' A B |'+'#|'+'$ , |'+'\\, .|'+'\\ . |'+'\\. .|'+' RC $|'+' R.C |'+' R.C.|'+'MMM |'+'. A |'+'R.C|'+'RC. |'+'. R.C|'+'A R.C|'+'. A R.C. |'+' A RC.|'+'RC.$|'+' A RC $|'+' AA |'+' AC |'+' AF |'+'D OR|'+'C OR|'+'B OR|'+'A OR|'+'\\$'+' A |'+
									'OR MORE|'+' F$|'+' M$|'+'MMM|'+'MM |'+' M M|'+'UU PROP|'+'M F$|'+'M M F$|'+'UUMV|'+'UUPROP|'+' [A-Z]$|'+' [A-Z] [A-Z]$|'+'\'',trim(regexreplace('\\(|'+'\\)|'+'[0-9]+|'+'-|'+'- $',regexreplace('ORCN|'+'ORNC|'+'OCRN|'+'RCN|'+'CMCN|'+'PRCM|'+'ORN|'+'ORC|'+'ORCM|'+'0RCN',
									trim(input.counts,left,right)[stringlib.stringfind(trim(input.counts,left,right),regexfind(searchpattern,trim(input.counts,left,right),2),1)]+
									trim(input.counts,left,right)[stringlib.stringfind(trim(input.counts,left,right),regexfind(searchpattern,trim(input.counts,left,right),2),1)+1..31],''),' '),left,right),''),
									if(regexfind('DESCRIPTION NOT IN FILE',trim(input.counts,left,right),0)='' 
									and regexfind('ORCN|'+'ORNC|'+'OCRN|'+'RCN|'+'CMCN|'+'PRCM|'+'ORN|'+'ORC|'+'ORCM|'+'0RCN',trim(input.counts,left,right),0)='',
									trim(input.counts,left,right)[stringlib.stringfind(trim(input.counts,left,right),regexfind(searchpattern,trim(input.counts,left,right),2),1)]+
									trim(input.counts,left,right)[stringlib.stringfind(trim(input.counts,left,right),regexfind(searchpattern,trim(input.counts,left,right),2),1)+1..31],
									''));
self.court_off_desc_2			:= '';
self.court_off_type_cd 			:= '';
self.court_off_type_desc 		:= '';
self.court_off_lev 				:= '';
self.court_statute 				:= '';
self.court_additional_statutes 	:= '';
self.court_statute_desc 		:= '';
self.court_disp_date 			:= '';
self.court_disp_code 			:= '';
self.court_disp_desc_1	 		:= if(regexfind('CONV|'+'ACQUIT|'+'DISM|'+'DEFER|'+'GUILT',input.disposition,0)<>'',
									regexreplace('[0-9]+',regexreplace('/',input.disposition,''),''),
									'');
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

pOHCrim := project(d,tOHCrim(left));

fOHOffend:= dedup(sort(distribute(pOHCrim,hash(offender_key)),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,source_file,local),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::Crim_OH_Hamilton_Offenses_Clean');

export map_OH_Hamilton_Offenses	:= fOHOffend;
