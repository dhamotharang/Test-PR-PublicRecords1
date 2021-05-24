import PublicRecords_KEL, risk_indicators, fcra, MDR, faa, fcra, doxie_files, std, SexOffender, dx_prof_license_mari, doxie, watercraft, bankruptcyv2, ln_propertyv2, RiskView, AVM_V2;
IMPORT KEL13 AS KEL;

//please note
//FCRA overrides are NOT archivable


EXPORT FCRA_Overrides(PublicRecords_KEL.Interface_Options Options,
											PublicRecords_KEL.Join_Interface_Options JoinFlags) := MODULE 

SHARED Layouts_FDC  := PublicRecords_KEL.ECL_Functions.Layouts_FDC(Options);
SHARED NotRegulated := PublicRecords_KEL.ECL_Functions.Constants.NotRegulated;
SHARED BlankString  := PublicRecords_KEL.ECL_Functions.Constants.BlankString;
SHARED SetDPMBitmap := PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.SetValue;
SHARED CFG_File     := PublicRecords_KEL.KEL_Queries_MAS_Shared.C_Compile;
SHARED GLBARegulatedDeathMasterRecord(STRING glb_flag) := glb_flag = 'Y';
SHARED DPPARegulatedWaterCraftRecord(STRING dppa_flag) := IF(TRIM(dppa_flag, LEFT, RIGHT) = 'Y', TRUE, FALSE);	
SHARED LN_PropertyV2_Src(STRING ln_fares_id) := MDR.sourceTools.fProperty(ln_fares_id);
SHARED Common       := PublicRecords_KEL.ECL_Functions.Common(Options, JoinFlags);
SHARED restrictedStates := fcra.compliance.watercrafts.restricted_states;	// need consumer permission

SHARED ArchiveDate(string datevalue_in1, string datevalue_in2 = '' ):= function
	
	DateValue := TRIM(datevalue_in1);
	DateValue2 := TRIM(datevalue_in2);
	
	datechooser(string datevalue) := function
	
	cleanDate := PublicRecords_KEL.ECL_Functions.Fn_Clean_Date((STRING) TRIM(DateValue))[1];
	cleanDate2 := PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(DateValue[1..6]+'01')[1];
	validDatechooser := MAP( (STRING)DateValue NOT IN ['', '0'] AND cleanDate.yearfilled and cleanDate.Monthfilled and cleanDate.dayfilled and cleanDate.DateValid => (STRING) DateValue,//if we have a full valid date keep it
													(STRING)DateValue NOT IN ['', '0'] and length(TRIM(DateValue)) = 7 and cleanDate2.DateValid  => cleanDate2.ValidPortion_01,//if we have a YYYYMMD number keep [1..6] + 01 cleaned if its valid
														(STRING)DateValue IN ['', '0'] OR (INTEGER)cleanDate.ValidPortion_01 = 0 OR REGEXFIND('[^0-9.]',  DateValue, NOCASE)=> '',//if the date is cleaned to 00000000 or is not numeric set to ''
														cleanDate.ValidPortion_01);	//else keep it, this should only be good dates			


		
	return validDatechooser;
	end;
	
	date1 := datechooser(datevalue);
	
return If(date1 = '', datechooser(datevalue2), date1);	
	
end;	

