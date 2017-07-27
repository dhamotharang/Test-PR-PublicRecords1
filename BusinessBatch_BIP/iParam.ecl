IMPORT BatchShare,BusinessBatch_BIP;

EXPORT iParam :=
MODULE

  // JIRA RR-10621 Exclude Experian records (default = FALSE)
  EXPORT BatchParams :=
  INTERFACE(BatchShare.IParam.BatchParams)
		EXPORT BOOLEAN BestOnly;
    EXPORT BOOLEAN ExcludeExperian;
  END;

  // Function to initalize the params
	EXPORT getBatchParams() :=
	FUNCTION
			BaseBatchParams := BatchShare.IParam.getBatchParams();
			
			inMod := MODULE(PROJECT(BaseBatchParams,BatchParams,OPT))
				EXPORT UNSIGNED8 MaxResultsPerAcct := BusinessBatch_BIP.Constants.Defaults.MaxResultsPerAcctno : STORED('Max_Results_Per_Acct');
				EXPORT BOOLEAN BestOnly := FALSE : STORED('Best_Only');
        EXPORT BOOLEAN ExcludeExperian := FALSE : STORED('ExcludeExperian');
			END;
			
			RETURN inMod;
		END;
END;