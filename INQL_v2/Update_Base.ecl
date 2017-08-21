EXPORT Update_Base (string pVersion, boolean pDelta = false, boolean pUseProd = false) := MODULE
	
	export fnAccurint := function
		//standardize input
		input		:= INQL_v2.Files(pVersion,pUseProd).Accurint_input;
		base_f 	:= input;
		return base_f;
	end;
	
	export fnCustom := function
		//standardize input
		input		:= INQL_v2.Files(pVersion, pUseProd).Custom_input;
		base_f 	:= input;
		return base_f;
	end;
	
	export fnBanko := function
		//standardize input
		input		:= INQL_v2.Files(pVersion, pUseProd).Banko_input;
		base_f 	:= input;
		return base_f;
	end;
	
	export fnBatch := function
		input		:= INQL_v2.Files(pVersion, pUseProd).Batch_input;
		base_f 	:= input;
		return base_f;
	end;
	
	export fnBatchR3 := function
		//standardize input
		input		:= INQL_v2.Files(pVersion, pUseProd).BatchR3_input;
		base_f 	:= input;
		return base_f;
	end;
	
	export fnBridger := function
		//standardize input
		input		:= INQL_v2.Files(pVersion, pUseProd).Bridger_input;
		base_f 	:= input;
		return base_f;
	end;
	
	export fnRiskwise := function
		//standardize input
		input		:= INQL_v2.Files(pVersion, pUseProd).Riskwise_input;
		base_f 	:= input;
		return base_f;
	end;
	
	export fnIDM := function
		//standardize input
		input		:= INQL_v2.Files(pVersion, pUseProd).IDM_input;
		base_f 	:= input;
		return base_f;
	end;
	
	export fnSBA := function
		//standardize input
		input		:= INQL_v2.Files(pVersion, pUseProd).SBA_input;
		base_f 	:= input;
		return base_f;
	end;
	
END;