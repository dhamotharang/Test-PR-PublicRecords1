import Crim_Common, Crim;


Input_RawFile_Merchant := DEDUP(SORT(File_FL_Alachua_Merchant,RECORD),RECORD);  
dInput_RawFile_Merchant:= distribute(Input_RawFile_Merchant(trim(name) not in FILTER_CONDITIONS), hash(casenumber));
dsInput_RawFile_Merchant := sort(dInput_RawFile_Merchant,RECORD,local);
//output(count(dsInput_RawFile_Merchant));
Input_RawFile_Merchant_dedup := dedup(dsInput_RawFile_Merchant,RECORD,RIGHT,local);
  
Crim_Common.Layout_In_Court_Offenses Map_Offense_merchant(Input_RawFile_Merchant_dedup L) := Transform
															 
  self.process_date         := Crim_Common.Version_In_Arrest_Offender;
	self.offender_key			    := Function_Offender_Key_Generator('3UM',L.casenumber,L.dateofarrest);
	self.vendor				        := '3U'; 
	self.state_origin			    := 'FL';
	self.source_file			    := 'FL_ALACHUA_MERCH_CRM';
	
	self.off_comp 				    := '';
	self.off_delete_flag 		  := '';
	self.off_date 				    := ''; 
	self.arr_date 				    := IF(Function_ParseDate(L.dateofarrest,'MMDDYYYY')between '19000101' and stringlib.GetDateYYYYMMDD(),
									                Function_ParseDate(L.dateofarrest,'MMDDYYYY'),''); 
	self.num_of_counts 			  := '';
	self.le_agency_cd 			  := '';
	self.le_agency_desc 		  := '';
	self.le_agency_case_number 	:= '';
	self.traffic_ticket_number 	:= '';
	self.traffic_dl_no 			  := '';
	self.traffic_dl_st 			  := '';
	self.arr_off_code 			  := '';
	self.arr_off_desc_1 		  := '';
	self.arr_off_desc_2 		  := '';
	self.arr_off_type_cd 		  := '';
	self.arr_off_type_desc 	  := '';
	self.arr_off_lev 			    := '';
	self.arr_statute 			    := '';
	self.arr_statute_desc 	  := '';
	self.arr_disp_date 			  := '';
	self.arr_disp_code 			  := '';
	self.arr_disp_desc_1 		  := '';
	self.arr_disp_desc_2 		  := '';
	self.pros_refer_cd 			  := '';
	self.pros_refer 			    := '';
	self.pros_assgn_cd 			  := '';
	self.pros_assgn 			    := '';
	self.pros_chg_rej 			  := '';
	self.pros_off_code 			  := '';
	self.pros_off_desc_1 		  := '';
	self.pros_off_desc_2 		  := '';
	self.pros_off_type_cd 	  := '';
	self.pros_off_type_desc   := '';
	self.pros_off_lev 			  := '';
	self.pros_act_filed 		  := '';
	self.court_case_number 	  := trim(L.casenumber);
	self.court_cd 				    := '';
	self.court_desc 			    := '';
	self.court_appeal_flag 	  := '';
	self.court_final_plea 	  := '';
	self.court_off_code 		  := '';
	self.court_off_desc_1 	  := trim(L.descriptionofcharge);
	self.court_off_desc_2		  := '';
	self.court_off_type_cd 	  := '';
	self.court_off_type_desc  := '';
	self.court_off_lev 			  := CASE (regexfind('([A-Z][A-Z])',L.casenumber,0),
	                                   'CF' => 'F',
																		 'MM' => 'M',
																		 '');
	                             //L.casenumber[8..8];
	self.court_statute 			  := '';
	self.court_additional_statutes:= '';
	self.court_statute_desc   := '';
	self.court_disp_date 		  := IF(Function_ParseDate(L.adjudicationdate,'MMDDYYYY')between '19000101' and stringlib.GetDateYYYYMMDD(),
									                Function_ParseDate(L.adjudicationdate,'MMDDYYYY'),'');; 
	self.court_disp_code 		  := '';
	self.court_disp_desc_1	  := '';
	self.court_disp_desc_2 	  := '';
	self.sent_date 			      := '';
	self.sent_jail 			      := '';																			
	self.sent_susp_time 		  := '';
	self.sent_court_cost 		  := '';
	self.sent_court_fine 		  := '';
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

