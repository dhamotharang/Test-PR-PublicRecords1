import Address, BatchShare;

export IParam := module
	
	export BatchParams := interface (BatchShare.IParam.BatchParams)
		export boolean AppendBest := false;
	end;

	// **************************************************************************************
	//   This is where the service options should be read from #store.
	//	 The module parameter should be passed along to the underlying attributes.
	// **************************************************************************************			
	export getBatchParams() := 
	function
		
		base_params := BatchShare.IParam.getBatchParams();
		
		// project the base params to read shared parameters from store.
		in_mod := module(project(base_params, BatchParams, opt))				

			// if necessary, you may redefine default values for common parameters here.			
			export unsigned8 	MaxResultsPerAcct  	:= Experian_Phones_Services.Constants.Defaults.MaxResultsPerAcctno  : stored('MaxResultsPerAcct');

			// and/or define default values for domain specific parameters here.
			export boolean		AppendBest := true;
			
		END;
		
		return in_mod;
	end;	
	
		
end;