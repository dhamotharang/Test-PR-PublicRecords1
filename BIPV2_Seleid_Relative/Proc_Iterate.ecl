//Executable code
EXPORT Proc_Iterate(STRING iter,DATASET(Layout_Base) InFile0 = BIPV2_Seleid_Relative.In_Base,string pversion = BIPV2_Seleid_Relative.KeyInfix/*HACK TO ADD PVERSION*/,STRING OutFileNameP = '~temp::Seleid::BIPV2_Seleid_Relative::it',UNSIGNED MatchThreshold = Config.MatchThreshold,BOOLEAN Debugging = true) := MODULE
SHARED InFile := InFile0;
SHARED MM := BIPV2_Seleid_Relative.matches(InFile,MatchThreshold); // Get the matching module
OSR := OUTPUT(CHOOSEN(MM.MatchSampleRecords,10000),NAMED('MatchSampleRecords'));
OSL := OUTPUT(CHOOSEN(MM.ToSlice,1000),NAMED('SliceOutCandidates'));
EXPORT OutputSamples := PARALLEL(OSR,OSL);// Provide the records!
SHARED BM := BIPV2_Seleid_Relative.BasicMatch(InFile);
BMS := OUTPUT(CHOOSEN(BM.patch_file, 1000), NAMED('BasicMatch_Patch_File'));
OMatchSamples := OUTPUT(CHOOSEN(MM.MatchSample,1000),NAMED('MatchSample'));
OBSamples := OUTPUT(CHOOSEN(MM.BorderlineMatchSample,10000),NAMED('BorderlineMatchSample'));
OAS := OUTPUT(CHOOSEN(MM.AlmostMatchSample,10000),NAMED('AlmostMatchSample'));
EXPORT OutputExtraSamples := PARALLEL(OMatchSamples, OBSamples, OAS, BMS); // This is not called automatically - call yourself if you want them!
OS := OUTPUT(BIPV2_Seleid_Relative.specificities(InFile).specificities,NAMED('Specificities'));
OPRP := OUTPUT(BIPV2_Seleid_Relative.match_candidates(InFile).prepropogationstats,NAMED('PrePopStats'));
OPP := OUTPUT(BIPV2_Seleid_Relative.match_candidates(InFile).postpropogationstats,NAMED('PostPopStats'));
PRPPS := OUTPUT(MM.PreIds.IdCounts,NAMED('PreClusterCount'));
PRPP := OUTPUT(MM.PreIds.Seleid_Clusters,NAMED('PreClusters'),ALL);
PPPS := OUTPUT(MM.PostIds.IdCounts,NAMED('PostClusterCount'));
PPP := OUTPUT(MM.PostIds.Seleid_Clusters,NAMED('PostClusters'),ALL);
MP := PARALLEL( OUTPUT(MM.MatchesPerformed,NAMED('MatchesPerformed')),OUTPUT(BIPV2_Seleid_Relative.BasicMatch(InFile).basic_match_count,NAMED('BasicMatchesPerformed')));
SP := OUTPUT(MM.SlicesPerformed,NAMED('SlicesPerformed'));
MPPA := OUTPUT(MM.MatchesPropAssisted * 100 / MM.MatchesPerformed,NAMED('PropagationAssisted_Pcnt'));
MPPR := OUTPUT(MM.MatchesPropRequired * 100 / MM.MatchesPerformed,NAMED('PropagationRequired_Pcnt'));
RE := OUTPUT(TOPN(MM.RuleEfficacy,1000,RuleNumber),NAMED('RuleEfficacy'));
CB := OUTPUT(TOPN(MM.ConfidenceBreakdown,1000,conf),NAMED('ConfidenceLevels'));
SpcS := OUTPUT(BIPV2_Seleid_Relative.specificities(InFile).SpcShift,NAMED('SPCShift'));
EXPORT ExecutionStats := PARALLEL(OS,SpcS,PRPP,PPP,PRPPS,PPPS,MP,SP,RE,CB,MPPA,MPPR,OPRP,OPP);
d := DATASET([{MM.PatchingError0,MM.DuplicateRids0,COUNT(BIPV2_Seleid_Relative.match_candidates(InFile).Unlinkables)}],{INTEGER PatchingError0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0});
EXPORT ValidityStats := PARALLEL( OUTPUT(d,NAMED('ValidityStatistics')), OUTPUT(MM.PostIds.Advanced0,NAMED('IdConsistency0')));
EXPORT InputValidityStats := OUTPUT(MM.PreIds.Advanced0,NAMED('InputIdConsistency0'));
EXPORT DebugKeys := Keys(InFile,pversion/*HACK PASS IN PVERSION TO KEYS*/).BuildAll;
EXPORT OutputFileName := OutFileNameP+iter;
EXPORT OutputFile := OUTPUT(MM.patched_infile,,OutputFileName,COMPRESSED);// Change file for each iteration
EXPORT OutputFileA := OUTPUT(MM.patched_infile,,OutputFileName,OVERWRITE,COMPRESSED);// Change file for each iteration
SHARED ChangeName := '~temp::Seleid::BIPV2_Seleid_Relative::changes_it'+iter;
EXPORT OutputChanges := SEQUENTIAL( OUTPUT(MM.IdChanges,,ChangeName,OVERWRITE,COMPRESSED),FileServices.AddSuperFile(Keys(InFile,pversion/*HACK PASS IN PVERSION TO KEYS*/).MatchHistoryName,ChangeName));
EXPORT OutputChangesA := SEQUENTIAL( FileServices.RemoveSuperFile(BIPV2_Seleid_Relative.Keys(InFile,pversion/*HACK PASS IN PVERSION TO KEYS*/).MatchHistoryName,ChangeName),OUTPUT(MM.IdChanges,,ChangeName,OVERWRITE,COMPRESSED),FileServices.AddSuperFile(BIPV2_Seleid_Relative.Keys(InFile,pversion/*HACK PASS IN PVERSION TO KEYS*/).MatchHistoryName,ChangeName));
//EXPORT LoopN(UNSIGNED N,UNSIGNED mt=Config.MatchThreshold) := LOOP(InFile,N,BIPV2_Seleid_Relative.matches(ROWS(LEFT),mt).patched_infile); // Loop N times
//EXPORT LoopThisN(d,N,mt=Config.MatchThreshold,ThinLoop=FALSE) := FUNCTIONMACRO
//	IMPORT BIPV2_Seleid_Relative;
//	#IF (ThinLoop=FALSE)
//		RETURN LOOP(PROJECT(d,BIPV2_Seleid_Relative.Layout_Base),N,BIPV2_Seleid_Relative.matches(ROWS(LEFT),mt).patched_infile);
//	#ELSE
//		RETURN JOIN(d, LOOP(PROJECT(d,BIPV2_Seleid_Relative.Layout_Base),N,BIPV2_Seleid_Relative.matches(ROWS(LEFT),mt).patched_infile), LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(LEFT),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
//	#END
//ENDMACRO;
//EXPORT LoopThisK(d,K,NMax=100,ThinLoop=FALSE) := FUNCTIONMACRO
//	IMPORT BIPV2_Seleid_Relative;
//	#IF (ThinLoop=FALSE)
//		RETURN LOOP(PROJECT(d,BIPV2_Seleid_Relative.Layout_Base),COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),Seleid,ALL))>K,BIPV2_Seleid_Relative.matches(ROWS(LEFT),0).patched_infile);
//	#ELSE
//		RETURN JOIN(d, LOOP(PROJECT(d,BIPV2_Seleid_Relative.Layout_Base),COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),Seleid,ALL))>K,BIPV2_Seleid_Relative.matches(ROWS(LEFT),0).patched_infile), LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(LEFT),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
//	#END
//ENDMACRO;
SHARED LinkPhase(BOOLEAN again) := SEQUENTIAL(PARALLEL(Keys(InFile,pversion/*HACK PASS IN PVERSION TO KEYS*/).RelationshipKeys,OutputSamples,ExecutionStats,ValidityStats/*,IF(again,OutputFileA,OutputFile),IF(again,OutputChangesA,OutputChanges)*//*HACK*/ ),IF(Debugging,DebugKeys));
EXPORT DoAll := LinkPhase(FALSE);
EXPORT DoAllAgain := LinkPhase(TRUE);
END;
