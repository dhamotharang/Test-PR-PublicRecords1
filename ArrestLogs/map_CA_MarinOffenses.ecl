import Crim_Common, Address, Gong;


p	:= ArrestLogs.file_CA_Marin.cmbnd(Charge_Desc <> '');

Crim_Common.Layout_In_Court_Offenses tMarin(p input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offenses;
self.offender_key 				:= 'A1'+input.ID;
self.vendor 					:= 'A1';
self.state_origin 				:= 'CA';
self.source_file 				:= '(CV)CA-MarinArrest';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= if(fSlashedMDYtoCYMD(input.Arrest_Dt) < Crim_Common.Version_In_Arrest_Offender
									and fSlashedMDYtoCYMD(input.Arrest_Dt) <> '00000000', 
									fSlashedMDYtoCYMD(input.Arrest_Dt),
									'');
self.num_of_counts 				:= '';
self.le_agency_cd 				:= '';//input.arrest_agency;
self.le_agency_desc 			:= if(StringLib.StringToUpperCase(trim(input.arrest_agency,left,right))<>'OTHER',
									StringLib.StringToUpperCase(input.arrest_agency),
									'');
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= if(input.Charge_Desc <> '' and regexfind('HOWARD',input.Charge_Desc)<>(boolean)'true',
									regexreplace('1st degree|'+'2nd degree|'+'3rd degree'+'FIRST DEGREE |'+'SECOND DEGREE |'+'THIRD DEGREE |'+':|'+'(E)',
									stringlib.stringtouppercase(input.Charge_Desc),''),
									trim(input.Charge_Desc,left,right));
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= if(trim(input.Code,left,right)='X','',trim(input.Code,left,right));
self.arr_statute 				:= input.charge_num;
self.arr_statute_desc 			:= '';
self.arr_disp_date 				:= if(fSlashedMDYtoCYMD(input.arrest_dt) < Crim_Common.Version_In_Arrest_Offenses and
									  fSlashedMDYtoCYMD(input.arrest_dt) <>'00000000',
									  fSlashedMDYtoCYMD(input.arrest_dt),
									  '');
self.arr_disp_code 				:= '';
self.arr_disp_desc_1 			:= 'BOOKED';
self.arr_disp_desc_2 			:= if(trim(input.bond,left,right) != '$0.00' and trim(input.bond,left,right) <> '' and trim(input.bond,left,right) <> '$',
								     ('BOND AMT '+trim(input.bond,left,right)),
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
self.court_case_number 			:= input.case_num;
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

pMarin := project(p,tMarin(left));
					
arrOut:= pMarin + ArrestLogs.FileAbinitioOffenses(vendor='A1' and arr_statute<>'');

dd_arrOut:= dedup(sort(distribute(arrOut,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::ArrestLogs_CA_Marin_Offenses');

export map_CA_MarinOffenses	:= dd_arrOut;