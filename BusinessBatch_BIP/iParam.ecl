IMPORT BatchShare,BusinessBatch_BIP,Business_Risk_BIP,Gateway;

EXPORT iParam :=
MODULE

  // JIRA RR-10621 Exclude Experian records (default = FALSE)
  EXPORT BatchParams :=
  INTERFACE(BatchShare.IParam.BatchParams)
		EXPORT BOOLEAN BestOnly;
    EXPORT BOOLEAN Use_Append;
    EXPORT BOOLEAN ExcludeExperian;
    EXPORT BOOLEAN ExcludeMarketing;
    EXPORT UNSIGNED1 Score_Threshold;
    EXPORT UNSIGNED1 OFAC_Version;
  END;

  // Function to initalize the params
	EXPORT getBatchParams() :=
	FUNCTION
			BaseBatchParams := BatchShare.IParam.getBatchParams();
			
			inMod := MODULE(PROJECT(BaseBatchParams, BatchParams, OPT))
				EXPORT UNSIGNED8 MaxResultsPerAcct := BusinessBatch_BIP.Constants.Defaults.MaxResultsPerAcctno : STORED('Max_Results_Per_Acct');
				EXPORT BOOLEAN BestOnly := FALSE : STORED('Best_Only');
        EXPORT BOOLEAN Use_Append := FALSE : STORED('Use_Append');
        EXPORT BOOLEAN ExcludeExperian := FALSE : STORED('ExcludeExperian');
        // JIRA RR-15244: if we are classified as marketing use (via industry_class / intended_use), we will use BRM Marketing mode
        EXPORT BOOLEAN ExcludeMarketing := BaseBatchParams.isDirectMarketing();
        EXPORT UNSIGNED1 Score_Threshold := 75 : STORED('Score_Threshold');
        EXPORT UNSIGNED1 OFAC_Version := Business_Risk_BIP.Constants.Default_OFAC_Version : STORED('OFAC_Version');
	
        EXPORT DATASET(Gateway.Layouts.Config) Gateways := Gateway.Configuration.Get();
			END;
			
			RETURN inMod;
		END;

  // Batch Params for Single-View Service
  // -------------------------------------------------
  EXPORT SingleView := 
  MODULE

    EXPORT BatchParams :=
    INTERFACE(BatchShare.IParam.BatchParams)
      EXPORT UNSIGNED8 MaxBusinessesPerAcct;
      EXPORT UNSIGNED8 MaxContactsPerAcct;
      EXPORT UNSIGNED1 Score_Threshold;
      EXPORT UNSIGNED1 Biz_Score_Threshold;
      EXPORT UNSIGNED1 History_Limit_Years;
      EXPORT BOOLEAN ExcludeMarketing;
    END;

    EXPORT getSVBatchParams() := 
    FUNCTION
      BaseBatchParams := BatchShare.IParam.getBatchParams();
      
      inMod := MODULE(PROJECT(BaseBatchParams, BatchParams, OPT))
        EXPORT UNSIGNED8 MaxResultsPerAcct := BusinessBatch_BIP.Constants.SingleView.MaxResultsPerAcctno : STORED('Max_Results_Per_Acct');
        EXPORT UNSIGNED8 MaxBusinessesPerAcct := BusinessBatch_BIP.Constants.SingleView.MaxLinkedPerAcctno : STORED('Max_Businesses_Per_Acct');
        EXPORT UNSIGNED8 MaxContactsPerAcct := BusinessBatch_BIP.Constants.SingleView.MaxLinkedPerAcctno : STORED('Max_Contacts_Per_Acct');
        EXPORT UNSIGNED1 Score_Threshold := 75 : STORED('Score_Threshold');
        EXPORT UNSIGNED1 Biz_Score_Threshold := 75 : STORED('Biz_Score_Threshold');
        EXPORT UNSIGNED1 History_Limit_Years := 2 : STORED('History_Limit_Years');
        EXPORT BOOLEAN ExcludeMarketing := BaseBatchParams.isDirectMarketing();
  
        EXPORT DATASET(Gateway.Layouts.Config) Gateways := Gateway.Configuration.Get();
      END;
      
      RETURN inMod;
    END;

  END;
END;