pFLAM_Offense := dedup(sort(project(Input_RawFile_Merchant_dedup,Map_Offense_merchant(left)),RECORD,local),RECORD,local);
//----------------------------------------------------------------------------------------------------------------
// NDR Code

import Crim_Common, Crim;

dInput_RawFile_ndr:= distribute(File_FL_Alachua_NDR(not ln_cnf_nmt_max  in [ '5555555','6666666'] or
                                 ln_cnf_nmt_min  in [ '5555555','6666666'] or
													       ln_comm_ctrl    in [ '5555555','6666666'] or
													       ln_dl_supd_rvkd in [ '5555555','6666666'] or
                                 type_cnfnmt = 'J' or 
																 regexfind(sent_provisions,'([0-9]+)',0) <> ''  ), hash(case_num));
																 
Input_RawFil_ndr := DEDUP(SORT(dInput_RawFile_ndr,RECORD,local),RECORD,local);
  
spl_sent_Provision (string spl_sent_prov_code )	:= 
     CASE ( spl_sent_prov_code, 
		        'F' =>	'Firearms Offense section 775.087,FS - 3 year min',
						'Y'	=>	'Youthful Offender Act section 958.04,FS',
						'M'	=>	'Capital Offense - serve no less than 25 years, subsec 775.082(1),FS',
						'R'	=>	'Resentencing-credit time previously served in DOC or DOJJ',
						'D'	=>	'Sentenced as Mentally Disor Sex Offender',
						'G'	=>	'Def/Juv sentenced under sentencing guidelines',
						'C'	=>	'Contr Subst. Within 1000 ft of school-3 yr min 893.13(1)(e)1,FS',
						'S'	=>	'Short-barreled rifle, shotgun, machine gun- 5 yr min 790.221(2),FS',
						'E'	=>	'Continuing Crim Entrp-25 yr mandatory min sect 893.20,FS',
						'P'	=>	'Prison Credit for time prev served prior to resentencing',
						'L'	=>	'Law Enf Protection Act-serve minimum term sect 775.0823,FS',
						'T'	=>	'Defendant not allowed to earn gain time',
						'J'	=>	'Junny-Rios-Martinez Jr Act-sex battery not eligb for gain time 794.011,FS',
						'O'	=>	'Unlawful taking, poss or use of Law Enf Officers firearm-3 yr min 775.0875,FS',
						'A'	=>	'Asslt or Battery on person 65 or older-3 yr min sect 784.08,FS',
						'W'	=>	'Making, Throw a Destru Device-serve 5 yr before parole eligibility 790.161,FS',
						'B'	=>	'Planting of "Hoax Bomb"-3 yrs min section 790.165, FS',
						'K'	=>	'Dealing drugs within 200 ft of cert pub areas-prohibit gain time/eligibility of parole',
						'Q'	=>	'Evidencing prejudice while committing offense-enhanced penalties sect 775.085,FS',
						'U'	=>	'Wearing mask while committing offense-enhanced penalties sect 775.045,FS',
						'I'	=>	'Def det to be sex predator by written findings of court sect 775.23,FS',
						'1'	=>	'Battry of Law Enf Offcr-3 yr term if ofr poss a firearm 775.087,FS',
						'2'	=>	'Battry of Law Enf Offcr-8 yr term if ofr poss a semi-automatic weapon',
						'3'	=>	'Adjudged as habitual felon or serious juv offender 775.084(3)(a),FS or 39.01(62),FS',
						'H'	=>	'Sentncd as habitual felon or serious juv offender 775.084(4)(a),FS or 39.058,FS',
						'4'	=>	'Adjudged as habitual violent fel offender, sect 775.084(3)(a),FS',
						'V'	=>	'Sentncd as habitual violent fel offender, sect 775.084(3)(b),FS',
						'5'	=>	'Adjudged as violent career crim sec 775.084(3)(b), FS',
						'X'	=>	'Sentncd as violent career crim sec 775.084(4)(c),FS',
            '');
		 
