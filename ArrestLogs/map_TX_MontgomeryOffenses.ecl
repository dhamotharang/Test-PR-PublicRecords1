import Crim_Common, Address, Lib_date;

d	:= ArrestLogs.file_TX_Montgomery+file_reformat_TX_Montgomery;

fMontgomery := d(trim(d.Name,left,right)<>'Name');

Crim_Common.Layout_In_Court_Offenses tMontgomery(fMontgomery input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key 				:= 'F3'+trim(input.id,left,right)+fSlashedMDYtoCYMD(input.Book_Dt);
self.vendor 					:= 'F3';//NEED TO UPDATE
self.state_origin 				:= 'TX';
self.source_file 				:= '(CV)TX-MontgomeryCtyArr';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= '';
self.arr_date 					:= '';
self.num_of_counts 				:= '';
self.le_agency_cd 				:= if(length(input.agency)<5,
									input.agency,
									'');
self.le_agency_desc 			:= '';
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= if(length(input.charge)>4,
									input.charge,
									'');
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= '';
self.arr_statute 				:= '';
self.arr_statute_desc 			:= '';
self.arr_disp_date 				:= '';
self.arr_disp_code 				:= '';
self.arr_disp_desc_1 			:= '';
self.arr_disp_desc_2 			:= if(trim(input.bond_amt,all) ~in ['0.00','$0.00','','NOBOND','nobond'] and regexfind('\\/',input.bond_amt,0)='',
									 'Bond Amt $'+input.bond_amt,
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

pMontgomery := project(fMontgomery,tMontgomery(left));

//arrOut:= pMontgomery + ArrestLogs.FileAbinitioOffenses(vendor='');

arrOut:= dedup(sort(distribute(pMontgomery,hash(offender_key)),
									offender_key,le_agency_cd,arr_off_desc_1 ,arr_disp_desc_2,local),
									offender_key,le_agency_cd,arr_off_desc_1 ,arr_disp_desc_2,local);
dd_ArrOut  := arrout(arr_off_desc_1+arr_off_desc_2<>''  )+ 
          Join(arrout(arr_off_desc_1+arr_off_desc_2  =''),arrout(arr_off_desc_1+arr_off_desc_2  <>''),
		  left.offender_key=right.offender_key,left only,local):PERSIST('~thor_dell400::persist::ArrestLogs_TX_Montgomery_Offenses');

export Map_TX_MontgomeryOffenses := dd_arrOut;