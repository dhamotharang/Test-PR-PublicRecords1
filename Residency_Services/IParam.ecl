IMPORT BatchShare;

EXPORT IParam := MODULE
	
	EXPORT BatchParams := interface(BatchShare.IParam.BatchParams)
	END;

	EXPORT getBatchParams() := FUNCTION
		
		base_params := BatchShare.IParam.getBatchParams();
	
		// project the base params to read shared parameters from store.
		in_mod := MODULE(project(base_params, BatchParams, OPT))
		END;
		
		RETURN in_mod;
  END;

END;