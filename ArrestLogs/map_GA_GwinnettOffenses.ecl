import Crim_Common, Address, ut;

p	:= ArrestLogs.file_GA_Gwinnett.cmbnd;

Crim_Common.Layout_In_Court_Offenses tGwinnett(p input) := Transform

updateFileNo   := fileservices.GetSuperFileSubCount('~thor_data400::in::arrlog::ga::gwinnett'): stored('updateFileNo');; 
updateFileName := fileservices.GetSuperFileSubName('~thor_data400::in::arrlog::ga::gwinnett',updateFileNo): stored('updateFileName');
update_date    := stringlib.stringfilter(regexreplace('thor_data400',updateFileName,''),'0123456789')[1..8]: stored('update_date');

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= update_date;
self.offender_key 				:= 'AN'+input.ID;
self.vendor 					:= 'AN';
self.state_origin 				:= 'GA';
self.source_file 				:= '(CV)GA-GwinnettCtyArr';
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
self.arr_off_desc_1 			:= if(length(trim(
									regexreplace(' +'
										,stringlib.stringfilter(Stringlib.stringtouppercase(input.descr)
										,' ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-')
										,' ')
									,left,right))<5, '',
									trim(
									regexreplace(' +'
										,stringlib.stringfilter(Stringlib.stringtouppercase(input.descr)
										,' ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-')
										,' ')
									,left,right));
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= if(input.fel_misd_traffic_hold in ['M','F','T','I'],
										input.fel_misd_traffic_hold,
										'');
self.arr_statute 				:= if(regexfind('[0-9]',input.code_section,0)<>'' and
									regexfind('\\*|00-00000',input.code_section,0)='' and
									length(input.code_section)>1,
									input.code_section,
									'');
self.arr_statute_desc 			:= '';
self.arr_disp_date 				:= '';
self.arr_disp_code 				:= '';
self.arr_disp_desc_1 			:= 'BOOKED'+' '+'WARRANT# '+input.warrant_num;
self.arr_disp_desc_2 			:= if(input.bond <> '0' and input.bond <> '' and input.bond <> ' ' and trim(Arrestlogs.FormatMoney((integer)input.bond), left) <> '0.00'
                                /*and trim(Arrestlogs.FormatMoney((integer)input.bond), all) <> ' '*/
                                and length(trim(Arrestlogs.FormatMoney((integer)input.bond), left)) < 10,
								     ('BOND AMT ' +'$' + trim(Arrestlogs.FormatMoney((integer)input.bond), left)),
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

pGwinnett := project(p,tGwinnett(left));

arrOut:= pGwinnett(arr_off_desc_1<>'' and regexfind('[a-zA-Z]',arr_off_desc_1)) + ArrestLogs.FileAbinitioOffenses(vendor='AN');

dd_arrOut := dedup(sort(distribute(arrOut,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::ArrestLogs_GA_Gwinnett_Offenses');

export map_GA_GwinnettOffenses	:= dd_arrOut;