EXPORT GetOverrideFlags(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) shell) := function


	PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII_Overrides add_flags(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII_Overrides le, PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII ri) := TRANSFORM
		// NOTE: this code was borrowed from --->>> LIB_InstantID_Function_FCRA and adaped for MAS
		// After dempsey all corrections have been tied to a lexid so we no longer need to join to the ssn override keys

		// ssn_flags := CHOOSEN (fcra.key_override_flag_ssn (l_ssn=le.P_InpClnSSN, datalib.NameMatch (le.P_InpClnNameLast, le.P_InpClnNameMid, le.P_InpClnNameFirst, fname, mname, lname)<3), PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT);

	did_flags := CHOOSEN (fcra.key_override_flag_did (keyed (l_did=(string)le.p_lexid) and record_id not in set(le.consumerstatements, recidforstid) ), PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT);
	flags := PROJECT (did_flags, fcra.Layout_override_flag);
	flagrecs := CHOOSEN (dedup (flags, ALL), PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT);//1000
		
			//record_id - suppressions
			//ffid - corrections
			
	//around august 2020 the suppression records that were previously kept in the flag did key will be moved completly over to person context and delteed from the flag key.
	//after this change the override keys will only have correction records
	//the below statements for suppressions bled context and flag id together. 
	
	
		
	// for each datagroup, add back the record_id we already have obtained from personContext search earlier
	SELF.advo_correct_ffid              := SET(flagrecs(file_id = FCRA.FILE_ID.advo),flag_file_id);
	SELF.advo_correct_record_id         := SET(flagrecs(file_id = FCRA.FILE_ID.advo),record_id) + le.advo_correct_record_id ;
	
	SELF.air_correct_ffid               := SET(flagrecs(file_id = FCRA.FILE_ID.AIRCRAFT),flag_file_id);
	SELF.air_correct_RECORD_ID          := SET(flagrecs(file_id = FCRA.FILE_ID.AIRCRAFT),record_id) + le.air_correct_RECORD_ID ;
	
	SELF.avm_correct_ffid               := SET(flagrecs(file_id = FCRA.FILE_ID.AVM),flag_file_id);
	SELF.avm_correct_RECORD_ID          := SET(flagrecs(file_id = FCRA.FILE_ID.AVM),record_id) + le.avm_correct_RECORD_ID ;	
	
	SELF.avm_medians_correct_ffid               := SET(flagrecs(file_id = FCRA.FILE_ID.avm_medians),flag_file_id);
	SELF.avm_medians_correct_RECORD_ID          := SET(flagrecs(file_id = FCRA.FILE_ID.avm_medians),record_id) + le.avm_medians_correct_RECORD_ID ;
	
	SELF.bankrupt_correct_ffid          := SET(flagrecs(file_id = FCRA.FILE_ID.BANKRUPTCY),flag_file_id);
	SELF.bankrupt_correct_cccn          :=  le.bankrupt_correct_cccn ;//the way we find suppression records is different than corrected
	SELF.bankrupt_correct_RECORD_ID 		:= SET(flagrecs(file_id = FCRA.FILE_ID.BANKRUPTCY),record_id);//the way we find suppression records is different than corrected

	SELF.crim_correct_ofk               := SET(flagrecs(file_id = FCRA.FILE_ID.OFFENDERS),record_id)+ 
																					SET(flagrecs(file_id = FCRA.FILE_ID.COURT_OFFENSES),record_id)+
																					SET(flagrecs(file_id = FCRA.FILE_ID.OFFENSES),record_id)+le.crim_correct_ofk ;
																				//fcra.functions.GetSexOffendersIDs(le.did, flagrecs(file_id = FCRA.FILE_ID.SO_MAIN))//old shell has SO data mas does not right now, just in case we add it later
	
	SELF.crim_correct_ffid              := SET(flagrecs(file_id = FCRA.FILE_ID.OFFENDERS),flag_file_id) + 
																					SET(flagrecs(file_id = FCRA.FILE_ID.COURT_OFFENSES),flag_file_id) + 
																					SET(flagrecs(file_id = FCRA.FILE_ID.OFFENSES),flag_file_id); 
																				 // SET(flagrecs(file_id = FCRA.FILE_ID.SO_MAIN),flag_file_id);	//old shell has SO data mas does not right now, just in case we add it later																				 
	
	self.Death_correct_ffid  						:= SET(flagrecs(file_id = FCRA.FILE_ID.DID_DEATH),flag_file_id);
	self.Death_correct_record_id  			:= SET(flagrecs(file_id = FCRA.FILE_ID.DID_DEATH),record_id) + le.Death_correct_record_id ;
	
	SELF.email_data_correct_ffid        := SET(flagrecs(file_id = FCRA.FILE_ID.email_data),flag_file_id);
	SELF.email_data_correct_record_id   := SET(flagrecs(file_id = FCRA.FILE_ID.email_data),record_id) + le.email_data_correct_record_id ;	
	
	SELF.gong_correct_ffid              := SET(flagrecs(file_id = FCRA.FILE_ID.GONG),flag_file_id);
	SELF.gong_correct_record_id         := SET(flagrecs(file_id = FCRA.FILE_ID.GONG),record_id) + le.gong_correct_record_id ;
	
	//header is different and does odd things, it is corrected in PublicRecords_KEL.MAS_get.Header_Corrections_Function_Roxie
	SELF.header_correct_record_id       := SET(flagrecs(file_id = FCRA.FILE_ID.hdr),record_id) + le.header_correct_record_id ;
	
	SELF.inquiries_correct_ffid         := SET(flagrecs(file_id = FCRA.FILE_ID.inquiries),flag_file_id);
	SELF.inquiries_correct_record_id    := SET(flagrecs(file_id = FCRA.FILE_ID.inquiries),record_id) + le.inquiries_correct_record_id ;	
	
	SELF.infutor_correct_ffid           := SET(flagrecs(file_id = FCRA.FILE_ID.INFUTOR),flag_file_id);
	SELF.infutor_correct_record_id      := SET(flagrecs(file_id = FCRA.FILE_ID.INFUTOR),record_id) + le.infutor_correct_record_id ;
	
	SELF.lien_correct_ffid              := SET(flagrecs(file_id = FCRA.FILE_ID.LIEN),flag_file_id);	
	SELF.lien_correct_tmsid_rmsid       := SET(flagrecs(file_id = FCRA.FILE_ID.LIEN),record_id) + le.lien_correct_tmsid_rmsid ;
	
	SELF.prop_correct_ffid              := SET(flagrecs(file_id = FCRA.FILE_ID.ASSESSMENT),flag_file_id) +
																					SET(flagrecs(file_id = FCRA.FILE_ID.DEED),flag_file_id) +
																					SET(flagrecs(file_id = FCRA.FILE_ID.SEARCH),flag_file_id);	
	
	SELF.prop_correct_lnfare            := SET(flagrecs(file_id = FCRA.FILE_ID.ASSESSMENT),record_id) +
																					SET(flagrecs(file_id = FCRA.FILE_ID.DEED),record_id) + 
																					SET(flagrecs(file_id = FCRA.FILE_ID.SEARCH),record_id) + le.prop_correct_lnfare ;	
	
	SELF.proflic_correct_ffid           := SET(flagrecs(file_id = FCRA.FILE_ID.PROFLIC),flag_file_id) +
																					SET(flagrecs(file_id = FCRA.FILE_ID.MARI),flag_file_id); //+ le.proflic_correct_RECORD_ID ;
																					
	SELF.proflic_correct_RECORD_ID      := SET(flagrecs(file_id = FCRA.FILE_ID.PROFLIC),record_id) + 
																					SET(flagrecs(file_id = FCRA.FILE_ID.MARI),record_id)+ le.proflic_correct_RECORD_ID;	//since we can sup on persistent rec id in mari and prof lic key in pl I think we want this here instead
																						//you can be in both which means we need to check override key for suppressions and suppress before we get overrides
	


	
	SELF.student_correct_ffid           := SET(flagrecs(file_id = FCRA.FILE_ID.STUDENT),flag_file_id) + SET(flagrecs(file_id = FCRA.FILE_ID.STUDENT_alloy),flag_file_id);
	SELF.student_correct_RECORD_ID      := SET(flagrecs(file_id = FCRA.FILE_ID.STUDENT),record_id)    + SET(flagrecs(file_id = FCRA.FILE_ID.STUDENT_alloy),record_id) + le.student_correct_RECORD_ID ;	
	

	SELF.water_correct_ffid             := SET(flagrecs(file_id = FCRA.FILE_ID.WATERCRAFT),flag_file_id)  ;
	SELF.water_correct_RECORD_ID        := SET(flagrecs(file_id = FCRA.FILE_ID.WATERCRAFT),record_id)+ le.water_correct_RECORD_ID;		
	
	SELF.thrive_correct_ffid             := SET(flagrecs(file_id = FCRA.FILE_ID.THRIVE),flag_file_id)  ;
	SELF.thrive_correct_record_id        := SET(flagrecs(file_id = FCRA.FILE_ID.THRIVE),record_id)+ le.thrive_correct_record_id;	
	
	SELF.SexOffender_correct_ffid             := SET(flagrecs(file_id = FCRA.FILE_ID.so_offenses),flag_file_id)  ;
	SELF.SexOffender_correct_record_id        := SET(flagrecs(file_id = FCRA.FILE_ID.so_offenses),record_id)+ le.SexOffender_correct_record_id;	
	
	//the below are not used in mas but keeping them here just in case since they were already coded in the boca shell
	// SELF.impulse_correct_ffid           := SET(flagrecs(file_id = FCRA.FILE_ID.IMPULSE),flag_file_id);
	// SELF.impulse_correct_record_id      := SET(flagrecs(file_id = FCRA.FILE_ID.IMPULSE),record_id) + le.impulse_correct_record_id ;
		
		//not needed for mas	
	// SELF.paw_correct_ffid               := SET(flagrecs(file_id = FCRA.FILE_ID.paw),flag_file_id);
	// SELF.paw_correct_record_id          := SET(flagrecs(file_id = FCRA.FILE_ID.paw),record_id) + le.paw_correct_record_id ;	
	
		//deleted a long time ago
	// SELF.ibehavior_correct_ffid					:= SET(flagrecs(file_id in [FCRA.FILE_ID.ibehavior_consumer,FCRA.FILE_ID.ibehavior_purchase]),flag_file_id) ;
	// SELF.ibehavior_correct_record_id		:= SET(flagrecs(file_id in [FCRA.FILE_ID.ibehavior_consumer,FCRA.FILE_ID.ibehavior_purchase]),record_id) + le.ibehavior_correct_record_id ;	
	
	//not needed for mas
	// SELF.ssn_correct_ffid               := SET(flagrecs(file_id = FCRA.FILE_ID.ssn),flag_file_id);
	// SELF.ssn_correct_record_id          := SET(flagrecs(file_id = FCRA.FILE_ID.ssn),record_id) + le.ssn_correct_record_id ;		
	
	//nonFCRA only... not sure why this is here??
	// SELF.veh_correct_ffid               := SET(flagrecs(file_id = FCRA.FILE_ID.VEHICLE),flag_file_id);
	// SELF.veh_correct_vin                := SET(flagrecs(file_id = FCRA.FILE_ID.VEHICLE),record_id) + le.veh_correct_vin;
	
		
		self.p_lexid := le.p_lexid;
		self.G_ProcUID := le.G_ProcUID;
		
		SELF.ConsumerFlags := le.ConsumerFlags;
		SELF.ConsumerStatements := le.ConsumerStatements;
		SELF := le;
		self := ri;
		SELF := [];
	END;

	PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII_Overrides add_flags_blanks(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII le) := TRANSFORM
		self := le;
		SELF := [];
	end;	
	
		in_context := project(shell,transform(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII_Overrides, self := left; self :=[];));
				
		getPersonContext := if(options.isFCRA AND common.DoFDCJoin_Overrides, PublicRecords_KEL.MAS_get.checkPersonContext_MAS(GROUP(in_context,G_ProcUID), options.gateways, options.IntendedPurpose));
		with_personcontext := ungroup(getPersonContext);
		
		final_FCRA := Join(with_personcontext, shell, 
						left.p_lexid = right.p_lexid and
						left.G_ProcUID = right.G_ProcUID,
							add_flags (left,right), left outer);
			
	with_overrides := if((unsigned)shell[1].p_inpclnarchdt[1..8] = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and Options.isFCRA AND common.DoFDCJoin_Overrides, final_FCRA, PROJECT(shell, add_flags_blanks(LEFT)));
				
	return with_overrides;	
	
