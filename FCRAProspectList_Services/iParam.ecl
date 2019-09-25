IMPORT BatchShare;

EXPORT iParam :=
MODULE

  EXPORT BatchParams :=
  INTERFACE(BatchShare.IParam.BatchParams)	
  END;

  // Function to initalize the params
	EXPORT getBatchParams() :=
	FUNCTION
			BaseBatchParams := BatchShare.IParam.getBatchParams();			
			inMod := MODULE (PROJECT(BaseBatchParams,BatchParams))
			END;			
			RETURN inMod;
		END;
END;
