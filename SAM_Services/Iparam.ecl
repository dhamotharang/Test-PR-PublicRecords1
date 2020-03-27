IMPORT BatchShare, BIPV2, SAM_Services, STD;

EXPORT IParam := MODULE

	EXPORT BatchParams :=
			INTERFACE(BatchShare.IParam.BatchParams);
			EXPORT STRING1 BIPFetchLevel;
      EXPORT UNSIGNED1 Score_Threshold;
  END;
	
	
  // Function to initalize the batch params
  EXPORT getBatchParams() :=	FUNCTION
      BaseBatchParams := BatchShare.IParam.getBatchParams();
			
      inMod := MODULE(PROJECT(BaseBatchParams,BatchParams,OPT))
        BipFetchLevelTmp := BIPV2.IDconstants.Fetch_Level_SELEID : STORED('BIPFetchLevel');
        EXPORT STRING1 BIPFetchLevel := STD.Str.touppercase(BipFetchLevelTmp);
        EXPORT UNSIGNED1 Score_Threshold := 75 : STORED('Score_Threshold');
      END;
      RETURN inMod;
  END;
	
END;
