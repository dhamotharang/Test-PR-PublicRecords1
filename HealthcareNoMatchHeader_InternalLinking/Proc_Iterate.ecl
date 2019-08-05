//Executable code
/*HACK-O-MATIC*/IMPORT SALT311,HealthcareNoMatchHeader_Ingest;
/*HACK-O-MATIC*/EXPORT Proc_Iterate(STRING pSrc, STRING pVersion, STRING iter,DATASET(Layout_HEADER) InFile = HealthcareNoMatchHeader_Ingest.Files(pSrc,pVersion).AllRecords,STRING OutFileNameP = HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Linking(iter).Iteration.new,UNSIGNED MatchThreshold = Config.MatchThreshold,BOOLEAN Debugging = true) := MODULE
SHARED MM := HealthcareNoMatchHeader_InternalLinking./*HACK-O-MATIC*/matches(pSrc,pVersion,InFile,MatchThreshold); // Get the matching module
SHARED S := /*HACK-O-MATIC*/Specificities(pSrc,pVersion,InFile).Specificities[1];
dsOSR := CHOOSEN(MM.MatchSampleRecords,10000);
dsOSL := CHOOSEN(MM.ToSlice,1000);
OSL := OUTPUT(dsOSL,NAMED('SliceOutCandidates'),OVERWRITE);
OSR := OUTPUT(dsOSR,NAMED('MatchSampleRecords'),OVERWRITE);
EXPORT OutputSamples := PARALLEL(OSR,OSL);// Provide the records!
SHARED BM := HealthcareNoMatchHeader_InternalLinking./*HACK-O-MATIC*/BasicMatch(pSrc,pVersion,InFile);
dsOMatchSamples := CHOOSEN(MM.MatchSample,1000);
dsOBSamples := CHOOSEN(MM.BorderlineMatchSample,10000);
dsOAS := CHOOSEN(MM.AlmostMatchSample,10000);
dsThr := RECORD
  UNSIGNED BasicMatchThreshold := Config.BasicMatchThreshold;
  UNSIGNED MatchThreshold := MatchThreshold;
  UNSIGNED LowerMatchThreshold := MatchThreshold-3; // as defined in matches/Debug (not Underlinks)
  UNSIGNED IntraMatchThreshold := MatchThreshold-3 - Config.SliceDistance;
END;
mtch := /*HACK-O-MATIC*/Debug(pSrc,pVersion,InFile, S, MatchThreshold).AnnotateMatches(MM.PossibleMatches);
MSD :=
  ENTH(mtch(Conf<MatchThreshold,Conf>=MatchThreshold-3),500) +
  ENTH(mtch(Conf=MatchThreshold),500) +
  ENTH(mtch(Conf>MatchThreshold,Conf<=MatchThreshold+3),500);
