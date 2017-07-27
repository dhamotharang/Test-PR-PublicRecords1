import Address,AutoKeyI,AutoHeaderI,AutoStandardI, BatchShare,suppress;

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
			export unsigned8 	MaxResultsPerAcct  	:= ERO_Services.Constants.Defaults.MaxResultsPerAcctno  : stored('MaxResultsPerAcct');

			// and/or define default values for domain specific parameters here.
			export boolean		AppendBest := true;
			
		END;
		
		return in_mod;
	end;	
	EXPORT AutoKeyIdsParams := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		EXPORT BOOLEAN workHard := true;
		EXPORT BOOLEAN noFail := true;
		EXPORT BOOLEAN isdeepDive := FALSE;
	END;
	
	EXPORT searchParams := INTERFACE (AutoStandardI.PermissionI_Tools.params,
																		AutoStandardI.LIBIN.PenaltyI.base, 
																		AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,
																		AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,
																		AutoKeyIdsParams)			
		EXPORT BOOLEAN 		noFail := true;
		EXPORT UNSIGNED2 	penalty_threshold := 10;
		EXPORT UNSIGNED2 	max_results := 10;
		EXPORT STRING6 		ssnMask := 'NONE'; 
		EXPORT unsigned1 	dob_mask_value := suppress.Constants.dateMask.NONE; 
	END;			
end;