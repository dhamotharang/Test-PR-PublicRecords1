import Address, BatchShare;

export IParam := module
	
	export BatchParams := interface(BatchShare.IParam.BatchParams)
		 		EXPORT unsigned2 TaxYearsToIgnore;
		
	end;

	export getBatchParams() := 
	function
		
		base_params := BatchShare.IParam.getBatchParams();
		
		// project the base params to read shared parameters from store.
		in_mod := module(project(base_params, BatchParams, opt))						
			export unsigned2 TaxYearsToIgnore := Constants.Defaults.TaxYearsToIgnore : STORED('TaxYearsToIgnore'); 
			export unsigned2 ScoreThreshold := Constants.ScoreThreshold : STORED('ScoreThreshold');
			export string RealTimePermissibleUse := Constants.RealTimePermissibleUse : STORED('RealTimePermissibleUse');
		END;
		
		return in_mod;
	end;	
	
end;