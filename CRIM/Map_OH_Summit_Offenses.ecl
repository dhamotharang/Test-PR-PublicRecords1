import Crim_Common, Crim;

Input_RawFile := DEDUP(SORT(File_OH_Summit,RECORD),RECORD);  
dInput_RawFile:= distribute(Input_RawFile(trim(defendant) not in FILTER_CONDITIONS and 
                                          trim(defendant) <> 'Defendant' and
																					( defendant <> '' and 
																					regexfind('[a-zA-Z]+',defendant,0)<> '') and 
																					((trim(offense_count) <> '0' and
																					  trim(offense_count) <> '' )or
																					trim(offense_type) <> '' or
	                                        trim(offense_class) <> '' or	                             
	                                        trim(offense_code) <> '' or
	                                        trim(offense_description) <> '' or
																					trim(offense_date) <> '')                                          
																					), hash(casenumber));
																					
																					
dsInput_RawFile := sort(dInput_RawFile,RECORD,local);

Input_RawFile_dedup := dedup(dsInput_RawFile,RECORD,RIGHT,local);
  
Crim_Common.Layout_In_Court_Offenses Map_Offense(Input_RawFile_dedup L) := Transform
															 
  self.process_date         := Crim_Common.Version_In_Arrest_Offender;
	self.offender_key			    := Function_Offender_Key_Generator('4B',trim(L.casenumber),trim(stringlib.stringfindreplace(L.Filedate,'/','')));
	self.vendor				        := '4B'; 
	self.state_origin			    := 'OH';
	self.source_file			    := '(CV)OH_SUMMIT_CRIM';	
	self.off_comp 				    := '';
	self.off_delete_flag 		  := '';
	self.off_date 				    := IF(Function_ParseDate(L.offense_date,'MM/DD/YYYY')between '19000101' and stringlib.GetDateYYYYMMDD(),
									                Function_ParseDate(L.offense_date,'MM/DD/YYYY'),'');
	self.arr_date 				    := ''; 
	self.num_of_counts 			  := IF (trim(L.offense_count) <> '0',trim(L.offense_count),'');
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
	self.court_off_desc_1 	  := '';
	self.court_off_desc_2		  := '';
	self.court_off_type_cd 	  := '';
	self.court_off_type_desc  := trim(L.offense_type);
	self.court_off_lev 			  := MAP(trim(L.offense_class)[1..1] in [ 'D','G','-','V'] => '',	                                
																	 regexfind('[FM]+',L.offense_class,0)= '' => '',
	                                 stringlib.stringfilterout(stringlib.stringtouppercase(trim(L.offense_class)),'-/'));	                             
	self.court_statute 			  := MAP(length(trim(L.offense_code)) <= 1 => '',
	                                 regexfind('[0-9]+',L.offense_code,0)= '' => '',
	                                 regexfind('([0-9]+[.]*[0-9]+) (AND|and)$',trim(L.offense_code),0) <> '' => 
	                                 regexreplace('([0-9]+[.]*[0-9]+) (AND|and)$',trim(L.offense_code),'$1') , 
																	 trim(L.offense_code));
	self.court_additional_statutes:= '';
	self.court_statute_desc   := MAP(trim(L.offense_description) = '------------------------------' => '',
	                                 length(trim(L.offense_description)) = 1 =>'',
                                   trim(L.offense_description));                                                
	self.court_disp_date 		  := '';
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

pOHSC_Offense := dedup(sort(project(Input_RawFile_dedup,Map_Offense(left)),RECORD,local),RECORD,local);

//----------------------------------------------------------------------------------------------------------------
export Map_OH_Summit_Offenses := pOHSC_Offense  : persist ('~thor_dell400::persist::Crim_OH_SUmmit_Offenses');