OMatchSamples := OUTPUT(dsOMatchSamples,OVERWRITE,NAMED('MatchSample'));
OBSamples := OUTPUT(dsOBSamples,NAMED('BorderlineMatchSample'),OVERWRITE);
OAS := OUTPUT(dsOAS,NAMED('AlmostMatchSample'),OVERWRITE);
BMS := OUTPUT(CHOOSEN(BM.patch_file, 1000), NAMED('BasicMatch_Patch_File'),OVERWRITE);
Thr := OUTPUT(ROW(dsThr),NAMED('Thresholds'),OVERWRITE);
OMSD := OUTPUT(MSD,NAMED('MatchSampleDebug'),ALL,OVERWRITE);
EXPORT OutputExtraSamples := PARALLEL(OMatchSamples, OBSamples, OAS, BMS, Thr, OMSD); // This is not called automatically - call yourself if you want them!
dsMPSP := DATASET([{'MatchesPerformed', MM.MatchesPerformed}, {'BasicMatchesPerformed', BM.basic_match_count}, {'SlicesPerformed', MM.SlicesPerformed}], {STRING label, UNSIGNED value});
dsPS := DATASET([{'PropagationAssisted_Pcnt', MM.MatchesPropAssisted * 100 / MM.MatchesPerformed}, {'PropagationRequired_Pcnt', MM.MatchesPropRequired * 100 / MM.MatchesPerformed}], {STRING label, UNSIGNED Pcnt});
dsRE := TOPN(MM.RuleEfficacy,1000,RuleNumber);
dsCB := TOPN(MM.ConfidenceBreakdown,1000,conf);
OS := OUTPUT(HealthcareNoMatchHeader_InternalLinking./*HACK-O-MATIC*/Specificities(pSrc,pVersion,InFile).specificities,NAMED('Specificities'),OVERWRITE);
OPRP := OUTPUT(HealthcareNoMatchHeader_InternalLinking./*HACK-O-MATIC*/match_candidates(pSrc,pVersion,InFile).prepropogationstats,NAMED('PrePopStats'),OVERWRITE);
OPP := OUTPUT(HealthcareNoMatchHeader_InternalLinking./*HACK-O-MATIC*/match_candidates(pSrc,pVersion,InFile).postpropogationstats,NAMED('PostPopStats'),OVERWRITE);
PRPPS := OUTPUT(MM.PreIds.IdCounts,NAMED('PreClusterCount'),OVERWRITE);
PRPP := OUTPUT(MM.PreIds.nomatch_id_Clusters,NAMED('PreClusters'),ALL,OVERWRITE);
PPPS := OUTPUT(MM.PostIds.IdCounts,NAMED('PostClusterCount'),OVERWRITE);
PPP := OUTPUT(MM.PostIds.nomatch_id_Clusters,NAMED('PostClusters'),ALL,OVERWRITE);
SpcS := OUTPUT(HealthcareNoMatchHeader_InternalLinking./*HACK-O-MATIC*/Specificities(pSrc,pVersion,InFile).SpcShift,NAMED('SPCShift'),OVERWRITE);
MPSP := OUTPUT(dsMPSP, NAMED('MatchStatistics'),OVERWRITE);
PS := OUTPUT(dsPS, NAMED('PropogationStats'),OVERWRITE);
RE := OUTPUT(dsRE,NAMED('RuleEfficacy'),OVERWRITE);
CB := OUTPUT(dsCB,NAMED('ConfidenceLevels'),OVERWRITE);
EXPORT ExecutionStats := PARALLEL(OS,SpcS,PRPP,PPP,PRPPS,PPPS,MPSP,RE,CB, PS,OPRP,OPP);
dsValidityStats := DATASET([{MM.PatchingError0,MM.DuplicateRids0,COUNT(HealthcareNoMatchHeader_InternalLinking./*HACK-O-MATIC*/match_candidates(pSrc,pVersion,InFile).Unlinkables)}],{INTEGER PatchingError0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0});
EXPORT ValidityStats := PARALLEL( OUTPUT(dsValidityStats,NAMED('ValidityStatistics'),OVERWRITE), OUTPUT(MM.PostIds.Advanced0,NAMED('IdConsistency0'),OVERWRITE));
EXPORT InputValidityStats := OUTPUT(MM.PreIds.Advanced0,NAMED('InputIdConsistency0'),OVERWRITE);
EXPORT DebugKeys := /*HACK-O-MATIC*/Keys(pSrc,pVersion,InFile).BuildAll;
EXPORT OutputFileName := /*HACK-O-MATIC*/OutFileNameP;
EXPORT OutputFile := OUTPUT(MM.patched_infile,,OutputFileName,COMPRESSED);// Change file for each iteration
EXPORT OutputFileA := OUTPUT(MM.patched_infile,,OutputFileName,OVERWRITE,COMPRESSED);// Change file for each iteration
SHARED ChangeName := /*HACK-O-MATIC*/HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Linking(iter).Changes.new;
EXPORT OutputChanges := SEQUENTIAL( OUTPUT(MM.IdChanges,,ChangeName,OVERWRITE,COMPRESSED),FileServices.AddSuperFile(/*HACK-O-MATIC*/MatchHistory(pSrc,pVersion).MatchHistoryName,ChangeName));
EXPORT OutputChangesA := SEQUENTIAL( IF(FileServices.SuperFileExists(HealthcareNoMatchHeader_InternalLinking./*HACK-O-MATIC*/MatchHistory(pSrc,pVersion).MatchHistoryName),FileServices.RemoveSuperFile(HealthcareNoMatchHeader_InternalLinking./*HACK-O-MATIC*/MatchHistory(pSrc,pVersion).MatchHistoryName,ChangeName)),OUTPUT(MM.IdChanges,,ChangeName,OVERWRITE,COMPRESSED),FileServices.AddSuperFile(HealthcareNoMatchHeader_InternalLinking./*HACK-O-MATIC*/MatchHistory(pSrc,pVersion).MatchHistoryName,ChangeName));
//EXPORT LoopN(UNSIGNED N, UNSIGNED mt=Config.MatchThreshold) := LOOP(InFile,N,HealthcareNoMatchHeader_InternalLinking.matches(ROWS(LEFT), mt).patched_infile); // Loop N times
//EXPORT LoopThisN(d,N,mt=Config.MatchThreshold,ThinLoop=FALSE) := FUNCTIONMACRO
//	IMPORT HealthcareNoMatchHeader_InternalLinking;
//	#IF (ThinLoop=FALSE)
//		RETURN LOOP(PROJECT(d,HealthcareNoMatchHeader_InternalLinking.Layout_HEADER),N,HealthcareNoMatchHeader_InternalLinking.matches(ROWS(LEFT), mt).patched_infile);
//	#ELSE
//		RETURN JOIN(d, LOOP(PROJECT(d,HealthcareNoMatchHeader_InternalLinking.Layout_HEADER),N,HealthcareNoMatchHeader_InternalLinking.matches(ROWS(LEFT), mt).patched_infile), LEFT.RID=RIGHT.RID, TRANSFORM(RECORDOF(LEFT),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
//	#END
//ENDMACRO;
//EXPORT LoopThisK(d,K,NMax=100,ThinLoop=FALSE) := FUNCTIONMACRO
//	IMPORT HealthcareNoMatchHeader_InternalLinking;
//	#IF (ThinLoop=FALSE)
//		RETURN LOOP(PROJECT(d,HealthcareNoMatchHeader_InternalLinking.Layout_HEADER),COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),nomatch_id,ALL))>K,HealthcareNoMatchHeader_InternalLinking.matches(ROWS(LEFT), 0).patched_infile);
//	#ELSE
//		RETURN JOIN(d, LOOP(PROJECT(d,HealthcareNoMatchHeader_InternalLinking.Layout_HEADER),COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),nomatch_id,ALL))>K,HealthcareNoMatchHeader_InternalLinking.matches(ROWS(LEFT), 0).patched_infile), LEFT.RID=RIGHT.RID, TRANSFORM(RECORDOF(LEFT),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
//	#END
//ENDMACRO;
SHARED LinkPhase(BOOLEAN again) := SEQUENTIAL(PARALLEL(OutputSamples,ExecutionStats,ValidityStats,IF(again,OutputFileA,OutputFile),IF(again,OutputChangesA,OutputChanges) ),IF(Debugging,DebugKeys));
EXPORT DoAll := LinkPhase(FALSE);
EXPORT DoAllAgain := LinkPhase(TRUE);
END;