end;
	
EXPORT GetOverrideAdvo(DATASET( Layouts_FDC.LayoutAddressGeneric_inputs) shell) := function

 advo_rec := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER P_lexid;
    FCRA.Layout_Override_ADVO;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.advo_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.advo_correct_record_id;
  end;
	
	advo_corrections_data := join(shell, FCRA.Key_Override_ADVO_FFID,
									keyed(right.flag_file_id in left.advo_correct_ffid),
									transform(advo_rec,
										self := right;
										self := left,
										self := []),
									atmost(PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT));
										
	
	advo_corrections_data_clean := project(advo_corrections_data, transform(Layouts_FDC.Layout_ADVO__Key_Addr1_History,
						SELF.Src := MDR.sourceTools.src_advo_valassis,
						SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_advo_valassis, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),					
						self.Archive_Date := '';	
						self.date_first_seen :=  archivedate((string)left.date_first_seen);
						SELF := left,
						SELF := []));
			
	return advo_corrections_data_clean;	
	
end;


EXPORT GetOverrideAircraft(DATASET( Layouts_FDC.Layout_FDC) shell) := function

  aircraft_rec := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER P_lexid;
    faa.layout_aircraft_registration_out_Persistent_ID;
    string20 flag_file_id;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.air_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.air_correct_RECORD_ID;
  end;

	reg_corrected := join(shell, fcra.key_override_faa.aircraft,//this key is empty
                       keyed (Right.flag_file_id IN Left.air_correct_ffid),
                       	TRANSFORM(aircraft_rec,
													self := right,
													SELF := left,
													SELF := []), 
                        atmost(PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT_SLIM));
												
		
	reg_corrected_data_clean := project(reg_corrected, transform(Layouts_FDC.Layout_FAA__key_aircraft_id,
						SELF.Src := MDR.sourceTools.src_Aircrafts,
						SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Aircrafts, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
						self.Archive_Date := '';		
						self.date_first_seen :=  archivedate((string)left.date_first_seen);
						SELF := left,
						SELF := []));	
	
	return reg_corrected_data_clean;	
	
end;

