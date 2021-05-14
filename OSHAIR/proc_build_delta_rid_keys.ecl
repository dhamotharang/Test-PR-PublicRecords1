import doxie, Tools, BIPV2, dx_OSHAIR, RoxieKeyBuild, dops;

export proc_build_delta_rid_keys(string pversion) :=
function

  // Build New Delta Rid Keys
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local( dx_OSHAIR.keys_delta_rid.accident
																						 ,DATASET([],OSHAIR.layout_oshair_accident_clean)//OSHAIR.Files().Base.Accident.Built
																						 ,dx_OSHAIR.names().delta_rid_accident
																						 ,dx_OSHAIR.names(pversion,false).delta_rid_accident_New
																				 		 ,DeltaRidAccidentKey);  
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local( dx_OSHAIR.keys_delta_rid.hazardous_substance
																						 ,DATASET([],OSHAIR.layout_oshair_hazardous_substance_clean)//OSHAIR.Files().Base.Hazardous.Built
																						 ,dx_OSHAIR.names().delta_rid_hazardous_substance
																						 ,dx_OSHAIR.names(pversion,false).delta_rid_hazardous_substance_New
																				 		 ,DeltaRidHazSubKey);																					 
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local( dx_OSHAIR.keys_delta_rid.inspection
																						 ,DATASET([],OSHAIR.layout_oshair_inspection_clean_BIP)//OSHAIR.Files().Base.Inspection.Built
																						 ,dx_OSHAIR.names().delta_rid_inspection
																						 ,dx_OSHAIR.names(pversion,false).delta_rid_inspection_New
																				 		 ,DeltaRidInspectionKey);			
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local( dx_OSHAIR.keys_delta_rid.program
																						 ,DATASET([],OSHAIR.layout_oshair_program_clean)//OSHAIR.Files().Base.Program.Built
																						 ,dx_OSHAIR.names().delta_rid_program
																						 ,dx_OSHAIR.names(pversion,false).delta_rid_program_New
																				 		 ,DeltaRidProgramKey);	
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local( dx_OSHAIR.keys_delta_rid.violations
																						 ,DATASET([],OSHAIR.layout_oshair_violations_clean)//OSHAIR.Files().Base.Violations.Built
																						 ,dx_OSHAIR.names().delta_rid_violations
																						 ,dx_OSHAIR.names(pversion,false).delta_rid_violations_New
																				 		 ,DeltaRidViolationsKey);		
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local( dx_OSHAIR.keys_delta_rid.autokey_payload
																						 ,DATASET([],OSHAIR.layout_oshair_inspection_clean_BIP)//OSHAIR.Files().Base.Inspection.Built
																						 ,dx_OSHAIR.names().delta_rid_autokey_payload
																						 ,dx_OSHAIR.names(pversion,false).delta_rid_autokey_payload_New
																				 		 ,DeltaRidAKPayloadKey);			
																						 
  // Move Delta Rid Keys to Built
	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::oshair::inspection::delta_rid'
																				,'~thor_data400::key::oshair::'+pversion+'::inspection::delta_rid'
																				,mv2blt_insp);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::oshair::program::delta_rid'
																				 ,'~thor_data400::key::oshair::'+pversion+'::program::delta_rid'
																				 ,mv2blt_pgm);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::oshair::violations::delta_rid'
																				,'~thor_data400::key::oshair::'+pversion+'::violations::delta_rid'
																				,mv2blt_viol);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::oshair::hazardous_substance::delta_rid'
																				,'~thor_data400::key::oshair::'+pversion+'::hazardous_substance::delta_rid'
																				,mv2blt_haz_sub);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::oshair::accident::delta_rid'
																				,'~thor_data400::key::oshair::'+pversion+'::accident::delta_rid'
																				,mv2blt_acc);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::oshair::autokey_payload::delta_rid'
																				,'~thor_data400::key::oshair::'+pversion+'::autokey_payload::delta_rid'
																				,mv2blt_ak);																			

	// Move Keys to QA
	RoxieKeyBuild.mac_sk_move('~thor_data400::key::oshair::inspection::delta_rid','Q',mv2qa_insp);
	RoxieKeyBuild.mac_sk_move('~thor_data400::key::oshair::program::delta_rid','Q',mv2qa_pgm);
	RoxieKeyBuild.mac_sk_move('~thor_data400::key::oshair::violations::delta_rid','Q',mv2qa_viol);
	RoxieKeyBuild.mac_sk_move('~thor_data400::key::oshair::hazardous_substance::delta_rid','Q',mv2qa_haz_sub);
	RoxieKeyBuild.mac_sk_move('~thor_data400::key::oshair::accident::delta_rid','Q',mv2qa_acc);
	RoxieKeyBuild.mac_sk_move('~thor_data400::key::oshair::autokey_payload::delta_rid','Q',mv2qa_ak);

											 
	full_build :=
	
	sequential(
	     // Build Delta Rid keys
			 DeltaRidAccidentKey
		  ,DeltaRidHazSubKey
			,DeltaRidInspectionKey
			,DeltaRidProgramKey
			,DeltaRidViolationsKey
			,DeltaRidAKPayloadKey
			// Move Delta Rid keys to built
			,parallel( mv2blt_insp
							 ,mv2blt_pgm
							 ,mv2blt_viol
							 ,mv2blt_haz_sub
							 ,mv2blt_acc
							 ,mv2blt_ak)
			// Move Delta Rid keys to qa
			,parallel( mv2qa_insp
							 ,mv2qa_pgm
							 ,mv2qa_viol
							 ,mv2qa_haz_sub
							 ,mv2qa_acc
							 ,mv2qa_ak)
	);
		
	return full_build;

end;