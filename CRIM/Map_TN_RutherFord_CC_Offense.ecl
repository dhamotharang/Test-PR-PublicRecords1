import Crim_Common, Crim;

Input_RawFile := File_TN_RutherFord_CC;
  
DInput_RawFile := DISTRIBUTE(Input_RawFile, HASH(cause_number));
  
Crim_Common.Layout_In_Court_Offenses Map_Offense(DInput_RawFile L) := Transform
	string v_dr_lic       := IF( TRIM(L.drivers_license) in invalid_values ,'',TRIM(L.drivers_license));
	string v_ssn          := IF( TRIM(L.social_sec_no) in invalid_values or 
	                             stringlib.stringfind(L.social_sec_no,'UNK',1)>0,'',TRIM(L.social_sec_no));
															 
	string v_count        := REGEXFIND('[0-9]+[0-9]* COUNT',L.charge,0);
	
	string v_degree       := StringLib.StringFindReplace(REGEXFIND('[0-9a-zA-Z]+ DEGREE',L.charge,0),'DEGREE','');
	string v_degree1      := MAP(v_degree= 'FIRST' => '1',
	                               v_degree= 'SECOND'=> '2',
																 v_degree= 'THIRD' => '3',
																 v_degree= 'FORTH' => '4' ,
																 v_degree= 'FIFTH' => '5',
																 v_degree= 'SIXTH' => '6',
																 v_degree= 'SEVENTH' => '7',
																 REGEXFIND('[0-9]*',v_degree,0)	 );
	self.process_date 			:= Crim_Common.Version_In_Arrest_Offenses;
	self.offender_key 			:= TN_RutherFord_Offender_key_Generator('3RC', L.Cause_number,L.indictmentdate);
	self.vendor 						:= '3R';
	self.state_origin 			:= 'TN';
	self.source_file 				:= 'TN_RUTHERFORD_CC_CRM';
	self.off_comp 				  := '';
	self.off_delete_flag 		:= '';
	self.off_date 				  := ''; 
	self.arr_date 				  := '';
	self.num_of_counts 			:= StringLib.stringfilterout(StringLib.StringFindReplace(v_count,'COUNT',''),'()');
	self.le_agency_cd 			:= '';
	self.le_agency_desc 		:= '';
	self.le_agency_case_number 	:= '';
	self.traffic_ticket_number 	:= '';
	self.traffic_dl_no 			:= '';
	self.traffic_dl_st 			:= '';
	self.arr_off_code 			:= '';
	self.arr_off_desc_1 		:= '';
	self.arr_off_desc_2 		:= '';
	self.arr_off_type_cd 		:= '';
	self.arr_off_type_desc 	:= '';
	self.arr_off_lev 			  := '';
	self.arr_statute 			  := '';
	self.arr_statute_desc 	:= '';
	self.arr_disp_date 			:= '';
	self.arr_disp_code 			:= '';
	self.arr_disp_desc_1 		:= '';
	self.arr_disp_desc_2 		:= '';
	self.pros_refer_cd 			:= '';
	self.pros_refer 			  := '';
	self.pros_assgn_cd 			:= '';
	self.pros_assgn 			  := '';
	self.pros_chg_rej 			:= '';
	self.pros_off_code 			:= '';
	self.pros_off_desc_1 		:= '';
	self.pros_off_desc_2 		:= '';
	self.pros_off_type_cd 	:= '';
	self.pros_off_type_desc := '';
	self.pros_off_lev 			:= '';
	self.pros_act_filed 		:= '';
	self.court_case_number 	:= trim(L.cause_number);
	self.court_cd 				  := '';
	self.court_desc 			  := '';
	self.court_appeal_flag 	:= '';
	self.court_final_plea 	:= '';
	self.court_off_code 		:= '';
	self.court_off_desc_1 	:= trim(L.charge);
	self.court_off_desc_2		:= '';
	self.court_off_type_cd 	:= '';
	self.court_off_type_desc:= '';
	self.court_off_lev 			:= IF (trim(L.Type_of_case) in ['M','F'], trim(L.Type_of_case) + trim(v_degree1),'');
	self.court_statute 			:= '';
	self.court_additional_statutes:= '';
	self.court_statute_desc := '';
	self.court_disp_date 		:= IF(Function_ParseDate(L.Judgment_date,'MMDDYY')between '19000101' and (string)((integer)Crim_Common.Version_Development),
									              Function_ParseDate(L.Judgment_date,'MMDDYY'),''); 
	self.court_disp_code 		:= '';
	self.court_disp_desc_1	:= trim(L.disposition);
	self.court_disp_desc_2 	:= '';
	self.sent_date 			    := '';
	self.sent_jail 			    := '';																			
	self.sent_susp_time 		:= '';
	self.sent_court_cost 		:= '';
	self.sent_court_fine 		:= '';
	self.sent_susp_court_fine := '';
	self.sent_probation 		  := '';
	self.sent_addl_prov_code 	:= '';
	self.sent_addl_prov_desc_1:= '';
	self.sent_addl_prov_desc_2:= '';
	self.sent_consec 			    := '';
	self.sent_agency_rec_cust_ori := '';
	self.sent_agency_rec_cust 	  := '';
	self.appeal_date 			        := '';
	self.appeal_off_disp 		      := '';
	self.appeal_final_decision 	  := '';

end;

pTNRCC_Offense := project(DInput_RawFile,Map_Offense(left));

// fOHOffend:= dedup(sort(distribute(pOHCrim,hash(offender_key)),
				// offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1, court_disp_desc_1,local),
					// offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,court_disp_desc_1,all,local,left)
									// :PERSIST('~thor200_144::persist::Crim_OH_Athens_Offenses');

TNRGS_Offense := CRIM.Map_TN_RutherFord_GS_Offense;

export Map_TN_RutherFord_CC_Offense := pTNRCC_Offense +TNRGS_Offense : PERSIST('~thor_dell400::persist::Crim_TN_Rutherford_Offenses');