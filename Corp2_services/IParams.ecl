import BatchShare;

export IParams := module
	
	export BatchParams := interface (BatchShare.IParam.BatchParams)
		export boolean ViewDebugs    := FALSE;
		export boolean NoRestriction := FALSE; 
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
			// specific parameters.
			in_mod := module(project(base_params, BatchParams, opt))				
				export boolean   ReturnCurrentOnly := FALSE : STORED('ReturnCurrentOnly');
				export unsigned8 MaxResultsPerAcct := 1000  : STORED('MaxResultsPerAcct');
				export unsigned2 PenaltThreshold   := 5     : STORED('PenaltThreshold');
				// For debugging:
				export boolean ViewDebugs    := FALSE : STORED('ViewDebugs'); // View intermediate datasets
				export boolean NoRestriction := FALSE : STORED('RunWithNoRestriction'); // Ignores 1000 record cap per acctno
			end;
			
			return in_mod;
		end;	
	
		export getServiceParams() := function
			in_mod := module
				export boolean SearchRegisteredAgents := false : stored('SearchRegisteredAgents');
				export boolean SimplifiedContactReturn := false : stored('SimplifiedContactReturn');
				export boolean LatestForMAs := false : stored('LatestForMAs');
			end;
			return in_mod;
		end;

end;