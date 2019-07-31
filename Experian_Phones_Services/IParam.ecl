import BatchShare;

export IParam := module
	
	export BatchParams := interface (BatchShare.IParam.BatchParamsV2)
		export boolean AppendBest := false;
		export boolean include_PhonesFeedback := false;
	end;

	// **************************************************************************************
	//   This is where the service options should be read from #store.
	//	 The module parameter should be passed along to the underlying attributes.
	// **************************************************************************************			
	export getBatchParams() := 
	function
		
		base_params := BatchShare.IParam.getBatchParamsV2();
		
		// project the base params to read shared parameters from store.
		in_mod := module(project(base_params, BatchParams, opt))				

			// if necessary, you may redefine default values for common parameters here.			
			export unsigned8 	MaxResultsPerAcct  	:= Experian_Phones_Services.Constants.Defaults.MaxResultsPerAcctno  : stored('MaxResultsPerAcct');

			// and/or define default values for domain specific parameters here.
			export boolean		AppendBest := true;

			export boolean incl_PhonesFeedback := FALSE : STORED('Include_Phones_Feedback');
		END;
		
		return in_mod;
	end;	
	
		
end;
