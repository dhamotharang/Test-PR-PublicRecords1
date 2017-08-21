import crim_common, crim_cp_ln, _validate,hygenics_soff;

Layout_Court_Offenses_ECL_Cade_id := RECORD
INTEGER ecl_cade_id;
INTEGER ecl_charge_id;
hygenics_soff.Layout_common_Offense;
hygenics_soff.Layout_out_main_cross.orig_dl_number;
hygenics_soff.Layout_out_main_cross.orig_dl_state;
//hygenics_soff.layout_out_main_cross.case_number;
//hygenics_soff.layout_out_main_cross.case_type_desc;
crim_cp_ln.Layout_cross_case_master.OLD_RECORD_SUPPLIER_CD_C;
crim_cp_ln.Layout_cross_case_master.RECORD_SUPPLIER_CD_C;
string20 court_ID;
end;

Layout_Case_Master_and_Moxie_Court_Offenses := RECORD
CM_CASE_NUM := MapPrimOffenderToCaseMaster.CASE_NUM_C ;
// CM_DOB := MapPrimOffenderToCaseMaster.DOB;
// CM_SSN := MapPrimOffenderToCaseMaster.SSN;
// CM_NC_DOB := MapPrimOffenderToCaseMaster.NC_DOB;
CM_SOURCE_UID := MapPrimOffenderToCaseMaster.source_uid_c;
Layout_Court_Offenses_ECL_Cade_id;
END;


Layout_Case_Master_and_Moxie_Court_Offenses tr_Attach_CM_Constants_Court_offenses(MapPrimOffenderToCaseMaster L, File_Court_Offenses_ECL_Cade_id R) := TRANSFORM
SELF.CM_CASE_NUM := L.CASE_NUM_C;
// SELF.CM_DOB := L.DOB;																																	 
// SELF.CM_SSN := L.SSN;
// SELF.CM_NC_DOB := L.NC_DOB;
SELF.CM_SOURCE_UID := L.SOURCE_UID_C;
SELF := R;
END;


ds_CaseMasterCourtOffenses := JOIN(MapPrimOffenderToCaseMaster,File_Court_Offenses_ECL_Cade_id,
																			LEFT.ecl_cade_id=RIGHT.ecl_cade_id,
																			 tr_Attach_CM_Constants_Court_offenses(LEFT,RIGHT)); 

Layout_CriminalCharges_Offender_key := Layout_criminal_charges_cp;

Layout_CriminalCharges_Offender_key  tr_CourtOffensesToCrimCharges(ds_CaseMasterCourtOffenses L) 
                                                    := TRANSFORM//, SKIP(L.CASE_NUMBER<>L.COURT_CASE_NUMBER AND L.COURT_CASE_NUMBER <> '')


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
													 


