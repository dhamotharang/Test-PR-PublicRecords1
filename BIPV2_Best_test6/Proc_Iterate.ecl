//Executable code
EXPORT Proc_Iterate(STRING iter) := MODULE
SHARED InFile := BIPV2_Best_test6.In_Base;
OSR := OUTPUT(CHOOSEN(BIPV2_Best_test6.matches(InFile).MatchSampleRecords,10000),NAMED('MatchSampleRecords'));
OSL := OUTPUT(CHOOSEN(BIPV2_Best_test6.matches(InFile).ToSlice,1000),NAMED('SliceOutCandidates'));
EXPORT OutputSamples := PARALLEL(OSR,OSL);// Provide the records!
OMatchSamples := OUTPUT(CHOOSEN(BIPV2_Best_test6.matches(InFile).MatchSample,1000),NAMED('MatchSample'));
OBSamples := OUTPUT(CHOOSEN(BIPV2_Best_test6.matches(InFile).BorderlineMatchSample,10000),NAMED('BorderlineMatchSample'));
OAS := OUTPUT(CHOOSEN(BIPV2_Best_test6.matches(InFile).AlmostMatchSample,10000),NAMED('AlmostMatchSample'));
EXPORT OutputExtraSamples := PARALLEL(OMatchSamples,OBSamples,OAS); // This is not called automatically - call yourself if you want them!
OS := OUTPUT(BIPV2_Best_test6.specificities(InFile).specificities,NAMED('Specificities'));
OPRP := OUTPUT(BIPV2_Best_test6.match_candidates(InFile).prepropogationstats,NAMED('PrePopStats'));
OPP := OUTPUT(BIPV2_Best_test6.match_candidates(InFile).postpropogationstats,NAMED('PostPopStats'));
PRPPS := OUTPUT(BIPV2_Best_test6.matches(InFile).PrePatchIdCount,NAMED('PreClusterCount'),all);
PRPP := OUTPUT(BIPV2_Best_test6.matches(InFile).PreClusters,NAMED('PreClusters'),all);
PPPS := OUTPUT(BIPV2_Best_test6.matches(InFile).PostPatchIDCount,NAMED('PostClusterCount'),all);
PPP := OUTPUT(BIPV2_Best_test6.matches(InFile).PostClusters,NAMED('PostClusters'),all);
MP := PARALLEL( OUTPUT(BIPV2_Best_test6.matches(InFile).MatchesPerformed,NAMED('MatchesPerformed')),OUTPUT(BIPV2_Best_test6.BasicMatch(InFile).basic_match_count,NAMED('BasicMatchesPerformed')));
SP := OUTPUT(BIPV2_Best_test6.matches(InFile).SlicesPerformed,NAMED('SlicesPerformed'));
MPPA := OUTPUT(BIPV2_Best_test6.matches(InFile).MatchesPropAssisted * 100 / BIPV2_Best_test6.matches(InFile).MatchesPerformed,NAMED('PropagationAssisted_Pcnt'));
MPPR := OUTPUT(BIPV2_Best_test6.matches(InFile).MatchesPropRequired * 100 / BIPV2_Best_test6.matches(InFile).MatchesPerformed,NAMED('PropagationRequired_Pcnt'));
RE := OUTPUT(TOPN(matches(InFile).RuleEfficacy,1000,RuleNumber),NAMED('RuleEfficacy'));
CB := OUTPUT(TOPN(matches(InFile).ConfidenceBreakdown,1000,conf),NAMED('ConfidenceLevels'));
SpcS := OUTPUT(BIPV2_Best_test6.specificities(InFile).SpcShift,NAMED('SPCShift'));
FLG := OUTPUT(Best(InFile).In_Flagged_Summary,NAMED('FlagSummary'));
FLG1 := OUTPUT(CHOOSEN(Best(InFile).In_Flagged_Summary_BySrc,10000),NAMED('FlagSrcSummary'));
EXPORT ExecutionStats := PARALLEL(OS,SpcS,PRPP,PPP,PRPPS,PPPS,MP,SP,RE,CB,MPPA,MPPR,OPRP,OPP,FLG,FLG1);
d := DATASET([{BIPV2_Best_test6.matches(InFile).PatchingError0,BIPV2_Best_test6.matches(InFile).DidsNoRid0,BIPV2_Best_test6.matches(InFile).DidsAboveRid0,BIPV2_Best_test6.matches(InFile).DuplicateRids0,COUNT(BIPV2_Best_test6.match_candidates(InFile).Unlinkables)}],{INTEGER PatchingError0, INTEGER DidsNoRid0, INTEGER DidsAboveRid0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0});
EXPORT ValidityStats := OUTPUT(d,NAMED('ValidityStatistics'));
EXPORT DebugKeys := Keys(InFile).BuildAll;
EXPORT OutputFile := OUTPUT(BIPV2_Best_test6.matches(InFile).patched_infile,,'~temp::Proxid::BIPV2_Best_test6::it'+iter,COMPRESSED);// Change file for each iteration
EXPORT OutputFileA := OUTPUT(BIPV2_Best_test6.matches(InFile).patched_infile,,'~temp::Proxid::BIPV2_Best_test6::it'+iter,OVERWRITE,COMPRESSED);// Change file for each iteration
//EXPORT LoopN(UNSIGNED N,UNSIGNED mt=41) := LOOP(BIPV2_Best_test6.In_Base,N,BIPV2_Best_test6.matches(ROWS(LEFT),mt).patched_infile); // Loop N times
//EXPORT LoopThisN(DATASET(BIPV2_Best_test6.Layout_Base)d,UNSIGNED N,UNSIGNED mt=41) := LOOP(d,N,BIPV2_Best_test6.matches(ROWS(LEFT),mt).patched_infile);
//EXPORT LoopThisK(DATASET(BIPV2_Best_test6.Layout_Base)d,UNSIGNED K,UNSIGNED NMax=100) := LOOP(d,COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),Proxid,ALL))>K,BIPV2_Best_test6.matches(ROWS(LEFT),0).patched_infile); // Loop until K clusters left
SHARED LinkPhase(BOOLEAN again) := PARALLEL(OutputSamples,ExecutionStats,ValidityStats,DebugKeys,IF(again,OutputFileA,OutputFile));
EXPORT DoAll := LinkPhase(FALSE);
EXPORT DoAllAgain := LinkPhase(TRUE);
END;
