import Crim_Common, Crim;

  
dInput_RawFile:= distribute(File_FL_Alachua_Arrest(trim(name) not in FILTER_CONDITIONS and name <> ''), hash(name));
dsInput_RawFile := sort(dInput_RawFile,RECORD,local);
//output(count(dsInput_RawFile));
Input_RawFile_dedup := dedup(dsInput_RawFile,RECORD,RIGHT,local);
//output(count(Input_RawFile_dedup));

Crim_Common.Layout_In_Court_Offenses Map_Offense(Input_RawFile_dedup L) := Transform
															 
//Degree	C=capital, L=Life, P=first degree, punishable by life, F=first degree, S=second degree, T=third degree, N=N/A
//level   F=felony, M=misd, I=infraction, C-county ordinance, L-Municipal ordinance
  
	self.process_date     := Crim_Common.Version_In_Arrest_Offender;
	self.offender_key			:= '3FA'+HASH(trim(L.name)+trim(L.DOB)+trim(L.arrestdate));
	self.vendor				    := '32';
	self.state_origin			:= 'FL';
	self.source_file			:= 'FL_ALACHUA_ARREST';
	
	self.off_comp 				  := '';
	self.off_delete_flag 		:= '';
	self.off_date 				  := ''; 
	self.arr_date 				  := IF(Function_ParseDate(L.arrestdate,'MMDDYYYY')between '19000101' and stringlib.GetDateYYYYMMDD(),
									              Function_ParseDate(L.arrestdate,'MMDDYYYY'),''); 
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
	self.arr_off_lev 			  := trim(L.level) + trim(L.degree);
	string itiscounty_ord   := IF (stringlib.stringfindreplace(trim(L.statute),'8','') ='','Y','N');
	string itisMunicip_ord  := IF (stringlib.stringfindreplace(trim(L.statute),'9','') ='','Y','N');
	
	self.arr_statute 			  := IF(itiscounty_ord= 'Y' or itisMunicip_ord ='Y', '',trim(L.statute));
	self.arr_statute_desc 	:= MAP(L.statute ='88888888888' and regexfind('(COUNTY)',L.chargetext,0) <> '' =>trim(L.chargetext),
	                               L.statute ='88888888888' and regexfind('(COUNTY)',L.chargetext,0) =  '' =>'COUNTY ORDINANCE VIOL :' + trim(L.chargetext)  ,
 																 L.statute ='99999999999' and regexfind('(MUNICIPAL)',L.chargetext,0) <> '' =>trim(L.chargetext),
																 L.statute ='99999999999' and regexfind('(MUNICIPAL)',L.chargetext,0) =  '' =>'MUNICIPAL ORDINANCE VIOL :' + trim(L.chargetext)  ,
	                               trim(L.chargetext)
																);
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
	self.court_case_number 	:= '';
	self.court_cd 				  := '';
	self.court_desc 			  := '';
	self.court_appeal_flag 	:= '';
	self.court_final_plea 	:= '';
	self.court_off_code 		:= '';
	self.court_off_desc_1 	:= '';
	self.court_off_desc_2		:= '';
	self.court_off_type_cd 	:= '';
	self.court_off_type_desc:= '';
	self.court_off_lev 			:= '';
	self.court_statute 			:= '';
	self.court_additional_statutes:= '';
	self.court_statute_desc := '';
	self.court_disp_date 		:= ''; 
	self.court_disp_code 		:= '';
	self.court_disp_desc_1	:= '';
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

pFLAR_Offense := dedup(sort(project(Input_RawFile_dedup,Map_Offense(left)),RECORD),RECORD);


export Map_FL_Alachua_Arrest_Offenses := pFLAR_Offense  : persist ('~thor_dell400::persist::Crim_FL_Alachua_Arrest_Offenses');
;