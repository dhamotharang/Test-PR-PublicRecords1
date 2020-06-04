//Executable code
EXPORT Proc_Iterate(string pversion/*HACK*/,string iter,DATASET(Layout_DOT) InFile0 = BIPV2_DOTID_PLATFORM.In_DOT,STRING OutFileNameP = '~temp::DOTid::BIPV2_DOTID_PLATFORM::it',UNSIGNED MatchThreshold = Config.MatchThreshold,BOOLEAN Debugging = true) := MODULE
SHARED InFile := InFile0;
SHARED MM := BIPV2_DOTID_PLATFORM.matches(InFile,MatchThreshold); // Get the matching module
OSR := OUTPUT(CHOOSEN(MM.MatchSampleRecords,10000),NAMED('MatchSampleRecords'));
EXPORT OutputSamples := OSR;// Provide the records!
SHARED BM := BIPV2_DOTID_PLATFORM.BasicMatch(InFile);
BMS := OUTPUT(CHOOSEN(BM.patch_file, 1000), NAMED('BasicMatch_Patch_File'));
OMatchSamples := OUTPUT(CHOOSEN(MM.MatchSample,1000),NAMED('MatchSample'));
OBSamples := OUTPUT(CHOOSEN(MM.BorderlineMatchSample,10000),NAMED('BorderlineMatchSample'));
OAS := OUTPUT(CHOOSEN(MM.AlmostMatchSample,10000),NAMED('AlmostMatchSample'));
EXPORT OutputExtraSamples := PARALLEL(OMatchSamples, OBSamples, OAS, BMS); // This is not called automatically - call yourself if you want them!
OS := OUTPUT(BIPV2_DOTID_PLATFORM.specificities(InFile).specificities,NAMED('Specificities'));
OPRP := OUTPUT(BIPV2_DOTID_PLATFORM.match_candidates(InFile).prepropogationstats,NAMED('PrePopStats'));
OPP := OUTPUT(BIPV2_DOTID_PLATFORM.match_candidates(InFile).postpropogationstats,NAMED('PostPopStats'));
PRPPS := OUTPUT(MM.PreIds.IdCounts,NAMED('PreClusterCount'));
PRPP := OUTPUT(MM.PreIds.DOTid_Clusters,NAMED('PreClusters'),ALL);
PPPS := OUTPUT(MM.PostIds.IdCounts,NAMED('PostClusterCount'));
PPP := OUTPUT(MM.PostIds.DOTid_Clusters,NAMED('PostClusters'),ALL);
MP := PARALLEL( OUTPUT(MM.MatchesPerformed,NAMED('MatchesPerformed')),OUTPUT(BIPV2_DOTID_PLATFORM.BasicMatch(InFile).basic_match_count,NAMED('BasicMatchesPerformed')));
MPPA := OUTPUT(MM.MatchesPropAssisted * 100 / MM.MatchesPerformed,NAMED('PropagationAssisted_Pcnt'));
MPPR := OUTPUT(MM.MatchesPropRequired * 100 / MM.MatchesPerformed,NAMED('PropagationRequired_Pcnt'));
RE := OUTPUT(TOPN(MM.RuleEfficacy,1000,RuleNumber),NAMED('RuleEfficacy'));
CB := OUTPUT(TOPN(MM.ConfidenceBreakdown,1000,conf),NAMED('ConfidenceLevels'));
SpcS := OUTPUT(BIPV2_DOTID_PLATFORM.specificities(InFile).SpcShift,NAMED('SPCShift'));
EXPORT ExecutionStats := PARALLEL(OS,SpcS,PRPP,PPP,PRPPS,PPPS,MP,RE,CB,MPPA,MPPR,OPRP,OPP);
d := DATASET([{MM.PatchingError0,MM.DuplicateRids0,COUNT(BIPV2_DOTID_PLATFORM.match_candidates(InFile).Unlinkables),COUNT(BIPV2_DOTID_PLATFORM.specificities(InFile).Rejected_file)}],{INTEGER PatchingError0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0,UNSIGNED RecordsRejected0});
EXPORT ValidityStats := PARALLEL( OUTPUT(d,NAMED('ValidityStatistics')), OUTPUT(MM.PostIds.Advanced0,NAMED('IdConsistency0')));
EXPORT InputValidityStats := OUTPUT(MM.PreIds.Advanced0,NAMED('InputIdConsistency0'));
EXPORT DebugKeys := Keys(InFile).BuildAll;
EXPORT OutputFileName := OutFileNameP+iter;
EXPORT OutputFile := OUTPUT(MM.patched_infile,,OutputFileName,COMPRESSED);// Change file for each iteration
EXPORT OutputFileA := OUTPUT(MM.patched_infile,,OutputFileName,OVERWRITE,COMPRESSED);// Change file for each iteration
import bipv2;
SHARED ChangeName := '~temp::DOTid::BIPV2_DOTID_PLATFORM::changes_it'+iter+'_'+ pversion/*HACK*/;
EXPORT OutputChanges := SEQUENTIAL( OUTPUT(MM.IdChanges,,ChangeName,OVERWRITE,COMPRESSED),FileServices.AddSuperFile(Keys(InFile).MatchHistoryName,ChangeName));
EXPORT OutputChangesA := SEQUENTIAL( IF(FileServices.SuperFileExists(BIPV2_DOTID_PLATFORM.Keys(InFile).MatchHistoryName),FileServices.RemoveSuperFile(BIPV2_DOTID_PLATFORM.Keys(InFile).MatchHistoryName,ChangeName)),OUTPUT(MM.IdChanges,,ChangeName,OVERWRITE,COMPRESSED),FileServices.AddSuperFile(BIPV2_DOTID_PLATFORM.Keys(InFile).MatchHistoryName,ChangeName));
//EXPORT LoopN(UNSIGNED N,UNSIGNED mt=Config.MatchThreshold) := LOOP(InFile,N,BIPV2_DOTID_PLATFORM.matches(ROWS(LEFT),mt).patched_infile); // Loop N times
//EXPORT LoopThisN(d,N,mt=Config.MatchThreshold,ThinLoop=FALSE) := FUNCTIONMACRO
//	IMPORT BIPV2_DOTID_PLATFORM;
//	#IF (ThinLoop=FALSE)
//		RETURN LOOP(PROJECT(d,BIPV2_DOTID_PLATFORM.Layout_DOT),N,BIPV2_DOTID_PLATFORM.matches(ROWS(LEFT),mt).patched_infile);
//	#ELSE
//		RETURN JOIN(d, LOOP(PROJECT(d,BIPV2_DOTID_PLATFORM.Layout_DOT),N,BIPV2_DOTID_PLATFORM.matches(ROWS(LEFT),mt).patched_infile), LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(LEFT),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
//	#END
//ENDMACRO;
//EXPORT LoopThisK(d,K,NMax=100,ThinLoop=FALSE) := FUNCTIONMACRO
//	IMPORT BIPV2_DOTID_PLATFORM;
//	#IF (ThinLoop=FALSE)
//		RETURN LOOP(PROJECT(d,BIPV2_DOTID_PLATFORM.Layout_DOT),COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),DOTid,ALL))>K,BIPV2_DOTID_PLATFORM.matches(ROWS(LEFT),0).patched_infile);
//	#ELSE
//		RETURN JOIN(d, LOOP(PROJECT(d,BIPV2_DOTID_PLATFORM.Layout_DOT),COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),DOTid,ALL))>K,BIPV2_DOTID_PLATFORM.matches(ROWS(LEFT),0).patched_infile), LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(LEFT),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
//	#END
//ENDMACRO;
SHARED LinkPhase(BOOLEAN again) := SEQUENTIAL(PARALLEL(OutputSamples,ExecutionStats,ValidityStats,IF(again,OutputFileA,OutputFile),IF(again,OutputChangesA,OutputChanges) ),IF(Debugging,DebugKeys));
//Perform the build of the cleave indexes - prior to remainder of work
SHARED WithCleave(BOOLEAN again) := IF(Config.ByPassCleave,LinkPhase(Again),SEQUENTIAL( Cleave(InFile).BuildAll, LinkPhase(Again) ));
EXPORT DoAll := WithCleave(FALSE);
EXPORT DoAllAgain := WithCleave(TRUE);
END;