sent_Provision (string sent_prov_code )	:= 
      CASE ( sent_prov_code, 
						'B' => 'Bail Forfeited/Estreated',
						'C' => 'Confinement or Fine',
						'H' => 'Confinement in Hospital',
						'G' => 'Night Confinement',
						'W' => 'Weekend Confinement',
						'S' => 'Suspended Fine',
						'O' => 'Community Service',
						'F' => 'Fine or Community Service',
						'A' => 'Attend DUI School or Drug Rehab Program',
						'E' => 'Probation Revoked',
						'D' => 'Confinement or Comm Service',
						'K' => 'Work Release',
						'T' => 'Other Court Restriction/Judicial Warning',
						'U' => 'Split Sent-Incarc foll by probation',
						'V' => 'Split Sent-Incarc foll by comm control',
			//			'Z' => 'Split Sent-Incarc foll by youthful offender community control',
						'I' => 'Electronic Monitor',
			//			'J' => 'Undetermined period but not longer than 19th birthday for Juvenile cases only',
			//			'L' => 'Undetermined period but not longer than 21st birthday for Juvenile cases only',
						'2' => 'Low risk non-residential',
						'4' => 'Low risk residential',
						'6' => 'Moderate risk',
						'8' => 'High risk residential',
						'0' => 'Maximum risk residential',
						'');

