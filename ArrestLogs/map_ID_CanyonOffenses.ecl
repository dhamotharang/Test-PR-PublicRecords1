import Crim_Common, Address, Gong, ut;

p	:= file_ID_Canyon(name<>'Name');


Crim_Common.Layout_In_Court_Offenses  tCanyon(p input) 
:= Transform
lstb:=Stringlib.StringFind( input.Charge ,' - ',1);
len:=length(input.Charge);
lsts:=Stringlib.StringFind(input.Charge,']',1);
lstl:=Stringlib.StringFind(input.Charge,'[',1);

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

string8     getReasonableRange(string newDateIn) 
:=    map((newDateIn[1..2] between '19' and '20') and 
			(newDateIn < ut.GetDate) => newDateIn,'');
			
			
self.process_date				:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key				:= 'F6'+trim(input.ID,left,right);
self.vendor						:= 'F6';
self.state_origin				:= 'ID';
self.source_file				:= '(CV)ID-CanyonArr';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= //input.photo for some files is actually the arrest date
									if(regexfind('.jpg',input.photo)
												,''
												,getReasonableRange(fSlashedMDYtoCYMD(input.photo[1..stringlib.stringfind(input.photo,' ',1)-1])));
self.num_of_counts 				:= '';
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= '';
self.le_agency_case_number 		:= input.ID;
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev				:= if(IF(length(trim(input.Charge[lstl+1..lsts-1],all))=2,'',input.Charge[lstl+1..lsts-1]) in ['F','M'],
									IF(length(trim(input.Charge[lstl+1..lsts-1],all))=2,'',input.Charge[lstl+1..lsts-1]),
									'');
									
self.arr_statute			    := if(regexfind('-', input.Charge[1..lstb]), regexreplace('\\[M\\]|\\[F\\]|\\{.\\}', input.Charge[1..lstb], ''), '');
		 
self.arr_off_desc_1 			:= if(regexfind('-', input.Charge[1..lstb]), regexreplace('\\[M\\]|\\[F\\]|\\{.\\}', input.charge[lstb+3..], ''), regexreplace('\\[M\\]|\\[F\\]|\\{.\\}', input.Charge, ''));

/*self.arr_statute			    := if(input.charge[1]<'A' and lsts<lstb and lsts>0, input.Charge[1..lstl-1],
                                       if(input.charge[1]<'A',input.Charge[1..lstb],''));
		 
self.arr_off_desc_1 			:= trim(regexreplace('^-|^[ ]+|^[]]|[\r\n]',if(input.Charge[1]>'9' ,input.charge,
		                             if(lsts<lstb,input.charge[lstb+1..],input.charge[length(trim(self.arr_statute,right))+3..lstl-1])),''),left);
*/
self.arr_statute_desc 			:= '';
self.arr_disp_date 				:= '';
self.arr_disp_code 				:= '';
self.arr_disp_desc_1 			:= 'BOOKED';
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

pCanyon := project(p,tCanyon(left));


dd_arrOut:= dedup(sort(distribute(pCanyon,hash(offender_key)),
									offender_key,arr_date,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,local),
									offender_key,arr_date,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,right):
									PERSIST('~thor_dell400::persist::ArrestLogs_ID_Canyon_Offenses');

export map_ID_CanyonOffenses	:= dd_arrOut;