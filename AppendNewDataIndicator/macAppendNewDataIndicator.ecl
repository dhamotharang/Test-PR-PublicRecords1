EXPORT macAppendNewDataIndicator(dIn1, dIn2, sJoinFields1, sJoinFields2, appendPrefix = '\'\'') := FUNCTIONMACRO
	IMPORT hipie_ecl, JoinDataset;
	
	LOCAL sJoinStmt	:= hipie_ecl.macComputeJoinStatement(sJoinFields1, sJoinFields2);
	LOCAL dLeftOnly := JoinDataset.macJoinDataset(dIn1, dIn2, sJoinStmt, 'Left Only', , FALSE);
	LOCAL tUniqueIds:= TABLE(dLeftOnly, {#EXPAND(sJoinFields1), INTEGER #EXPAND(appendPrefix + 'NewFlag') := 1}, #EXPAND(sJoinFields1), MERGE);
	
	LOCAL dOut    := JoinDataset.macJoinDataset(dIn1, tUniqueIds, sJoinStmt, 'Left Outer', appendPrefix + 'NewFlag', FALSE);
	
	RETURN dOut;
ENDMACRO;