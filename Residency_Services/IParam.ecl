IMPORT BatchShare;

EXPORT IParam := MODULE
	
	EXPORT BatchParams := interface(BatchShare.IParam.BatchParamsV2)
	END;

	EXPORT getBatchParams() := FUNCTION
		
		base_params := BatchShare.IParam.getBatchParamsV2();
	
		// project the base params to read shared parameters from store.
		in_mod := MODULE(project(base_params, BatchParams, OPT))
		END;
		
		RETURN in_mod;
  END;

END;