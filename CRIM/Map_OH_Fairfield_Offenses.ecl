import crim_common, Crim, Address, ut;

/*Input Files*/
df_disposition	:= CRIM.File_OH_Fairfield.DISPOSITION;
df_charge				:= CRIM.File_OH_Fairfield.CHARGE;
df_indv 				:= CRIM.File_OH_Fairfield.PERSON; //used to capture charge count

//join files
	l_charge_disp	:= record
		string20	case_number;
		string10	charge_code;
		string50	charge_desc;
		string25	charge_disp_desc;
		string8		charge_disp_date;
		string4		sent_days_jail;
		string4		sent_days_jail_susp;
		string4		sent_days_jail_prob;
		string50	charge_degree_off;
		string8		file_date;
		string25	case_term_desc;
		string8		case_term_date;
	end;

l_charge_disp	JoinFiles(df_charge L, df_disposition R) := Transform
	self.case_number := IF(L.case_number = '',R.case_number, L.case_number);
	self	:= L;
	self	:= R;
	self := [];
end;

srt_disp	:= sort(distribute(df_disposition,hash(case_number)),case_number,local);
srt_charge	:= sort(distribute(df_charge,hash(case_number)),case_number,local);

j_files	:= join(srt_charge, srt_disp,
								trim(left.case_number,left,right) = ut.CleanSpacesAndUpper(right.case_number),
								JoinFiles(left,right),full outer,local);

statute	:= '([0-9]+\\.[0-9]+[ ]*\\(*[A-Z]*\\)*[ ]*\\(*[0-9]*\\)*)';

Crim_Common.Layout_In_Court_Offenses tOHCrim(j_files dInput) := Transform
self.process_date		:= Crim_Common.Version_Development;
self.offender_key 	:= '1I'+ ut.CleanSpacesAndUpper(dInput.case_number);
self.vendor					:= '1I';
self.state_origin		:= 'OH';
self.source_file		:= 'OH-FAIRFIELDCRIMCT';
self.off_comp 				:= '';
self.off_delete_flag 	:= '';
self.off_date 				:= '';
self.arr_date 				:= '';
self.num_of_counts 		:= '';
self.le_agency_cd 		:= '';
self.le_agency_desc 	:= '';
self.le_agency_case_number := '';
self.traffic_ticket_number := '';
self.traffic_dl_no 		:= '';
self.traffic_dl_st 		:= '';
self.arr_off_code 		:= '';
self.arr_off_desc_1 	:= '';
self.arr_off_desc_2 		:= '';
self.arr_off_type_cd 		:= '';
self.arr_off_type_desc 	:= '';
self.arr_off_lev 				:= '';
self.arr_statute 				:= '';
self.arr_statute_desc 	:= '';
self.arr_disp_date 			:= '';
self.arr_disp_code 			:= '';
self.arr_disp_desc_1 		:= '';
self.arr_disp_desc_2 		:= '';
self.pros_refer_cd 			:= '';
self.pros_refer 				:= '';
self.pros_assgn_cd 			:= '';
self.pros_assgn 				:= '';
self.pros_chg_rej 			:= '';
self.pros_off_code 			:= '';
self.pros_off_desc_1 		:= '';
self.pros_off_desc_2 		:= '';
self.pros_off_type_cd 	:= '';
self.pros_off_type_desc := '';
self.pros_off_lev 			:= '';
self.pros_act_filed 		:= '';
self.court_case_number 	:= ut.CleanSpacesAndUpper(dInput.case_number);
self.court_cd 					:= '';
self.court_desc 				:= '';
self.court_appeal_flag 	:= '';
self.court_final_plea 	:= '';
self.court_off_code 		:= '';
ClnOffDesc							:= IF(regexfind('UNTERMIN|HISTORY|^CRIMINA|UNAVAILAB|JURY TRIAL|COURT TRIAL',ut.CleanSpacesAndUpper(dInput.charge_desc)),'',
															IF(regexfind(statute,dInput.charge_desc),regexreplace(statute,ut.CleanSpacesAndUpper(dInput.charge_desc),''),
																IF(regexfind(' FM[1-9]',ut.CleanSpacesAndUpper(dInput.charge_desc)),'',
																		ut.CleanSpacesAndUpper(dInput.charge_desc))));
