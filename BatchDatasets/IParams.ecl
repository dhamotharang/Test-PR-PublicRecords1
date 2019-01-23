
import BatchShare;

export IParams := module
	
	export BatchParams := interface (BatchShare.IParam.BatchParams)
		export string5 industry_class := '';
	end;

	// **************************************************************************************
	//   This is where the service options should be read from #store.
	//	 The module parameter should be passed along to the underlying attributes.
	// **************************************************************************************			
	export getBatchParams() := 
		function
			
			base_params := BatchShare.IParam.getBatchParams();
			
			// Project the base params to read shared parameters from store. If necessary, 
			// you may redefine default values for common parameters and/or define default 
			// values for domain-specific parameters.
			in_mod := module(project(base_params, BatchParams, opt))				
				export string5 industry_class := '' : STORED('IndustryClass');
			END;
			
			return in_mod;
		end;	
end;