SELF.ECL_CADE_ID := L.ECL_CADE_ID;
SELF.ECL_CHARGE_ID := L.ECL_CHARGE_ID; 
SELF.OFFENDER_KEY := L.seisint_primary_KEY;
SELF.CRCH_ID_C := '';
SELF.ORIGINAL_CHARGE_C_A_X := '';
SELF.ORIGINAL_CHARGE_NUMBER_OCCUR := '';
//SELF.ORIGINAL_CHARGE_F     := ORIGINAL_CHARGE_F;
SELF.ORIGINAL_CHARGE_SHORT := '';
//SELF.ORIGINAL_CODE_SECTION := ORIGINAL_CODE_SECTION;
//SELF.ORIGINAL_CASE_TYPE_C  := ORIGINAL_CASE_TYPE_C;
SELF.ORIGINAL_CHARGE_QUALIFIER_FLG := '';
SELF.ORIGINAL_CHARGE_CLASS_FLG_F   := '';
SELF.AMENDED_CHARGE_C_A_X          := '';
SELF.AMENDED_CHARGE_NUMBER_OCCUR   := '';
SELF.AMENDED_CHARGE_C      := trim(L.offense_description)+' '+trim(L.offense_description_2);
SELF.AMENDED_CHARGE_SHORT  := '';
SELF.AMENDED_CODE_SECTION  := trim(L.offense_code_or_statute);
SELF.AMENDED_CASE_TYPE     := trim(L.offense_level);//trim(L.offense_category);
SELF.AMENDED_CHARGE_QUALIFIER_FLG := '';
SELF.AMENDED_CHARGE_CLASS_FLG     := '';
SELF.CHARGE_DELETION_FLG          := '';//L.off_delete_flag;
SELF.DISPOSITION                  := '';
SELF.DISPOSITION_DT               :=  IF(_validate.date.fIsValid(L.disposition_dt)=true,L.disposition_dt,'');
SELF.DISPOSITION_MSG              := '';//IF(L.court_final_plea <> '','PLEA: ' + TRIM(L.court_final_plea),'');
SELF.COUNT_TYPE                   := '';
SELF.CHARGE_COUNT                 := '';//L.num_of_counts;
SELF.APPEAL_DT_F                  := '';
SELF.OFFENSE_DT_C                 := IF(_validate.date.fIsValid(L.offense_date)=true,L.offense_date,'');
SELF.OFFENSE_TOWN_C               := l.offense_location;
SELF.OFFENSE_DESCRIPTION_C        := '';
SELF.OFFENSE_LEVEL_NUM            := '';
SELF.ORIG_PLEA_CD                 := '';//IF(LENGTH(TRIM(L.court_final_plea))= 2, TRIM(L.court_final_plea), TRIM(L.court_final_plea[1..2]));
SELF.ORIG_PLEA_DT                 := '';
SELF.PLEA_WITHDRAWN_DT            := '';
SELF.NEW_PLEA_CD                  := '';
SELF.CONCLUDED_BY_CD              := '';
SELF.DRIVERS_LICENSE_NUMBER_F     := IF(L.orig_dl_number <> '', TRIM(L.orig_dl_number),''); 
SELF.DRIVERS_LICENSE_STATE_CD_F   := IF(L.orig_dl_state <> '', TRIM(L.orig_dl_state),''); 
SELF.CAMA_CASE_NUM                := TRIM(L.CM_CASE_NUM);
SELF.CAMA_SOURCE_UID              := L.CM_SOURCE_UID;                       
SELF.CAMA_CASE_SUBJECT_SEQ        := '1';
SELF.CREATED_BY                   := 'HPCCLOAD';
SELF.CREATION_DT                  := StringLib.GetDateYYYYMMDD();
SELF.LAST_UPDATED_BY              := '';
SELF.LAST_UPDATE_DT               := '';
SELF.RECORD_SUPPLIER_CD_C         := L.RECORD_SUPPLIER_CD_C;
SELF.BATCH_NUMBER                 := '';
SELF.ARREST_DISPOSITION_DT_F      := '';
SELF.ARREST_DISPOSITION_MSG_F     := '';																																 
SELF.COURT_LOCATION_C             := L.conviction_jurisdiction ; 																				
SELF.CAUSE_NUMBER_C               := L.court_case_number;
SELF.COURT_PROVISION_C            := '';
SELF.DISPOSITION_DURING_APPEAL    := '';
SELF.FINAL_DECISION_ON_APPEAL     := '';
SELF.SENTENCE_STATUS_CHG_DT_C     := '';
SELF.AGENCY_RECEIVING_CUSTODY     := '';
SELF.PROSECUTOR_LOCATION          := '';
SELF.PROSECUTOR_CASE_REFFER_TO    := '';	
SELF.CHARGE_REJECTED_DT           := '';
SELF.PROSECUTOR_ACTION            := '';//TRIM(l.pros_act_filed);
SELF.PROSECUTOR_OFFENSE           := '';																									  
SELF.PROSECUTION_CASE_TYPE        := '';																 
SELF.PROSECUTE_GENERAL_OFFENSE_CHAR := '';
SELF.OTHER_CONVICTION_OFFENSE       := '';
SELF.PRIM_INDICTMENT_OFFENSE        := '';
SELF.PRIM_INDICTMENT_CLASS          := '';
SELF.ARRAIGNED_OFFENSE        			:= '';
SELF.ARRAIGNED_CASE_TYPE_C    			:= '';
SELF.ARRAIGNED_CODE_SECTION_C 			:= '';
SELF.CALLED_AND_FAILED_DT     			:= '';
SELF.FAILURE_TO_APPEAR_DT     			:= '';
SELF.METHOD_OF_DISPOSITION_CD 			:= '';
SELF.NON_MV_FAIL_TO_COMPLY_DT 			:= '';
SELF.MV_FAILURE_TO_COMPLY_DT  			:= '';
SELF.SHOW_CAUSE_ORDER_DT      			:= '';
SELF.OFFENDER_TYPE            			:= '';
SELF.OLD_RECORD_SUPPLIER_CD   			:= L.OLD_RECORD_SUPPLIER_CD_C;
SELF.CHARGE_FILE_DT           			:= IF(_validate.date.fIsValid(L.arrest_date)=true,L.arrest_date,'');
SELF.PROSECUTOR_CODE_SECTION  			:= '';
SELF.CAPIAS_DT                			:= '';
SELF.REARREST_DT              			:= '';
SELF.BOND_HEARING_DT          			:= '';
SELF.PROS_DECISION_DT         			:= '';
SELF.CHARGE_REOPEN_DT         			:= '';
SELF.CHG_REOPEN_CLOSE_DT      			:= '';
SELF.PRIM_INDICTMENT_NUMBER  			  := '';
SELF.REOPEN_REASON           			  := '';
SELF.CHECKED_DT_C             			:= '';
SELF.CLOSEOUT_DT_C            			:= '';
SELF.REFERENCE_INFO           			:= '';
SELF.CUSTODY_DT_C             			:= '';
SELF.ADMIT_DT_C               			:= '';
//SCHEDULED RELEASE DATE: 20110408                                                                                                                                                    
 release_dt :=                   MAP(regexfind('(SCHEDULED RELEASE DATE: )(.*)(;)(.*)',trim(L.sentence_description_2)	) => 	regexreplace('(SCHEDULED RELEASE DATE: )(.*)(;)(.*)',trim(L.sentence_description_2),'$2'),	
		                                 regexfind('(.*)(;) (SCHEDULED RELEASE DATE: )(.*)$',trim(L.sentence_description_2)	)   => 	regexreplace('(.*)(;) (SCHEDULED RELEASE DATE: )(.*)$'  ,trim(L.sentence_description_2),'$4'),	
									                   regexfind('(SCHEDULED RELEASE DATE: )(.*)$',trim(L.sentence_description_2)	)   => 	regexreplace('(SCHEDULED RELEASE DATE: )(.*)$'  ,trim(L.sentence_description_2),'$2'),	
												             '');  	
SELF.RELEASE_DT_C             			:= IF(_validate.date.fIsValid(release_dt)=true,release_dt,'');
SELF.CONVICT_DT_C             			:= IF(_validate.date.fIsValid(l.conviction_date)=true,l.conviction_date,'');
SELF.NC_OFFENSE_DT            			:= IF(_validate.date.fIsValid(L.offense_date)=false,L.offense_date,'');
SELF.NC_DISPOSITION_DT        			:= IF(_validate.date.fIsValid(L.disposition_dt)=false,L.disposition_dt,'');
SELF.CHARGE_INFO              			:= '';
SELF.CUSTODY_INFO             			:= '';
SELF.OFFENSE_STATUS           			:= '';
SELF := [];
END;
		
ds_CriminalCharges := PROJECT(ds_CaseMasterCourtOffenses,tr_CourtOffensesToCrimCharges(LEFT));
  
export MapCourtOffensesToCriminalCharges := //SORT(ds_CriminalCharges,ecl_cade_id,ecl_charge_id)
                                                                  ds_CriminalCharges
                                                                    : persist ('~thor_data400::persist::out::crim::cross_aoc_and_county::MapCourtOffensesToCriminalCharges');   
                                                                                             
                                                                                             



