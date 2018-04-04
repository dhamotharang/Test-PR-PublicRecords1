import PromoteSupers;

EXPORT ConsolidateInputs(boolean isFcra = false) := MODULE
	
	Accurint 		:= INQL_v2.Standardize_input(isFcra, 1).Accurint;
	doAccurint	:= INQL_v2.MAC_Consolidate_Files(Accurint, 1, isFcra);
		
	Custom      := INQL_v2.Standardize_input(isFcra, 2).Custom;
	doCustom 		:= INQL_v2.MAC_Consolidate_Files(Custom, 2, isFcra);
		
	Batch       := INQL_v2.Standardize_input(isFcra, 3).Batch;
	doBatch     := INQL_v2.MAC_Consolidate_Files(Batch, 3, isFcra);
		
	BatchR3     := INQL_v2.Standardize_input(isFcra, 4).BatchR3;
	doBatchR3 	:= INQL_v2.MAC_Consolidate_Files(BatchR3, 4, isFcra);
	
	Banko       := INQL_v2.Standardize_input(isFcra, 5).Banko;
	doBanko     := INQL_v2.MAC_Consolidate_Files(Banko, 5, isFcra);
	
	Bridger     := INQL_v2.Standardize_input(isFcra, 6).Bridger;
	doBridger 	:= INQL_v2.MAC_Consolidate_Files(Bridger, 6, isFcra);
	
	Riskwise 		:= INQL_v2.Standardize_input(isFcra, 7).Riskwise;
	doRiskwise	:= INQL_v2.MAC_Consolidate_Files(Riskwise, 7, isFcra);
	
	IDM         := INQL_v2.Standardize_input(isFcra, 8).IDM;
	doIDM       := INQL_v2.MAC_Consolidate_Files(IDM, 8, isFcra);
	
	SBA         := INQL_v2.Standardize_input(isFcra, 9).SBA;
	doSBA       := INQL_v2.MAC_Consolidate_Files(SBA, 9, isFcra);
	
	export do := sequential(
								doAccurint
							 ,doCustom
							 ,doBatch
							 ,doBatchR3
							 ,doBanko
							 ,doBridger
							 ,doRiskwise
							 ,doIDM
							 ,doSBA
							 );
END;