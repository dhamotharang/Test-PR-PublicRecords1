import ut;
EXPORT Clean_and_Translate(boolean fcra = false) := MODULE

	export fnAccurint := function
		
		logType := 1;//'ACCURINT';		
		FileToCommon := INQL_v2.fnMap_Custom_and_Accurint(fcra,logType);
		return FileToCommon;
		
	end;
	
	export fnCustom := function
	
		logType := 2;//'CUSTOM';
		FileToCommon := INQL_v2.fnMap_Custom_and_Accurint(fcra,logType);
		return FileToCommon;
		
	end;
	
	export fnBatch := function
	
		logType := 3;//'BATCH';
		FileToCommon := INQL_v2.fnMap_Batch(fcra, logType);
		return FileToCommon;
		
	end;
	
	export fnBatchR3 := function
		
		logType := 4;//'BATCHR3';
		FileToCommon := INQL_v2.fnMap_BatchR3(fcra, logType);
		return FileToCommon;
		
	end;
	
	export fnBanko := function
		
		logType := 5;//'BANKO';
		FileToCommon := INQL_v2.fnMap_Banko(fcra, logType);
		return FileToCommon;
		
	end;	
	
	export fnBridger := function
		
		logType := 6;//'BRIDGER';
		FileToCommon := INQL_v2.fnMap_Bridger(fcra, logType);
		return FileToCommon;
		
	end;
	
	export fnRiskwise := function
	
		logType := 7;//'RISKWISE';
		FileToCommon := INQL_v2.fnMap_Riskwise(fcra, logType);
		return FileToCommon;
		
	end;	
	
	export fnIDM := function
	
		logType := 8;//'IDM';
		FileToCommon := INQL_v2.fnMap_IDM(fcra, logType);
		return FileToCommon;
		
	end;
	
	export fnSBA := function
	
		logType := 9;//'SBA';
		res := INQL_v2.fnMap_SBA(fcra, logType);
		return res;
	end;

	export fnBatch_PIIs := function
	
		logType := 3;//'Batch_PIIs';
		res := INQL_v2.fnMap_Batch_PIIs(fcra, logType);
		return res;
	end;

  
END;