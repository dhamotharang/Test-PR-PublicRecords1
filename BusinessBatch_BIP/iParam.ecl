IMPORT BatchShare,BusinessBatch_BIP,Business_Risk_BIP,Gateway;

EXPORT iParam :=
MODULE

  // JIRA RR-10621 Exclude Experian records (default = FALSE)
  EXPORT BatchParams :=
  INTERFACE(BatchShare.IParam.BatchParams)
		EXPORT BOOLEAN BestOnly;
    EXPORT BOOLEAN ExcludeExperian;
    EXPORT UNSIGNED1 OFAC_Version;
  END;

  // Function to initalize the params
	EXPORT getBatchParams() :=
	FUNCTION
			BaseBatchParams := BatchShare.IParam.getBatchParams();
			
			inMod := MODULE(PROJECT(BaseBatchParams,BatchParams,OPT))
				EXPORT UNSIGNED8 MaxResultsPerAcct := BusinessBatch_BIP.Constants.Defaults.MaxResultsPerAcctno : STORED('Max_Results_Per_Acct');
				EXPORT BOOLEAN BestOnly := FALSE : STORED('Best_Only');
        EXPORT BOOLEAN ExcludeExperian := FALSE : STORED('ExcludeExperian');
        EXPORT UNSIGNED1 OFAC_Version := Business_Risk_BIP.Constants.Default_OFAC_Version : STORED('OFAC_Version');
	
        EXPORT DATASET(Gateway.Layouts.Config) Gateways := Gateway.Configuration.Get();
			END;
			
			RETURN inMod;
		END;
END;