import Crim_Common;

d := crim.File_OH_Allen_LimaMunicipal;

Crim_Common.Layout_In_Court_Offenses tOHCrim(d input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offenses;
self.offender_key 				:= '3C'+input.ID;
self.vendor 					:= '3C';
self.state_origin 				:= 'OH';
self.source_file 				:= 'OH_Allen_Lima_Municipal';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= fSlashedMDYtoCYMD(input.ViolationDate);
self.arr_date 					:= '';
self.num_of_counts 				:= '';
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= input.ArrestingAgency;
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= input.TicketNumber;
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= '';
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= '';
self.arr_statute 				:= input.OriginalCharge[1..stringlib.stringfind(input.OriginalCharge,'-',1)-1];
self.arr_statute_desc 			:= input.OriginalCharge[stringlib.stringfind(input.OriginalCharge,'-',1)-1..stringlib.stringfind(input.OriginalCharge,'-',1)+70];
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
self.court_case_number 			:= input.caseno;
self.court_cd 					:= '';
self.court_desc 				:= '';
self.court_appeal_flag 			:= '';
self.court_final_plea 			:= '';
self.court_off_code 			:= '';
self.court_off_desc_1 			:= stringlib.stringfilterout(input.offense,'*');
self.court_off_desc_2			:= '';
self.court_off_type_cd 			:= '';
self.court_off_type_desc 		:= '';
self.court_off_lev 				:= trim(regexreplace('BOND',input._penalty,''),left,right);
self.court_statute 				:= regexreplace('CONV',input.sectioncode,'');
self.court_additional_statutes 	:= '';
self.court_statute_desc 		:= '';
self.court_disp_date 			:= '';
self.court_disp_code 			:= '';
self.court_disp_desc_1	 		:= if(input.Finding<>'',input.Finding,regexreplace('CONVERSION DATA',input.status,''));
self.court_disp_desc_2 			:= if(input.licensesuspended<>'','License Suspended '+ input.licensesuspended,'');
self.sent_date 					:= '';
self.sent_jail 					:= if(regexfind('[0-9]',input.jail),input.jail,'');
self.sent_susp_time 			:= '';

unsigned court_cost				:= (unsigned)Stringlib.stringfilter(input.TotalAmount,'0123456789')
									- ((unsigned)Stringlib.stringfilter(input.FinesDue,'0123456789') - (unsigned)Stringlib.stringfilter(input.FinesSuspended,'0123456789'));
									
self.sent_court_cost 			:= if(regexfind('[1-9]',input.TotalAmount),(string)court_cost,'');
self.sent_court_fine 			:= if(regexfind('[1-9]',input.FinesDue),Stringlib.stringfilter(input.FinesDue,'0123456789'),'');
self.sent_susp_court_fine 		:= if(regexfind('[1-9]',input.FinesSuspended),Stringlib.stringfilter(input.FinesSuspended,'0123456789'),'');
self.sent_probation 			:= stringlib.stringfilterout(if(regexfind('[0-9]',input.probationtime),input.probationtime,''),'.');
self.sent_addl_prov_code 		:= '';
self.sent_addl_prov_desc_1 		:= input.conditions;
self.sent_addl_prov_desc_2 		:= '';
self.sent_consec 				:= if(regexfind('CONSECUTIVE',input.jail),'C','');
self.sent_agency_rec_cust_ori 	:= '';
self.sent_agency_rec_cust 		:= '';
self.appeal_date 				:= '';
self.appeal_off_disp 			:= '';
self.appeal_final_decision 		:= '';

end;

pOHCrim := project(d,tOHCrim(left));

fOHOffend:= dedup(sort(distribute(pOHCrim,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_desc_1,court_statute_desc,court_off_desc_1,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_desc_1,court_statute_desc,court_off_desc_1,local,right):
									PERSIST('~thor_dell400::persist::Crim_OH_Allen_LimaMunicipal_Offenses');

export Map_OH_Allen_LimaMunicipal_Offenses := fOHOffend;