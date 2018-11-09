import Drivers, DriversV2, lib_stringlib, ut, VersionControl;
 
export Mapping_DL_OH_As_ConvPoints( string  pversion, dataset(DriversV2.Layouts_DL_OH_In.Layout_OH_CP_Pdate) in_file) := module

	 // function to suppress all zero and parenthesis string data to empty string
	 export AllZeroClean(string instr) := function
	    filteredStr := StringLib.stringFilter(trim(instr,left,right), '0{}');
			outstr := if (length(trim(instr,left,right)) = length(trim(filteredStr,left,right)), '', trim(instr,left,right));
			return(outstr);
	 end;
	 
	export Map_Signed_Field(string sfield) :=	FUNCTION
			string	clean_sfield	:=	map(	sfield[length(trim(sfield))] in ['{'] => sfield[1..(length(trim(sfield))-1)] + '0',
																			sfield[length(trim(sfield))] in ['A'] => sfield[1..(length(trim(sfield))-1)] + '1',
																			sfield[length(trim(sfield))] in ['B'] => sfield[1..(length(trim(sfield))-1)] + '2',
																			sfield[length(trim(sfield))] in ['C'] => sfield[1..(length(trim(sfield))-1)] + '3',
																			sfield[length(trim(sfield))] in ['D'] => sfield[1..(length(trim(sfield))-1)] + '4',
																			sfield[length(trim(sfield))] in ['E'] => sfield[1..(length(trim(sfield))-1)] + '5',
																			sfield[length(trim(sfield))] in ['F'] => sfield[1..(length(trim(sfield))-1)] + '6',
																			sfield[length(trim(sfield))] in ['G'] => sfield[1..(length(trim(sfield))-1)] + '7',
																			sfield[length(trim(sfield))] in ['H'] => sfield[1..(length(trim(sfield))-1)] + '8',
																			sfield[length(trim(sfield))] in ['I'] => sfield[1..(length(trim(sfield))-1)] + '9',
																			sfield[1..length(trim(sfield))]);
			return clean_sfield;
	end;	 
   
   //**************** CONVICTIONS Mapping **********************************************************************************
   Conviction_Type_Cd := Tables_CP_OH.Conviction_Type_Cd;
   
   in_OH_Convictions := in_file(trim(DRIVERS_DETAIL_RECORD_TYPE_CODE,left,right) in Conviction_Type_Cd);
   
   Layout_Oh_Conv_out := Layouts_DL_OH_In.Layout_OH_CONVICTIONS;
   
   Layout_Oh_Conv_out trfOHConv(in_OH_Convictions l) := transform
			self.process_date                    := l.process_date;
			self.KEY_NUMBER                      := Map_Signed_Field(l.KEY_NUMBER);
			self.REC_SEQ_NUM                     := Map_Signed_Field(l.REC_SEQ_NUM);
			self.DRIVER_RECORD_DELETE_DATE       := l.DRIVER_RECORD_DELETE_DATE;
			self.DRIVERS_DETAIL_RECORD_TYPE_CODE := l.DRIVERS_DETAIL_RECORD_TYPE_CODE;
			self.OFFENSE_VIOLATION_DATE          := l.payload[1..8];
			self.PLATE_NUMBER                    := l.payload[9..16];
			self.CONVICTION_DATE                 := l.payload[17..24];
			self.COURT_CODE                      := l.payload[25..30];
			self.DRIVERS_OHIO_OFFENSE_CONVICTION := l.payload[31..33];
			self.DRIVERS_SENTENCE_CODE           := l.payload[34..34];
			self.COURT_ASSESSED_POINTS           := Map_Signed_Field(l.payload[35..36]);
			self.HAZARDOUS_MATERIALS_FLAG        := l.payload[37..37];
			self.DRIVERS_BATCH_NUMBER            := l.payload[38..43];
			self.CONVICTION_PLEA_FLAG            := l.payload[44..44];
			self.COURT_CASE_NUMBER               := l.payload[45..60];
			self.ACD_OFFENSE_CODE                := l.payload[61..63];
			self.ACD_CONVICTION_OFFENSE_DETAILS  := Map_Signed_Field(l.payload[64..68]);
			self.DRIVERS_COMMERCIAL_VEHICLE_IND  := l.payload[69..69];
			self.DRIVERS_REFERENCE_LOCATOR_NBR   := l.payload[70..87];
			self.OFFENSE_REDUCED_FROM_CODE       := l.payload[88..90];
			self.DATABASE_RECORD_CREATE_DATE     := l.payload[91..98];
			self.MERGED_FROM_KEYNUMBER           := Map_Signed_Field(l.payload[99..107]);
			self.BMV_S1_CASE_NUMBER              := l.payload[108..117];
			self.BMV_P2_CASE_NUMBER              := l.payload[118..127];
			self.BMV_P3_CASE_NUMBER              := l.payload[128..137];
			self.BMV_DL_CASE_NUMBER              := l.payload[138..147];
			self.BMV_HABITUAL_CASE_NUMBER        := l.payload[148..157];
			self.PROOF_FILING_SHOWN_DATE         := l.payload[158..165];
			self.RECORD_EXPUNGED_DATE            := l.payload[166..173];
			self.JURISDICTION_CODE               := l.payload[174..175];
			self.SOA_CONVICTION_WITHDRAWL_OFFENSE:= l.payload[176..183];
			self.COURT_TYPE_CODE                 := l.payload[184..187];
			self.BMV_SP_CASE_NUMBER              := l.payload[188..197];
			self.PROGRAM_ID                      := l.payload[198..201];
			self.SYSTEM_DATE_TIME_STAMP          := l.payload[202..217];
			self.USER_IDENTIFICATION_CODE        := l.payload[218..223];
			self.OUT_OF_STATE_DRIVER_LICENSE_NBR := l.payload[224..248];
			self.STATE_OF_ORIGIN                 := l.payload[249..250];
			self.SUSPENSION_CLASS_CODE           := l.payload[251..251];  //string1
			self.COURT_ORDERED_REMEDIAL_COURSE   := l.payload[252..252]; //string1
			//self.FILLER                          := l.payload[253..578];
			self                                 := l;
			self := [];
   end;
  
   export file_Oh_Conviction := project(in_OH_Convictions, trfOHConv(left));
   
   Layout_Conviction_Common := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Convictions;
   
   Layout_Conviction_Common trfOHToConvictions(file_Oh_Conviction l) := transform
			self.process_date         := StringLib.stringFilter(l.process_date, '0123456789');
			self.dt_first_seen        := self.process_date;
			self.dt_last_seen         := self.process_date;
			self.src_state            := 'OH';
			self.DLCP_KEY             := trim(l.KEY_NUMBER, left, right);
			self.TYPE_CD              := StringLib.StringToUpperCase(trim(l.DRIVERS_DETAIL_RECORD_TYPE_CODE,left,right));
			self.TYPE_DESC            := StringLib.StringToUpperCase(Tables_CP_OH.RECORD_TYPE_CODE(self.TYPE_CD));
			self.VIOLATION_DATE       := StringLib.stringFilter(l.OFFENSE_VIOLATION_DATE, '0123456789');
			self.PLATE_NBR            := StringLib.StringToUpperCase(trim(l.PLATE_NUMBER,left,right));
			self.CONVICTION_DATE      := StringLib.stringFilter(l.CONVICTION_DATE, '0123456789');
			self.COURT_COUNTY         := StringLib.StringToUpperCase(trim(l.COURT_CODE,left,right));
			self.COURT_TYPE_CD        := StringLib.StringToUpperCase(trim(l.COURT_TYPE_CODE,left,right));
			self.COURT_TYPE_DESC      := StringLib.StringToUpperCase(Tables_CP_OH.COURT_TYPE_CODE(SELF.COURT_TYPE_CD));
			self.ST_OFFENSE_CONV_CD   := StringLib.StringToUpperCase(trim(l.DRIVERS_OHIO_OFFENSE_CONVICTION,left,right));
			self.ST_OFFENSE_CONV_DESC := StringLib.StringToUpperCase(Tables_CP_OH.OFFENSE_CONV_CODE(self.ST_OFFENSE_CONV_CD));
			self.SENTENCE             := StringLib.StringToUpperCase(trim(l.DRIVERS_SENTENCE_CODE,left,right));
			self.SENTENCE_DESC        := StringLib.StringToUpperCase(Tables_CP_OH.SENTENCE_CODE(self.SENTENCE));
			                          //Modified code to translate the 2nd alpha char code to its equivalent numeric value for points. Bug# 29605 
			self.POINTS               := StringLib.StringToUpperCase(trim(l.COURT_ASSESSED_POINTS[1])) + 
			                             DriversV2.Tables_CP_OH.POINT_CODE(StringLib.StringToUpperCase(trim(l.COURT_ASSESSED_POINTS[2])));
			self.HAZARDOUS_CD         := StringLib.StringToUpperCase(trim(l.HAZARDOUS_MATERIALS_FLAG,left,right));
			self.HAZARDOUS_DESC       := StringLib.StringToUpperCase(Tables_CP_OH.HAZARDOUS_MAT_FLAG(self.HAZARDOUS_CD));
			self.PLEA_CD              := StringLib.StringToUpperCase(trim(l.CONVICTION_PLEA_FLAG,left,right));
			self.PLEA_DESC            := StringLib.StringToUpperCase(Tables_CP_OH.CONVICTION_PLEA_FLAG(self.PLEA_CD));
			self.COURT_CASE_NBR       := StringLib.StringToUpperCase(trim(l.COURT_CASE_NUMBER,left,right));
			self.ACD_OFFENSE_CD       := StringLib.StringToUpperCase(trim(l.ACD_OFFENSE_CODE,left,right));
			self.ACD_OFFENSE_DESC     := StringLib.StringToUpperCase(Tables_CP_OH.ACD_Offense_Codes(self.ACD_OFFENSE_CD));
			self.VEHICLE_NO           := StringLib.StringToUpperCase(trim(l.DRIVERS_COMMERCIAL_VEHICLE_IND,left,right));
			self.REDUCED_CD           := StringLib.StringToUpperCase(trim(l.OFFENSE_REDUCED_FROM_CODE,left,right));
			self.REDUCED_DESC         := '';
			self.CREATE_DATE          := StringLib.stringFilter(l.DATABASE_RECORD_CREATE_DATE, '0123456789');
			self.BMV_CASE_NBR_1       := StringLib.StringToUpperCase(trim(l.BMV_S1_CASE_NUMBER,left,right));
			self.BMV_CASE_NBR_2       := StringLib.StringToUpperCase(trim(l.BMV_P2_CASE_NUMBER,left,right));
			self.BMV_CASE_NBR_3       := StringLib.StringToUpperCase(trim(l.BMV_P3_CASE_NUMBER,left,right));
			self.HABITUAL_CASE_NBR    := StringLib.StringToUpperCase(trim(l.BMV_HABITUAL_CASE_NUMBER,left,right));
			self.FILED_DATE           := StringLib.stringFilter(l.PROOF_FILING_SHOWN_DATE, '0123456789');
			self.EXPUNGED_DATE        := StringLib.stringFilter(l.RECORD_EXPUNGED_DATE, '0123456789');
			self.JURISDICTION         := StringLib.StringToUpperCase(trim(l.JURISDICTION_CODE,left,right));
			self.SOA_CONVICTION       := StringLib.StringToUpperCase(trim(l.SOA_CONVICTION_WITHDRAWL_OFFENSE,left,right));
			self.BMV_SP_CASE_NBR      := StringLib.StringToUpperCase(trim(l.BMV_SP_CASE_NUMBER,left,right));
			self.OUT_OF_STATE_DL_NBR  := StringLib.StringToUpperCase(trim(l.OUT_OF_STATE_DRIVER_LICENSE_NBR,left,right));
			self.STATE_OF_ORIGIN      := StringLib.StringToUpperCase(trim(l.STATE_OF_ORIGIN,left,right));
			self                      := l;
			self                      := [];	  
   end;
   
   Oh_As_Conviction := project(file_Oh_Conviction, trfOHToConvictions(left));
   
   export OH_As_Convictions := Oh_As_Conviction;
   
   
   //**************** SUSPENSIONS Mapping **********************************************************************************
   Suspension_Type_Cd := Tables_CP_OH.Suspension_Type_Cd;
   
   in_OH_Suspention := in_file(trim(DRIVERS_DETAIL_RECORD_TYPE_CODE,left,right) in Suspension_Type_Cd);
   
   Layout_Oh_Susp_out := Layouts_DL_OH_In.Layout_OH_SUSPENSIONS;
   
   Layout_Oh_Susp_out trfOHSusp(in_OH_Suspention l) := transform
			self.process_date                    := l.process_date;
			self.KEY_NUMBER                      := Map_Signed_Field(l.KEY_NUMBER);
			self.REC_SEQ_NUM                     := Map_Signed_Field(l.REC_SEQ_NUM);
			self.DRIVER_RECORD_DELETE_DATE       := l.DRIVER_RECORD_DELETE_DATE;
			self.DRIVERS_DETAIL_RECORD_TYPE_CODE := l.DRIVERS_DETAIL_RECORD_TYPE_CODE;
			self.OFFENSE_VIOLATION_DATE          := l.payload[1..8];
			self.CLEAR_DATE                      := l.payload[9..16];
			self.PROOF_FILING_SHOWN_DATE         := l.payload[17..24];
			self.RECORD_TYPE_ACTION_DATE         := l.payload[25..32];
			self.START_DATE_FROM                 := l.payload[33..40];
			self.END_DATE_TO                     := l.payload[41..48];
			self.BMV_CASE_NUMBER                 := l.payload[49..58];
			self.COURT_CASE_NUMBER               := l.payload[59..74];
			self.COURT_CODE                      := l.payload[75..80];
			self.DRIVERS_OHIO_OFFENSE_CONVICTION := l.payload[81..83];
			self.DRIVERS_COMMERCIAL_VEHICLE_IND  := l.payload[84..84];
			self.HAZARDOUS_MATERIALS_FLAG        := l.payload[85..85];
			self.JURISDICTION_CODE               := l.payload[86..87];
			self.FEE_PAID_DATE                   := l.payload[88..95];
			self.DRIVERS_RECEIPT_NUMBER          := l.payload[96..105];
			self.PLATE_NUMBER                    := l.payload[106..113];
			self.CDL_DISQUALIFICATION_REASON_CODE:= l.payload[114..116];
			self.CDL_OUT_OF_STATE_DISQUAL_TYPE   := l.payload[117..119];
			self.DRIVERS_DISQUALIFICATION_EXTEN  := l.payload[120..120];
			self.DRIVERS_DISQUAL_REASON_REFEREN  := l.payload[121..128];
			self.DRIVERS_REFERENCE_LOCATOR_NUMBER:= l.payload[129..146];
			self.SCHOOL_DISTRICT_NUMBER          := Map_Signed_Field(l.payload[147..152]);
			self.WITHDRAWAL_CLEARANCE_REASON     := l.payload[153..153];
			self.NAIC_INSURANCE_CODE             := l.payload[154..158];
			self.INSURANCE_BOND_FILING_INDICATOR := l.payload[159..159];
			self.CLEARED_FOR_RESTRICTED_DRIVING  := l.payload[160..167];
			self.WITHDRAWAL_REASON_CODE          := Map_Signed_Field(l.payload[168..170]);
			self.DRIVERS_REMEDIAL_DRIVING_COURSE := l.payload[171..178];
			self.DRIVERS_LICENSE_EXAM_DATE       := l.payload[179..186];
			self.ACD_OFFENSE_CODE                := l.payload[187..189];
			self.WITHDRAWAL_STATUS_CODE          := l.payload[190..190];
			self.MODIFIED_DRIVING_DATE           := l.payload[191..198];
			self.SETTLEMENT_AGREEMENT_DATE       := l.payload[199..206];
			self.DRIVERS_RESTRICTION_CODE        := l.payload[207..208];
			self.CONVICTION_DATE                 := l.payload[209..216];
			self.APPEAL_FILED_DATE               := l.payload[217..224];
			self.APPEAL_DENIED_DATE              := l.payload[225..232];
			self.APPEAL_GRANTED_DATE             := l.payload[233..240];
			self.CONVICTION_PLEA_FLAG            := l.payload[241..241];
			self.DRIVERS_SUSPENSION_REVOCATION   := l.payload[242..242];
			self.COUNTY_NUMBER                   := l.payload[243..244];
			self.DRIVERS_ARREST_DATE             := l.payload[245..252];
			self.DRIVERS_LICENSE_NUMBER          := l.payload[253..260];
			self.MERGED_FROM_KEYNUMBER           := Map_Signed_Field(l.payload[261..269]);
			self.DATABASE_RECORD_CREATE_DATE     := l.payload[270..277];
			self.DRIVERS_LICENSE_RECEIVED_DATE   := l.payload[278..285];
			self.PLATE_RECEIVED_DATE             := l.payload[286..293];
			self.FRA_SUSPENSION_START_DATE       := l.payload[294..301];
			self.FRA_SUSPENSION_END_DATE         := l.payload[302..309];
			self.DRIVERS_ACCIDENT_DATE           := l.payload[310..317];
			self.RELATED_BMV_CASE_NUMBER_1       := l.payload[318..327];
			self.NARRATIVE_LITERAL_CODE          := l.payload[328..328];
			self.FEE_REQUIRED_FLAG               := l.payload[329..329];
			self.VEHICLE_OWNER_INDICATOR         := l.payload[330..330];
			self.SOA_CONV_WITHDRAWAL_OFFENSE     := l.payload[331..338];
			self.RECORD_EXPUNGED_DATE            := l.payload[339..346];
			self.DRIVERS_BATCH_NUMBER            := l.payload[347..352];
			self.INQUIRY_REFERRAL_CODE           := l.payload[353..353];
			self.MODIFIED_DRIVING_END_DATE       := l.payload[354..361];
			self.APPEAL_SUSPENSION_STAY_FLAG     := l.payload[362..362];
			self.FEE_RECORD_SEQUENCE_NUM_BMV     := Map_Signed_Field(l.payload[363..365]);
			self.FRA_RECORD_SEQUENCE_NUM_BMV     := Map_Signed_Field(l.payload[366..368]);
			self.C1_SEQUENCE_NUMBER              := Map_Signed_Field(l.payload[369..371]);
			self.WITHDRAWAL_TYPE_DETAIL          := Map_Signed_Field(l.payload[372..374]);
			self.HIGHWAY_PATROL_LIC_CANCELLATION := l.payload[375..375];
			self.BMV_DL_CASE_NUMBER              := l.payload[376..385];
			self.RELATED_BMV_CASE_NUMBER_2       := l.payload[386..395];
			self.PROGRAM_ID                      := l.payload[396..399];
			self.SYSTEM_DATE_TIME_STAMP          := l.payload[400..415];
			self.USER_IDENTIFICATION_CODE        := l.payload[416..421];
			self.FIND_PAID_DATE                  := l.payload[422..429];
			self.MAIL_BY_DATE                    := l.payload[430..437];
			self.CHILD_SUPPORT_ENFORCE_AGENCY    := Map_Signed_Field(l.payload[438..441]);
			self.CHILD_SUPPORT_ENFORCE_CASE_NBR  := Map_Signed_Field(l.payload[442..451]);
			self.CHILD_SUPPORT_ENFORCE_ORDER_NBR := l.payload[452..468];
			self.CHILD_SUPP_ENF_PARTICIPANT_NBR  := Map_Signed_Field(l.payload[469..480]);
			self.SIX_POINT_LETTER_DATE           := l.payload[481..488]; //string8
			self.APPEAL_HEARING_DEADLINE_DATE    := l.payload[489..496]; //string8
			self.REMEDIAL_DRIVING_SCHOOL_CERTIF  := l.payload[497..502]; //string6
			self.COURT_APPEARANCE_EFFECTIVE_DATE := l.payload[503..510]; //string8
			self.SUSPENSION_CLASS_CODE           := l.payload[511..511]; //string1
			self.BLOCKING_TYPE_CODE              := l.payload[512..512]; //string1
			self.MODIFY_ORDER_BY_CODE            := l.payload[513..518]; //string6
			//self.FILLER                          := l.payload[519..578]; //string60
			self                                 := l;
			self                                 := [];
   end;
  
   export file_Oh_Suspension := project(in_OH_Suspention, trfOHSusp(left));
   
   Layout_Suspension_Common := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Suspensions;
   
   Layout_Suspension_Common trfOHToSuspension(file_Oh_Suspension l) := transform
			self.process_date           := StringLib.stringFilter(l.process_date, '0123456789');
			self.dt_first_seen          := self.process_date;
			self.dt_last_seen           := self.process_date;
			self.src_state              := 'OH';	  
			self.DLCP_KEY               := trim(l.KEY_NUMBER, left, right);
			self.TYPE_CD                := StringLib.StringToUpperCase(trim(l.DRIVERS_DETAIL_RECORD_TYPE_CODE,left,right));
			self.TYPE_DESC              := StringLib.StringToUpperCase(Tables_CP_OH.RECORD_TYPE_CODE(self.TYPE_CD));
			self.VIOLATION_DATE         := StringLib.stringFilter(l.OFFENSE_VIOLATION_DATE, '0123456789');
			self.FILED_DATE             := StringLib.stringFilter(l.PROOF_FILING_SHOWN_DATE, '0123456789');  
			self.CLEAR_DATE             := StringLib.stringFilter(l.CLEAR_DATE, '0123456789');
			self.ACTION_DATE            := StringLib.stringFilter(l.RECORD_TYPE_ACTION_DATE, '0123456789');
			self.START_DATE             := StringLib.stringFilter(l.START_DATE_FROM, '0123456789');
			self.END_DATE               := StringLib.stringFilter(l.END_DATE_TO, '0123456789');	  
			self.BMV_CASE_NBR_1         := StringLib.StringToUpperCase(trim(l.BMV_CASE_NUMBER,left,right));
			self.COURT_CASE_NBR         := StringLib.StringToUpperCase(trim(l.COURT_CASE_NUMBER,left,right));
			self.COURT_NAME_CD          := StringLib.StringToUpperCase(trim(l.COURT_CODE,left,right));
			self.COURT_NAME_DESC        := StringLib.StringToUpperCase('');	  
			self.COURT_COUNTY           := StringLib.StringToUpperCase(trim(l.COURT_CODE,left,right));
			self.COURT_TYPE             := StringLib.StringToUpperCase(trim(l.COURT_CODE,left,right));	  
			self.ST_OFFENSE_CONV_CD     := StringLib.StringToUpperCase(trim(l.DRIVERS_OHIO_OFFENSE_CONVICTION,left,right));
			self.ST_OFFENSE_CONV_DESC   := StringLib.StringToUpperCase(Tables_CP_OH.OFFENSE_CONV_cODE(self.ST_OFFENSE_CONV_CD));
			self.VEHICLE_NO_CD          := StringLib.StringToUpperCase(trim(l.DRIVERS_COMMERCIAL_VEHICLE_IND,left,right));
			self.VEHICLE_NO_DESC        := StringLib.StringToUpperCase(Tables_CP_OH.VEHICLE_IND_CODE(self.VEHICLE_NO_CD));	  
			self.HAZARDOUS_CD           := StringLib.StringToUpperCase(trim(l.HAZARDOUS_MATERIALS_FLAG,left,right));
			self.HAZARDOUS_DESC         := StringLib.StringToUpperCase(Tables_CP_OH.HAZARDOUS_MAT_FLAG(self.HAZARDOUS_CD));
			self.JURISDICTION           := StringLib.StringToUpperCase(trim(l.JURISDICTION_CODE,left,right));
			self.FEE_PD_DATE            := StringLib.stringFilter(l.FEE_PAID_DATE, '0123456789');
			self.PLATE_NBR              := StringLib.StringToUpperCase(trim(l.PLATE_NUMBER,left,right));
			self.CDL_DISQ_REASON_CD     := StringLib.StringToUpperCase(trim(l.CDL_DISQUALIFICATION_REASON_CODE,left,right));
			self.CDL_DISQ_REASON_DESC   := StringLib.StringToUpperCase(Tables_CP_OH.CDI_DISQ_REASON_CODE(self.CDL_DISQ_REASON_CD));
			self.CDL_OFS_DISQUAL_REASON_CD   := StringLib.StringToUpperCase(trim(l.CDL_OUT_OF_STATE_DISQUAL_TYPE,left,right));
			self.CDL_OFS_DISQUAL_REASON_DESC := StringLib.StringToUpperCase(Tables_CP_OH.CDI_OOS_DISQ_TYPE(self.CDL_OFS_DISQUAL_REASON_CD));
			self.DISQ_EXT_CD            := StringLib.StringToUpperCase(trim(l.DRIVERS_DISQUALIFICATION_EXTEN,left,right));
			self.DISQ_EXT_DESC          := StringLib.StringToUpperCase('');
			self.DISQ_REASON_REF        := StringLib.StringToUpperCase(trim(l.DRIVERS_DISQUAL_REASON_REFEREN,left,right));
			self.DISQ_REASON_DESC       := StringLib.StringToUpperCase('');
			self.SD_NBR                 := AllZeroClean(StringLib.StringToUpperCase(trim(l.SCHOOL_DISTRICT_NUMBER,left,right)));
			self.WD_CLEAR_REASON_CD     := StringLib.StringToUpperCase(trim(l.WITHDRAWAL_CLEARANCE_REASON,left,right));
			self.WD_CLEAR_REASON_DESC   := StringLib.StringToUpperCase(Tables_CP_OH.WD_CLE_REASON_CODE(self.WD_CLEAR_REASON_CD));
			self.NAIC_INS_CD            := StringLib.StringToUpperCase(trim(l.NAIC_INSURANCE_CODE,left,right));
			self.NAIC_INS_DESC          := StringLib.StringToUpperCase(Tables_CP_OH.INSURANCE_CODE(self.NAIC_INS_CD));
			self.INS_BND_FILING_IND     := StringLib.StringToUpperCase(trim(l.INSURANCE_BOND_FILING_INDICATOR,left,right));
			self.CLEARED_DATE           := StringLib.stringFilter(l.CLEARED_FOR_RESTRICTED_DRIVING, '0123456789');
			self.WD_REASON_CD           := StringLib.StringToUpperCase(trim(l.WITHDRAWAL_REASON_CODE,left,right));
			self.WD_REASON_DESC         := StringLib.StringToUpperCase(Tables_CP_OH.WD_REASON_CODE(SELF.WD_REASON_CD));
			self.REMEDIAL_DRV_CRS_DT    := StringLib.StringToUpperCase(trim(l.DRIVERS_REMEDIAL_DRIVING_COURSE,left,right));
			self.EXAM_DATE              := StringLib.stringFilter(l.DRIVERS_LICENSE_EXAM_DATE, '0123456789');
			self.ACD_OFFENSE_CD         := StringLib.StringToUpperCase(trim(l.ACD_OFFENSE_CODE,left,right));
			self.ACD_OFFENSE_DESC       := StringLib.StringToUpperCase(Tables_CP_OH.ACD_Offense_Codes(self.ACD_OFFENSE_CD));
			self.WD_STATUS_CD           := StringLib.StringToUpperCase(trim(l.WITHDRAWAL_STATUS_CODE,left,right));
			self.WD_STATUS_DESC         := StringLib.StringToUpperCase(Tables_CP_OH.Withdrawal_Status_Code(self.WD_STATUS_CD));
			self.MOD_DRV_DATE           := StringLib.stringFilter(l.MODIFIED_DRIVING_DATE, '0123456789');
			self.SETTLE_AGREE_DATE      := StringLib.stringFilter(l.SETTLEMENT_AGREEMENT_DATE, '0123456789');
			self.RESTRICTION_CD         := StringLib.StringToUpperCase(trim(l.DRIVERS_RESTRICTION_CODE,left,right));
			self.RESTRICTION_DESC       := StringLib.StringToUpperCase(Tables_CP_OH.RESTRICTION_CODE(self.RESTRICTION_CD));
			self.CONVICTION_DATE        := StringLib.stringFilter(l.CONVICTION_DATE, '0123456789');
			self.APPEAL_FILE_DATE       := StringLib.stringFilter(l.APPEAL_FILED_DATE, '0123456789');
			self.APPEAL_DENY_DATE       := StringLib.stringFilter(l.APPEAL_DENIED_DATE, '0123456789');
			self.APPEAL_GRANTED_DATE    := StringLib.stringFilter(l.APPEAL_GRANTED_DATE, '0123456789');
			self.PLEA_CD                := StringLib.StringToUpperCase(trim(l.CONVICTION_PLEA_FLAG,left,right));
			self.PLEA_DESC              := StringLib.StringToUpperCase(Tables_CP_OH.CONVICTION_PLEA_FLAG(self.PLEA_CD));
			self.SUSPENSION_REVOCATION  := StringLib.StringToUpperCase(trim(l.DRIVERS_SUSPENSION_REVOCATION,left,right));
			self.COUNTY_CD              := StringLib.StringToUpperCase(trim(l.COUNTY_NUMBER,left,right));
			self.COUNTY_DESC            := StringLib.StringToUpperCase('');
			self.ARREST_DATE            := StringLib.stringFilter(l.DRIVERS_ARREST_DATE, '0123456789');
			self.LICENSE_NUMBER         := StringLib.StringToUpperCase(trim(l.DRIVERS_LICENSE_NUMBER,left,right));
			self.CREATE_DATE            := StringLib.stringFilter(l.DATABASE_RECORD_CREATE_DATE, '0123456789');
			self.LICENSE_REC_DATE       := StringLib.stringFilter(l.DRIVERS_LICENSE_RECEIVED_DATE, '0123456789');
			self.PLATE_REC_DATE         := StringLib.stringFilter(l.PLATE_RECEIVED_DATE, '0123456789');
			self.FRA_SUP_START_DATE     := StringLib.stringFilter(l.FRA_SUSPENSION_START_DATE, '0123456789');
			self.FRA_SUP_END_DATE       := StringLib.stringFilter(l.FRA_SUSPENSION_END_DATE, '0123456789');
			self.ACCIDENT_DATE          := StringLib.stringFilter(l.DRIVERS_ACCIDENT_DATE, '0123456789');
			self.RELATED_BMV_CASE_NBR   := StringLib.StringToUpperCase(trim(l.RELATED_BMV_CASE_NUMBER_1,left,right));
			self.NARRATIVE_CD           := StringLib.StringToUpperCase(trim(l.NARRATIVE_LITERAL_CODE,left,right));
			self.NARRATIVE_DESC         := StringLib.StringToUpperCase(Tables_CP_OH.NARRATIVE_CODE(self.NARRATIVE_CD));
			self.FEE_REQUIRED           := StringLib.StringToUpperCase(trim(l.FEE_REQUIRED_FLAG,left,right));
			self.VEHICLE_OWNER_IND      := StringLib.StringToUpperCase(trim(l.VEHICLE_OWNER_INDICATOR,left,right));
			self.SOA_CONVICTION         := StringLib.StringToUpperCase(trim(l.SOA_CONV_WITHDRAWAL_OFFENSE,left,right));
			self.EXPUNGED_DATE          := StringLib.stringFilter(l.RECORD_EXPUNGED_DATE, '0123456789');
			self.MODIFIED_DRV_END_DT    := StringLib.stringFilter(l.MODIFIED_DRIVING_END_DATE, '0123456789');
			self.APPEAL_SUP_STAY        := StringLib.StringToUpperCase(trim(l.APPEAL_SUSPENSION_STAY_FLAG,left,right)); 
			self.WD_TYPE_DETAIL         := AllZeroClean(StringLib.StringToUpperCase(trim(l.WITHDRAWAL_TYPE_DETAIL,left,right)));
			self.HP_LICENSE_CANCEL      := StringLib.StringToUpperCase(trim(l.HIGHWAY_PATROL_LIC_CANCELLATION,left,right));
			self.BMV_DL_CASE_NBR        := StringLib.StringToUpperCase(trim(l.BMV_DL_CASE_NUMBER,left,right));
			self.RELATED_BMV_CASE_NBR_2 := StringLib.StringToUpperCase(trim(l.RELATED_BMV_CASE_NUMBER_2,left,right));
			self.FINE_PAID_DATE         := StringLib.stringFilter(l.FIND_PAID_DATE, '0123456789');
			self.CSEA                   := AllZeroClean(StringLib.StringToUpperCase(trim(l.CHILD_SUPPORT_ENFORCE_AGENCY,left,right)));
			self.CSEA_CASE_NBR          := AllZeroClean(StringLib.StringToUpperCase(trim(l.CHILD_SUPPORT_ENFORCE_CASE_NBR,left,right)));
			self.CSEA_ORDER_NBR         := AllZeroClean(StringLib.StringToUpperCase(trim(l.CHILD_SUPPORT_ENFORCE_ORDER_NBR,left,right)));
			self.CSEA_PART_NBR          := AllZeroClean(StringLib.StringToUpperCase(trim(l.CHILD_SUPP_ENF_PARTICIPANT_NBR,left,right)));
			self                        := l;
			self                        := [];	  
   end;
   
   Oh_Suspension := project(file_Oh_Suspension, trfOHToSuspension(left));
   
   export OH_As_Suspension := Oh_Suspension;
   
   //**************** DRIVER RECORD INFORMATION Mapping ********************************************************************
   DR_Info_Type_Cd := Tables_CP_OH.DR_Info_Type_Cd;
   
   in_OH_DR_Info := in_file(trim(DRIVERS_DETAIL_RECORD_TYPE_CODE,left,right) in DR_Info_Type_Cd);
   
   Layout_Oh_DR_Info_out := Layouts_DL_OH_In.Layout_OH_DR_INFo;
   
   Layout_Oh_DR_Info_out trfOHDRInfo(in_OH_DR_Info l) := transform
			self.process_date                    := l.process_date;
			self.KEY_NUMBER                      := Map_Signed_Field(l.KEY_NUMBER);
			self.REC_SEQ_NUM                     := Map_Signed_Field(l.REC_SEQ_NUM);
			self.DRIVER_RECORD_DELETE_DATE       := l.DRIVER_RECORD_DELETE_DATE;
			self.DRIVERS_DETAIL_RECORD_TYPE_CODE := l.DRIVERS_DETAIL_RECORD_TYPE_CODE;
			self.FREE_FORM_NARRATIVE_TEXT        := l.payload[1..150];
			self.RECORD_TYPE_ACTION_DATE         := l.payload[151..158];
			self.DRIVERS_COSIGNERS_RELATIONSHIP  := l.payload[159..159];
			self.DRIVERS_COSIGNERS_NAME          := l.payload[160..194];
			self.COSIGNERS_DRIVERS_LICENSE_NBR   := l.payload[195..202];
			self.MICROFILM_NUMBER                := l.payload[203..208];
			self.DATABASE_RECORD_CREATE_DATE     := l.payload[209..216];
			self.MERGED_FROM_KEYNUMBER           := Map_Signed_Field(l.payload[217..225]);	   
			self.OUT_OF_STATE_DL_DATE_OF_ISSUANCE:= l.payload[226..233];
			self.PERSONS_NEW_STATE_OF_RECORD     := l.payload[234..235];	   
			self.OUT_OF_STATE_DL_NBR             := l.payload[236..260];	   
			self.DRIVERS_LICENSE_NUMBER          := l.payload[261..268];	   
			self.REMEDIAL_REQUIREMENTS_COMPLETE  := l.payload[269..276];
			self.REMEDIAL_REQUIRE_DENIED_DATE    := l.payload[277..284];	   
			self.DOCUMENT_MAILED_DATE            := l.payload[285..292];	   
			self.RECORD_EXPUNGED_DATE            := l.payload[293..300];	   
			self.BMV_CASE_NUMBER                 := l.payload[301..310];	   
			self.COURT_CASE_NUMBER               := l.payload[311..326];	   
			self.COURT_CODE                      := l.payload[327..332];
			self.CLEAR_DATE                      := l.payload[333..340];	   
			self.DRIVERS_BATCH_NUMBER            := l.payload[341..346];	   
			self.PROGRAM_ID                      := l.payload[347..350];	   
			self.SYSTEM_DATE_TIME_STAMP          := l.payload[351..366];	   
			self.USER_IDENTIFICATION_CODE        := l.payload[367..372];	   
			self.WARRANT_BLOCK_EFFECTIVE_DATE    := l.payload[373..380];
			self.NARRATIVE_RECORD_DISPLAY_FLAG   := l.payload[381..381];
			self.REMEDIAL_DRIVING_SCHOOL_CERTIF  := l.payload[382..387]; //string6   
			self.RETENTION_DATE                  := l.payload[388..395];//string8   
			self.COURT_ORDERED_REMEDIAL_COURSE   := l.payload[396..396];//string1   
			self.PAYMENT_PLAN_CODE               := l.payload[397..397];//string1   
			self.PAYMENT_PLAN_START_DATE         := l.payload[398..405];//string8   
			self.PAYMENT_PLAN_END_DATE           := l.payload[406..413];//string8   
			self.MODIFIED_DRIVING_DATE           := l.payload[414..421];//string8   
			self.MODIFIED_DRIVING_END_DATE       := l.payload[422..429];//string8   
			self.NOTIFY_COURT_FLAG               := l.payload[430..430];//string1   
			self.PAYMENT_PLAN_TERMINATION_DATE   := l.payload[431..438];//string8   
			self.FEE_REQUIRED_FLAG               := l.payload[439..439];//string1   
			self.FEE_PAID_DATE                   := l.payload[440..447];//string8   
			self.RELEASE_DATE                    := l.payload[448..455];//string8   
			self.BANKRUPTCY_FLAG                 := l.payload[456..456];//string1   
			self.FAILURE_TO_REINSTATE_DATE       := l.payload[457..464];//string8   
			//self.FILLER                          := l.payload[465..578];//string114 
			self                                 := l;
			self  															 := [];
   end;
  
   export file_Oh_DR_Info := project(in_OH_DR_Info, trfOHDRInfo(left));
   
   Layout_DR_Info_Common := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Driver_Record_Info;
   
   Layout_DR_Info_Common trfOHToDR_Info(file_Oh_DR_Info l) := transform
			self.process_date            := StringLib.stringFilter(l.process_date, '0123456789');
			self.dt_first_seen           := self.process_date;
			self.dt_last_seen            := self.process_date;
			self.src_state               := 'OH';	  
			self.DLCP_KEY                := trim(l.KEY_NUMBER, left, right);
			self.TYPE_CD                 := StringLib.StringToUpperCase(trim(l.DRIVERS_DETAIL_RECORD_TYPE_CODE,left,right));
			self.TYPE_DESC               := StringLib.StringToUpperCase(Tables_CP_OH.RECORD_TYPE_CODE(self.TYPE_CD));
			self.ACTION_DATE             := StringLib.stringFilter(l.RECORD_TYPE_ACTION_DATE, '0123456789');
			self.BMV_CASE_NBR_1          := StringLib.StringToUpperCase(trim(l.BMV_CASE_NUMBER,left,right));
			self.CLEAR_DATE              := StringLib.stringFilter(l.CLEAR_DATE, '0123456789');	  
			self.COSIGNERS_DL_NBR        := StringLib.StringToUpperCase(trim(l.COSIGNERS_DRIVERS_LICENSE_NBR,left,right));      
			self.COSIGNERS_NAME          := StringLib.StringToUpperCase(trim(l.DRIVERS_COSIGNERS_NAME,left,right));	  
			self.COSIGNERS_RELATIONSHIP  := StringLib.StringToUpperCase(trim(l.DRIVERS_COSIGNERS_RELATIONSHIP,left,right));	  
			self.COURT_CASE_NBR          := StringLib.StringToUpperCase(trim(l.COURT_CASE_NUMBER,left,right));
			self.CREATE_DATE             := StringLib.stringFilter(l.DATABASE_RECORD_CREATE_DATE, '0123456789');
			self.DL_NBR                  := StringLib.StringToUpperCase(trim(l.DRIVERS_LICENSE_NUMBER,left,right));
			self.EXPUNGED_DATE           := StringLib.stringFilter(l.RECORD_EXPUNGED_DATE, '0123456789');
			self.MAILED_DATE             := StringLib.stringFilter(l.DOCUMENT_MAILED_DATE, '0123456789');
			self.NARRATIVE               := StringLib.StringToUpperCase(trim(l.FREE_FORM_NARRATIVE_TEXT,left,right));
			self.OUT_OF_STATE_DL_NBR     := StringLib.StringToUpperCase(trim(l.OUT_OF_STATE_DL_NBR,left,right));
			self.REMEDIAL_REQUIRE_COMP   := StringLib.StringToUpperCase(trim(l.REMEDIAL_REQUIREMENTS_COMPLETE,left,right));            
			self.REMEDIAL_REQUIRE_DENIED := StringLib.stringFilter(l.REMEDIAL_REQUIRE_DENIED_DATE, '0123456789');
			self.WARRANT_EFF_DATE        := StringLib.stringFilter(l.WARRANT_BLOCK_EFFECTIVE_DATE, '0123456789');
			self                         := l;
   end;
   
   Oh_DR_Info := project(file_Oh_DR_Info, trfOHToDR_Info(left));
   
   export OH_As_DR_Info := Oh_DR_Info;
   
   //**************** ACCIDENT Mapping *************************************************************************************
   Accident_Type_Cd := Tables_CP_OH.Accident_Type_Cd;
   
   in_OH_Accident := in_file(trim(DRIVERS_DETAIL_RECORD_TYPE_CODE,left,right) in Accident_Type_Cd);
   
   Layout_Oh_Accident_out := Layouts_DL_OH_In.Layout_OH_ACCIDENT;
   
   Layout_Oh_Accident_out trfOHRawToAccident(in_OH_Accident l) := transform
			self.process_date                    := l.process_date;
			self.KEY_NUMBER                      := Map_Signed_Field(l.KEY_NUMBER);
			self.REC_SEQ_NUM                     := Map_Signed_Field(l.REC_SEQ_NUM);
			self.DRIVER_RECORD_DELETE_DATE       := l.DRIVER_RECORD_DELETE_DATE;
			self.DRIVERS_DETAIL_RECORD_TYPE_CODE := l.DRIVERS_DETAIL_RECORD_TYPE_CODE;	   
			self.COUNTY_NUMBER                   := l.payload[1..2];
			self.JURISDICTION_CODE               := l.payload[3..4];
			self.DRIVERS_ACCIDENT_SEVERITY_IND   := l.payload[5..5];
			self.DRIVERS_ACCIDENT_DATE           := l.payload[6..13];	   
			self.DRIVERS_COMMERCIAL_VEHICLE_IND  := l.payload[14..14];
			self.HAZARDOUS_MATERIALS_FLAG        := l.payload[15..15];	   
			self.DRIVERS_REFERENCE_LOCATOR_NBR   := l.payload[16..33];	   
			self.DATABASE_RECORD_CREATE_DATE     := l.payload[34..41];	   
			self.MERGED_FROM_KEYNUMBER           := Map_Signed_Field(l.payload[42..50]);	   
			self.A1_CHANGED_TO_L1_DATE           := l.payload[51..58];	   
			self.BMV_CASE_NUMBER                 := l.payload[59..68];	   
			self.RECORD_EXPUNGED_DATE            := l.payload[69..76];	   
			self.PROGRAM_ID                      := l.payload[77..80];
			self.SYSTEM_DATE_TIME_STAMP          := l.payload[81..96];	   
			self.USER_IDENTIFICATION_CODE        := l.payload[97..102];       
			self.FILLER                          := l.payload[103..578];
			self                                 := l;
   end;
  
   file_Oh_Accident := project(in_OH_Accident, trfOHRawToAccident(left));
   
   Layout_Accident_Common := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Accident;
   
   Layout_Accident_Common trfOHToAccident(file_Oh_Accident l) := transform
			self.process_date       := StringLib.stringFilter(l.process_date, '0123456789');
			self.dt_first_seen      := self.process_date;
			self.dt_last_seen       := self.process_date;
			self.src_state          := 'OH';	  
			self.DLCP_KEY           := trim(l.KEY_NUMBER, left, right);
			self.TYPE_CD            := StringLib.StringToUpperCase(trim(l.DRIVERS_DETAIL_RECORD_TYPE_CODE,left,right));
			self.TYPE_DESC          := StringLib.StringToUpperCase(Tables_CP_OH.RECORD_TYPE_CODE(self.TYPE_CD));
			self.COUNTY             := StringLib.StringToUpperCase(trim(l.COUNTY_NUMBER,left, right));      
			self.JURISDICTION       := StringLib.StringToUpperCase(trim(l.JURISDICTION_CODE,left,right));
			self.SEVERITY_CD        := StringLib.StringToUpperCase(trim(l.DRIVERS_ACCIDENT_SEVERITY_IND,left,right));	  
			self.SEVERITY_DESC      := StringLib.StringToUpperCase(Tables_CP_OH.ACCIDENT_SEVERITY_CODE(self.SEVERITY_CD));
			self.ACCIDENT_DATE      := StringLib.stringFilter(l.DRIVERS_ACCIDENT_DATE, '0123456789');
			self.VEHICLE_NO         := StringLib.StringToUpperCase(trim(l.DRIVERS_COMMERCIAL_VEHICLE_IND,left,right));
			self.HAZARDOUS_CD       := StringLib.StringToUpperCase(trim(l.HAZARDOUS_MATERIALS_FLAG,left,right));
			self.HAZARDOUS_DESC     := StringLib.StringToUpperCase(Tables_CP_OH.HAZARDOUS_MAT_FLAG(self.HAZARDOUS_CD));            
			self.CREATE_DATE        := StringLib.stringFilter(l.DATABASE_RECORD_CREATE_DATE, '0123456789');	  
			self.BMV_CASE_NBR_1     := StringLib.StringToUpperCase(trim(l.BMV_CASE_NUMBER,left, right));
			self.EXPUNGED_DATE      := StringLib.stringFilter(l.RECORD_EXPUNGED_DATE, '0123456789');
			self                    := l;
   end;
   
   Oh_Accident := project(file_Oh_Accident, trfOHToAccident(left));
   
   export OH_As_Accident := Oh_Accident;

   //**************** FRA Insurance Mapping ********************************************************************************
   FRA_Insurance_Type_Cd := Tables_CP_OH.Conviction_Type_Cd + 
														Tables_CP_OH.Suspension_Type_Cd +
														Tables_CP_OH.DR_Info_Type_Cd +
														Tables_CP_OH.Accident_Type_Cd;
   
   in_OH_FRA_Insurance := in_file(trim(DRIVERS_DETAIL_RECORD_TYPE_CODE,left,right) not in FRA_Insurance_Type_Cd);
   
   Layout_Oh_FRA_Insurance_out := Layouts_DL_OH_In.Layout_OH_FRA_Insurance;
   
   Layout_Oh_FRA_Insurance_out trfOHRawToFRA(in_OH_FRA_Insurance l) := transform
			self.process_date                     := l.process_date;
			self.KEY_NUMBER                       := Map_Signed_Field(l.KEY_NUMBER);
			self.REC_SEQ_NUM                      := Map_Signed_Field(l.REC_SEQ_NUM);
			self.DRIVERS_INSURANE_COMPANY_CODE    := Map_Signed_Field(l.DRIVER_RECORD_DELETE_DATE[1..3]);
			self.PROOF_FILING_START_DATE          := trim(l.DRIVER_RECORD_DELETE_DATE[4..8],left, right) + 
																							 trim(l.DRIVERS_DETAIL_RECORD_TYPE_CODE,left, right) +
																							 l.payload[1..1];	   
			self.PROOF_FILING_END_DATE            := l.payload[2..9];
			self.DRIVERS_INSURANCE_POLICY_NBR     := l.payload[10..25];
			self.DRIVERS_PROOF_OF_INS_CANCELATION := l.payload[26..33];
			self.MERGED_FROM_KEYNUMBER            := Map_Signed_Field(l.payload[34..42]);	   
			self.DATABASE_RECORD_CREATE_DATE      := l.payload[43..50];	   
			self.PROGRAM_ID                       := l.payload[51..54];	   
			self.SYSTEM_DATE_TIME_STAMP           := l.payload[55..70];	   
			self.USER_IDENTIFICATION_CODE         := l.payload[71..76];
			self.PROOF_FILING_START_DATE_LATEST   := l.payload[77..84];	   
			self.DRIVERS_PROOF_CANCEL_POSTED_DATE := l.payload[85..92];	   
			self.DRIVERS_PROOF_FILING_POSTED_DATE := l.payload[93..100];
			self.FILLER                           := l.payload[101..578];
			self                                  := l;
   end;
  
   file_Oh_FRA_Insurance := project(in_OH_FRA_Insurance, trfOHRawToFRA(left));
   //output(choosen(file_Oh_FRA_Insurance,100));
   
   Layout_FRA_Common := DriversV2.Layouts_DL_Conv_Points_Common.Layout_FRA_Insurance;
   
   Layout_FRA_Common trfOHToFRA(file_Oh_FRA_Insurance l) := transform
			self.process_date          := StringLib.stringFilter(l.process_date, '0123456789');
			self.dt_first_seen         := self.process_date;
			self.dt_last_seen          := self.process_date;
			self.src_state             := 'OH';	  
			self.DLCP_KEY              := trim(l.KEY_NUMBER, left, right);      
			self.CANCEL_POSTED_DATE    := StringLib.stringFilter(l.DRIVERS_PROOF_CANCEL_POSTED_DATE, '0123456789');
			self.CREATE_DATE           := StringLib.stringFilter(l.DATABASE_RECORD_CREATE_DATE, '0123456789');
			self.FILED_DATE            := StringLib.stringFilter(l.DRIVERS_PROOF_FILING_POSTED_DATE, '0123456789');
			self.INS_CANCEL_DT         := StringLib.stringFilter(l.DRIVERS_PROOF_OF_INS_CANCELATION, '0123456789');	  
			self.INS_POLICY_NBR        := StringLib.StringToUpperCase(trim(l.DRIVERS_INSURANCE_POLICY_NBR,left,right));
			self.INSURANCE_CO_CD       := StringLib.StringToUpperCase(trim(l.DRIVERS_INSURANE_COMPANY_CODE,left,right));
			self.INSURANCE_CO_DESC     := StringLib.StringToUpperCase(Tables_CP_OH.INSURANCE_CODE(self.INSURANCE_CO_CD));            
			self.LATEST_PROOF_START_DT := StringLib.stringFilter(l.PROOF_FILING_START_DATE_LATEST, '0123456789');
			self.PROOF_START_DATE      := StringLib.stringFilter(l.PROOF_FILING_START_DATE, '0123456789');
			self.PROOF_END_DATE        := StringLib.stringFilter(l.PROOF_FILING_END_DATE, '0123456789');
			self                       := l;
   end;
   
   Oh_FRA_Insurance := project(file_Oh_FRA_Insurance, trfOHToFRA(left));
   
   export OH_As_FRA_Insurance := Oh_FRA_Insurance;
	 
	 shared logical_name := DriversV2.Constants.Cluster+'in::dl2::'+pversion+'::OH::';	 

	 VersionControl.macBuildNewLogicalFile( logical_name+'As_Convictions'	,OH_As_Convictions		,Bld_OH_As_Convictions		);
	 VersionControl.macBuildNewLogicalFile( logical_name+'As_Suspension'	,OH_As_Suspension			,Bld_OH_As_Suspension			);
	 VersionControl.macBuildNewLogicalFile( logical_name+'As_DR_Info'			,OH_As_DR_Info				,Bld_OH_As_DR_Info				);
	 VersionControl.macBuildNewLogicalFile( logical_name+'As_Accident'		,OH_As_Accident				,Bld_OH_As_Accident				);
	 VersionControl.macBuildNewLogicalFile( logical_name+'As_Insurance'		,OH_As_FRA_Insurance	,Bld_OH_As_FRA_Insurance	);
	 
	 export Build_DL_OH_Convpoints :=	 
	 sequential (parallel( Bld_OH_As_Convictions
												,Bld_OH_As_Suspension
												,Bld_OH_As_DR_Info
												,Bld_OH_As_Accident
												,Bld_OH_As_FRA_Insurance
											 )
								,sequential( FileServices.StartSuperFileTransaction()
														,fileservices.addsuperfile(DriversV2.Constants.Cluster+'in::dl2::ConvPoints::As_Convictions',logical_name+'As_Convictions')
														,fileservices.addsuperfile(DriversV2.Constants.Cluster+'in::dl2::ConvPoints::As_Suspension',logical_name+'As_Suspension')
														,fileservices.addsuperfile(DriversV2.Constants.Cluster+'in::dl2::ConvPoints::As_DR_Info',logical_name+'As_DR_Info')
														,fileservices.addsuperfile(DriversV2.Constants.Cluster+'in::dl2::ConvPoints::As_Accident',logical_name+'As_Accident')
														,fileservices.addsuperfile(DriversV2.Constants.Cluster+'in::dl2::ConvPoints::As_Insurance',logical_name+'As_Insurance')
														,FileServices.FinishSuperFileTransaction()
													 )
							);			 

end;