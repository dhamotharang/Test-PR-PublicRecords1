import PromoteSupers;

EXPORT ConsolidateInputs(boolean isFcra = false) := MODULE
	
	Accurint 		:= INQL_v2.Standardize_input(isFcra, 1).Accurint;
	doAccurint	:= INQL_v2.MAC_Consolidate_Files(Accurint,'Accurint', isFcra);
		
	Custom      := INQL_v2.Standardize_input(isFcra, 2).Custom;
	doCustom 		:= INQL_v2.MAC_Consolidate_Files(Custom, 'Custom', isFcra);
		
	Batch       := INQL_v2.Standardize_input(isFcra, 3).Batch;
	doBatch     := INQL_v2.MAC_Consolidate_Files(Batch, 'Batch', isFcra);
		
	BatchR3     := INQL_v2.Standardize_input(isFcra, 4).BatchR3;
	doBatchR3 	:= INQL_v2.MAC_Consolidate_Files(BatchR3, 'BatchR3', isFcra);
	
	Banko       := INQL_v2.Standardize_input(isFcra, 5).Banko;
	doBanko     := INQL_v2.MAC_Consolidate_Files(Banko, 'Banko', isFcra);
	
	Bridger     := INQL_v2.Standardize_input(isFcra, 6).Bridger;
	doBridger 	:= INQL_v2.MAC_Consolidate_Files(Bridger, 'Bridger', isFcra);
	
	Riskwise 		:= INQL_v2.Standardize_input(isFcra, 7).Riskwise;
	doRiskwise	:= INQL_v2.MAC_Consolidate_Files(Riskwise, 'Riskwise', isFcra);
	
	IDM         := INQL_v2.Standardize_input(isFcra, 8).IDM;
	doIDM       := INQL_v2.MAC_Consolidate_Files(IDM, 'IDM', isFcra);
	
	SBA         := INQL_v2.Standardize_input(isFcra, 9).SBA;
	doSBA       := INQL_v2.MAC_Consolidate_Files(SBA, 'SBA', isFcra);
	
	
  nonfcra_seq := 	sequential(
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

  fcra_seq    := sequential(
								doAccurint
							 ,doBatch
							 ,doBatchR3
							 ,doBanko
							 ,doRiskwise
							 );							 
	
	export do := if(isFCRA,fcra_seq, nonfcra_seq);
	
END;