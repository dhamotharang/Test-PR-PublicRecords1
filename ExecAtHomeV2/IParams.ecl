IMPORT BatchShare,BIPV2,STD;

EXPORT IParams := MODULE

	EXPORT BatchParams :=
		INTERFACE (BatchShare.IParam.BatchParams)
			EXPORT STRING1 BIPFetchLevel;
      EXPORT BOOLEAN execsOnly; 
    END;
  
  // Function to initalize the batch params
	EXPORT getBatchParams() :=	
    FUNCTION
      BaseBatchParams := BatchShare.IParam.getBatchParams();

      inMod := MODULE(PROJECT(BaseBatchParams,BatchParams,OPT)) 
        BipFetchLevelTmp := BIPV2.IDconstants.Fetch_Level_SELEID : STORED('BIPFetchLevel');
        EXPORT STRING1  BIPFetchLevel := STD.Str.touppercase(BipFetchLevelTmp);
			  EXPORT BOOLEAN  execsOnly := TRUE : STORED('ReturnExecutivesOnly');
      END;
      RETURN inMod;
	  END;
		
END;

