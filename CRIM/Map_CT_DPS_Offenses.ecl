import crim_common;
ds_ddcharst := crim.File_CT_DPS.trDDCHARST;
ds_ddchchrg := crim.File_CT_DPS.trDDCHCHRG;

layout_ddchrg_arst := record
		crim.Layout_CT_DPS_DDCHARST;
		crim.Layout_CT_DPS_DDCHCHRG and not [id_spbi, datearst, ts_ddcharst_tybrkr];


END;
layout_ddchrg_arst  jDDChrg_arst(ds_ddcharst L, ds_ddchchrg R) := TRANSFORM
		SELF := L;
		SELF := R;
END;		
		
ds_ddchrg_arst			:=JOIN(ds_ddcharst, ds_ddchchrg
							, LEFT.id_spbi  = RIGHT.id_spbi
							and LEFT.datearst = RIGHT.datearst
							and LEFT.ts_ddcharst_tybrkr = RIGHT.ts_ddcharst_tybrkr
								, jDDChrg_arst(left,right), left outer); 

// output(ds_ddchrg_arst(id_spbi= '000014316'));	

ds_arst := crim.File_CT_DPS.trArrest;;
ds_chrg := crim.File_CT_DPS.trOffense;

layout_chrg_arst := record
		crim.Layout_CT_DPS_Arrest;
		crim.Layout_CT_DPS_Offense and not [id_spbi, id_docket];

END;
layout_chrg_arst  jChrg_arst(ds_arst L, ds_chrg R) := TRANSFORM
		SELF := L;
		SELF := R;
END;		
		
ds_chrg_arst			:=JOIN(ds_arst, ds_chrg
							, LEFT.id_spbi  = RIGHT.id_spbi
							and LEFT.id_docket = RIGHT.id_docket
							, jChrg_arst(left,right), left outer); 
							
// output(ds_chrg_arst(id_spbi= '000014316'));	

input1 := ds_chrg_arst;
input2 := ds_ddchrg_arst;

cmbndArstChrgLayout := record
input1;
	string26	ats_ddcharst_tybrkr;
	string2		dockga;
	string1		dockfac;
	string7		dockseq;
	string1		docksufx;
	//string20	nameacc;
	string15	contrib1;
	string15	contrib2;
	string10	datecort;
	string2		fl_fingerprnt_sup;
	//string10	datechrg;          
	//string15	charge;            
	string20	disp1;             
	string20	disp2; 
end;


cmbndArstChrgLayout t1(input1 L) := transform
self := L;
self := [];
end;

precs1 := project(input1,t1(left));

cmbndArstChrgLayout t2(input2 L) := transform
self := L;
self := [];
end;

precs2 := project(input2,t2(left));

cmbndArstChrgFile := precs1 + precs2;
// output(cmbndArstChrgFile(id_spbi= '000014316'));

ds_cmbnd := cmbndArstChrgFile;

ds_person := crim.File_CT_DPS.trperson;

layout_chrg_arst_person := RECORD
		crim.Layout_CT_DPS_Person.parsed;
		ds_cmbnd;

END;
layout_chrg_arst_person  jChrg_arst_person(ds_person L, ds_cmbnd R) := TRANSFORM
		SELF := L;
		SELF := R;
END;		
		
ds			:=JOIN(ds_person, ds_cmbnd
							, LEFT.pid_spbi  = RIGHT.id_spbi
								, jChrg_arst_person(left,right), left outer); 
// output(choosen(ds(id_spbi='000014316'), 5000));

string8     fSlashedMDYtoCYMD(string pDateIn) 
			:=    intformat((integer2)regexreplace('.*/.*/([1-9]+)',pDateIn,'$1'),4,1) 
			+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
			+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

Crim_Common.Layout_In_Court_Offenses tCTCrim(ds input) := Transform
integer nonzero  		:=  StringLib.StringFind(input.am_fine_ordered,'[1-9]',1);
																														
		
varstring amt_fined	:=  IF (nonzero >0 ,input.am_fine_ordered[nonzero..], '');


