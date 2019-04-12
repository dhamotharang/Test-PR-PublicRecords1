//Executable code
IMPORT SALT311;
EXPORT Proc_Iterate(STRING iter,DATASET(Layout_Hdr) InFile = Watchdog_best.In_Hdr,STRING OutFileNameP = '~temp::did::Watchdog_best::it',UNSIGNED MatchThreshold = Config.MatchThreshold,BOOLEAN Debugging = true) := MODULE
SHARED MM := Watchdog_best.matches(InFile, MatchThreshold); // Get the matching module
SHARED S := Specificities(InFile).Specificities[1];
dsOSR := CHOOSEN(MM.MatchSampleRecords,10000);
dsOSL := CHOOSEN(MM.ToSlice,1000);
OSL := OUTPUT(dsOSL,NAMED('SliceOutCandidates'));
OSR := OUTPUT(dsOSR,NAMED('MatchSampleRecords'));
EXPORT OutputSamples := PARALLEL(OSR,OSL);// Provide the records!
SHARED BM := Watchdog_best.BasicMatch(InFile);
dsOMatchSamples := CHOOSEN(MM.MatchSample,1000);
dsOBSamples := CHOOSEN(MM.BorderlineMatchSample,10000);
dsOAS := CHOOSEN(MM.AlmostMatchSample,10000);
dsThr := RECORD
  UNSIGNED BasicMatchThreshold := Config.BasicMatchThreshold;
  UNSIGNED MatchThreshold := MatchThreshold;
  UNSIGNED LowerMatchThreshold := MatchThreshold-3; // as defined in matches/Debug (not Underlinks)
  UNSIGNED IntraMatchThreshold := MatchThreshold-3 - Config.SliceDistance;
END;
mtch := Debug(InFile, S, MatchThreshold).AnnotateMatches(MM.PossibleMatches);
MSD :=
  ENTH(mtch(Conf<MatchThreshold,Conf>=MatchThreshold-3),500) +
  ENTH(mtch(Conf=MatchThreshold),500) +
  ENTH(mtch(Conf>MatchThreshold,Conf<=MatchThreshold+3),500);