self.court_off_desc_1 	:= StringLib.StringFindReplace(ClnOffDesc,'-','');
self.court_off_desc_2		:= '';
self.court_off_type_cd 	:= '';
self.court_off_type_desc:= '';
UpperDegree							:= ut.CleanSpacesAndUpper(dInput.charge_degree_off);
TempDegree							:= map(regexfind('FELON',UpperDegree) => 'F',
																regexfind('MISD',UpperDegree) => 'M',
																regexfind('TRAFFIC',UpperDegree) => 'TR',
																regexfind('CITAT',UpperDegree) => 'C',
																regexfind('STATE',UpperDegree) => 'FS','');
TempOffLev							:= regexreplace('[^0-9]',UpperDegree,'');
self.court_off_lev 			:= StringLib.StringFindReplace(TempDegree+TempOffLev,' ','');
self.court_statute 			:= regexreplace('\\($',regexfind(statute,dInput.charge_desc,0),'');
self.court_additional_statutes:= '';
self.court_statute_desc 	    := '';
self.court_disp_date 			    := trim(dInput.case_term_date,left,right);
self.court_disp_code 			    := '';
self.court_disp_desc_1	      := IF(regexfind('UNTERMIN|HISTORY|^CRIMINA|UNAVAILAB|JURY TRIAL|COURT TRIAL',ut.CleanSpacesAndUpper(dInput.case_term_desc)),'',
																		ut.CleanSpacesAndUpper(dInput.case_term_desc));
self.court_disp_desc_2 		    := '';
self.sent_date 					      := '';
self.sent_jail 					      := '';
self.sent_susp_time 			    := '';
self.sent_court_cost 			    := '';
self.sent_court_fine 			    := '';
self.sent_susp_court_fine     := '';
self.sent_probation 			    := '';
self.sent_addl_prov_code 	    := '';
self.sent_addl_prov_desc_1    := '';
self.sent_addl_prov_desc_2    := '';
self.sent_consec 				      := '';
self.sent_agency_rec_cust_ori := '';
self.sent_agency_rec_cust 		:= '';
self.appeal_date 				      := '';
self.appeal_off_disp 			    := '';
self.appeal_final_decision 		:= '';
end;

proj_ds_offenses := project(j_files,tOHCrim(left));

//Join with Individual file to get charge_cnt
srt_Offenses	:= sort(distribute(proj_ds_offenses,hash(court_case_number)),court_case_number,local);
srt_Indv			:= sort(distribute(df_indv,hash(case_number)),case_number,local);

Crim_Common.Layout_In_Court_Offenses GetOffCnt(srt_Offenses L, srt_Indv R) := Transform
	self.off_comp 	:= StringLib.StringFindReplace(R.charge_cnt,'0','');
	self := L;
end;


j_GetOffCnt	:= join(srt_Offenses,srt_Indv,
								trim(left.court_case_number,left,right) = ut.CleanSpacesAndUpper(right.case_number),
								GetOffCnt(left,right), left outer, lookup,local);
								
sd_df_offenses:= dedup(sort(distribute(j_GetOffCnt,hash(offender_key)),
									offender_key,off_date,court_statute,court_off_desc_1,court_disp_date,court_disp_desc_1,local),
									record,local):
									PERSIST('~thor_dell400::persist::Crim_OH_Fairfield_Offenses');

EXPORT Map_OH_Fairfield_Offenses := sd_df_offenses(court_case_number <> '' and 
																									(trim(court_off_desc_1,left,right)+trim(court_disp_desc_1,left,right)+trim(court_disp_date,left,right))<> '');