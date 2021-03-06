//Executable code
IMPORT SALT311;
EXPORT Proc_Iterate(STRING iter,DATASET(Layout_LGID3) InFile = BIPV2_LGID3.In_LGID3,STRING OutFileNameP = '~temp::LGID3::BIPV2_LGID3::it',UNSIGNED MatchThreshold = Config.MatchThreshold,BOOLEAN Debugging = true) := MODULE
SHARED MM := BIPV2_LGID3.matches(InFile, MatchThreshold); // Get the matching module
SHARED S := Specificities(InFile).Specificities[1];
dsOSR := CHOOSEN(MM.MatchSampleRecords,10000);
dsOSL := CHOOSEN(MM.ToSlice,1000);
OSL := OUTPUT(dsOSL,NAMED('SliceOutCandidates'));
OSR := OUTPUT(dsOSR,NAMED('MatchSampleRecords'));
EXPORT OutputSamples := PARALLEL(OSR,OSL);// Provide the records!
SHARED BM := BIPV2_LGID3.BasicMatch(InFile);
/*HACKProcIterate02*/ //dsBMSF := CHOOSEN(BM.Block, 1000);
dsOMatchSamples := CHOOSEN(MM.MatchSample,1000);
dsOBSamples := CHOOSEN(MM.BorderlineMatchSample,10000);
dsOAS := CHOOSEN(MM.AlmostMatchSample,10000);
dsThr := RECORD
  UNSIGNED BasicMatchThreshold := Config.BasicMatchThreshold;
  UNSIGNED MatchThreshold := MatchThreshold;
  UNSIGNED LowerMatchThreshold := MatchThreshold-3; // as defined in matches/Debug (not Underlinks)
  UNSIGNED IntraMatchThreshold := MatchThreshold-3 - Config.SliceDistance;
