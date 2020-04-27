﻿//Executable code
IMPORT SALT311;
EXPORT Proc_Iterate(STRING iter,string keyversion/*HACKProcIterate01 -- add keyversion*/,DATASET(Layout_DOT_Base) InFile = BIPV2_ProxID.In_DOT_Base,STRING OutFileNameP = '~temp::Proxid::BIPV2_ProxID::it',UNSIGNED MatchThreshold = Config.MatchThreshold,BOOLEAN Debugging = true) := MODULE
SHARED MM := BIPV2_ProxID.matches(InFile, MatchThreshold); // Get the matching module
SHARED S := Specificities(InFile).Specificities[1];
dsOSR := CHOOSEN(MM.MatchSampleRecords,1000)/* HACKProcIterate04 lower match sample records output*/;
OSR := OUTPUT(dsOSR,NAMED('MatchSampleRecords'));
EXPORT OutputSamples := OSR;// Provide the records!
SHARED BM := BIPV2_ProxID.BasicMatch(InFile);
dsBMSF := CHOOSEN(BM.Block, 1000);
dsOMatchSamples := CHOOSEN(MM.MatchSample,1000);
dsOBSamples := CHOOSEN(MM.BorderlineMatchSample,10000);
dsOAS := CHOOSEN(MM.AlmostMatchSample,10000);
dsThr := RECORD
  UNSIGNED BasicMatchThreshold := Config.BasicMatchThreshold;
  UNSIGNED MatchThreshold := MatchThreshold;
  UNSIGNED LowerMatchThreshold := MatchThreshold-3; // as defined in matches/Debug (not Underlinks)
  UNSIGNED IntraMatchThreshold := MatchThreshold-3 /*- Config.SliceDistance*//*HACKProcIterate05*/;
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
BMSF := OUTPUT(dsBMSF, NAMED ('BasicMatch_Block'));
EXPORT OutputExtraSamples := PARALLEL(OMatchSamples, OBSamples, OAS, BMS, Thr, OMSD, BMSF); // This is not called automatically - call yourself if you want them!
dsMPSP := DATASET([{'MatchesPerformed', MM.MatchesPerformed}, {'BasicMatchesPerformed', BM.basic_match_count}], {STRING label, UNSIGNED value});
dsPS := DATASET([{'PropagationAssisted_Pcnt', MM.MatchesPropAssisted * 100 / MM.MatchesPerformed}, {'PropagationRequired_Pcnt', MM.MatchesPropRequired * 100 / MM.MatchesPerformed}], {STRING label, UNSIGNED Pcnt});
dsRE := TOPN(MM.RuleEfficacy,1000,RuleNumber);
dsCB := TOPN(MM.ConfidenceBreakdown,1000,conf);
dsLBS := MM.LinkBlocksPerformed;
dsLBR := MM.LinkBlocksRulesUsedVsTotal;
OS := OUTPUT(BIPV2_ProxID.Specificities(InFile).specificities,NAMED('Specificities'));
OPRP := OUTPUT(BIPV2_ProxID.match_candidates(InFile).prepropogationstats,NAMED('PrePopStats'));
OPP := OUTPUT(BIPV2_ProxID.match_candidates(InFile).postpropogationstats,NAMED('PostPopStats'));
PRPPS := OUTPUT(MM.PreIds.IdCounts,NAMED('PreClusterCount'));
PRPP := OUTPUT(MM.PreIds.Proxid_Clusters,NAMED('PreClusters'),ALL);
PPPS := OUTPUT(MM.PostIds.IdCounts,NAMED('PostClusterCount'));
PPP := OUTPUT(MM.PostIds.Proxid_Clusters,NAMED('PostClusters'),ALL);
SpcS := OUTPUT(BIPV2_ProxID.Specificities(InFile).SpcShift,NAMED('SPCShift'));
LBS := OUTPUT(dsLBS,NAMED('LinkBlockSplits'));
LBR := OUTPUT(dsLBR,NAMED('LinkBlocksRulesUsedVsTotal'));
MPSP := OUTPUT(dsMPSP, NAMED('MatchStatistics'));
PS := OUTPUT(dsPS, NAMED('PropogationStats'));
RE := OUTPUT(dsRE,NAMED('RuleEfficacy'));
CB := OUTPUT(dsCB,NAMED('ConfidenceLevels'));
EXPORT ExecutionStats := PARALLEL(OS,SpcS,PRPP,PPP,PRPPS,PPPS,MPSP,RE,CB, PS,OPRP,OPP,LBS);
dsValidityStats := DATASET([{MM.PatchingError0,MM.DuplicateRids0,COUNT(BIPV2_ProxID.match_candidates(InFile).Unlinkables),COUNT(BIPV2_ProxID.Specificities(InFile).Rejected_file),COUNT(LinkBlockers(InFile).RuleBreakers0), COUNT(LinkBlockers(InFile).Patches_dirty_rids0), COUNT(LinkBlockers(InFile).Patches_dirty0)}],{INTEGER PatchingError0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0,UNSIGNED RecordsRejected0,UNSIGNED LinkBlockRuleBreakers0,UNSIGNED LinkBlockPatches_dirty_rids0, UNSIGNED LinkBlockPatches_dirty0});
EXPORT ValidityStats := PARALLEL( OUTPUT(dsValidityStats,NAMED('ValidityStatistics')), OUTPUT(MM.PostIds.Advanced0,NAMED('IdConsistency0')));
EXPORT InputValidityStats := OUTPUT(MM.PreIds.Advanced0,NAMED('InputIdConsistency0'));
EXPORT DebugKeys := Keys(InFile,keyversion).BuildAll; // HACKProcIterate02 keys to add keyersion
EXPORT OutputFileName := OutFileNameP+iter;
EXPORT OutputFile := OUTPUT(MM.patched_infile,,OutputFileName,COMPRESSED);// Change file for each iteration
EXPORT OutputFileA := OUTPUT(MM.patched_infile,,OutputFileName,OVERWRITE,COMPRESSED);// Change file for each iteration
SHARED ChangeName := '~temp::Proxid::BIPV2_ProxID::changes_it'+keyversion;/* HACKProcIterate03 use keyversion for changes file*/
EXPORT OutputChanges := SEQUENTIAL( OUTPUT(MM.IdChanges,,ChangeName,OVERWRITE,COMPRESSED),FileServices.AddSuperFile(MatchHistory.MatchHistoryName,ChangeName));
EXPORT OutputChangesA := SEQUENTIAL( IF(FileServices.SuperFileExists(BIPV2_ProxID.MatchHistory.MatchHistoryName),FileServices.RemoveSuperFile(BIPV2_ProxID.MatchHistory.MatchHistoryName,ChangeName)),OUTPUT(MM.IdChanges,,ChangeName,OVERWRITE,COMPRESSED),FileServices.AddSuperFile(BIPV2_ProxID.MatchHistory.MatchHistoryName,ChangeName));
//EXPORT LoopN(UNSIGNED N, UNSIGNED mt=Config.MatchThreshold) := LOOP(InFile,N,BIPV2_ProxID.matches(ROWS(LEFT), mt).patched_infile); // Loop N times
//EXPORT LoopThisN(d,N,mt=Config.MatchThreshold,ThinLoop=FALSE) := FUNCTIONMACRO
//	IMPORT BIPV2_ProxID;
//	#IF (ThinLoop=FALSE)
//		RETURN LOOP(PROJECT(d,BIPV2_ProxID.Layout_DOT_Base),N,BIPV2_ProxID.matches(ROWS(LEFT), mt).patched_infile);
//	#ELSE
//		RETURN JOIN(d, LOOP(PROJECT(d,BIPV2_ProxID.Layout_DOT_Base),N,BIPV2_ProxID.matches(ROWS(LEFT), mt).patched_infile), LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(LEFT),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
//	#END
//ENDMACRO;
//EXPORT LoopThisK(d,K,NMax=100,ThinLoop=FALSE) := FUNCTIONMACRO
//	IMPORT BIPV2_ProxID;
//	#IF (ThinLoop=FALSE)
//		RETURN LOOP(PROJECT(d,BIPV2_ProxID.Layout_DOT_Base),COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),Proxid,ALL))>K,BIPV2_ProxID.matches(ROWS(LEFT), 0).patched_infile);
//	#ELSE
//		RETURN JOIN(d, LOOP(PROJECT(d,BIPV2_ProxID.Layout_DOT_Base),COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),Proxid,ALL))>K,BIPV2_ProxID.matches(ROWS(LEFT), 0).patched_infile), LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(LEFT),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
//	#END
//ENDMACRO;
SHARED LinkPhase(BOOLEAN again) := SEQUENTIAL(PARALLEL(OutputSamples,ExecutionStats,ValidityStats,IF(again,OutputFileA,OutputFile),IF(again,OutputChangesA,OutputChanges) ),IF(Debugging,DebugKeys));
//Perform the build of the cleave indexes - prior to remainder of work
SHARED WithCleave(BOOLEAN again) := IF(Config.ByPassCleave,LinkPhase(Again),SEQUENTIAL( Cleave(InFile).BuildAll, LinkPhase(Again) ));
EXPORT DoAll := WithCleave(FALSE);
EXPORT DoAllAgain := WithCleave(TRUE);
END;
