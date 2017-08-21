import Crim_Common, Crim;

//Input_RawFile     :=  File_TN_RutherFord_GS;
Input_Disp_lookup :=  dedup(sort(File_TN_RutherFord_GS_Disp_Lookup,disp_code,include),disp_code,right);

DInput_RawFile    :=  distribute(File_TN_RutherFord_GS(trim(name) not in FILTER_CONDITIONS and 
                            length(trim(name))>1 and 
														length(trim(cause_number))>1), hash(cause_number));
  
Crim_Common.Layout_In_Court_Offenses Map_Offense(DInput_RawFile L) := Transform

	self.process_date 			:= Crim_Common.Version_In_Arrest_Offenses;
	self.offender_key 			:= TN_RutherFord_Offender_key_Generator('3YG', L.Cause_number,L.court_Date);
	self.vendor 						:= '3Y';
	self.state_origin 			:= 'TN';
	self.source_file 				:= '(CP)TN_RUTHERFORD_GS_CRM';
	self.off_comp 				  := '';
	self.off_delete_flag 		:= '';
	self.off_date 				  := IF(Function_ParseDate(L.offense_date,'MMDDYY')between '19000101' and (string)((integer)Crim_Common.Version_Development),
									              Function_ParseDate(L.offense_date,'MMDDYY'),'');  
	self.arr_date 				  := IF(Function_ParseDate(L.arrest_date,'MMDDYY')between '19000101' and (string)((integer)Crim_Common.Version_Development),
									              Function_ParseDate(L.arrest_date,'MMDDYY'),''); 
	self.num_of_counts 			:= '';
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
	                                          

  string v_court_off_lev  := MAP (REGEXFIND('FELONY',L.charge) =>'F',
	                                REGEXFIND('FELONEY',L.charge) =>'F',
	                                REGEXFIND('FELONIOUS',L.charge) =>'F',
	                                REGEXFIND(' MISD$',L.charge) =>'M',
																	REGEXFIND('[ (]MISD ',L.charge) =>'M',
	                                REGEXFIND('MISDEMEANOR',L.charge) =>'M',
																	'');
																 
	self.court_off_lev 			:= v_court_off_lev;
	self.court_statute 			:= '';
	self.court_additional_statutes:= '';
	self.court_statute_desc := '';
	self.court_disp_date 		:= IF(Function_ParseDate(L.Judgment_date,'MMDDYY')between '19000101' and (string)((integer)Crim_Common.Version_Development),
									              Function_ParseDate(L.Judgment_date,'MMDDYY'),''); 
	self.court_disp_code 		:= trim(L.Judgment_data);
	self.court_disp_desc_1	:= '';
	self.court_disp_desc_2 	:= '';
	self.sent_date 			    := '';
	self.sent_jail 			    := '';																			
	self.sent_susp_time 		:= '';
	self.sent_court_cost 		:= '';
	self.sent_court_fine 		:= '';
	self.sent_susp_court_fine 		:= '';
	self.sent_probation 		  		:= '';
	self.sent_addl_prov_code 			:= '';
	self.sent_addl_prov_desc_1		:= '';
	self.sent_addl_prov_desc_2		:= '';
	self.sent_consec 			    	  := '';
	self.sent_agency_rec_cust_ori := '';
	self.sent_agency_rec_cust 	  := '';
	self.appeal_date 			        := '';
	self.appeal_off_disp 		      := '';
	self.appeal_final_decision 	  := '';

end;

pTNRGS_Offense := project(DInput_RawFile,Map_Offense(left));
//output(pTNRGS_Offense);
Crim_Common.Layout_In_Court_Offenses Get_Disp_desc(pTNRGS_Offense L, Input_Disp_lookup R) := transform
  self.court_disp_desc_1	:= If( LENGTH(R.disp_desc)>40, R.disp_desc[1..40],R.disp_desc);
	self.court_disp_desc_2 	:= If( LENGTH(R.disp_desc)>40, R.disp_desc[41..],'');
  Self := L;
end;

JTNRGS_offense_Disp_lookup := Join(pTNRGS_Offense, Input_Disp_lookup, 
                                   trim(left.court_disp_code) = trim(right.disp_code),
                                   Get_Disp_desc(LEFT,RIGHT), LEFT OUTER,lookup);

export Map_TN_RutherFord_GS_Offense := JTNRGS_offense_Disp_lookup ;