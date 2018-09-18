IMPORT SSNBest_Services,BatchShare,BatchDatasets,ut;
EXPORT IParams := MODULE

	EXPORT HardCodedFlags := INTERFACE
		EXPORT BOOLEAN   suppress_and_mask  := TRUE;
		EXPORT BOOLEAN   check_RNA_         := FALSE;
	END;

	EXPORT BatchParams := INTERFACE(BatchDatasets.IParams.BatchParams,HardCodedFlags)
		EXPORT BOOLEAN   Display_HRI        := FALSE;
	  EXPORT UNSIGNED3 DIDScoreThreshold  := SSNBest_Services.Constants.DIDScoreThreshold;
		EXPORT BOOLEAN   IsGlbRequired      := FALSE;
	END;

	EXPORT getBatchParams() := FUNCTION
		base_params := BatchDatasets.IParams.getBatchParams();
		in_mod := MODULE(PROJECT(base_params, BatchParams, OPT))
			EXPORT BOOLEAN   Display_HRI        := FALSE : STORED('Display_HRI');
			EXPORT UNSIGNED3 DIDScoreThreshold  := SSNBest_Services.Constants.DIDScoreThreshold : STORED('DIDScoreThreshold'); //internal
			EXPORT BOOLEAN   IsGlbRequired      := FALSE : STORED('IsGlbRequired');
			EXPORT TYPEOF(BatchDatasets.IParams.BatchParams.IncludeMinors) IncludeMinors:= FALSE : STORED('IncludeMinors'); 
		END;
		RETURN in_mod;
	END;

	//used to call SSNBest_Services.Functions.fetchSSNs_generic - currently used in ADL_Best - DidVille.MAC_BestAppend & doxie.best_records
	EXPORT SSNBestParams := INTERFACE(HardCodedFlags)
		EXPORT TYPEOF(BatchDatasets.IParams.BatchParams.GLBPurpose)          GLBPurpose          := BatchShare.Constants.Defaults.GLBPurpose;
	  EXPORT TYPEOF(BatchDatasets.IParams.BatchParams.DPPAPurpose)         DPPAPurpose         := BatchShare.Constants.Defaults.DPPAPurpose;
	  EXPORT TYPEOF(BatchDatasets.IParams.BatchParams.DataRestrictionMask) DataRestrictionMask := BatchShare.Constants.Defaults.DataRestrictionMask;
	  EXPORT TYPEOF(BatchDatasets.IParams.BatchParams.ApplicationType)     ApplicationType     := BatchShare.Constants.Defaults.ApplicationType;
	  EXPORT TYPEOF(BatchDatasets.IParams.BatchParams.industry_class)      industry_class      := ut.IndustryClass.UTILI_IC; //we restrict it by default 'UTILI'
	  EXPORT TYPEOF(BatchDatasets.IParams.BatchParams.ssn_mask)            ssn_mask            := BatchShare.Constants.Defaults.SSNMask; //'NONE'
	  EXPORT TYPEOF(BatchDatasets.IParams.BatchParams.IncludeMinors)       IncludeMinors       := FALSE;
	END;

	//this function is called to set the interface parameters before calling SSNBest_Services.Functions.fetchSSNs_generic
	//NOTE that you can also call the fetchSSN's functions via your default stored batch params as is done in the SSNBest
	//batch service or call setSSNBestParams_byInMod below
//	EXPORT setSSNBestParams(glb_,dppa_,DRM_,appType_,indClass_,ssnMask_,IncludeMinors_,suppress_and_mask_ = TRUE,checkRNA_ = FALSE) := FUNCTIONMACRO
	EXPORT setSSNBestParams(mod_access,IncludeMinors_,suppress_and_mask_ = TRUE,checkRNA_ = FALSE) := FUNCTIONMACRO
    IMPORT BatchDatasets;

	 in_mod :=
		MODULE(SSNBest_Services.IParams.SSNBestParams)
			EXPORT TYPEOF(BatchDatasets.IParams.BatchParams.GLBPurpose)          GLBPurpose          := mod_access.glb;//glb_;
			EXPORT TYPEOF(BatchDatasets.IParams.BatchParams.DPPAPurpose)         DPPAPurpose         := mod_access.dppa;//dppa_;
			EXPORT TYPEOF(BatchDatasets.IParams.BatchParams.DataRestrictionMask) DataRestrictionMask := mod_access.DataRestrictionMask;//DRM_;
			EXPORT TYPEOF(BatchDatasets.IParams.BatchParams.ApplicationType)     ApplicationType     := mod_access.application_type;//appType_;
			EXPORT TYPEOF(BatchDatasets.IParams.BatchParams.industry_class)      industry_class      := mod_access.industry_class;//indClass_;
			EXPORT TYPEOF(BatchDatasets.IParams.BatchParams.ssn_mask)            ssn_mask            := mod_access.ssn_mask;//ssnMask_;
			EXPORT TYPEOF(BatchDatasets.IParams.BatchParams.IncludeMinors)       IncludeMinors       := IncludeMinors_;
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