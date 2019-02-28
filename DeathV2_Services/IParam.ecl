IMPORT $, BatchShare, BatchServices, doxie;

EXPORT IParam := MODULE

	EXPORT BatchParams := INTERFACE(BatchShare.IParam.BatchParamsV2)
		EXPORT BOOLEAN 		AddSupplemental 					:= FALSE;
		EXPORT BOOLEAN 		ExtraMatchCodes 					:= FALSE;
		EXPORT BOOLEAN 		IncludeBlankDOD 					:= FALSE;
		EXPORT BOOLEAN 		NoDIDAppend 							:= FALSE;
		/* did score thresholds as defined by interface */
		EXPORT UNSIGNED3 	DidScoreThreshold 				:= $.Constants.DEFAULT_DID_SCORE_THRESHOLD;
		/* enable/disable augmented ADL addr append - see Bug 51541 */
		EXPORT BOOLEAN 		MatchCodeADLAppend 				:= TRUE;
		/* match code filtering */			
		EXPORT BOOLEAN 		PartialNameMatchCodes 		:= FALSE;
		EXPORT STRING 		MatchCodeIncludes 				:= BatchServices.MatchCodes.default_includes;
		EXPORT UNSIGNED2 	DaysBack 									:= 0;
	END;	

	EXPORT getBatchParams() := 
	FUNCTION
		
		mBaseParams := BatchShare.IParam.getBatchParamsV2();
		
		in_mod := module(project(mBaseParams, BatchParams, opt))							
			EXPORT BOOLEAN 		AddSupplemental 				:= FALSE : STORED('AddSupplemental');
			EXPORT BOOLEAN 		ExtraMatchCodes 				:= FALSE : STORED('ExtraMatchCodes');
			EXPORT BOOLEAN 		IncludeBlankDOD 				:= FALSE : STORED('IncludeBlankDOD');
			EXPORT BOOLEAN 		NoDIDAppend 						:= FALSE : STORED('NoDIDAppend');
			EXPORT UNSIGNED3 DidScoreThreshold 			:= $.Constants.DEFAULT_DID_SCORE_THRESHOLD : STORED('DID_Score_Threshold');
			EXPORT BOOLEAN 		MatchCodeADLAppend 			:= TRUE : STORED('MatchCode_ADL_Append');
			EXPORT BOOLEAN 		PartialNameMatchCodes 	:= FALSE : STORED('PartialNameMatchCodes');
			EXPORT STRING  		MatchCodeIncludes 			:= BatchServices.MatchCodes.default_includes : STORED('MatchCode_Includes');
			EXPORT UNSIGNED2 DaysBack 								:= 0 : STORED('DaysBack');	
		END;
		
		RETURN in_mod;
	END;	
	
	/* death data restrictions */
	
	EXPORT DeathRestrictions := INTERFACE(doxie.IDataAccess)
		EXPORT BOOLEAN UseDeathMasterSSAUpdates := FALSE;
		EXPORT BOOLEAN SuppressNonMarketingDeathSources := FALSE;
		EXPORT Integer DeathMasterPurpose := DeathV2_Services.Constants.DeathMasterPurpose.NoValue;
	END;
	
  // Create from a module compatible with GlobalModule
	EXPORT GetDeathRestrictions(inmod) := 
	FUNCTIONMACRO				

		IMPORT doxie, ut;
    local mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(inmod);

		death_mod := MODULE(PROJECT (mod_access, DeathV2_Services.IParam.DeathRestrictions, OPT))
			EXPORT boolean UseDeathMasterSSAUpdates := doxie.compliance.use_DM_SSA_updates (DataPermissionMask);
			EXPORT BOOLEAN SuppressNonMarketingDeathSources := FALSE : stored('SuppressNonMarketingDeathSources');	
			STRING10 input_DeathMasterPurpose := '' : stored('DeathMasterPurpose');	
   // converting to integer as we only restrict if it is 0
			EXPORT Integer DeathMasterPurpose := IF(input_DeathMasterPurpose= '', DeathV2_Services.Constants.DeathMasterPurpose.NoValue,ut.BinaryStringToInteger(input_DeathMasterPurpose));	
		END;		
		
	RETURN death_mod;
	ENDMACRO;	

  // Create from a module compatible with IDataAccess
  //TODO: call it from GetDeathRestrictions
  EXPORT GetRestrictions (mod_access) := FUNCTIONMACRO
    IMPORT doxie, ut;
    RETURN MODULE(PROJECT (mod_access, DeathV2_Services.IParam.DeathRestrictions, OPT))
			EXPORT boolean UseDeathMasterSSAUpdates := doxie.compliance.use_DM_SSA_updates (DataPermissionMask);
      EXPORT boolean SuppressNonMarketingDeathSources := FALSE : STORED('SuppressNonMarketingDeathSources');
      string10 input_DeathMasterPurpose := '' : STORED('DeathMasterPurpose');
      // converting to integer as we only restrict if it is 0
      EXPORT integer DeathMasterPurpose := IF(input_DeathMasterPurpose= '', DeathV2_Services.Constants.DeathMasterPurpose.NoValue,ut.BinaryStringToInteger(input_DeathMasterPurpose));
    END;
  ENDMACRO;

END;