EXPORT GetOverrideAVM(DATASET( Layouts_FDC.LayoutAddressGeneric_inputs) shell) := function
 
 avm_rec := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER P_lexid;
    fcra.layout_override_avm;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.avm_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.avm_correct_RECORD_ID;
  end;
	
	avm_corr := join(shell, FCRA.Key_Override_AVM_FFID,
										keyed(right.flag_file_id in left.avm_correct_ffid),
											TRANSFORM(avm_rec,
												self := right,
												SELF := left,
												SELF := []), 
											atmost(PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT_SLIM));
		
		
	avm_corr_data_clean := project(avm_corr, transform(Layouts_FDC.Layout_AVM_V2_Key_AVM_Address_Norm_Records,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.AVM,
					SELF.DPMBitmap := SetDPMBitmap( Source := PublicRecords_KEL.ECL_Functions.Constants.AVM, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF.history_date :=  ArchiveDate(left.recording_date),// doing this so our avm overrides have some kind of date to get past the asof statement, not ideal but without it kel will drop these on the floor
					self.Archive_Date := '';									
					SELF := left,
					SELF := []));		
	
	return avm_corr_data_clean;	

end;

EXPORT GetOverrideAVMMedians(DATASET( Layouts_FDC.LayoutAddressGeneric_inputs) shell) := function
 
 avm_medians_rec := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER P_lexid;
    AVM_V2.layouts.Layout_Override_AVM_Medians;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.avm_medians_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.avm_medians_correct_record_id;
		string history_date;
  end;
	
	avm_medians_corr := join(shell, FCRA.Key_Override_AVM.avm_medians,
										keyed(right.flag_file_id in left.avm_medians_correct_ffid),
											TRANSFORM(avm_medians_rec,
												self := right,
												SELF := left,
												SELF := []), 
											atmost(PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT_SLIM));
		
		
	avm_medians_corr_data_clean := project(avm_medians_corr, transform(Layouts_FDC.Layout_AVM_V2_Key_AVM_Medians_Norm_Records,
					SELF.Src := PublicRecords_KEL.ECL_Functions.Constants.AVM,
					SELF.DPMBitmap := SetDPMBitmap( Source := PublicRecords_KEL.ECL_Functions.Constants.AVM, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					SELF.history_date :=  ArchiveDate((STRING)STD.Date.Today()),// doing this so our avm overrides have some kind of date to get past the asof statement, not ideal but without it kel will drop these on the floor
					self.Archive_Date := '';									
					SELF := left,
					SELF := []));		
	
	return avm_medians_corr_data_clean;	

end;


EXPORT GetOverrideBanko(DATASET( Layouts_FDC.Layout_FDC) shell) := function
 	
 bankoSearch_lay := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER P_lexid;
		bankruptcyv2.layout_bankruptcy_search_v3;
		string20 flag_file_id;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.bankrupt_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.bankrupt_correct_RECORD_ID;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.bankrupt_correct_cccn;
  end; 

	bk_corr := join(shell, fcra.key_override_bkv3_search_ffid,
										// keyed(right.flag_file_id = left.flag_file_id),
									keyed(right.flag_file_id IN left.bankrupt_correct_ffid),
										transform(bankoSearch_lay, 
													self := right,
													SELF := left,
													SELF := []), 
									atmost(PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT_SLIM));
									
							
	bk_corr_data_clean := project(bk_corr, transform(Layouts_FDC.Layout_BankruptcyV3__key_bankruptcyv3_search,
					SELF.Src := MDR.sourceTools.src_Bankruptcy,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Bankruptcy, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.date_first_seen :=  archivedate((string)left.date_first_seen);
					self.Archive_Date := '';									
					SELF := left,
					SELF := []));		

	return bk_corr_data_clean;	
	
end;

EXPORT GetOverrideCrimOffenders(DATASET( Layouts_FDC.Layout_FDC) shell) := function
 
 
 crimOffenderslay := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER P_lexid;
		recordof(doxie_files.key_offenders(true));
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.crim_correct_ofk;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.crim_correct_ffid;
  end;
 
	crim_corr_Offenders := join(shell, fcra.Key_Override_Crim.Offenders,
													keyed(right.flag_file_id IN left.crim_correct_ffid),
														TRANSFORM(crimOffenderslay,
															SELF := right,
															SELF := left,
															SELF := []), 
														atmost(PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT_SLIM));
														
	Doxie_Files__Key_Offenders_Src(STRING data_type) := CASE(data_type,
				'1' => MDR.sourceTools.src_Accurint_DOC, //DC
				'2' => MDR.sourceTools.src_Accurint_Crim_Court,//CC
				'5' => MDR.sourceTools.src_Accurint_Arrest_Log, //AL
					'');	
	
							
	crim_corr_Offenders_data_clean := project(crim_corr_Offenders, transform(Layouts_FDC.Layout_Doxie_Files__Key_Offenders,
					SELF.src := CASE(left.data_type,
											'1' => MDR.sourceTools.src_Accurint_DOC, //DC
											'2' => MDR.sourceTools.src_Accurint_Crim_Court,//CC
											'5' => MDR.sourceTools.src_Accurint_Arrest_Log, //AL
												'');
					SELF.DPMBitmap := SetDPMBitmap( Source := Doxie_Files__Key_Offenders_Src(left.data_type), FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.fcra_date :=   archivedate(left.fcra_date);
					self.Archive_Date := '';												
					SELF := left,
					SELF := []));		
	
	return crim_corr_Offenders_data_clean;	
	
end;


EXPORT GetOverrideCrimOffenses(DATASET( Layouts_FDC.Layout_FDC) shell) := function


crimOffenseslay := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER P_lexid;
		recordof (doxie_files.key_offenses (true));
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.crim_correct_ofk;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.crim_correct_ffid;
  end;
 
	crim_corr_offenses := join(shell, fcra.Key_Override_Crim.offenses,//empty
													keyed(right.flag_file_id IN left.crim_correct_ffid),
														TRANSFORM(crimOffenseslay,
															SELF := right,
															SELF := left,
															SELF := []), 
														atmost(PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT_SLIM));	
	
	
	crim_corr_offenses_data_clean := project(crim_corr_offenses, transform(Layouts_FDC.Layout_Doxie_Files__Key_Offenses,
					SELF.Src := MDR.sourceTools.src_Accurint_DOC,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Accurint_DOC, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := '';	
					self.fcra_date :=  archivedate(left.fcra_date);
					SELF := left,
					SELF := []));		
	
	return crim_corr_offenses_data_clean;	
	
end;

EXPORT GetOverrideCrimCourt(DATASET( Layouts_FDC.Layout_FDC) shell) := function

crimCourtlay := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER P_lexid;
		recordof (doxie_files.key_court_offenses (true));
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.crim_correct_ofk;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.crim_correct_ffid;
  end;
 
	crim_corr_Court := join(shell, fcra.Key_Override_Crim.court_offenses,//empty
											keyed(right.flag_file_id IN left.crim_correct_ffid),
                       	TRANSFORM(crimCourtlay,
													SELF := right,
													SELF := left,
													SELF := []), 
                        atmost(PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT_SLIM));	
				
	crim_corr_Court_data_clean := project(crim_corr_Court, transform(Layouts_FDC.Layout_Doxie_files__Key_Court_Offenses,
					SELF.Src := MDR.sourceTools.src_Accurint_Crim_Court,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Accurint_Crim_Court, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.fcra_date := archivedate( left.fcra_date);
					self.Archive_Date := '';					
					SELF := left,
					SELF := []));		
	
	return crim_corr_Court_data_clean;	
	
end;


EXPORT GetOverrideSexOffenders(DATASET( Layouts_FDC.Layout_FDC) shell) := function

//not used in mas as of june 2020 putting this here for later.

SOCourtlay := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER P_lexid;
		string20 flag_file_id;
		recordof(SexOffender.key_SexOffender_SPK(TRUE));
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.SexOffender_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.SexOffender_correct_record_id;
  end;
 

 //see Risk_Indicators.Boca_Shell_SO_FCRA for rest of exclusion logic when added so keys to FDC code
	SO_corr_Court := join(shell, fcra.key_override_sexoffender.so_main,//this key is empty
											keyed(right.flag_file_id IN left.SexOffender_correct_ffid),
														TRANSFORM(SOCourtlay,
															SELF := right,
															SELF := left,
															SELF := []), 
														atmost(PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT_SLIM));	
	

	SO_data_clean := project(SO_corr_Court, transform(Layouts_FDC.Layout_SexOffender__Key_SexOffender_SPK,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,						
					SELF.Src := MDR.sourceTools.src_sexoffender;
					SELF.DPMBitmap :=SetDPMBitmap( Source := MDR.sourceTools.src_sexoffender, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.dt_first_reported :=  archivedate((string)left.dt_first_reported) ;
					self.Archive_Date := '';
					SELF := left,
					SELF := []));		
						
	return SO_data_clean;	
	
end;

EXPORT GetOverrideDeath(DATASET( Layouts_FDC.Layout_FDC) shell) := function
 
	Deathlay := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER P_lexid;
		recordof (doxie.key_death_masterV2_ssa_DID_fcra);
		string20 flag_file_id;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.Death_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.Death_correct_record_id;
	end;
				
	
				
	Death_corr := join(shell, FCRA.key_override_death_master.did_death,//this key is empty
											keyed(right.flag_file_id in left.Death_correct_ffid),
												TRANSFORM(Deathlay,
													SELF := right,
													SELF := left,
													SELF := []), 
												atmost(PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT_SLIM)); 
 	

	Death_corr_corr_data_clean := project(Death_corr, transform(Layouts_FDC.Layout_Doxie__Key_Death_MasterV2_SSA_DID,
					SELF.Src := left.src,
					SELF.DPMBitmap := SetDPMBitmap( Source := left.src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := GLBARegulatedDeathMasterRecord(left.glb_flag), Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),	
					self.dod8 :=  archivedate((string)left.dod8);
					self.Archive_Date := '';					
					SELF := left,
					SELF := []));		
	
	return Death_corr_corr_data_clean;	
	
end;

EXPORT GetOverrideEmail(DATASET( Layouts_FDC.Layout_FDC) shell) := function

Emaillay := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER P_lexid;
		FCRA.Layout_Override_Email_Data;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.email_data_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.email_data_correct_record_id;
  end;

	emailfile_corrections := join(shell, fcra.Key_Override_Email_Data_ffid,
															keyed(right.flag_file_id in left.email_data_correct_ffid),
																TRANSFORM(Emaillay,
																	SELF := right,
																	SELF := left,
																	SELF := []), 
																atmost(PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT_SLIM));	
		
		
	emailfile_corrections_data_clean := project(emailfile_corrections, transform(Layouts_FDC.Layout_Email_Data__Key_Did_FCRA,
					SELF.Src := left.Email_SRC,
					SELF.DPMBitmap :=SetDPMBitmap( Source := left.Email_SRC, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.date_first_seen := archivedate(  (string)left.date_first_seen);
					self.Archive_Date := '';					
					SELF := left,
					SELF := []));		

	
	return emailfile_corrections_data_clean;	
	
end;


EXPORT GetOverrideGong(DATASET( Layouts_FDC.Layout_FDC) shell) := function

	Gonglay := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER P_lexid;
		fcra.Layout_Override_Gong;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.gong_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.gong_correct_record_id;
  end;
 
	gong_correct := join(shell, FCRA.Key_Override_Gong_FFID,
											keyed(right.flag_file_id in left.gong_correct_ffid),
                       	TRANSFORM(Gonglay,
													SELF := right,
													SELF := left,
													SELF := []), 
                        atmost(PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT_SLIM));	
		
	gong_correct_data_clean := project(gong_correct, transform(Layouts_FDC.Layout_Gong__Key_History_DID,
				SELF.Src := left.Src,
				SELF.DPMBitmap := SetDPMBitmap( Source := left.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
				SELF.Listing_Type := TRIM(left.Listing_Type_Bus + left.Listing_Type_Res + left.Listing_Type_Gov, ALL),
				self.Archive_Date := '';			
				self.dt_first_seen :=  archivedate((string)left.dt_first_seen);
				SELF := left,
				SELF := []));		
	
	return gong_correct_data_clean;	
	
end;

EXPORT GetOverrideInquiry(DATASET( Layouts_FDC.Layout_FDC) shell) := function

	Inquirylay := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER P_lexid;
		FCRA.Layout_Override_Inquiries;
  end;
 
 
	inq_correct := join(shell, fcra.Key_Override_Inquiries_ffid, 
						keyed(right.flag_file_id in left.inquiries_correct_ffid) and
							((trim(std.str.ToUpperCase(RIGHT.search_info.function_description)) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.FCRA_Functions)	AND 
							(trim(RIGHT.bus_intel.use) = PublicRecords_KEL.ECL_Functions.AccLogs_Constants.Check_Bus_Intel_Uses) AND 
							(trim(RIGHT.search_info.product_code) IN PublicRecords_KEL.ECL_Functions.AccLogs_Constants.valid_product_codes)),
							TRANSFORM(Inquirylay,
													SELF := right,
													SELF := left,
													SELF := []), 
							atmost(5000));	//special for inq
 				
	inq_correct_data_clean := project(inq_correct, transform(Layouts_FDC.Layout_Inquiry_AccLogs__Key_FCRA_DID,
					SELF.DateOfInquiry := left.Search_Info.DateTime[1..8];
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs;
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := '';					
					SELF := left,
					SELF := []));		
	
	return inq_correct_data_clean;	
	
end;

EXPORT GetOverrideInfutor(DATASET( Layouts_FDC.Layout_FDC) shell) := function

	Infutorlay := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER P_lexid;
		FCRA.Layout_Override_Infutor;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.infutor_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.infutor_correct_record_id;
  end;
 
 
	infutor_correct := join(shell, FCRA.Key_Override_Infutor_FFID,
												keyed(right.flag_file_id in left.infutor_correct_ffid),
												TRANSFORM(Infutorlay,
													SELF := right,
													SELF := left,
													SELF := []), 
												atmost(PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT_SLIM)); 
 		
	infutor_correct_data_clean := project(infutor_correct, transform(Layouts_FDC.Layout_InfutorCID__Key_Infutor_Phone,
					SELF.Src := MDR.sourceTools.src_InfutorCID,
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InfutorCID, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.dt_first_seen := (integer)archivedate((string)left.dt_first_seen);
					self.Archive_Date := '';					
					SELF := left,
					SELF := []));		
	
	return infutor_correct_data_clean;	
	
end;


EXPORT GetOverrideLiensParty(DATASET( Layouts_FDC.Layout_FDC) shell) := function

	LiensPartylay := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER P_lexid;
		FCRA.Layout_Override_Liensv2_party;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.lien_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.lien_correct_tmsid_rmsid;
  end;
 
	Liens_Party_correct := join(shell, fcra.key_Override_liensv2_party_ffid,
											keyed(right.flag_file_id IN left.lien_correct_ffid) and 
											left.P_Lexid=(unsigned)right.did,
												TRANSFORM(LiensPartylay,
													SELF := right,
													SELF := left,
													SELF := []), 
												atmost(PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT)); 	
												
	//permissions are applied in the DENORMALIZE for liens								 						
	Liens_Party_correct_data_clean := project(Liens_Party_correct, transform(Layouts_FDC.Layout_LiensV2_Key_Liens_Party_ID_Records,
					self.Archive_Date := '';	
					self.DPMBitmap := SetDPMBitmap( Source := PublicRecords_KEL.ECL_Functions.Constants.Set_Liens_Sources(left.TMSID), FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated , DPPA_Restricted := NotRegulated, DPPA_State :=blankstring, KELPermissions := CFG_File);
					self.date_first_seen :=  archivedate((string)left.date_first_seen);
					SELF := left,
					SELF := []));		
	
	return Liens_Party_correct_data_clean;	
	
end;

EXPORT GetOverrideLiensMain(DATASET( Layouts_FDC.Layout_FDC) shell) := function
 
	LiensMainlay := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER P_lexid;
		FCRA.Layout_Override_Liensv2_main;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.lien_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.lien_correct_tmsid_rmsid;
	end;
												
	Liens_Main_correct := join(shell, fcra.key_Override_liensv2_main_ffid,
											keyed(right.flag_file_id IN left.lien_correct_ffid),  
												TRANSFORM(LiensMainlay,
													SELF := right,
													SELF := left,
													SELF := []), 
												atmost(PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT)); 
												
 	//permissions are applied in the DENORMALIZE for liens					
	Liens_Main_correct_data_clean := project(Liens_Main_correct, transform(Layouts_FDC.Layout_LiensV2_key_liens_main_ID_Records,
					self.Archive_Date := '';	
					self.DPMBitmap := SetDPMBitmap( Source := PublicRecords_KEL.ECL_Functions.Constants.Set_Liens_Sources(left.TMSID), FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated , DPPA_Restricted := NotRegulated, DPPA_State :=blankstring, KELPermissions := CFG_File);
					SELF := left,
					SELF := []));		
	
	return Liens_Main_correct_data_clean;	
	
end;

EXPORT GetOverridePropAssess(DATASET( Layouts_FDC.Layout_FDC) shell) := function
 
	PropAssesslay := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER P_lexid;
		string20 flag_file_id;
		ln_propertyv2.layout_property_common_model_base;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.prop_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.prop_correct_lnfare;
	end;
				
	PropAssess_correct := join(shell, FCRA.key_override_property.assessment,
											keyed(right.flag_file_id in left.prop_correct_ffid),
												TRANSFORM(PropAssesslay,
													SELF := right,
													SELF := left,
													SELF := []), 
												atmost(PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT_SLIM)); 
	
	
 	//permissions are applied in the next join for PL					
	PropAssess_correct_data_clean := project(PropAssess_correct, transform(Layouts_FDC.Layout_PropertyV2_Key_Assessor_Fid_Records,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := LN_PropertyV2_Src(left.ln_fares_id),
					SELF.fireplace_indicator := left.fireplace_indicator = 'Y',
					SELF.ln_mobile_home_indicator := left.ln_mobile_home_indicator = 'Y',
					SELF.ln_condo_indicator := left.ln_condo_indicator = 'Y',
					SELF.ln_property_tax_exemption := left.ln_property_tax_exemption = 'Y',
					SELF.current_record := left.current_record = 'Y',
					SELF.owner_occupied := left.owner_occupied = 'Y',
					SELF.date_first_seen := (unsigned) MAP(	ArchiveDate(left.tax_year, left.assessed_value_year) <> ''  => ArchiveDate(left.tax_year, left.assessed_value_year),
																							ArchiveDate(left.market_value_year, left.certification_date) <> ''  => ArchiveDate(left.market_value_year, left.certification_date),
																							ArchiveDate(left.tape_cut_date, left.recording_date) <> ''  => ArchiveDate(left.tape_cut_date, left.recording_date),
																							ArchiveDate(left.prior_recording_date, left.sale_date));
					SELF.DPMBitmap := SetDPMBitmap( Source := LN_PropertyV2_Src(left.ln_fares_id), FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File, Marketing_State := left.State_Code),
					self.Archive_Date := '';					
					self := left;
					SELF := []));		
	
	return PropAssess_correct_data_clean;	
	
end;

EXPORT GetOverridePropDeed(DATASET( Layouts_FDC.Layout_FDC) shell) := function
 
	PropDeedlay := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER P_lexid;
		string20 flag_file_id;
		ln_propertyv2.layout_deed_mortgage_common_model_base;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.prop_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.prop_correct_lnfare;
	end;
				
	PropDeed_correct := join(shell, FCRA.key_override_property.deed,
											keyed(right.flag_file_id in left.prop_correct_ffid),
												TRANSFORM(PropDeedlay,
													SELF := right,
													SELF := left,
													SELF := []), 
												atmost(PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT_SLIM)); 

												
 	//permissions are applied in the next join for PL					
	PropDeed_correct_data_clean := project(PropDeed_correct, transform(Layouts_FDC.Layout_PropertyV2_Key_Deed_Fid_Records,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.current_record := LEFT.current_record = 'Y',
					SELF.timeshare_flag := LEFT.timeshare_flag = 'Y',
					SELF.addl_name_flag := LEFT.addl_name_flag = 'Y',
					SELF.Date_First_Seen :=  (INTEGER)ArchiveDate((string)left.contract_date,(string)left.recording_date),
					SELF.Src := LN_PropertyV2_Src(LEFT.ln_fares_id),
					SELF.DPMBitmap :=SetDPMBitmap( Source := LN_PropertyV2_Src(left.ln_fares_id), FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File, Marketing_State := left.State),
					self.Archive_Date := '';					
					self := left;
					SELF := []));		
	
	return PropDeed_correct_data_clean;	
	
end;

EXPORT GetOverridePropSearch(DATASET( Layouts_FDC.Layout_FDC) shell) := function
 
	PropSearchlay := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER P_lexid;
		string20 flag_file_id;
		ln_propertyv2.layout_search_building;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.prop_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.prop_correct_lnfare;
	end;
				
	PropSearch_correct := join(shell, FCRA.key_override_property.search,
											keyed(right.flag_file_id in left.prop_correct_ffid),
												TRANSFORM(PropSearchlay,
													SELF := right,
													SELF := left,
													SELF := []), 
												atmost(PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT_SLIM)); 
												
 	//we do not have dateselector on this dataset	
	PropSearch_correct_data_clean := project(PropSearch_correct, transform(Layouts_FDC.Layout_PropertyV2_Key_Search_Fid_Records,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.Src := LN_PropertyV2_Src(left.ln_fares_id),
					SELF.PartyIsBuyerOrOwner := left.source_code[1] = 'O',
					SELF.PartyIsBorrower := left.source_code[1] = 'B',
					SELF.PartyIsSeller := left.source_code[1] = 'S',
					SELF.PartyIsCareOf := left.source_code[1] = 'C',
					SELF.OwnerAddress := left.source_code[2] = 'O',
					SELF.SellerAddress := left.source_code[2] = 'S',
					SELF.PropertyAddress := left.source_code[2] = 'P',
					SELF.BorrowerAddress := left.source_code[2] = 'B',
					SELF.DPMBitmap := SetDPMBitmap( Source := LN_PropertyV2_Src(left.ln_fares_id), FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File, Marketing_State := left.ST),
					self := left;
					SELF := []));		
	
	return PropSearch_correct_data_clean;	
	
end;

EXPORT GetOverrideProfLic(DATASET( Layouts_FDC.Layout_FDC) shell) := function
 
	ProfLiclay := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER P_lexid;
		FCRA.Layout_Override_ProfLic;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.proflic_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.proflic_correct_RECORD_ID
	end;
				
	ProfLic_correct := join(shell, FCRA.key_override_proflic_ffid,
											keyed(right.flag_file_id in left.proflic_correct_ffid),
												TRANSFORM(ProfLiclay,
													SELF := right,
													SELF := left,
													SELF := []), 
												atmost(PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT_SLIM)); 

												
 	//permissions are applied in the next join for PL					
	ProfLic_correct_data_clean := project(ProfLic_correct, transform(Layouts_FDC.Layout_Prof_LicenseV2__Key_Proflic_Did,
					SELF.did := (INTEGER)left.did,
					SELF.Src := MDR.sourceTools.src_Professional_License;
					self.Archive_Date := '';					
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Professional_License, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File, Generic_Restriction := left.vendor = RiskView.Constants.directToConsumerPL_sources),
					self.date_first_seen :=  archivedate((string)left.date_first_seen);
					SELF := left,
					SELF := []));		
	
	return ProfLic_correct_data_clean;	
	
end;

EXPORT GetOverrideMari(DATASET( Layouts_FDC.Layout_FDC) shell) := function
 
	Marilay := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER P_lexid;
		recordof(dx_prof_license_mari.layouts.i_did) - [global_sid,record_sid];
    string20 flag_file_id;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.proflic_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.proflic_correct_RECORD_ID;
	end;
				
	Mari_correct := join(shell, FCRA.Key_Override_Proflic_Mari_ffid.proflic_mari,
											keyed(right.flag_file_id in left.proflic_correct_ffid),
												TRANSFORM(Marilay,
													SELF := right,
													SELF := left,
													SELF := []), 
												atmost(PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT_SLIM)); 

	
	//permissions are applied in the next join for PL
	Mari_correct_data_clean := project(Mari_correct, transform(Layouts_FDC.Layout_Prof_License_Mari__Key_Did,
					self.Archive_Date := '';					
					SELF.Src := MDR.sourceTools.src_Mari_Prof_Lic;
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_Mari_Prof_Lic, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File, Generic_Restriction := left.std_source_upd IN Risk_Indicators.iid_constants.restricted_Mari_vendor_set),
					self.date_first_seen :=  archivedate((string)left.date_first_seen);
					SELF := left,
					SELF := []));		
	
	return Mari_correct_data_clean;	
	
end;


EXPORT GetOverrideAmericanStudent(DATASET( Layouts_FDC.Layout_FDC) shell) := function
 
	AmericanStudentlay := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER P_lexid;
		fcra.Layout_Override_Student_New;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.student_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.student_correct_RECORD_ID;
	end;

				
	AmericanStudent_correct := join(shell, FCRA.Key_Override_Student_New_FFID,
										keyed(right.flag_file_id in left.student_correct_ffid),
												TRANSFORM(AmericanStudentlay,
													SELF := right,
													SELF := left,
													SELF := []), 
												atmost(PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT_SLIM)); 
 	
	
	AmericanStudent_correct_data_clean := project(AmericanStudent_correct, transform(Layouts_FDC.Layout_American_student_list__key_DID,
					SELF.DPMBitmap := SetDPMBitmap( Source := left.source, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated , DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),			
					self.Archive_Date := '';
					self.date_first_seen :=  archivedate((string)left.date_first_seen);
					SELF := left,
					SELF := []));		
	
	return AmericanStudent_correct_data_clean;	
	
end;


EXPORT GetOverrideAlloyStudent(DATASET( Layouts_FDC.Layout_FDC) shell) := function
 
	AlloyStudentlay := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER P_lexid;
		fcra.layout_override_alloy AND NOT tier2;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.student_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.student_correct_RECORD_ID;
	end;

				
	AlloyStudent_correct := join(shell, FCRA.Key_Override_Alloy_FFID,
    keyed(right.flag_file_id in left.student_correct_ffid),
												TRANSFORM(AlloyStudentlay,
													SELF := right,
													SELF := left,
													SELF := []), 
												atmost(PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT_SLIM)); 
 	
	
	AlloyStudent_correct_data_clean := project(AlloyStudent_correct, transform(Layouts_FDC.Layout_AlloyMedia_student_list__key_DID,
					SELF.DPMBitmap := SetDPMBitmap( Source := left.source, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated , DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := '';
					self.date_first_seen :=  archivedate((string)left.date_first_seen);
					SELF := left,
					SELF := []));		
	
	return AlloyStudent_correct_data_clean;	
	
end;

EXPORT GetOverrideThrive(DATASET( Layouts_FDC.Layout_FDC) shell) := function
 
	Thrivelay := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER P_lexid;
		FCRA.Layout_Override_thrive;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.thrive_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.thrive_correct_record_id;
	end;

				
	Thrive_correct := join(shell, FCRA.Key_Override_Thrive_ffid.thrive,//this key is empty
    keyed(right.flag_file_id in left.thrive_correct_ffid),
												TRANSFORM(Thrivelay,
													SELF := right,
													SELF := left,
													SELF := []), 
												atmost(PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT_SLIM)); 
 	
	
	
	Thrive_correct_data_clean := project(Thrive_correct, transform(Layouts_FDC.Layout_Thrive__Key___Did_QA,
					SELF.Src := left.src;
					SELF.DPMBitmap := SetDPMBitmap( Source := left.Src, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := '';	
					self.dt_first_seen :=  (integer)archivedate( (string)left.dt_first_seen);
					SELF := left,
					SELF := []));		
					
	return Thrive_correct_data_clean;	
	
end;

EXPORT GetOverrideWatercraft(DATASET( Layouts_FDC.Layout_FDC) shell) := function
 
	Watercraftlay := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER P_lexid;
	  string20 flag_file_id;
    recordof (watercraft.key_watercraft_sid (true)) - [global_sid,record_sid];
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.water_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.water_correct_RECORD_ID;
	end;

				
	Watercraft_correct := join(shell, FCRA.Key_Override_Watercraft.sid,
    keyed(right.flag_file_id in left.water_correct_ffid) and
		((Options.IsPrescreen AND right.state_origin not in restrictedStates) or ~Options.IsPrescreen),
											TRANSFORM(Watercraftlay,
													SELF := right,
													SELF := left,
													SELF := []), 
												atmost(PublicRecords_KEL.ECL_Functions.Constants.MAX_OVERRIDE_LIMIT_SLIM)); 
 	
	
	Watercraft_correct_data_clean := project(Watercraft_correct, transform(Layouts_FDC.Layout_Watercraft__Key_Watercraft_SID,
					SELF.Src := MDR.sourceTools.fWatercraft(left.source_Code, left.state_origin);
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.fWatercraft(left.source_Code, left.state_origin), FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := DPPARegulatedWaterCraftRecord(left.dppa_flag), DPPA_State := BlankString, KELPermissions := CFG_File),											
					self.Archive_Date := '';
					self.date_first_seen :=  archivedate((string)left.date_first_seen);
					SELF := left,
					SELF := []));		
					
	return Watercraft_correct_data_clean;	
	
end;

end;
