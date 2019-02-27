IMPORT SSNBest_Services, BatchShare, doxie;

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

  // This function will likely become obsolete when BatchShare.IParam will be made compatible with IDataAccess.
  EXPORT setFromBatch (BatchParams mod_batch) := FUNCTION
    mod_access := MODULE (SSNBestParams)
      EXPORT unsigned1 glb := mod_batch.GLBPurpose;
      EXPORT unsigned1 dppa := mod_batch.DPPAPurpose;
      EXPORT string DataPermissionMask := mod_batch.DataPermissionMask;
      EXPORT string DataRestrictionMask := mod_batch.DataRestrictionMask;
      EXPORT string5 industry_class := mod_batch.IndustryClass;
      EXPORT string32 application_type := mod_batch.ApplicationType;
      EXPORT boolean show_minors := mod_batch.IncludeMinors OR (mod_batch.GLBPurpose = 2);
      EXPORT string ssn_mask :=  mod_batch.ssn_mask;

		  EXPORT BOOLEAN suppress_and_mask  := mod_batch.suppress_and_mask;
		  EXPORT BOOLEAN check_RNA_         := mod_batch.check_RNA_;    
    END; 
    RETURN mod_access;
  END;

END;