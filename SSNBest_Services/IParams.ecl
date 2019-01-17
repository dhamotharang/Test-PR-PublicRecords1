IMPORT SSNBest_Services,BatchShare,ut;
EXPORT IParams := MODULE

	EXPORT HardCodedFlags := INTERFACE
		EXPORT BOOLEAN   suppress_and_mask  := TRUE;
		EXPORT BOOLEAN   check_RNA_         := FALSE;
	END;

	EXPORT BatchParams := INTERFACE(BatchShare.IParam.BatchParams,HardCodedFlags)
		EXPORT BOOLEAN   Display_HRI        := FALSE;
	  EXPORT UNSIGNED3 DIDScoreThreshold  := SSNBest_Services.Constants.DIDScoreThreshold;
		EXPORT BOOLEAN   IsGlbRequired      := FALSE;
	END;

	EXPORT getBatchParams() := FUNCTION
		base_params := BatchShare.IParam.getBatchParams();
		in_mod := MODULE(PROJECT(base_params, BatchParams, OPT))
			EXPORT BOOLEAN   Display_HRI        := FALSE : STORED('Display_HRI');
			EXPORT UNSIGNED3 DIDScoreThreshold  := SSNBest_Services.Constants.DIDScoreThreshold : STORED('DIDScoreThreshold'); //internal
			EXPORT BOOLEAN   IsGlbRequired      := FALSE : STORED('IsGlbRequired');
			EXPORT TYPEOF(BatchShare.IParam.BatchParams.IncludeMinors) IncludeMinors:= FALSE : STORED('IncludeMinors'); 
		END;
		RETURN in_mod;
	END;

	//used to call SSNBest_Services.Functions.fetchSSNs_generic - currently used in ADL_Best - DidVille.MAC_BestAppend & doxie.best_records
	EXPORT SSNBestParams := INTERFACE(HardCodedFlags)
		EXPORT TYPEOF(BatchShare.IParam.BatchParams.GLBPurpose)          GLBPurpose          := BatchShare.Constants.Defaults.GLBPurpose;
	  EXPORT TYPEOF(BatchShare.IParam.BatchParams.DPPAPurpose)         DPPAPurpose         := BatchShare.Constants.Defaults.DPPAPurpose;
	  EXPORT TYPEOF(BatchShare.IParam.BatchParams.DataRestrictionMask) DataRestrictionMask := BatchShare.Constants.Defaults.DataRestrictionMask;
	  EXPORT TYPEOF(BatchShare.IParam.BatchParams.ApplicationType)     ApplicationType     := BatchShare.Constants.Defaults.ApplicationType;
	  EXPORT TYPEOF(BatchShare.IParam.BatchParams.industryclass)       industryclass       := ut.IndustryClass.UTILI_IC; //we restrict it by default 'UTILI'
	  EXPORT TYPEOF(BatchShare.IParam.BatchParams.ssn_mask)            ssn_mask            := BatchShare.Constants.Defaults.SSNMask; //'NONE'
	  EXPORT TYPEOF(BatchShare.IParam.BatchParams.IncludeMinors)       IncludeMinors       := FALSE;
	END;

	//this function is called to set the interface parameters before calling SSNBest_Services.Functions.fetchSSNs_generic
	//NOTE that you can also call the fetchSSN's functions via your default stored batch params as is done in the SSNBest
	//batch service or call setSSNBestParams_byInMod below
	EXPORT setSSNBestParams(mod_access,IncludeMinors_,suppress_and_mask_ = TRUE,checkRNA_ = FALSE) := FUNCTIONMACRO
    IMPORT BatchShare;  

	 in_mod :=
		MODULE(SSNBest_Services.IParams.SSNBestParams)
			EXPORT TYPEOF(BatchShare.IParam.BatchParams.GLBPurpose)          GLBPurpose          := mod_access.glb;//glb_;
			EXPORT TYPEOF(BatchShare.IParam.BatchParams.DPPAPurpose)         DPPAPurpose         := mod_access.dppa;//dppa_;
			EXPORT TYPEOF(BatchShare.IParam.BatchParams.DataRestrictionMask) DataRestrictionMask := mod_access.DataRestrictionMask;//DRM_;
			EXPORT TYPEOF(BatchShare.IParam.BatchParams.ApplicationType)     ApplicationType     := mod_access.application_type;//appType_;
			EXPORT TYPEOF(BatchShare.IParam.BatchParams.industryclass)       industry_class      := mod_access.industry_class;//indClass_;
			EXPORT TYPEOF(BatchShare.IParam.BatchParams.ssn_mask)            ssn_mask            := mod_access.ssn_mask;//ssnMask_;
			EXPORT TYPEOF(BatchShare.IParam.BatchParams.IncludeMinors)       IncludeMinors       := IncludeMinors_;
			EXPORT BOOLEAN suppress_and_mask := suppress_and_mask_;
		  EXPORT BOOLEAN check_RNA_        := checkRNA_;
		END;
		RETURN in_mod;
	ENDMACRO;

	EXPORT setSSNBestParams_byInMod(in_params,suppress_and_mask_ = TRUE,checkRNA_ = FALSE) := FUNCTIONMACRO
		in_mod := MODULE(PROJECT(in_params, SSNBest_Services.IParams.SSNBestParams, OPT))
			EXPORT BOOLEAN suppress_and_mask := suppress_and_mask_;
		  EXPORT BOOLEAN check_RNA_        := checkRNA_;
		END;	
		RETURN in_mod;
	ENDMACRO;
	
END;