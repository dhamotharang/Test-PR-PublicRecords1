IMPORT AutoStandardI, BatchShare, BatchServices, ut;

EXPORT IParam := MODULE

	EXPORT BatchParams := INTERFACE(BatchShare.IParam.BatchParams)
		EXPORT BOOLEAN 		AddSupplemental 					:= FALSE;
		EXPORT BOOLEAN 		ExtraMatchCodes 					:= FALSE;
		EXPORT BOOLEAN 		IncludeBlankDOD 					:= FALSE;
		EXPORT BOOLEAN 		NoDIDAppend 							:= FALSE;
		/* did score thresholds as defined by interface */
		EXPORT UNSIGNED3 	DidScoreThreshold 				:= Constants.DEFAULT_DID_SCORE_THRESHOLD;
		/* enable/disable augmented ADL addr append - see Bug 51541 */
		EXPORT BOOLEAN 		MatchCodeADLAppend 				:= TRUE;
		/* match code filtering */			
		EXPORT BOOLEAN 		PartialNameMatchCodes 		:= FALSE;
		EXPORT STRING 		MatchCodeIncludes 				:= BatchServices.MatchCodes.default_includes;
		EXPORT UNSIGNED2 	DaysBack 									:= 0;
	END;	

	EXPORT getBatchParams() := 
	FUNCTION
		
		mBaseParams := BatchShare.IParam.getBatchParams();
		
		in_mod := module(project(mBaseParams, BatchParams, opt))							
			EXPORT BOOLEAN 		AddSupplemental 				:= FALSE : STORED('AddSupplemental');
			EXPORT BOOLEAN 		ExtraMatchCodes 				:= FALSE : STORED('ExtraMatchCodes');
			EXPORT BOOLEAN 		IncludeBlankDOD 				:= FALSE : STORED('IncludeBlankDOD');
			EXPORT BOOLEAN 		NoDIDAppend 						:= FALSE : STORED('NoDIDAppend');
			EXPORT UNSIGNED3 DidScoreThreshold 			:= Constants.DEFAULT_DID_SCORE_THRESHOLD : STORED('DID_Score_Threshold');
			EXPORT BOOLEAN 		MatchCodeADLAppend 			:= TRUE : STORED('MatchCode_ADL_Append');
			EXPORT BOOLEAN 		PartialNameMatchCodes 	:= FALSE : STORED('PartialNameMatchCodes');
			EXPORT STRING  		MatchCodeIncludes 			:= BatchServices.MatchCodes.default_includes : STORED('MatchCode_Includes');
			EXPORT UNSIGNED2 DaysBack 								:= 0 : STORED('DaysBack');	
		END;
		
		RETURN in_mod;
	END;	
	
	/* death data restrictions */
	
	EXPORT DeathRestrictions := 
	INTERFACE(AutoStandardI.DataPermissionI.params, AutoStandardI.DataRestrictionI.params, AutoStandardI.InterfaceTranslator.industry_class_val.params)	
		EXPORT BOOLEAN UseDeathMasterSSAUpdates := FALSE;
		EXPORT BOOLEAN IsConsumer := FALSE;
		EXPORT BOOLEAN SuppressNonMarketingDeathSources := FALSE;
		EXPORT Integer DeathMasterPurpose := DeathV2_Services.Constants.DeathMasterPurpose.NoPermissibleUse;		
	END;
	
	EXPORT GetDeathRestrictions(inmod) := 
	FUNCTIONMACRO				

		IMPORT AutoStandardI, ut;
		dmod := PROJECT(inmod, DeathV2_Services.IParam.DeathRestrictions, OPT);

		death_mod := MODULE(dmod)	
			EXPORT BOOLEAN UseDeathMasterSSAUpdates := AutoStandardI.DataPermissionI.val(dmod).use_DeathMasterSSAUpdates;
			EXPORT BOOLEAN IsConsumer := AutoStandardI.InterfaceTranslator.industry_class_value.val(dmod) = ut.IndustryClass.Knowx_IC;
			EXPORT BOOLEAN SuppressNonMarketingDeathSources := FALSE : stored('SuppressNonMarketingDeathSources');	
			string5 input_DeathMasterPurpose := '0' : stored('DeathMasterPurpose');	
			EXPORT Integer DeathMasterPurpose := (Integer)input_DeathMasterPurpose;	
		END;		
		
	RETURN death_mod;
	ENDMACRO;	

END;
