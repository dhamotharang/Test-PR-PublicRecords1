//Executable code
IMPORT SALT35;
EXPORT Proc_Iterate(STRING iter,DATASET(Layout_POWID_Down) InFile = BIPV2_POWID_Down.In_POWID_Down,STRING OutFileNameP = '~temp::POWID::BIPV2_POWID_Down::it',UNSIGNED MatchThreshold = Config.MatchThreshold,BOOLEAN Debugging = true) := MODULE
SHARED MM := BIPV2_POWID_Down.matches(InFile,MatchThreshold); // Get the matching module
OSR := OUTPUT(CHOOSEN(MM.MatchSampleRecords,10000),NAMED('MatchSampleRecords'));
EXPORT OutputSamples := OSR;// Provide the records!
SHARED BM := BIPV2_POWID_Down.BasicMatch(InFile);
BMS := OUTPUT(CHOOSEN(BM.patch_file, 1000), NAMED('BasicMatch_Patch_File'));
OMatchSamples := OUTPUT(CHOOSEN(MM.MatchSample,1000),NAMED('MatchSample'));
OBSamples := OUTPUT(CHOOSEN(MM.BorderlineMatchSample,10000),NAMED('BorderlineMatchSample'));
OAS := OUTPUT(CHOOSEN(MM.AlmostMatchSample,10000),NAMED('AlmostMatchSample'));
EXPORT OutputExtraSamples := PARALLEL(OMatchSamples, OBSamples, OAS, BMS); // This is not called automatically - call yourself if you want them!
OS := OUTPUT(BIPV2_POWID_Down.specificities(InFile).specificities,NAMED('Specificities'));
OPRP := OUTPUT(BIPV2_POWID_Down.match_candidates(InFile).prepropogationstats,NAMED('PrePopStats'));
OPP := OUTPUT(BIPV2_POWID_Down.match_candidates(InFile).postpropogationstats,NAMED('PostPopStats'));
PRPPS := OUTPUT(MM.PreIds.IdCounts,NAMED('PreClusterCount'));
PRPP := OUTPUT(MM.PreIds.POWID_Clusters,NAMED('PreClusters'),ALL);
PPPS := OUTPUT(MM.PostIds.IdCounts,NAMED('PostClusterCount'));
PPP := OUTPUT(MM.PostIds.POWID_Clusters,NAMED('PostClusters'),ALL);
MPSP := OUTPUT(DATASET([{'MatchesPerformed', MM.MatchesPerformed}, {'BasicMatchesPerformed', BIPV2_POWID_Down.BasicMatch(InFile).basic_match_count}], {STRING label, UNSIGNED value}), NAMED('MatchStatistics'));
PS := OUTPUT(DATASET([{'PropagationAssisted_Pcnt', MM.MatchesPropAssisted * 100 / MM.MatchesPerformed}, {'PropagationRequired_Pcnt', MM.MatchesPropRequired * 100 / MM.MatchesPerformed}], {STRING label, UNSIGNED Pcnt}), NAMED('PropogationStats'));
RE := OUTPUT(TOPN(MM.RuleEfficacy,1000,RuleNumber),NAMED('RuleEfficacy'));
CB := OUTPUT(TOPN(MM.ConfidenceBreakdown,1000,conf),NAMED('ConfidenceLevels'));
SpcS := OUTPUT(BIPV2_POWID_Down.specificities(InFile).SpcShift,NAMED('SPCShift'));
EXPORT ExecutionStats := PARALLEL(OS,SpcS,PRPP,PPP,PRPPS,PPPS,MPSP,RE,CB, PS,OPRP,OPP);
d := DATASET([{MM.PatchingError0,MM.DuplicateRids0,COUNT(BIPV2_POWID_Down.match_candidates(InFile).Unlinkables)}],{INTEGER PatchingError0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0});
EXPORT ValidityStats := PARALLEL( OUTPUT(d,NAMED('ValidityStatistics')), OUTPUT(MM.PostIds.Advanced0,NAMED('IdConsistency0')));
EXPORT InputValidityStats := OUTPUT(MM.PreIds.Advanced0,NAMED('InputIdConsistency0'));
EXPORT DebugKeys := Keys(InFile).BuildAll;
EXPORT OutputFileName := OutFileNameP+iter;
EXPORT OutputFile := OUTPUT(MM.patched_infile,,OutputFileName,COMPRESSED);// Change file for each iteration
EXPORT OutputFileA := OUTPUT(MM.patched_infile,,OutputFileName,OVERWRITE,COMPRESSED);// Change file for each iteration
SHARED ChangeName := '~temp::POWID::BIPV2_POWID_Down::changes_it'+iter;
EXPORT OutputChanges := SEQUENTIAL( OUTPUT(MM.IdChanges,,ChangeName,OVERWRITE,COMPRESSED),FileServices.AddSuperFile(MatchHistory.MatchHistoryName,ChangeName));
EXPORT OutputChangesA := SEQUENTIAL( IF(FileServices.SuperFileExists(BIPV2_POWID_Down.MatchHistory.MatchHistoryName),FileServices.RemoveSuperFile(BIPV2_POWID_Down.MatchHistory.MatchHistoryName,ChangeName)),OUTPUT(MM.IdChanges,,ChangeName,OVERWRITE,COMPRESSED),FileServices.AddSuperFile(BIPV2_POWID_Down.MatchHistory.MatchHistoryName,ChangeName));
//EXPORT LoopN(UNSIGNED N,UNSIGNED mt=Config.MatchThreshold) := LOOP(InFile,N,BIPV2_POWID_Down.matches(ROWS(LEFT),mt).patched_infile); // Loop N times
//EXPORT LoopThisN(d,N,mt=Config.MatchThreshold,ThinLoop=FALSE) := FUNCTIONMACRO
//	IMPORT BIPV2_POWID_Down;
//	#IF (ThinLoop=FALSE)
//		RETURN LOOP(PROJECT(d,BIPV2_POWID_Down.Layout_POWID_Down),N,BIPV2_POWID_Down.matches(ROWS(LEFT),mt).patched_infile);
//	#ELSE
//		RETURN JOIN(d, LOOP(PROJECT(d,BIPV2_POWID_Down.Layout_POWID_Down),N,BIPV2_POWID_Down.matches(ROWS(LEFT),mt).patched_infile), LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(LEFT),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
//	#END
//ENDMACRO;
//EXPORT LoopThisK(d,K,NMax=100,ThinLoop=FALSE) := FUNCTIONMACRO
//	IMPORT BIPV2_POWID_Down;
//	#IF (ThinLoop=FALSE)
//		RETURN LOOP(PROJECT(d,BIPV2_POWID_Down.Layout_POWID_Down),COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),POWID,ALL))>K,BIPV2_POWID_Down.matches(ROWS(LEFT),0).patched_infile);
//	#ELSE
//		RETURN JOIN(d, LOOP(PROJECT(d,BIPV2_POWID_Down.Layout_POWID_Down),COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),POWID,ALL))>K,BIPV2_POWID_Down.matches(ROWS(LEFT),0).patched_infile), LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(LEFT),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
//	#END
//ENDMACRO;
SHARED LinkPhase(BOOLEAN again) := SEQUENTIAL(PARALLEL(OutputSamples,ExecutionStats,ValidityStats,IF(again,OutputFileA,OutputFile),IF(again,OutputChangesA,OutputChanges) ),IF(Debugging,DebugKeys));
EXPORT DoAll := LinkPhase(FALSE);
EXPORT DoAllAgain := LinkPhase(TRUE);
END;
