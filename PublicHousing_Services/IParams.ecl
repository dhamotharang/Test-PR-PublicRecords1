import BatchShare;

export IParams := module
	
	export BatchParams := interface (BatchShare.IParam.BatchParams)
		export boolean   AppendBest             := false; // We're calling another function to append Best.
		export string2   InputState             := '';
		export string20  PropertyValueThreshold := '';
		export string4   PropertyYearThreshold  := '';
		export string4   MVRYearThreshold       := '';
		export boolean   ViewDebugs             := false;
		export boolean   GetSSNBest             := true;
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
				export string2   InputState             := ''    : STORED('InputState');
				export string20  PropertyValueThreshold := ''    : STORED('PropertyValueThreshold');
				export string4   PropertyYearThreshold  := ''    : STORED('PropertyYearThreshold');
				export string4   MVRYearThreshold       := ''    : STORED('MVRYearThreshold');
				export boolean   ViewDebugs             := FALSE : STORED('ViewDebugs');
				export boolean   IncludeMinors          := FALSE : STORED('IncludeMinors');
				export boolean   GetSSNBest             := TRUE  : STORED('GetSSNBest');
			END;
			
			return in_mod;
		end;	
	
end;