OMatchSamples := OUTPUT(dsOMatchSamples,NAMED('MatchSample'));
OBSamples := OUTPUT(dsOBSamples,NAMED('BorderlineMatchSample'));
OAS := OUTPUT(dsOAS,NAMED('AlmostMatchSample'));
BMS := OUTPUT(CHOOSEN(BM.patch_file, 1000), NAMED('BasicMatch_Patch_File'));
Thr := OUTPUT(ROW(dsThr),NAMED('Thresholds'));
OMSD := OUTPUT(MSD,NAMED('MatchSampleDebug'),ALL);
EXPORT OutputExtraSamples := PARALLEL(OMatchSamples, OBSamples, OAS, BMS, Thr, OMSD); // This is not called automatically - call yourself if you want them!
dsMPSP := DATASET([{'MatchesPerformed', MM.MatchesPerformed}, {'BasicMatchesPerformed', BM.basic_match_count}, {'SlicesPerformed', MM.SlicesPerformed}], {STRING label, UNSIGNED value});
dsPS := DATASET([{'PropagationAssisted_Pcnt', MM.MatchesPropAssisted * 100 / MM.MatchesPerformed}, {'PropagationRequired_Pcnt', MM.MatchesPropRequired * 100 / MM.MatchesPerformed}], {STRING label, UNSIGNED Pcnt});
dsRE := TOPN(MM.RuleEfficacy,1000,RuleNumber);
dsCB := TOPN(MM.ConfidenceBreakdown,1000,conf);
OS := OUTPUT(Watchdog_best.Specificities(InFile).specificities,NAMED('Specificities'));
OPRP := OUTPUT(Watchdog_best.match_candidates(InFile).prepropogationstats,NAMED('PrePopStats'));
OPP := OUTPUT(Watchdog_best.match_candidates(InFile).postpropogationstats,NAMED('PostPopStats'));
PRPPS := OUTPUT(MM.PreIds.IdCounts,NAMED('PreClusterCount'));
PRPP := OUTPUT(MM.PreIds.did_Clusters,NAMED('PreClusters'),ALL);
PPPS := OUTPUT(MM.PostIds.IdCounts,NAMED('PostClusterCount'));
PPP := OUTPUT(MM.PostIds.did_Clusters,NAMED('PostClusters'),ALL);
SpcS := OUTPUT(Watchdog_best.Specificities(InFile).SpcShift,NAMED('SPCShift'));
MPSP := OUTPUT(dsMPSP, NAMED('MatchStatistics'));
PS := OUTPUT(dsPS, NAMED('PropogationStats'));
RE := OUTPUT(dsRE,NAMED('RuleEfficacy'));
CB := OUTPUT(dsCB,NAMED('ConfidenceLevels'));
EXPORT ExecutionStats := PARALLEL(OS,SpcS,PRPP,PPP,PRPPS,PPPS,MPSP,RE,CB, PS,OPRP,OPP);
dsValidityStats := DATASET([{MM.PatchingError0,MM.DuplicateRids0,COUNT(Watchdog_best.match_candidates(InFile).Unlinkables)}],{INTEGER PatchingError0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0});
EXPORT ValidityStats := PARALLEL( OUTPUT(dsValidityStats,NAMED('ValidityStatistics')), OUTPUT(MM.PostIds.Advanced0,NAMED('IdConsistency0')));
EXPORT InputValidityStats := OUTPUT(MM.PreIds.Advanced0,NAMED('InputIdConsistency0'));
EXPORT DebugKeys := Keys(InFile).BuildAll;
EXPORT OutputFileName := OutFileNameP+iter;
EXPORT OutputFile := OUTPUT(MM.patched_infile,,OutputFileName,COMPRESSED);// Change file for each iteration
EXPORT OutputFileA := OUTPUT(MM.patched_infile,,OutputFileName,OVERWRITE,COMPRESSED);// Change file for each iteration
SHARED ChangeName := '~temp::did::Watchdog_best::changes_it'+iter;
EXPORT OutputChanges := SEQUENTIAL( OUTPUT(MM.IdChanges,,ChangeName,OVERWRITE,COMPRESSED),FileServices.AddSuperFile(MatchHistory.MatchHistoryName,ChangeName));
EXPORT OutputChangesA := SEQUENTIAL( IF(FileServices.SuperFileExists(Watchdog_best.MatchHistory.MatchHistoryName),FileServices.RemoveSuperFile(Watchdog_best.MatchHistory.MatchHistoryName,ChangeName)),OUTPUT(MM.IdChanges,,ChangeName,OVERWRITE,COMPRESSED),FileServices.AddSuperFile(Watchdog_best.MatchHistory.MatchHistoryName,ChangeName));
//EXPORT LoopN(UNSIGNED N, UNSIGNED mt=Config.MatchThreshold) := LOOP(InFile,N,Watchdog_best.matches(ROWS(LEFT), mt).patched_infile); // Loop N times
//EXPORT LoopThisN(d,N,mt=Config.MatchThreshold,ThinLoop=FALSE) := FUNCTIONMACRO
//	IMPORT Watchdog_best;
//	#IF (ThinLoop=FALSE)
//		RETURN LOOP(PROJECT(d,Watchdog_best.Layout_Hdr),N,Watchdog_best.matches(ROWS(LEFT), mt).patched_infile);
//	#ELSE
//		RETURN JOIN(d, LOOP(PROJECT(d,Watchdog_best.Layout_Hdr),N,Watchdog_best.matches(ROWS(LEFT), mt).patched_infile), LEFT.rid=RIGHT.rid, TRANSFORM(RECORDOF(LEFT),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
//	#END
//ENDMACRO;
//EXPORT LoopThisK(d,K,NMax=100,ThinLoop=FALSE) := FUNCTIONMACRO
//	IMPORT Watchdog_best;
//	#IF (ThinLoop=FALSE)
//		RETURN LOOP(PROJECT(d,Watchdog_best.Layout_Hdr),COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),did,ALL))>K,Watchdog_best.matches(ROWS(LEFT), 0).patched_infile);
//	#ELSE
//		RETURN JOIN(d, LOOP(PROJECT(d,Watchdog_best.Layout_Hdr),COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),did,ALL))>K,Watchdog_best.matches(ROWS(LEFT), 0).patched_infile), LEFT.rid=RIGHT.rid, TRANSFORM(RECORDOF(LEFT),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
//	#END
//ENDMACRO;
SHARED LinkPhase(BOOLEAN again) := SEQUENTIAL(PARALLEL(OutputSamples,ExecutionStats,ValidityStats,IF(again,OutputFileA,OutputFile),IF(again,OutputChangesA,OutputChanges) ),IF(Debugging,DebugKeys));
EXPORT DoAll := LinkPhase(FALSE);
EXPORT DoAllAgain := LinkPhase(TRUE);
END;