Crim_Common.Layout_In_Court_Offenses Map_Offense_ndr(Input_RawFil_ndr L) := Transform
															 
  self.process_date         := Crim_Common.Version_In_Arrest_Offender;
	self.offender_key			    := Function_Offender_Key_Generator('3VM',L.case_num,L.arrest_dt);
	self.vendor				        := '3V'; 
	self.state_origin			    := 'FL';
	self.source_file			    := 'FL_ALACHUA_NDR_CRM';
	
	self.off_comp 				    := '';
	self.off_delete_flag 		  := '';
	self.off_date 				    := ''; 
	self.arr_date 				    := IF(Function_ParseDate(L.arrest_dt,'MMDDYYYY')between '19000101' and stringlib.GetDateYYYYMMDD(),
									                Function_ParseDate(L.arrest_dt,'MMDDYYYY'),''); 
	self.num_of_counts 			  := '';
	self.le_agency_cd 			  := '';
	self.le_agency_desc 		  := '';
	self.le_agency_case_number 	:= '';
	self.traffic_ticket_number 	:= '';
	self.traffic_dl_no 			  := '';
	self.traffic_dl_st 			  := '';
	self.arr_off_code 			  := '';
	self.arr_off_desc_1 		  := '';
	self.arr_off_desc_2 		  := '';
	self.arr_off_type_cd 		  := '';
	self.arr_off_type_desc 	  := '';
	self.arr_off_lev 			    := '';
	self.arr_statute 			    := '';
	self.arr_statute_desc 	  := '';
	self.arr_disp_date 			  := '';
	self.arr_disp_code 			  := '';
	self.arr_disp_desc_1 		  := '';
	self.arr_disp_desc_2 		  := '';
	self.pros_refer_cd 			  := '';
	self.pros_refer 			    := '';
	self.pros_assgn_cd 			  := '';
	self.pros_assgn 			    := '';
	self.pros_chg_rej 			  := '';
	self.pros_off_code 			  := '';
	self.pros_off_desc_1 		  := '';
	self.pros_off_desc_2 		  := '';
	self.pros_off_type_cd 	  := '';
	self.pros_off_type_desc   := '';
	self.pros_off_lev 			  := '';
	self.pros_act_filed 		  := '';
	self.court_case_number 	  := trim(L.case_num);
	self.court_cd 				    := '';
	self.court_desc 			    := '';
	self.court_appeal_flag 	  := '';
	self.court_final_plea 	  := '';
	self.court_off_code 		  := '';
	self.court_off_desc_1 	  := '';
	self.court_off_desc_2		  := '';
	self.court_off_type_cd 	  := '';
	self.court_off_type_desc  := '';
	self.court_off_lev 			  := trim(L.level)+trim(L.degree);
	self.court_statute 			  := trim(L.statute);
	self.court_additional_statutes:= '';
	self.court_statute_desc   := trim(L.desc);
	self.court_disp_date 		  := IF(Function_ParseDate(L.disp_date,'MMDDYYYY')between '19000101' and stringlib.GetDateYYYYMMDD(),
									                Function_ParseDate(L.disp_date,'MMDDYYYY'),''); 
	self.court_disp_code 		  := '';
	self.court_disp_desc_1	  := '';
	self.court_disp_desc_2 	  := '';
	self.sent_date 			      := IF(Function_ParseDate(L.dt_sent_impd,'MMDDYYYY')between '19000101' and stringlib.GetDateYYYYMMDD(),
									                Function_ParseDate(L.dt_sent_impd,'MMDDYYYY'),''); 
  
	string Min_sent_temp      :=	stringlib.stringfindreplace(L.ln_cnf_nmt_min,' ','0');
	
	string Min_sent_temp1     :=	If ((integer)Min_sent_temp[1..3] <> 0,Min_sent_temp[1..3] + ' Years','') + 											
	                              If ((integer)Min_sent_temp[4..5] <> 0 ,Min_sent_temp[4..5] + ' Months','') + 
																If ((integer)Min_sent_temp[6..7] <> 0 ,Min_sent_temp[6..7] + ' Days','') ;																	
																		
  string Min_sent           :=  MAP  (L.ln_cnf_nmt_min = '' => '' ,
	                                    L.ln_cnf_nmt_min = '0000000' => '' ,
	                                    trim(L.ln_cnf_nmt_min) = '000000' => '' ,
																			L.ln_cnf_nmt_min = '9999999' => 'Death Sentence' ,
																			L.ln_cnf_nmt_min = '9999998' => 'Life Sentence' ,
															        Min_sent_temp1 );
																			
	string Max_sent_temp      :=	stringlib.stringfindreplace(L.ln_cnf_nmt_max,' ','0');
	
	string Max_sent_temp1     :=	trim(If ((integer)Max_sent_temp[1..3] <> 0,(string)(integer)trim(L.ln_cnf_nmt_max[1..3]) + ' Years ','') + 											
	                                   IF ((integer)Max_sent_temp[4..5] <> 0 ,(string)(integer)trim(L.ln_cnf_nmt_max[4..5]) + ' Months ','') + 
																     IF ((integer)Max_sent_temp[6..7] <> 0 ,(string)(integer)trim(L.ln_cnf_nmt_max[6..7]) + ' Days','') ,RIGHT);
																		
	string Max_sent           :=  MAP  (L.ln_cnf_nmt_max = '' => '' ,
	                                    L.ln_cnf_nmt_max = '0000000' => '' ,
	                                    trim(L.ln_cnf_nmt_max) = '000000' => '' ,
															        L.ln_cnf_nmt_max = '9999999' => 'Death Sentence' ,
																			L.ln_cnf_nmt_max = '9999998' => 'Life Sentence' ,
															        Max_sent_temp1 );

  string drug_sent_temp      :=	stringlib.stringfindreplace(L.drug_traf_term,' ','0');
	
	string drug_sent_temp1     :=	trim(IF ((integer)drug_sent_temp[1..3] <> 0,(string)(integer)trim(L.drug_traf_term[1..3]) + ' Years ','') + 											
	                                   IF ((integer)drug_sent_temp[4..5] <> 0 ,(string)(integer)trim(L.drug_traf_term[4..5]) + ' Months ','') + 
										       					 IF ((integer)drug_sent_temp[6..7] <> 0 ,(string)(integer)trim(L.drug_traf_term[6..7]) + ' Days','') );
																		
	string drug_sent           :=  MAP  (L.drug_traf_term = '' => '' ,
	                                     L.drug_traf_term = '0000000' => '' ,
	                                     trim(L.drug_traf_term) = '000000' => '' ,
															         L.drug_traf_term = '8888888' => '' ,
																			
															         drug_sent_temp1 );																			
																		 
	self.sent_jail 			      := trim(IF (Min_sent <> '', 'Min Sent :' + Min_sent,'' ) + 
	                                  IF (Max_sent <> '', ' Max Sent :'+ Max_sent, 
	                                      IF (drug_sent <> '', ' For Drug Trafficking :'+ drug_sent,'' )),LEFT,RIGHT); 
																		 
	self.sent_susp_time 		  := trim(L.lg_cnfnmt_suspd);
	self.sent_court_cost 		  := '';
	self.sent_court_fine 		  := '';
	self.sent_susp_court_fine := '';
	string Prob_end_date      := Function_ParseDate(L.term_dt,'MMDDYYYY');
																		 
	string sent_prob_temp     := stringlib.stringfindreplace(L.prob_time,' ','0');
	                            
	string sent_prob_temp1    :=	trim(If ((integer)sent_prob_temp[2..3] <> 0 ,(string)(integer)trim(L.prob_time[2..3]) + ' Years ','') + 											
	                                   IF ((integer)sent_prob_temp[4..5] <> 0 ,(string)(integer)trim(L.prob_time[4..5]) + ' Months ','') + 
																     IF ((integer)sent_prob_temp[6..7] <> 0 ,(string)(integer)trim(L.prob_time[6..7]) + ' Days','') );																	 
																		 
	self.sent_probation 		  := trim(CASE(L.prob_time[1..1] , 
	                                  'R' => 'Reporting ',
	                                  'N' => 'Non Reporting ',
																	  'C' => 'Court Reporting ','') + 
														   MAP  (L.prob_time[2..] = '' => '' ,
															       L.prob_time[2..] = '0000000' => '' ,
															       L.prob_time[2..] = '9999999' => 'Life Probation' ,
															       sent_prob_temp1 ),left,right);
																		 													
	self.sent_addl_prov_code 	:= '';
	
	string sent_provn1        := sent_Provision(l.sent_provisions[1..1]);
	string sent_provn2        := sent_Provision(l.sent_provisions[2..2]);
	string sent_provn3        := sent_Provision(l.sent_provisions[3..3]);
	string sent_provn4        := sent_Provision(l.sent_provisions[4..4]);
	string sent_provn5        := sent_Provision(l.sent_provisions[5..5]);
	
	string temp_sent_addl_prov_desc_1 :=trim(sent_provn1 + 
																			 If (sent_provn2 <> '', ';' + sent_provn2,'') + 
																			 If (sent_provn3 <> '', ';' + sent_provn3,'') + 
																			 If (sent_provn4 <> '', ';' + sent_provn4,'') + 
																			 If (sent_provn5 <> '', ';' + sent_provn5,'') ,left,right);
																
	string spsent_provn1      := spl_sent_Provision(l.spl_sent_Provsn[1..1]) ;
	string spsent_provn2      := spl_sent_Provision(l.spl_sent_Provsn[2..2]) ;
	string spsent_provn3      := spl_sent_Provision(l.spl_sent_Provsn[3..3]) ;
	string spsent_provn4      := spl_sent_Provision(l.spl_sent_Provsn[4..4]) ;
	string spsent_provn5      := spl_sent_Provision(l.spl_sent_Provsn[5..5]) ;
	string spsent_provn6      := spl_sent_Provision(l.spl_sent_Provsn[6..6]) ;
	string spsent_provn7      := spl_sent_Provision(l.spl_sent_Provsn[7..7]) ;
															 
	string temp_sent_addl_prov_desc_2 :=trim(spsent_provn1 + 
																			 If (spsent_provn2 <> '', ';' + spsent_provn2,'') + 
																			 If (spsent_provn3 <> '', ';' + spsent_provn3,'') + 
																			 If (spsent_provn4 <> '', ';' + spsent_provn4,'') + 
																			 If (spsent_provn5 <> '', ';' + spsent_provn5,'') + 
																			 If (spsent_provn6 <> '', ';' + spsent_provn6,'') +
																			 If (spsent_provn7 <> '', ';' + spsent_provn7,''),left,right);
	
	string comm_serv          := IF(l.comm_srvc = '' or l.comm_srvc = '0000', '','Comm Service: '+(string)(integer)l.comm_srvc+ ' Hours' );	
	
	string dl_supd_revk1      := trim(If ((integer)L.ln_dl_supd_rvkd[1..2] <> 0 ,(string)(integer)trim(L.ln_dl_supd_rvkd[1..2]) + ' Years ','') + 											
	                                  IF ((integer)L.ln_dl_supd_rvkd[3..4] <> 0 ,(string)(integer)trim(L.ln_dl_supd_rvkd[3..4]) + ' Months ','') + 
																    IF ((integer)L.ln_dl_supd_rvkd[5..6] <> 0 ,(string)(integer)trim(L.ln_dl_supd_rvkd[5..6]) + ' Days','') ,RIGHT);
																		
	string dl_supd_revk2      := MAP (L.ln_dl_supd_rvkd = '' => '' ,
	                                  trim(L.ln_dl_supd_rvkd) = '000000' => '' ,
																		trim(L.ln_dl_supd_rvkd,left,right) = 'L' => 'Life' ,
															      trim(L.ln_dl_supd_rvkd) = '999999' => 'Life Suspension' ,
																 		dl_supd_revk1 );
																			
	self.sent_addl_prov_desc_1:= MAP(temp_sent_addl_prov_desc_1 = '' and dl_supd_revk2 <> '' => 'DL Susp/Revoked: ' +dl_supd_revk2,
	                                 temp_sent_addl_prov_desc_1 = '' => comm_serv, 
	                                 temp_sent_addl_prov_desc_1[1] = ';' => temp_sent_addl_prov_desc_1[2..],
																   temp_sent_addl_prov_desc_1 ) ;
																
	self.sent_addl_prov_desc_2:= MAP(temp_sent_addl_prov_desc_1 <> '' and 
																	 dl_supd_revk2 <> ''                 => 'DL Susp/Revoked: ' +dl_supd_revk2,
	                                 temp_sent_addl_prov_desc_2 =  '' and 
	                                 temp_sent_addl_prov_desc_1 =  '' and 
																	  dl_supd_revk2 <> ''                => comm_serv, 
																	 temp_sent_addl_prov_desc_1 <> '' and 
																	  dl_supd_revk2 =  ''                => comm_serv, 	                                 	
	                                 temp_sent_addl_prov_desc_2[1] = ';' => temp_sent_addl_prov_desc_2[2..],
																	 temp_sent_addl_prov_desc_2) ;    
	
	self.sent_consec 			    := trim(L.stat);
	                             /*CASE (trim(L.stat) ,
	                                  '1' => 'consecutive', 
	                                  '2' => 'concurrent', 
																		'3' => 'coterminous/concurrent', 
																		'4' => 'included', 
																		'');*/

	self.sent_agency_rec_cust_ori := ''; 
	self.sent_agency_rec_cust 	  := CASE (trim(L.type_cnfnmt) ,
																				'C' => 'County Jail', 
																				'P' => 'State Prison', 
																				'H' => 'Hospital', 
																				'O' => 'Other Facility',
																				'');
	self.appeal_date 			        := '';
	self.appeal_off_disp 		      := '';
	self.appeal_final_decision 	  := '';

end;

pFLAN_Offense := dedup(sort(project(Input_RawFil_ndr,Map_Offense_ndr(left)),RECORD,local),RECORD,local);

//----------------------------------------------------------------------------------------------------------------
export Map_FL_Alachua_Offenses := pFLAM_Offense + pFLAN_Offense  : persist ('~thor_dell400::persist::Crim_FL_Alachua_Offenses');

