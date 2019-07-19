IMPORT  BatchShare, FCRA, FFD, Gateway;

EXPORT IParam := MODULE

	EXPORT BatchParams := INTERFACE(BatchShare.IParam.BatchParamsV2, FCRA.iRules)
			EXPORT BOOLEAN IncludeAllPersonContext := false;
  END;
	
	
  // Function to initalize the batch params
	EXPORT getBatchParams(boolean isFCRA = FALSE) :=	FUNCTION
			BaseBatchParams := BatchShare.IParam.getBatchParamsV2();
			inMod := MODULE(PROJECT(BaseBatchParams,BatchParams,OPT))
				EXPORT BOOLEAN IncludeAllPersonContext := false : STORED('IncludeAllPersonContext');	
				EXPORT dataset (Gateway.layouts.config) gateways := gateway.Configuration.get();
				EXPORT INTEGER8 FFDOptionsMask := IF(isFCRA, FFD.FFDMask.Get(), 0);
			END;
			
			RETURN inMod;
	END;
	
END;
