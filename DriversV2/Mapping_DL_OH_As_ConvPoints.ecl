import Std, Corp2_Mapping, VersionControl, _Validate, ut;

export Mapping_DL_OH_As_ConvPoints( string  pversion, dataset(DriversV2.Layouts_DL_OH_In.Layout_OH_CP_PDate) in_file) := module

	DriversV2.Layouts_DL_OH_In.Layout_OH_CP_PDate trfFixChars(DriversV2.Layouts_DL_OH_In.Layout_OH_CP_PDate l)	:=	transform
		self.blob 	 		:= DriversV2.functions.fn_RemoveRawDataSpecialChars(l.blob);
		self            := l;
	end;
	
	RemoveBadChars	  := project(in_file, trfFixChars(left));
	
	export in_OH_Viol := project(RemoveBadChars,
															 transform(DriversV2.Layouts_DL_OH_In.Header_Raw_Pdate,
																				 self.Key_Number       := left.blob[1..9];
																				 self.Record_Type_Code := left.blob[10..11];
																				 self.blob    				 := left.blob[12..];
																				 self                  := left; 
																			  ) );
	
  //**************** CONVICTIONS Mapping **********************************************************************************
	ds_Convictions      := in_OH_Viol(trim(Record_Type_Code,left,right) = 'CN');   
	Layout_Oh_Conv_out  := DriversV2.Layouts_DL_OH_In.Viol_Convictions_Raw;

	Layout_Oh_Conv_out trfOHConv(ds_Convictions l) := transform
		self.Conviction_Type_Code			:=l.blob[1..2];
		self.Offense_Violation_Date		:=l.blob[3..10];
		self.Plate_Number							:=l.blob[11..18];
		self.Conviction_Date					:=l.blob[19..26];
		self.Court_Code								:=l.blob[27..32];
		self.Ohio_Offense_Code				:=l.blob[33..34];
		self.Sentence_Code						:=l.blob[35];
		self.Court_Assessed_Points		:=l.blob[36..37];
		self.Had_Hazardous_Materials	:=l.blob[38];
		self.Batch_Number							:=l.blob[39..44];
		self.Conviction_Plea					:=l.blob[45];
		self.Court_Case_Number				:=l.blob[46..61];
		self.ACD_Offense_Code					:=l.blob[62..64];
		self.Posted_Speed							:=l.blob[65..66];
		self.Actual_Speed							:=l.blob[67..69];
		self.Blood_Alcohol_Content		:=l.blob[70..74];
		self.Is_Commercial_Vehicle		:=l.blob[75];
		self.Reference_Locator_Number	:=l.blob[76..93];
		self.Offense_Reduced_From_Code:=l.blob[94..96];
		self.Create_Date							:=l.blob[97..104];
		self.S1_Case_Number						:=l.blob[105..114];
		self.P2_Case_Number						:=l.blob[115..124];
		self.P3_Case_Number						:=l.blob[125..134];
		self.DL_Case_Number						:=l.blob[135..144];
		self.Habitual_Case_Number			:=l.blob[145..154];
		self.Jurisdiction_Code			  :=l.blob[155..156];
		self.SOA_ConvWithOffense_Code	:=l.blob[157..164];
		self.Court_Type_Code					:=l.blob[165..168];
		self.SP_Case_Number						:=l.blob[169..178];
		self.Out_of_State_Lic_Nbr			:=l.blob[179..203];
		self.State_of_Origin					:=l.blob[204..205];
		self.Suspension_Class					:=l.blob[206];
		self.Is_CourtOrdRemed_Driving :=l.blob[207];
		self.Is_CDL_Conviction        :=l.blob[208];
		self.Did_Show_Proof_of_Insu   :=l.blob[209];
		self.Parent_Guardian_RestCode :=l.blob[210];
		self.Parent_Guardian_RestDate :=l.blob[211..218];
		self.Related_Record_Type_Code :=l.blob[219..220];
		self.Is_Bus                   :=l.blob[221];
		self.Has_Fatalities           :=l.blob[222];
		self                          :=l;
		self                          :=[];
	end;

	export file_Oh_Conviction := project(ds_Convictions, trfOHConv(left));

	Layout_Conviction_Common  := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Convictions;

	Layout_Conviction_Common trfOHToConvictions(file_Oh_Conviction l) := transform
		self.dt_first_seen        := l.process_date;
		self.dt_last_seen         := l.process_date;
		self.src_state            := 'OH';
		self.dlcp_key             := trim(l.Key_Number, left, right);
		self.type_cd              := DriversV2.functions.TrimUpper(l.Record_Type_Code);
		self.type_desc            := DriversV2.Tables_CP_OH.record_type_code(DriversV2.functions.TrimUpper(self.type_cd));
		self.violation_date       := DriversV2.functions.ValidateDate(l.Offense_Violation_Date);
		self.plate_nbr            := DriversV2.functions.TrimUpper(l.plate_number);
		self.conviction_date      := DriversV2.functions.ValidateDate(l.conviction_date);
		self.court_county         := DriversV2.functions.TrimUpper(l.Court_Code);
		self.court_name_cd        := DriversV2.functions.TrimUpper(l.Court_Code);
		self.court_name_desc      := DriversV2.Tables_CP_OH.court_code(self.court_name_cd);
		self.court_type_cd        := DriversV2.functions.TrimUpper(l.Court_Type_Code);
		self.court_type_desc      := DriversV2.Tables_CP_OH.court_type_code(DriversV2.functions.TrimUpper(self.court_type_cd));
		self.st_offense_conv_cd   := DriversV2.functions.TrimUpper(l.Conviction_Type_Code);
		self.st_offense_conv_desc := DriversV2.Tables_CP_OH.offense_conv_code(DriversV2.functions.TrimUpper(self.st_offense_conv_cd));
		self.sentence             := DriversV2.functions.TrimUpper(l.Sentence_Code);
		self.sentence_desc        := DriversV2.Tables_CP_OH.sentence_code(DriversV2.functions.TrimUpper(self.sentence));
		self.points               := DriversV2.functions.TrimUpper(l.Court_Assessed_Points);
		self.hazardous_cd         := DriversV2.functions.TrimUpper(l.Had_Hazardous_Materials);
		self.hazardous_desc       := DriversV2.Tables_CP_OH.hazardous_mat_flag(DriversV2.functions.TrimUpper(self.hazardous_cd));
		self.plea_cd              := DriversV2.functions.TrimUpper(l.conviction_plea);
		self.plea_desc            := DriversV2.Tables_CP_OH.conviction_plea_flag(DriversV2.functions.TrimUpper(self.plea_cd));
		self.court_case_nbr       := DriversV2.functions.TrimUpper(l.court_case_number);
		self.acd_offense_cd       := DriversV2.functions.TrimUpper(l.ACD_Offense_Code);
		self.acd_offense_desc     := DriversV2.Tables_CP_OH.acd_offense_codes(DriversV2.functions.TrimUpper(self.acd_offense_cd));
		self.reduced_cd           := DriversV2.functions.TrimUpper(l.offense_reduced_from_code);
		self.reduced_desc         := '';
		self.create_date          := DriversV2.functions.ValidateDate(l.create_date);
		self.bmv_case_nbr_1       := DriversV2.functions.TrimUpper(l.s1_case_number);
		self.bmv_case_nbr_2       := DriversV2.functions.TrimUpper(l.p2_case_number);
		self.bmv_case_nbr_3       := DriversV2.functions.TrimUpper(l.p3_case_number);
		self.habitual_case_nbr    := DriversV2.functions.TrimUpper(l.habitual_case_number);
		self.soa_conviction       := DriversV2.functions.TrimUpper(l.SOA_ConvWithOffense_Code);
		self.bmv_sp_case_nbr      := DriversV2.functions.TrimUpper(l.sp_case_number);
		self.out_of_state_dl_nbr  := DriversV2.functions.TrimUpper(l.Out_of_State_Lic_Nbr);
		self.state_of_origin      := DriversV2.functions.TrimUpper(l.state_of_origin);
		self                      := l;
		self                      := [];	  
	end;

	export OH_As_Convictions:= project(file_Oh_Conviction, trfOHToConvictions(left));


	//**************** SUSPENSIONS Mapping **********************************************************************************
	
	ds_Suspention      := in_OH_Viol(trim(Record_Type_Code,left,right) = 'SU');
	Layout_Oh_Susp_out := DriversV2.Layouts_DL_OH_In.Viol_Suspensions_Raw;

	Layout_Oh_Susp_out trfOHSusp(ds_Suspention l) := transform
	 self.Suspension_Type_Code                    := l.blob[1..2];	
	 self.Offense_Violation_Date                  := l.blob[3..10];	
	 self.Clear_Date                              := l.blob[11..18];	
	 self.Proof_Filing_Shown_Date                 := l.blob[19..26];	
	 self.Action_Date                             := l.blob[27..34];	
	 self.Start_Date                              := l.blob[35..42];	
	 self.End_Date                                := l.blob[43..50];	
	 self.BMV_Case_Number                         := l.blob[51..60];	
	 self.Court_Code                              := l.blob[61..66];	
	 self.Ohio_Offense_Code                       := l.blob[67..69];	
	 self.Is_Commercial_Vehicle                   := l.blob[70];	
	 self.Had_Hazardous_Material                  := l.blob[71];	
	 self.Jurisdiction_Code                       := l.blob[72..73];	
	 self.Fee_Paid_Date                           := l.blob[74..81];	
	 self.Plate_Number                            := l.blob[82..89];	
	 self.CDL_Disqualification_Reason_Code        := l.blob[90..92];	
	 self.CDL_Out_of_State_Disqualification_Type  := l.blob[93..95];	
	 self.Disqualification_Extent_Flag            := l.blob[96];	
	 self.Disqualification_Reason_Reference       := l.blob[97..104];	
	 self.Reference_Locator_Number                := l.blob[105..122];	
	 self.School_District_Number                  := l.blob[123..128];	
	 self.Clearance_Reason                        := l.blob[129];	
	 self.Cleared_for_Restricted_Driving_Date     := l.blob[130..137];	
	 self.Withdrawal_Reason_Code                  := l.blob[138..140];	
	 self.Remedial_Driving_Course_Date            := l.blob[141..148];	
	 self.License_Exam_Date                       := l.blob[149..156];	
	 self.ACD_Offense_Code                        := l.blob[157..159];	
	 self.Withdrawal_Status_Code                  := l.blob[160];	
	 self.Modified_Driving_Date                   := l.blob[161..168];	
	 self.Settlement_Agreement_Date               := l.blob[169..176];	
	 self.Restriction_Code                        := l.blob[177..177];	
	 self.Conviction_Date                         := l.blob[178..186];	
	 self.Appeal_Filed_Date                       := l.blob[187..194];	
	 self.Appeal_Denied_Date                      := l.blob[195..202];	
	 self.Appeal_Granted_Date                     := l.blob[203..210];	
	 self.Conviction_Plea_Flag                    := l.blob[211];	
	 self.Is_Revocation                           := l.blob[212];	
	 self.County_Number                           := l.blob[213..214];	
	 self.Create_Date                             := l.blob[215..222];	
	 self.License_Received_Date                   := l.blob[223..230];	
	 self.Plate_Received_Date                     := l.blob[231..238];	
	 self.FRA_Start_Date                          := l.blob[239..246];	
	 self.FRA_End_Date                            := l.blob[247..254];	
	 self.Accident_Date                           := l.blob[255..262];	
	 self.Primary_Related_BMV_Case                := l.blob[263..272];	
	 self.Narrative_Literal_Code                  := l.blob[273];	
	 self.Is_Fee_Required                         := l.blob[274];	
	 self.Is_Vehicle_Owner                        := l.blob[275];	
	 self.SOA_ConvWithOffense_Code                := l.blob[276..283];	
	 self.Modified_Driving_End_Date               := l.blob[284..291];	
	 self.Is_Appeal_Stay                          := l.blob[292];	
	 self.Withdrawal_Type_Detail_Code             := l.blob[293..295];	
	 self.BMV_Related_DL_Case                     := l.blob[296..305];	
	 self.Additional_Related_BMV_Case             := l.blob[306..315];	
	 self.Fine_Paid_Date                          := l.blob[316..323];	
	 self.Mail_by_Date                            := l.blob[324..331];	
	 self.CSEA_Number                             := l.blob[332..335];	
	 self.CSEA_Case_Number                        := l.blob[336..345];	
	 self.CSEA_Order_Number                       := l.blob[346..362];	
	 self.CSEA_Agency_Participant_Number          := l.blob[363..374];	
	 self.Appeal_or_Hearing_Deadline_Date         := l.blob[375..382];	
	 self.Remedial_Driving_Course_G_Number        := l.blob[383..388];	
	 self.Court_Appearance_Effective_Date         := l.blob[389..396];	
	 self.Suspension_Class_Code                   := l.blob[397];	
	 self                                         := l;
	 self                                         := [];
	end;

	export file_Oh_Suspension := project(ds_Suspention, trfOHSusp(left));
	Layout_Suspension_Common  := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Suspensions;

	Layout_Suspension_Common trfOHToSuspension(file_Oh_Suspension l) := transform
		  self.dt_first_seen               := l.process_date;
   		self.dt_last_seen                := l.process_date;
   		self.src_state                   := 'OH';	  
   		self.dlcp_key               		 := trim(l.Key_Number, left, right);
   		self.type_cd                		 := DriversV2.functions.TrimUpper(l.Record_Type_Code);
   		self.type_desc              		 := DriversV2.Tables_CP_OH.record_type_code(DriversV2.functions.TrimUpper(self.type_cd));
   		self.violation_date         		 := DriversV2.functions.ValidateDate(l.Offense_Violation_Date);
   		self.filed_date             		 := DriversV2.functions.ValidateDate(l.Proof_Filing_Shown_Date);  
   		self.clear_date             		 := DriversV2.functions.ValidateDate(l.Clear_Date);
   		self.action_date            		 := DriversV2.functions.ValidateDate(l.Action_Date);
   		self.start_date             		 := DriversV2.functions.ValidateDate(l.Start_Date);
   		self.end_date               		 := DriversV2.functions.ValidateDate(l.end_Date);	  
   		self.bmv_case_nbr_1         		 := DriversV2.functions.TrimUpper(l.BMV_Case_Number);
   		self.court_name_cd          		 := DriversV2.functions.TrimUpper(l.Court_Code);
   		self.court_name_desc        		 := DriversV2.Tables_CP_OH.COURT_CODE(self.court_name_cd);	
			self.court_county           		 := DriversV2.functions.TrimUpper(l.Court_Code);
			self.court_type             		 := DriversV2.functions.TrimUpper(l.Court_Code);
   		self.st_offense_conv_cd     		 := DriversV2.functions.TrimUpper(l.Ohio_Offense_Code);
   		self.st_offense_conv_desc   		 := DriversV2.Tables_CP_OH.offense_conv_code(DriversV2.functions.TrimUpper(self.st_offense_conv_cd));
   		self.vehicle_no_cd          		 := DriversV2.functions.TrimUpper(l.Is_Commercial_Vehicle);
   		self.vehicle_no_desc        		 := DriversV2.Tables_CP_OH.vehicle_ind_code(DriversV2.functions.TrimUpper(self.vehicle_no_cd));	  
   		self.hazardous_cd           		 := DriversV2.functions.TrimUpper(l.Had_Hazardous_Material);
   		self.hazardous_desc         		 := DriversV2.Tables_CP_OH.hazardous_mat_flag(DriversV2.functions.TrimUpper(self.hazardous_cd));
   		self.jurisdiction           		 := DriversV2.functions.TrimUpper(l.Jurisdiction_Code);
   		self.fee_pd_date            		 := DriversV2.functions.ValidateDate(l.Fee_Paid_Date);
   		self.plate_nbr              		 := DriversV2.functions.TrimUpper(l.Plate_Number);
   		self.cdl_disq_reason_cd    			 := DriversV2.functions.TrimUpper(l.CDL_Disqualification_Reason_Code);
   		self.cdl_disq_reason_desc   		 := DriversV2.Tables_CP_OH.cdi_disq_reason_code(DriversV2.functions.TrimUpper(self.cdl_disq_reason_cd));
   		self.cdl_ofs_disqual_reason_cd   := DriversV2.functions.TrimUpper(l.CDL_Out_of_State_Disqualification_Type);
   		self.cdl_ofs_disqual_reason_desc := DriversV2.Tables_CP_OH.cdi_oos_disq_type(DriversV2.functions.TrimUpper(self.cdl_ofs_disqual_reason_cd));
   		self.disq_ext_cd            		 := DriversV2.functions.TrimUpper(l.Disqualification_Extent_Flag);						
   		self.disq_reason_ref        		 := DriversV2.functions.ValidateDate(l.Disqualification_Reason_Reference);				
   		self.sd_nbr                 		 := DriversV2.functions.TrimUpper(l.School_District_Number);
   		self.wd_clear_reason_cd     		 := DriversV2.functions.TrimUpper(l.Withdrawal_Type_Detail_Code);
   		self.wd_clear_reason_desc   		 := DriversV2.Tables_CP_OH.wd_cle_reason_code(DriversV2.functions.TrimUpper(self.wd_clear_reason_cd));						
   		self.cleared_date           		 := DriversV2.functions.ValidateDate(l.Cleared_for_Restricted_Driving_Date);
   		self.Conviction_Date             := DriversV2.functions.ValidateDate(l.Conviction_Date);
   		self.wd_reason_cd          			 := DriversV2.functions.TrimUpper(l.Withdrawal_Reason_Code);			
   		self.wd_reason_desc         		 := DriversV2.Tables_CP_OH.wd_reason_code(DriversV2.functions.TrimUpper(self.wd_reason_cd));
   		self.remedial_drv_crs_dt    		 := DriversV2.functions.TrimUpper(l.Remedial_Driving_Course_Date);						
   		self.appeal_file_date       		 := DriversV2.functions.ValidateDate(l.Appeal_Filed_Date);
   		self.appeal_deny_date       		 := DriversV2.functions.ValidateDate(l.Appeal_Denied_Date);
   		self.appeal_granted_date    		 := DriversV2.functions.ValidateDate(l.Appeal_Granted_Date);
   		self.plea_cd                		 := DriversV2.functions.TrimUpper(l.Conviction_Plea_Flag);
   		self.plea_desc              		 := DriversV2.Tables_CP_OH.conviction_plea_flag(DriversV2.functions.TrimUpper(self.plea_cd));
   		self.county_cd              		 := DriversV2.functions.TrimUpper(l.County_Number);
   		self.create_date            		 := DriversV2.functions.ValidateDate(l.Create_Date);
   		self.license_rec_date       		 := DriversV2.functions.ValidateDate(l.License_Received_Date);
   		self.plate_rec_date         		 := DriversV2.functions.ValidateDate(l.Plate_Received_Date);
   		self.fra_sup_start_date     		 := DriversV2.functions.ValidateDate(l.FRA_Start_Date);
   		self.fra_sup_end_date       		 := DriversV2.functions.ValidateDate(l.FRA_end_Date);
   		self.accident_date          		 := DriversV2.functions.ValidateDate(l.Accident_Date);
   		self.related_bmv_case_nbr   		 := DriversV2.functions.TrimUpper(l.Primary_Related_BMV_Case);
   		self.narrative_cd           		 := DriversV2.functions.TrimUpper(l.Narrative_Literal_Code);
   		self.narrative_desc         		 := DriversV2.Tables_CP_OH.narrative_code(DriversV2.functions.TrimUpper(self.narrative_cd));
   		self.fee_required           		 := DriversV2.functions.TrimUpper(l.Is_Fee_Required);
   		self.vehicle_owner_ind      		 := DriversV2.functions.TrimUpper(l.Is_Vehicle_Owner);
   		self.soa_conviction         		 := DriversV2.functions.TrimUpper(l.SOA_ConvWithOffense_Code);
   		self.modified_drv_end_dt    		 := DriversV2.functions.ValidateDate(l.Modified_Driving_end_Date);
   		self.appeal_sup_stay        		 := DriversV2.functions.TrimUpper(l.Is_Appeal_Stay); 
   		self.wd_type_detail         		 := DriversV2.functions.TrimUpper(l.Withdrawal_Type_Detail_Code);
   		self.bmv_dl_case_nbr        		 := DriversV2.functions.TrimUpper(l.BMV_Related_DL_Case);
   		self.related_bmv_case_nbr_2 		 := DriversV2.functions.TrimUpper(l.Additional_Related_BMV_Case);
   		self.fine_paid_date         		 := DriversV2.functions.ValidateDate(l.Fine_Paid_Date);
   		self.csea                   		 := DriversV2.functions.TrimUpper(l.CSEA_Number);
   		self.csea_case_nbr          		 := DriversV2.functions.TrimUpper(l.CSEA_Case_Number);
   		self.csea_order_nbr         		 := DriversV2.functions.TrimUpper(l.CSEA_Order_Number);
   		self.csea_part_nbr          		 := DriversV2.functions.TrimUpper(l.CSEA_Agency_Participant_Number);
   		self                             := l;
   		self                        		 := [];	  
	end;

	export OH_As_Suspension := project(file_Oh_Suspension, trfOHToSuspension(left));

	//**************** DRIVER RECORD INFORMATION Mapping ********************************************************************

	ds_cs_in					 :=in_OH_Viol(Record_Type_Code='CS');
	ds_cosigners_info  :=project(ds_cs_in, 
															 TRANSFORM(DriversV2.Layouts_DL_OH_In.Viol_cosigners_info_Raw,
																				 self.RECORD_TYPE_ACTION_DATE           := left.blob[1..8];
																				 self.DRIVERS_COSIGNERS_RELATIONSHIP    := left.blob[9];	
																				 self.DRIVERS_COSIGNERS_NAME            := left.blob[10..44];	
																				 self.COSIGNERS_DRIVERS_LICENSE_NBR     := left.blob[45..52];	
																				 self.DATABASE_RECORD_CREATE_DATE       := left.blob[53..60];
																				 self                                   := left;
																				  ));	
											
	ds_cosigners_info_proj := project(ds_cosigners_info,transform(DriversV2.Layouts_DL_OH_In.Temp_Combined_RecLayout4_DrInfo,self:= left;self:=[]));

	ds_wb_in					 :=in_OH_Viol(Record_Type_Code='WB');
	ds_Warrant_Blocks  :=project(ds_wb_in, 
															 TRANSFORM(DriversV2.Layouts_DL_OH_In.Viol_Warrant_Blocks_Raw,
																				 self.Create_Date                  := left.blob[1..8];
																				 self.BMV_Case_Number    					 := left.blob[9..20];	
																				 self.Court_Code            			 := left.blob[21..24];	
																				 self.Clear_Date     							 := left.blob[25..32];	
																				 self.Warrant_Block_Effective_Date := left.blob[33..40];
																				 self.Is_Fee_Required              := left.blob[41];	
																				 self.Fee_Paid_Date                := left.blob[42..49];	
																				 self.Release_Date	     					 := left.blob[50..57];	
																				 self.Is_Bankruptcy       				 := left.blob[58];
																				 self                              := left;
															 )); 
	ds_Warrant_Blocks_proj := project(ds_Warrant_Blocks,transform(DriversV2.Layouts_DL_OH_In.Temp_Combined_RecLayout4_DrInfo,self:= left;self:=[]));

	ds_rm_in						:=in_OH_Viol(Record_Type_Code='RM');
	ds_Remedial_Course  :=project(ds_rm_in, 
																TRANSFORM(DriversV2.Layouts_DL_OH_In.Viol_Remedial_Course_Raw,
																					self.RecCreationDate             := left.blob[0..8];
																					self.RemedialReqCompletionDate   := left.blob[9..16];	
																					self.requirementsDeniedDate      := left.blob[17..24];	
																					self.drivingSchoolGNum     			 := left.blob[25..30];	
																					self.remedialCourtOrderedInd     := left.blob[31];
																					self                             := left;
																				 ));
	ds_Remedial_Course_proj := project(ds_Remedial_Course,transform(DriversV2.Layouts_DL_OH_In.Temp_Combined_RecLayout4_DrInfo,self:= left;self:=[]));

	ds_is_in				 :=in_OH_Viol(Record_Type_Code='IS');
	ds_OOS_Issuance  :=project(ds_is_in, 
														 TRANSFORM(DriversV2.Layouts_DL_OH_In.Viol_OOS_Issuance_Raw,
																			 self.OOState_RecCreationDate:= left.blob[0..8];
																			 self.OutOfStateIssueDate 	 := left.blob[9..16];	
																			 self.NewSPCOfRecord      	 := left.blob[17..18];	
																			 self.OutOfStateDLN     	   := left.blob[19..43];	
																			 self                        := left;
																			 ));	
	ds_OOS_Issuance_proj  := project(ds_OOS_Issuance,transform(DriversV2.Layouts_DL_OH_In.Temp_Combined_RecLayout4_DrInfo,self:= left;self:=[]));

	ds_Combined4_DrInfo		:= ds_cosigners_info_proj + ds_Warrant_Blocks_proj + ds_Remedial_Course_proj + ds_OOS_Issuance_proj ;

	Layout_DR_Info_Common := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Driver_Record_Info;

	Layout_DR_Info_Common trfOHToDR_Info(DriversV2.Layouts_DL_OH_In.Temp_Combined_RecLayout4_DrInfo l) := transform
		self.dt_first_seen           := l.process_date;
		self.dt_last_seen            := l.process_date;
		self.src_state               := 'OH';
		self.dlcp_key                := trim(l.key_number, left, right);
		self.type_cd                 := DriversV2.functions.TrimUpper(l.record_type_code);
		self.type_desc               := DriversV2.Tables_CP_OH.record_type_code(self.type_cd);
		self.action_date             := DriversV2.functions.ValidateDate(l.record_type_action_date);
		self.bmv_case_nbr_1          := DriversV2.functions.TrimUpper(l.bmv_case_number);
		self.clear_date              := DriversV2.functions.ValidateDate(l.clear_date);	  
		self.cosigners_dl_nbr        := DriversV2.functions.TrimUpper(l.cosigners_drivers_license_nbr);      
		self.cosigners_name          := DriversV2.functions.TrimUpper(l.drivers_cosigners_name);	  
		self.cosigners_relationship  := DriversV2.functions.TrimUpper(l.drivers_cosigners_relationship);
		self.create_date             := DriversV2.functions.ValidateDate(l.create_date);
		self.out_of_state_dl_nbr     := DriversV2.functions.TrimUpper(l.OutOfStateDLN);
		self.remedial_require_comp   := DriversV2.functions.ValidateDate(l.RemedialReqCompletionDate);            
		self.remedial_require_denied := DriversV2.functions.ValidateDate(l.requirementsDeniedDate);
		self.warrant_eff_date        := DriversV2.functions.ValidateDate(l.warrant_block_effective_date);
		self                         := l;
		self                         := [];
	end;

	Oh_DRInfo := project(ds_Combined4_DrInfo, trfOHToDR_Info(left));

	ds_cn_in        :=in_OH_Viol(Record_Type_Code='LC');
	ds_Cancellation :=project(ds_cn_in, 
														TRANSFORM(DriversV2.Layouts_DL_OH_In.Viol_Cancellation_Raw,
																			 self.cancelRecordType := left.blob[1..2];
																			 self.dateEntered      := left.blob[3..10];	
																			 self.effectiveDate    := left.blob[11..18];	
																			 self.BMVcaseNum     	 := left.blob[19..26];	
																			 self.courtCaseNum     := left.blob[27..34];
																			 self.courtCode        := left.blob[35..42];
																			 self.newStateCode1    := left.blob[43..52];
																			 self.newStateCode2    := left.blob[53..62];
																			 self.newStateIssueDate:= left.blob[63..70];
																			 self                  := left;
																		 ));
																		 
	Layout_DR_Info_Common trfOH_LCTODR_Info(ds_Cancellation l) := transform
	
		self.dt_first_seen           := l.process_date;
		self.dt_last_seen            := l.process_date;
		self.src_state               := 'OH';	  
		self.dlcp_key                := trim(l.key_number, left, right);
		self.type_cd                 := DriversV2.functions.TrimUpper(l.record_type_code);
		self.type_desc               := DriversV2.Tables_CP_OH.record_type_code(self.type_cd);
		self.action_date             := DriversV2.functions.ValidateDate(l.dateEntered );
		self.bmv_case_nbr_1          := DriversV2.functions.TrimUpper(l.BMVcaseNum);
		self.court_case_nbr          := DriversV2.functions.TrimUpper(l.courtCaseNum);
		self                         := l;
		self                         := [];
	end;

	Oh_DRInfo1  				 := project(ds_Cancellation, trfOH_LCTODR_Info(left));
	Oh_DR_Info  				 := Oh_DRInfo + Oh_DRInfo1;
	export OH_As_DR_Info := Oh_DR_Info; 

	//**************** ACCIDENT Mapping *************************************************************************************
	ds_Accidents        	 := in_OH_Viol(trim(Record_Type_Code,left,right)= 'A1');
	Layout_Oh_Accident_out := DriversV2.Layouts_DL_OH_In.Viol_Accidents_Raw;

	Layout_Oh_Accident_out trfOHRawToAccident(ds_Accidents l) := transform
		self.County_Number                  := l.blob[1..2];
		self.Jurisdiction_Code              := l.blob[3..4];	
		self.Accident_Severity_Indicator    := l.blob[5];	
		self.Accident_Date                  := l.blob[6..13];	
		self.Is_Commercial_Vehicle          := l.blob[14];	
		self.Has_Hazardous_Materials        := l.blob[15];
		self.Reference_Locator_Number       := l.blob[16..33];	
		self.Create_Date                    := l.blob[34..41];	
		self.Accident_to_Line_of_Duty_Date  := l.blob[42..49];
		self.Patrol_Crash_ID                := l.blob[50..59];	
		self.NCIC_Code                      := l.blob[60..64];	
		self                                := l;
	end;

	file_Oh_Accidents 		 := project(ds_Accidents, trfOHRawToAccident(left));
	Layout_Accident_Common := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Accident;

	Layout_Accident_Common trfOHToAccident(file_Oh_Accidents l) := transform
		self.dt_first_seen      := l.process_date;
		self.dt_last_seen       := l.process_date;
		self.src_state          := 'OH';	  
		self.dlcp_key           := trim(l.key_number, left, right);
		self.type_cd            := DriversV2.functions.TrimUpper(l.record_type_code);
		self.type_desc          := DriversV2.Tables_CP_OH.record_type_code(DriversV2.functions.TrimUpper(self.type_cd));
		self.county             := DriversV2.functions.TrimUpper(l.county_number);      
		self.jurisdiction       := DriversV2.functions.TrimUpper(l.jurisdiction_code);
		self.severity_cd        := DriversV2.functions.TrimUpper(l.Accident_Severity_Indicator);	  
		self.severity_desc      := DriversV2.Tables_CP_OH.accident_severity_code(DriversV2.functions.TrimUpper(self.severity_cd));
		self.accident_date      := DriversV2.functions.ValidateDate(l.accident_date);
		self.vehicle_no         := DriversV2.functions.TrimUpper(l.Is_Commercial_Vehicle);
		self.hazardous_cd       := DriversV2.functions.TrimUpper(l.Has_Hazardous_Materials);
		self.hazardous_desc     := DriversV2.Tables_CP_OH.hazardous_mat_flag(DriversV2.functions.TrimUpper(self.hazardous_cd));            
		self.create_date        := DriversV2.functions.ValidateDate(l.create_date);	
	  self                    := l;		
		self                    :=[];
	end;

	export OH_As_Accident := project(file_Oh_Accidents, trfOHToAccident(left));

	//**************** FRA Insurance Mapping ********************************************************************************   
	ds_FRA_Insurance      			:= in_OH_Viol(trim(Record_Type_Code,left,right) = 'FR');      
	Layout_Oh_FRA_Insurance_out := DriversV2.Layouts_DL_OH_In.Viol_FRA_Insurance_Raw;

	Layout_Oh_FRA_Insurance_out trfOHRawToFRA(ds_FRA_Insurance l) := transform
		self.Proof_Filing_Start_Date           := l.blob[1..8];
		self.Proof_Filing_end_Date             := l.blob[9..16];	
		self.Insurance_Policy                  := l.blob[17..32];	
		self.Proof_Filing_Cancellation_Date    := l.blob[33..40];	
		self.Proof_Filing_Late_Start_Date      := l.blob[41..48];	
		self.Proof_Filing_Cancelled_Posted_Date:= l.blob[49..56];
		self.Proof_Filing_Posted_Date          := l.blob[57..64];
		self                                   := l;
	end;

	file_Oh_FRA_Insurance := project(ds_FRA_Insurance, trfOHRawToFRA(left));
	Layout_FRA_Common 		:= DriversV2.Layouts_DL_Conv_Points_Common.Layout_FRA_Insurance;

	Layout_FRA_Common trfOHToFRA(file_Oh_FRA_Insurance l) := transform
		self.dt_first_seen         := l.process_date;
		self.dt_last_seen          := l.process_date;
		self.src_state             := 'OH';	
		self.dlcp_key              := trim(l.key_number, left, right);      
		self.cancel_posted_date    := DriversV2.functions.ValidateDate(l.Proof_Filing_Cancelled_Posted_Date);
		self.filed_date            := DriversV2.functions.ValidateDate(l.proof_filing_posted_date);
		self.ins_cancel_dt         := DriversV2.functions.ValidateDate(l.Proof_Filing_Cancellation_Date);	  
		self.ins_policy_nbr        := DriversV2.functions.TrimUpper(l.Insurance_Policy);           
		self.latest_proof_start_dt := DriversV2.functions.ValidateDate(l.Proof_Filing_Late_Start_Date);
		self.proof_start_date      := DriversV2.functions.ValidateDate(l.Proof_Filing_Start_Date);
		self.proof_end_date        := DriversV2.functions.ValidateDate(l.Proof_Filing_end_Date);
		self                       := l;
		self                       := [];	
	end;

	Oh_FRA_Insurance 					 := project(file_Oh_FRA_Insurance, trfOHToFRA(left));
	export OH_As_FRA_Insurance := Oh_FRA_Insurance;
	
	shared logical_name 			 := DriversV2.Constants.Cluster+'in::dl2::'+pversion+'::OH::';	
	
	VersionControl.macBuildNewLogicalFile( logical_name+'As_Convictions'	,OH_As_Convictions		,Bld_OH_As_Convictions		);
	VersionControl.macBuildNewLogicalFile( logical_name+'As_Suspension'	  ,OH_As_Suspension			,Bld_OH_As_Suspension			);
	VersionControl.macBuildNewLogicalFile( logical_name+'As_DR_Info'			,OH_As_DR_Info				,Bld_OH_As_DR_Info				);
	VersionControl.macBuildNewLogicalFile( logical_name+'As_Accident'		  ,OH_As_Accident				,Bld_OH_As_Accident				);
	VersionControl.macBuildNewLogicalFile( logical_name+'As_Insurance'		,OH_As_FRA_Insurance	,Bld_OH_As_FRA_Insurance	);
	 
	export Build_DL_OH_Convpoints :=	 
	sequential(parallel(Bld_OH_As_Convictions
											,Bld_OH_As_Suspension
											,Bld_OH_As_DR_Info
											,Bld_OH_As_Accident
											,Bld_OH_As_FRA_Insurance
											 )
						  ,sequential( fileServices.StartSuperFileTransaction()
													,fileservices.AddSuperFile(DriversV2.Constants.Cluster+'in::dl2::ConvPoints::As_Convictions',logical_name+'As_Convictions')
													,fileservices.AddSuperFile(DriversV2.Constants.Cluster+'in::dl2::ConvPoints::As_Suspension',logical_name+'As_Suspension')
													,fileservices.AddSuperFile(DriversV2.Constants.Cluster+'in::dl2::ConvPoints::As_DR_Info',logical_name+'As_DR_Info')
													,fileservices.AddSuperFile(DriversV2.Constants.Cluster+'in::dl2::ConvPoints::As_Accident',logical_name+'As_Accident')
													,fileservices.AddSuperFile(DriversV2.Constants.Cluster+'in::dl2::ConvPoints::As_Insurance',logical_name+'As_Insurance')
													,fileServices.FinishSuperFileTransaction()
												 )
						);			 

end;