IMPORT BatchShare;

EXPORT iParam :=
MODULE

  EXPORT BatchParams :=
  INTERFACE(BatchShare.IParam.BatchParamsV2)	
  END;

  // Function to initalize the params
	EXPORT getBatchParams() :=
	FUNCTION
			BaseBatchParams := BatchShare.IParam.getBatchParamsV2();			
			inMod := MODULE (PROJECT(BaseBatchParams,BatchParams))
			END;			
			RETURN inMod;
		END;
END;
