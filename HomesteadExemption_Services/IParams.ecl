import Address, BatchDatasets, BatchShare;

export IParams := module
	
	export BatchParams := interface (BatchDatasets.IParams.BatchParams)
		export string5 industry_class      := '';
		export unsigned3 DIDScoreThreshold := 0;
		export string4 taxyear             := '';
		export boolean ViewDebugs          := false;
		export boolean GetSSNBest          := true;
	end;

	// **************************************************************************************
	//   This is where the service options should be read from #store.
	//	 The module parameter should be passed along to the underlying attributes.
	// **************************************************************************************			
	export getBatchParams() := 
		function
			
			base_params := BatchShare.IParam.getBatchParams();
			
			// Project the base params to read shared parameters from store. If necessary, you may 
			// redefine default values for common parameters and/or define default values for domain-
			// specific parameters
			in_mod := module(project(base_params, BatchParams, opt))				
				export string5 industry_class      := '' : STORED('IndustryClass');
				export unsigned3 DIDScoreThreshold := Constants.Defaults.DIDScoreThreshold : STORED('DIDScoreThreshold');
				export string4 taxyear             := '' : STORED('TaxYear');
				export boolean ViewDebugs          := FALSE : STORED('ViewDebugs');
				export boolean IncludeMinors       := FALSE : STORED('IncludeMinors');
				export boolean GetSSNBest          := TRUE  : STORED('GetSSNBest');
			END;
			
			return in_mod;
		end;	
	
		
end;