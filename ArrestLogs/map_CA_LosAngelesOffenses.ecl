import Crim_Common, Address, Gong;

p	:= ArrestLogs.file_CA_LosAngeles;

fLosAngeles := p(trim(p.Last_Name,left,right)<>'Last Name' and
			   trim(p.First_Name,left,right)<>'First Name' and
			   trim(p.Middle_Name,left,right)<>'Middle Name');

Crim_Common.Layout_In_Court_Offenses tLosAngeles(fLosAngeles input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offenses;
self.offender_key 				:= (string)'AG'+(integer)hash(trim(input.Last_Name,all)+trim(input.First_Name,all)+trim(input.Middle_Name,all)+input.Sex+input.case_no+fSlashedMDYtoCYMD(input.DOB)+input.Race+fSlashedMDYtoCYMD(input.Arrest_Dt));
self.vendor 					:= 'AG';
self.state_origin 				:= 'CA';
self.source_file 				:= '(CV)CA-LosAngelesArrest';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= if(fSlashedMDYtoCYMD(input.arrest_dt) < Crim_Common.Version_In_Arrest_Offenses and
									  fSlashedMDYtoCYMD(input.arrest_dt) <>'00000000',
									  fSlashedMDYtoCYMD(input.arrest_dt),
									  '');
self.num_of_counts 				:= '';
self.le_agency_cd 				:= '';//input.arrest_agency;
self.le_agency_desc 			:= input.agency_descr;
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= '';//charge description?
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= input.Charge_Level[1];
self.arr_statute 				:= '';//arrest charge?
self.arr_statute_desc 			:= '';
self.arr_disp_date 				:= if(fSlashedMDYtoCYMD(input.arrest_dt) < Crim_Common.Version_In_Arrest_Offenses and
									  fSlashedMDYtoCYMD(input.arrest_dt) <>'00000000',
									  fSlashedMDYtoCYMD(input.arrest_dt),
									  '');
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

pLosAngeles := project(fLosAngeles,tLosAngeles(left));
					
arrOut:= pLosAngeles + ArrestLogs.FileAbinitioOffenses(vendor='AG');
dd_arrOut := dedup(sort(distribute(arrOut,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::ArrestLogs_CA_LosAngeles_Offenses');

export map_CA_LosAngelesOffenses	:= dd_arrOut;