cd_jail_sen_max := map(input.cd_jail_sen_max = 'D' => 'Day(s)',
					input.cd_jail_sen_max = 'M' => 'Month(s)',
					input.cd_jail_sen_max = 'Y' => 'Year(s)',
					input.cd_jail_sen_max = '@' => '','');
cd_jail_sen_min := map(input.cd_jail_sen_min = 'D' => 'Day(s)',
					input.cd_jail_sen_min = 'M' => 'Month(s)',
					input.cd_jail_sen_min = 'Y' => 'Year(s)',
					input.cd_jail_sen_min = '@' => '','');
cd_jail_sen_susp := map(input.cd_jail_sen_susp = 'D' => 'Day(s)',
					input.cd_jail_sen_susp = 'M' => 'Month(s)',
					input.cd_jail_sen_susp = 'Y' => 'Year(s)','');		
cd_prob_sen_imp := map(input.cd_prob_sen_imp = 'D' => 'Day(s)',
					input.cd_prob_sen_imp = 'M' => 'Month(s)',
					input.cd_prob_sen_imp = 'Y' => 'Year(s)','');
cd_comm_service := map(input.cd_comm_service = 'D' => ' Day(s)',
					input.cd_comm_service = 'M' => ' Month(s)',
					input.cd_comm_service = 'H' => ' Hour(s)','');
					// trim(input.cd_comm_service,all) = '@' => '','');
