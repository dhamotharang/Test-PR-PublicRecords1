import Crim_Common, Address;

pre_fCalhoun	:= ArrestLogs.file_AL_Calhoun.cmbnd(ID <>'ID');

fCalhoun :=  pre_fCalhoun(Charge_Descr <> '');

tempLayout := record
fCalhoun.ID;
fCalhoun.Name;
fCalhoun.Booking_Dt;
fCalhoun.Charge_Descr;
num_ofcounts := count(group);
end;

tblCalhoun := table(fCalhoun,tempLayout,id,name,booking_dt,charge_descr,few);

Crim_Common.Layout_In_Court_Offenses tCalhoun(tblCalhoun input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key 				:= (string)'AD'+hash(trim(input.Name,all)+fSlashedMDYtoCYMD(input.Booking_Dt));
self.vendor 					:= 'AD';
self.state_origin 				:= 'AL';
self.source_file 				:= '(CV)AL-CalhounCtyArr';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= if(fSlashedMDYtoCYMD(input.Booking_Dt) < Crim_Common.Version_In_Arrest_Offender
									and fSlashedMDYtoCYMD(input.Booking_Dt)[1..2] in ['19','20'],
									fSlashedMDYtoCYMD(input.Booking_Dt),'');
self.num_of_counts 				:= '';//(string)input.num_ofcounts;
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= '';
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= regexreplace('\r',input.Charge_Descr,'');
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= '';
self.arr_statute 				:= '';
self.arr_statute_desc 			:= '';
self.arr_disp_date 				:= if(fSlashedMDYtoCYMD(input.Booking_Dt) < Crim_Common.Version_In_Arrest_Offender
									and fSlashedMDYtoCYMD(input.Booking_Dt)[1..2] in ['19','20'],
									fSlashedMDYtoCYMD(input.Booking_Dt),'');
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

pCalhoun := project(tblCalhoun,tCalhoun(left));

arrOut:= pCalhoun + ArrestLogs.FileAbinitioOffenses(vendor='AD');

dd_arrOut:= dedup(sort(distribute(arrOut,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::ArrestLogs_AL_Calhoun_Offenses');

export map_AL_CalhounOffenses	:= dd_arrOut;