END;
mtch := Debug(InFile, S, MatchThreshold).AnnotateMatches(MM.PossibleMatches,MM.All_Attribute_Matches);
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
/*HACKProcIterate03*/ //BMSF := OUTPUT(dsBMSF, NAMED ('BasicMatch_Block'));
/*HACKProcIterate03*/ //EXPORT OutputExtraSamples := PARALLEL(OMatchSamples, OBSamples, OAS, BMS, Thr, OMSD, BMSF); // This is not called automatically - call yourself if you want them!
dsMPSP := DATASET([{'MatchesPerformed', MM.MatchesPerformed}, {'BasicMatchesPerformed', BM.basic_match_count}, {'SlicesPerformed', MM.SlicesPerformed}], {STRING label, UNSIGNED value});
dsPS := DATASET([{'PropagationAssisted_Pcnt', MM.MatchesPropAssisted * 100 / MM.MatchesPerformed}, {'PropagationRequired_Pcnt', MM.MatchesPropRequired * 100 / MM.MatchesPerformed}], {STRING label, UNSIGNED Pcnt});
dsRE := TOPN(MM.RuleEfficacy,1000,RuleNumber);
dsCB := TOPN(MM.ConfidenceBreakdown,1000,conf);
dsLBS := MM.LinkBlocksPerformed;
dsLBR := MM.LinkBlocksRulesUsedVsTotal;
OS := OUTPUT(BIPV2_LGID3.Specificities(InFile).specificities,NAMED('Specificities'));
OPRP := OUTPUT(BIPV2_LGID3.match_candidates(InFile).prepropogationstats,NAMED('PrePopStats'));
OPP := OUTPUT(BIPV2_LGID3.match_candidates(InFile).postpropogationstats,NAMED('PostPopStats'));
PRPPS := OUTPUT(MM.PreIds.IdCounts,NAMED('PreClusterCount'));
PRPP := OUTPUT(MM.PreIds.LGID3_Clusters,NAMED('PreClusters'),ALL);
PPPS := OUTPUT(MM.PostIds.IdCounts,NAMED('PostClusterCount'));
PPP := OUTPUT(MM.PostIds.LGID3_Clusters,NAMED('PostClusters'),ALL);
SpcS := OUTPUT(BIPV2_LGID3.Specificities(InFile).SpcShift,NAMED('SPCShift'));
LBS := OUTPUT(dsLBS,NAMED('LinkBlockSplits'));
LBR := OUTPUT(dsLBR,NAMED('LinkBlocksRulesUsedVsTotal'));
MPSP := OUTPUT(dsMPSP, NAMED('MatchStatistics'));
PS := OUTPUT(dsPS, NAMED('PropogationStats'));
RE := OUTPUT(dsRE,NAMED('RuleEfficacy'));
CB := OUTPUT(dsCB,NAMED('ConfidenceLevels'));
EXPORT ExecutionStats := PARALLEL(OS,SpcS,PRPP,PPP,PRPPS,PPPS,MPSP,RE,CB, PS,OPRP,OPP,LBS);
dsValidityStats := DATASET([{MM.PatchingError0,MM.DuplicateRids0,COUNT(BIPV2_LGID3.match_candidates(InFile).Unlinkables),COUNT(BIPV2_LGID3.Specificities(InFile).Rejected_file),COUNT(LinkBlockers(InFile).RuleBreakers0), COUNT(LinkBlockers(InFile).Patches_dirty_rids0), COUNT(LinkBlockers(InFile).Patches_dirty0)}],{INTEGER PatchingError0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0,UNSIGNED RecordsRejected0,UNSIGNED LinkBlockRuleBreakers0,UNSIGNED LinkBlockPatches_dirty_rids0, UNSIGNED LinkBlockPatches_dirty0});
EXPORT ValidityStats := PARALLEL( OUTPUT(dsValidityStats,NAMED('ValidityStatistics')), OUTPUT(MM.PostIds.Advanced0,NAMED('IdConsistency0')));
EXPORT InputValidityStats := OUTPUT(MM.PreIds.Advanced0,NAMED('InputIdConsistency0'));
EXPORT DebugKeys := Keys(InFile).BuildAll;
EXPORT OutputFileName := OutFileNameP+iter;
EXPORT OutputFile := OUTPUT(MM.patched_infile,,OutputFileName,COMPRESSED);// Change file for each iteration
EXPORT OutputFileA := OUTPUT(MM.patched_infile,,OutputFileName,OVERWRITE,COMPRESSED);// Change file for each iteration
/*HACKProcIterate01*/import bipv2;
SHARED ChangeName := '~temp::LGID3::BIPV2_LGID3::changes_it'+iter+'_'+ bipv2.KeySuffix;
EXPORT OutputChanges := SEQUENTIAL( OUTPUT(MM.IdChanges,,ChangeName,OVERWRITE,COMPRESSED),FileServices.AddSuperFile(MatchHistory.MatchHistoryName,ChangeName));
EXPORT OutputChangesA := SEQUENTIAL( IF(FileServices.SuperFileExists(BIPV2_LGID3.MatchHistory.MatchHistoryName),FileServices.RemoveSuperFile(BIPV2_LGID3.MatchHistory.MatchHistoryName,ChangeName)),OUTPUT(MM.IdChanges,,ChangeName,OVERWRITE,COMPRESSED),FileServices.AddSuperFile(BIPV2_LGID3.MatchHistory.MatchHistoryName,ChangeName));
//EXPORT LoopN(UNSIGNED N, UNSIGNED mt=Config.MatchThreshold) := LOOP(InFile,N,BIPV2_LGID3.matches(ROWS(LEFT), mt).patched_infile); // Loop N times
//EXPORT LoopThisN(d,N,mt=Config.MatchThreshold,ThinLoop=FALSE) := FUNCTIONMACRO
//	IMPORT BIPV2_LGID3;
//	#IF (ThinLoop=FALSE)
//		RETURN LOOP(PROJECT(d,BIPV2_LGID3.Layout_LGID3),N,BIPV2_LGID3.matches(ROWS(LEFT), mt).patched_infile);
//	#ELSE
//		RETURN JOIN(d, LOOP(PROJECT(d,BIPV2_LGID3.Layout_LGID3),N,BIPV2_LGID3.matches(ROWS(LEFT), mt).patched_infile), LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(LEFT),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
//	#END
//ENDMACRO;
//EXPORT LoopThisK(d,K,NMax=100,ThinLoop=FALSE) := FUNCTIONMACRO
//	IMPORT BIPV2_LGID3;
//	#IF (ThinLoop=FALSE)
//		RETURN LOOP(PROJECT(d,BIPV2_LGID3.Layout_LGID3),COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),LGID3,ALL))>K,BIPV2_LGID3.matches(ROWS(LEFT), 0).patched_infile);
//	#ELSE
//		RETURN JOIN(d, LOOP(PROJECT(d,BIPV2_LGID3.Layout_LGID3),COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),LGID3,ALL))>K,BIPV2_LGID3.matches(ROWS(LEFT), 0).patched_infile), LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(LEFT),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
//	#END
//ENDMACRO;
SHARED LinkPhase(BOOLEAN again) := SEQUENTIAL(PARALLEL(OutputSamples,ExecutionStats,ValidityStats,IF(again,OutputFileA,OutputFile),IF(again,OutputChangesA,OutputChanges) ),IF(Debugging,DebugKeys));
EXPORT DoAll := LinkPhase(FALSE);
EXPORT DoAllAgain := LinkPhase(TRUE);
END;
