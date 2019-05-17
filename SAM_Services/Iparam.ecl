IMPORT BatchShare, BIPV2, STD;

EXPORT IParam := MODULE

	EXPORT BatchParams :=
			INTERFACE(BatchShare.IParam.BatchParamsV2);
			EXPORT STRING1 BIPFetchLevel;
  END;
	
	
  // Function to initalize the batch params
	EXPORT getBatchParams() :=	FUNCTION
			BaseBatchParams := BatchShare.IParam.getBatchParamsV2();
			
			inMod := MODULE(PROJECT(BaseBatchParams,BatchParams,OPT))
				EXPORT UNSIGNED8 MaxResultsPerAcct := BatchShare.Constants.Defaults.MaxResultsPerAcctno : STORED('Max_Results_Per_Acct');	
				BipFetchLevelTmp := BIPV2.IDconstants.Fetch_Level_SELEID : STORED('BIPFetchLevel');
				EXPORT STRING1 BIPFetchLevel := STD.Str.touppercase(BipFetchLevelTmp);
			END;
			
			RETURN inMod;
	END;
	
END;