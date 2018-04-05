import BatchShare, AutoStandardI, Relationship, AutoHeaderI;

export IParams := module
  
	export DIDParams :=
    INTERFACE(AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full)
  end;
  
	export BatchParams := interface (BatchShare.IParam.BatchParams,Relationship.IParams.relationshipParams)
		export boolean AppendBest          := false; // We're calling another function to append Best.
		export UNSIGNED3 DIDScoreThreshold := 0;
		export string2 input_state         := '';		
		export boolean ViewDebugs          := false;
    export unsigned1 MaxPhoneCount     := 3;
    export string5 industry_class      := '';
		export boolean GetSSNBest          := true;
		export boolean check_RNA_					 := TRUE;
		export boolean suppress_and_mask	 := FALSE;
		export boolean Display_HRI				 := TRUE;  // return SSN even when other_cnt >= 4
		export boolean AppendBestData      := FALSE; // return best data even when it matches the input data
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
			tmp_mod := module(project(base_params, BatchParams, opt))				
				export unsigned8 	MaxResultsPerAcct :=  Constants.Defaults.MaxResultsPerAcctno : STORED('MaxResultsPerAcct');
				export UNSIGNED3 DIDScoreThreshold  :=  Constants.Defaults.DIDScoreThreshold   : STORED('DIDScoreThreshold');
				export unsigned2 PenaltThreshold    := 10 : STORED('PenaltThreshold'); // BatchShare default is 20.
				export string2 input_state          := '' : STORED('InputState');
		//	export boolean ViewDebugs           := FALSE : STORED('ViewDebugs');
				export unsigned1 MaxPhoneCount      := 3 : STORED('MaxPhoneCount');
				export string5 industry_class       := AutoStandardI.InterfaceTranslator.industry_class_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.industry_class_val.params));
				export boolean IncludeMinors        := FALSE : STORED('IncludeMinors');				
				export boolean GetSSNBest           := TRUE  : STORED('GetSSNBest');
				export boolean check_RNA_					 := TRUE;
				export boolean suppress_and_mask	 := FALSE;
				export boolean Display_HRI				 := TRUE;  // return SSN even when other_cnt >= 4
				export boolean AppendBestData 		 := FALSE : STORED('AppendBestData'); //return best data even when it matches input
			END;
			
			in_mod:=Relationship.IParams.getParams(tmp_mod,BatchParams);

			return in_mod;
		end;	
	
		
end;