IMPORT SSNBest_Services, BatchShare, doxie;

EXPORT IParams := MODULE

	EXPORT HardCodedFlags := INTERFACE
		EXPORT BOOLEAN   suppress_and_mask  := TRUE;
		EXPORT BOOLEAN   check_RNA_         := FALSE;
	END;

	EXPORT BatchParams := INTERFACE(BatchShare.IParam.BatchParamsV2,HardCodedFlags)
		EXPORT BOOLEAN   Display_HRI        := FALSE;
	  EXPORT UNSIGNED3 DIDScoreThreshold  := SSNBest_Services.Constants.DIDScoreThreshold;
		EXPORT BOOLEAN   IsGlbRequired      := FALSE;
	END;

	EXPORT getBatchParams() := FUNCTION
		base_params := BatchShare.IParam.getBatchParamsV2();
		in_mod := MODULE(PROJECT(base_params, BatchParams, OPT))
			EXPORT BOOLEAN   Display_HRI        := FALSE : STORED('Display_HRI');
			EXPORT UNSIGNED3 DIDScoreThreshold  := SSNBest_Services.Constants.DIDScoreThreshold : STORED('DIDScoreThreshold'); //internal
			EXPORT BOOLEAN   IsGlbRequired      := FALSE : STORED('IsGlbRequired');
			EXPORT TYPEOF(BatchShare.IParam.BatchParams.IncludeMinors) IncludeMinors:= FALSE : STORED('IncludeMinors'); 
		END;
		RETURN in_mod;
	END;

	//used to call SSNBest_Services.Functions.fetchSSNs_generic - currently used in ADL_Best - DidVille.MAC_BestAppend & doxie.best_records
	EXPORT SSNBestParams := INTERFACE(HardCodedFlags, doxie.IDataAccess)
	END;

	//this function is called to set the interface parameters before calling SSNBest_Services.Functions.fetchSSNs_generic
	//NOTE that you can also call the fetchSSN's functions via your default stored batch params as is done in the SSNBest
	EXPORT setSSNBestParams(doxie.IDataAccess mod_access, boolean suppress_and_mask_ = TRUE, boolean checkRNA_ = FALSE) := FUNCTION

		in_mod := MODULE (PROJECT (mod_access, SSNBestParams, OPT))
			EXPORT BOOLEAN suppress_and_mask := suppress_and_mask_;
		  EXPORT BOOLEAN check_RNA_        := checkRNA_;
		END;
		RETURN in_mod;
	END;

  
END;