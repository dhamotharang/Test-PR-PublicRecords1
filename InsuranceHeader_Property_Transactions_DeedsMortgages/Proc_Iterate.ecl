//Executable code
IMPORT SALT34;
EXPORT Proc_Iterate(STRING version,STRING iter,DATASET(Layout_PROPERTY_TRANSACTION) InFile0 = InsuranceHeader_Property_Transactions_DeedsMortgages.In_PROPERTY_TRANSACTION,STRING OutFileNameP = '~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::it',UNSIGNED MatchThreshold = Config.MatchThreshold,BOOLEAN Debugging = true) := MODULE
SHARED version_use := iter+'::' + version + '::' + workunit; 
SHARED InFile := InFile0;
SHARED MM := InsuranceHeader_Property_Transactions_DeedsMortgages.matches(InFile,MatchThreshold); // Get the matching module
OSR := OUTPUT(CHOOSEN(MM.MatchSampleRecords,10000),NAMED('MatchSampleRecords'));
OSL := OUTPUT(CHOOSEN(MM.ToSlice,1000),NAMED('SliceOutCandidates'));
EXPORT OutputSamples := PARALLEL(OSR,OSL);// Provide the records!
SHARED BM := InsuranceHeader_Property_Transactions_DeedsMortgages.BasicMatch(InFile);
BMS := OUTPUT(CHOOSEN(BM.patch_file, 1000), NAMED('BasicMatch_Patch_File'));
OMatchSamples := OUTPUT(CHOOSEN(MM.MatchSample,1000),NAMED('MatchSample'));
OBSamples := OUTPUT(CHOOSEN(MM.BorderlineMatchSample,10000),NAMED('BorderlineMatchSample'));
OAS := OUTPUT(CHOOSEN(MM.AlmostMatchSample,10000),NAMED('AlmostMatchSample'));
EXPORT OutputExtraSamples := PARALLEL(OMatchSamples, OBSamples, OAS, BMS); // This is not called automatically - call yourself if you want them!
OS := OUTPUT(InsuranceHeader_Property_Transactions_DeedsMortgages.specificities(InFile).specificities,NAMED('Specificities'));
OPRP := OUTPUT(InsuranceHeader_Property_Transactions_DeedsMortgages.match_candidates(InFile).prepropogationstats,NAMED('PrePopStats'));
OPP := OUTPUT(InsuranceHeader_Property_Transactions_DeedsMortgages.match_candidates(InFile).postpropogationstats,NAMED('PostPopStats'));
PRPPS := OUTPUT(MM.PreIds.IdCounts,NAMED('PreClusterCount'));
PRPP := OUTPUT(MM.PreIds.DPROPTXID_Clusters,NAMED('PreClusters'),ALL);
PPPS := OUTPUT(MM.PostIds.IdCounts,NAMED('PostClusterCount'));
PPP := OUTPUT(MM.PostIds.DPROPTXID_Clusters,NAMED('PostClusters'),ALL);
MPSP := OUTPUT(DATASET([{'MatchesPerformed', MM.MatchesPerformed}, {'BasicMatchesPerformed', InsuranceHeader_Property_Transactions_DeedsMortgages.BasicMatch(InFile).basic_match_count}, {'SlicesPerformed', MM.SlicesPerformed}], {STRING label, UNSIGNED value}), NAMED('MatchStatistics'));
PS := OUTPUT(DATASET([{'PropagationAssisted_Pcnt', MM.MatchesPropAssisted * 100 / MM.MatchesPerformed}, {'PropagationRequired_Pcnt', MM.MatchesPropRequired * 100 / MM.MatchesPerformed}], {STRING label, UNSIGNED Pcnt}), NAMED('PropogationStats'));
RE := OUTPUT(TOPN(MM.RuleEfficacy,1000,RuleNumber),NAMED('RuleEfficacy'));
CB := OUTPUT(TOPN(MM.ConfidenceBreakdown,1000,conf),NAMED('ConfidenceLevels'));
SpcS := OUTPUT(InsuranceHeader_Property_Transactions_DeedsMortgages.specificities(InFile).SpcShift,NAMED('SPCShift'));
EXPORT ExecutionStats := PARALLEL(OS,SpcS,PRPP,PPP,PRPPS,PPPS,MPSP,RE,CB, PS,OPRP,OPP);
d := DATASET([{MM.PatchingError0,MM.DuplicateRids0,COUNT(InsuranceHeader_Property_Transactions_DeedsMortgages.match_candidates(InFile).Unlinkables)}],{INTEGER PatchingError0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0});
EXPORT ValidityStats := PARALLEL( OUTPUT(d,NAMED('ValidityStatistics')), OUTPUT(MM.PostIds.Advanced0,NAMED('IdConsistency0')));
EXPORT InputValidityStats := OUTPUT(MM.PreIds.Advanced0,NAMED('InputIdConsistency0'));
EXPORT DebugKeys := Keys(InFile).BuildAll;
EXPORT OutputFileName := OutFileNameP+version_use;
EXPORT OutputFile := OUTPUT(MM.patched_infile,,OutputFileName,COMPRESSED);// Change file for each iteration
EXPORT OutputFileA := OUTPUT(MM.patched_infile,,OutputFileName,OVERWRITE,COMPRESSED);// Change file for each iteration
SHARED ChangeName := '~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::changes_it'+version_use;
EXPORT OutputChanges := SEQUENTIAL( OUTPUT(MM.IdChanges,,ChangeName,OVERWRITE,COMPRESSED),FileServices.AddSuperFile(MatchHistory.MatchHistoryName,ChangeName));
EXPORT OutputChangesA := SEQUENTIAL( IF(FileServices.SuperFileExists(InsuranceHeader_Property_Transactions_DeedsMortgages.MatchHistory.MatchHistoryName),FileServices.RemoveSuperFile(InsuranceHeader_Property_Transactions_DeedsMortgages.MatchHistory.MatchHistoryName,ChangeName)),OUTPUT(MM.IdChanges,,ChangeName,OVERWRITE,COMPRESSED),FileServices.AddSuperFile(InsuranceHeader_Property_Transactions_DeedsMortgages.MatchHistory.MatchHistoryName,ChangeName));
//EXPORT LoopN(UNSIGNED N,UNSIGNED mt=Config.MatchThreshold) := LOOP(InFile,N,InsuranceHeader_Property_Transactions_DeedsMortgages.matches(ROWS(LEFT),mt).patched_infile); // Loop N times
//EXPORT LoopThisN(d,N,mt=Config.MatchThreshold,ThinLoop=FALSE) := FUNCTIONMACRO
//	IMPORT InsuranceHeader_Property_Transactions_DeedsMortgages;
//	#IF (ThinLoop=FALSE)
//		RETURN LOOP(PROJECT(d,InsuranceHeader_Property_Transactions_DeedsMortgages.Layout_PROPERTY_TRANSACTION),N,InsuranceHeader_Property_Transactions_DeedsMortgages.matches(ROWS(LEFT),mt).patched_infile);
//	#ELSE
//		RETURN JOIN(d, LOOP(PROJECT(d,InsuranceHeader_Property_Transactions_DeedsMortgages.Layout_PROPERTY_TRANSACTION),N,InsuranceHeader_Property_Transactions_DeedsMortgages.matches(ROWS(LEFT),mt).patched_infile), LEFT.rid=RIGHT.rid, TRANSFORM(RECORDOF(LEFT),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
//	#END
//ENDMACRO;
//EXPORT LoopThisK(d,K,NMax=100,ThinLoop=FALSE) := FUNCTIONMACRO
//	IMPORT InsuranceHeader_Property_Transactions_DeedsMortgages;
//	#IF (ThinLoop=FALSE)
//		RETURN LOOP(PROJECT(d,InsuranceHeader_Property_Transactions_DeedsMortgages.Layout_PROPERTY_TRANSACTION),COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),DPROPTXID,ALL))>K,InsuranceHeader_Property_Transactions_DeedsMortgages.matches(ROWS(LEFT),0).patched_infile);
//	#ELSE
//		RETURN JOIN(d, LOOP(PROJECT(d,InsuranceHeader_Property_Transactions_DeedsMortgages.Layout_PROPERTY_TRANSACTION),COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),DPROPTXID,ALL))>K,InsuranceHeader_Property_Transactions_DeedsMortgages.matches(ROWS(LEFT),0).patched_infile), LEFT.rid=RIGHT.rid, TRANSFORM(RECORDOF(LEFT),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
//	#END
//ENDMACRO;
SHARED LinkPhase(BOOLEAN again) := SEQUENTIAL(PARALLEL(OutputSamples,ExecutionStats,ValidityStats,IF(again,OutputFileA,OutputFile),IF(again,OutputChangesA,OutputChanges) ),IF(Debugging,DebugKeys));
EXPORT DoAll := LinkPhase(FALSE);
EXPORT DoAllAgain := LinkPhase(TRUE);
END;
