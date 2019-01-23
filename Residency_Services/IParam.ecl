IMPORT BatchShare;

EXPORT IParam := MODULE
	
	EXPORT BatchParams := interface(BatchShare.IParam.BatchParams)
		EXPORT STRING5 industry_class         := ''; //used in multiple Residency_Services.fn_get***
	END;

	EXPORT getBatchParams() := FUNCTION
		
		base_params := BatchShare.IParam.getBatchParams();
	
		// project the base params to read shared parameters from store.
		in_mod := MODULE(project(base_params, BatchParams, OPT))
			EXPORT STRING5 industry_class         := '' : STORED('IndustryClass');
		END;
		
		RETURN in_mod;
  END;

END;