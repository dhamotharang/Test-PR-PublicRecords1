import Crim_Common, Address, ut;

fPAOffenses_nohdr	:= Crim.File_PA_History(first_name<>'' and regexfind('[A-Z]',StringLib.StringToUpperCase(first_name)[1],0)<>'');

// Remove Expunge Records //

dPA_Exp := dedup(Crim.File_PA_Expunge.File_PA_History_Expunge,Docket_Number);

fPAOffenses_exp := join(fPAOffenses_nohdr, dPA_Exp, left.Docket_number=right.Docket_number, left only);

Crim.Layout_PA_History Exp_remove(fPAOffenses_exp input) := transform
self := input;
END;

fPAOffenses := project(fPAOffenses_exp, Exp_remove(left));
// End Of Remove Expunge Records //

Crim_Common.Layout_In_Court_Offenses tPACrim(fPAOffenses input) := Transform

self.process_date 				:= Crim_Common.Version_In_Arrest_Offenses;
self.offender_key 				:= '46'+trim(input.DOCKET_NUMBER,left,right);
self.vendor 					:= '46';
self.state_origin 				:= 'PA';
self.source_file 				:= 'PA_STATEWIDE_HIS(CV)';
self.off_comp 					:= '';
self.off_delete_flag 			:= '';
self.off_date 					:= if(regexreplace('/',trim(input.offense_dt,left,right),'')<= stringlib.GetDateYYYYMMDD(),
									regexreplace('/',trim(input.offense_dt,left,right),''),
									'');
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
self.court_case_number 			:= trim(input.DOCKET_NUMBER,left,right);
self.court_cd 					:= '';
self.court_desc 				:= '';
self.court_appeal_flag 			:= '';
self.court_final_plea 			:= '';
self.court_off_code 			:= '';
self.court_off_desc_1 			:= regexreplace('1ST|2ND|3RD|4TH|5TH|6TH|7TH|8TH|9TH|DEG|FEL|OF THE FIRST|OF THE SECOND|OF THE THIRD|DEGREE|OFFENSE|OFF|& SUB|AND SUBSEQUENT|M1',
									StringLib.StringToUpperCase(trim(input.charge_descr,left,right)),
									'');
self.court_off_desc_2			:= '';
self.court_off_type_cd 			:= '';
self.court_off_type_desc 		:= '';
self.court_off_lev 				:= MAP(regexfind('M1',regexreplace('-',trim(input.charge_descr,left,right),''),0)<>'' => 'MA',
									regexfind('M2',regexreplace('-',trim(input.charge_descr,left,right),''),0)<>'' => 'MB',
									regexfind('M3',regexreplace('-',trim(input.charge_descr,left,right),''),0)<>'' => 'MC',
									regexfind('M',regexreplace('-',trim(input.charge_descr,left,right),''),0)<>'' => 'MA',
									regexfind('F1',regexreplace('-',trim(input.charge_descr,left,right),''),0)<>'' => 'FA',
									regexfind('F2',regexreplace('-',trim(input.charge_descr,left,right),''),0)<>'' => 'FB',
									regexfind('F3',regexreplace('-',trim(input.charge_descr,left,right),''),0)<>'' => 'FC',
									regexfind('F',regexreplace('-',trim(input.charge_descr,left,right),''),0)<>'' => 'FA',
									'');
self.court_statute 				:= if(length(trim(input.section,left,right)+trim(input.subsection,left,right))>4 and
									regexfind('[0-9]',trim(input.section,left,right)+trim(input.subsection,left,right),0)<>'' and
									regexfind('CONDUCT',trim(input.section,left,right)+trim(input.subsection,left,right),0)='',
									trim(input.section,left,right)+trim(input.subsection,left,right),
									'');
self.court_additional_statutes	:= '';
self.court_statute_desc 		:= '';
self.court_disp_date 			:= if(regexreplace('/',trim(input.case_disp_dt,left,right),'')<= stringlib.GetDateYYYYMMDD(),
									regexreplace('/',trim(input.case_disp_dt,left,right),''),
									'');
self.court_disp_code 			:= '';
self.court_disp_desc_1	 		:= if(regexfind('GUILTY|DISMISS|NOLLE|MISTRIAL|NOLO|QUASH|AQUIT|ABATE|WITHDRAW',StringLib.StringToUpperCase(trim(input.case_disp,left,right)),0)<>'',
									StringLib.StringToUpperCase(trim(input.case_disp,left,right)),
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

pPACrim := project(fPAOffenses,tPACrim(left));

dd_PAOut:= dedup(sort(distribute(pPACrim,hash(offender_key)),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,source_file,local),
									offender_key,off_comp,arr_statute,arr_statute_desc,arr_off_code,arr_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::Crim_PA_Historical_Offenses_Clean');

export Map_PA_Historical_Offenses	:= dd_PAOut;