qt_jail_sen_max := if(input.qt_jail_sen_max='@', '', trim(input.qt_jail_sen_max, all));
qt_jail_sen_min := if(input.qt_jail_sen_min='@', '', trim(input.qt_jail_sen_min,all));
qt_comm_service := if(input.qt_comm_service='@   ', '', trim(input.qt_comm_service, all));

	self.process_date 				:= Crim_Common.Version_Development;
	self.offender_key 				:= '4A'+input.id_spbi+input.id_docket;										 
	self.vendor 					:= '4A';
	self.state_origin 				:= 'CT';
	self.source_file 				:= '(CP)CT Dept of Pub Sfty';
	self.off_comp 					:= if(input.id_charge_sequence='@', '', input.id_charge_sequence[2..]);
	self.off_delete_flag 			:= '';
	self.off_date 					:= if(stringlib.stringfindreplace(input.datechrg, '-', '') between '19000101' and Crim_Common.Version_Development,
										stringlib.stringfindreplace(input.datechrg, '-', ''),'');
	self.arr_date 					:= if(stringlib.stringfindreplace(input.datearst, '-', '') between '19000101' and Crim_Common.Version_Development,
										stringlib.stringfindreplace(input.datearst, '-', ''),'');
	self.num_of_counts 				:= if(input.qt_off_counts_orig='@' or input.qt_off_counts_orig='0000', '', input.qt_off_counts_orig[2..]);
	self.le_agency_cd 				:= if(input.id_docket_arresting_agcy='@', '', input.id_docket_arresting_agcy);
	self.le_agency_desc 			:= '';
	self.le_agency_case_number 		:= if(input.id_agcy_case='@', '', input.id_agcy_case);
	self.traffic_ticket_number 		:= '';
	self.traffic_dl_no 				:= '';
	self.traffic_dl_st 				:= '';
	self.arr_off_code 				:= '';
	self.arr_off_desc_1 			:= if(input.charge='@     @', '', input.charge);
	self.arr_off_desc_2 			:= '';
	self.arr_off_type_cd 			:= if(input.cd_off_type_orig='@', '', input.cd_off_type_orig);
	self.arr_off_type_desc 			:= '';
	self.arr_off_lev 				:= '';
	self.arr_statute 				:= if(input.cd_off_statut_orig='@', '', input.cd_off_statut_orig);
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
	self.court_off_desc_1 			:= regexreplace('[\\*|"|\\?]',input.charge, '');	
	self.court_off_desc_2			:= '';
	self.court_off_type_cd 			:= '';
	self.court_off_type_desc 		:= '';
	self.court_off_lev 				:= if(input.cd_off_type_orig='@' or input.cd_off_type_orig='X', '', input.cd_off_type_orig);
	self.court_statute 				:= if(input.cd_off_statut_orig='@', '', input.cd_off_statut_orig);
 	self.court_additional_statutes	:= '';
	self.court_statute_desc 		:= '';
	self.court_disp_date 			:= if(stringlib.stringfindreplace(input.dt_verdict, '-', '') between '19000101' and Crim_Common.Version_Development,
										stringlib.stringfindreplace(input.dt_verdict, '-', ''),'');
	self.court_disp_code 			:= if(input.tx_disp_legend= '@','', input.tx_disp_legend);
	self.court_disp_desc_1	 		:= '';
	self.court_disp_desc_2 			:= '';
	self.sent_date 					:= '';
	self.sent_jail 					:= if(qt_jail_sen_min='' and qt_jail_sen_max ='','',
										if(qt_jail_sen_min='' and qt_jail_sen_max <>'', 'Max:'+qt_jail_sen_max+' '+cd_jail_sen_max,
											if(qt_jail_sen_min<>'' and qt_jail_sen_max ='','Min:'+qt_jail_sen_min+' '+cd_jail_sen_min,
												if(qt_jail_sen_min<>'' and qt_jail_sen_max <>'','Min:'+qt_jail_sen_min+cd_jail_sen_min+';'+'Max:'+input.qt_jail_sen_max+' '+cd_jail_sen_max,
													''))));				
	self.sent_susp_time 			:= if(input.qt_jail_sen_susp='@', '', input.qt_jail_sen_susp +' '+cd_jail_sen_susp);
	self.sent_court_cost 			:= '';
	self.sent_court_fine 			:= if(input.am_fine_ordered='@', '', input.am_fine_ordered);
	self.sent_susp_court_fine 		:= '';
	self.sent_probation 			:= if(input.cd_prob_sen_imp='@', '', input.qt_prob_sen_imp+' '+cd_prob_sen_imp);
	self.sent_addl_prov_code 		:= '';
	self.sent_addl_prov_desc_1 		:= if(qt_comm_service='' , '', 'Comm Svc:'+qt_comm_service+cd_comm_service);
	self.sent_addl_prov_desc_2 		:= if(input.disp1='@' or input.disp1='' and input.disp2='@' or input.disp2='-' or input.disp2='', '', trim(regexreplace('[\\*|"|.\\\\]', input.disp1, ''), left, right) + ',' + regexreplace('-', input.disp2, ''));
	// if(input.disp1='@' and input.disp2='@', '', trim(regexreplace('[\\*|"|.\\\\]', input.disp1+''+regexreplace('//@', input.disp2, ''),''), left, right));

	self.sent_consec 				:= if(trim(input.cd_jail_sen_cnscnc, all)='@', '', input.cd_jail_sen_cnscnc);
	self.sent_agency_rec_cust_ori 	:= '';
	self.sent_agency_rec_cust 		:= '';
	self.appeal_date 				:= '';
	self.appeal_off_disp 			:= '';
	self.appeal_final_decision 		:= '';

end;

pCTCrim := project(ds,tCTCrim(left));
fCTOffend:= dedup(sort(pCTCrim,
				offender_key,off_comp,court_statute,court_statute_desc,court_off_code,arr_date,court_disp_date, court_off_desc_1, sent_addl_prov_desc_1,sent_addl_prov_desc_2),
					offender_key,off_comp,court_statute,court_statute_desc,court_off_code,arr_date, court_disp_date,court_off_desc_1, sent_date,
					sent_jail,sent_susp_time,sent_court_cost,sent_court_fine, sent_susp_court_fine,sent_probation,
					sent_consec, sent_addl_prov_desc_1, sent_addl_prov_desc_2,right)
									 :PERSIST('~thor_data400::persist::Crim_CT_DPS_Offenses');


export Map_CT_DPS_Offenses := fCTOffend;