//Executable code
EXPORT Proc_Iterate(STRING iter, dataset(layout_DOT_Base) InFile = In_DOT_Base) := MODULE
OSR := OUTPUT(CHOOSEN(BIPV2_Relative.matches(InFile).MatchSampleRecords,10000),NAMED('MatchSampleRecords'));
OSL := OUTPUT(CHOOSEN(BIPV2_Relative.matches(InFile).ToSlice,1000),NAMED('SliceOutCandidates'));
EXPORT OutputSamples := PARALLEL(OSR,OSL);// Provide the records!
OMatchSamples := OUTPUT(CHOOSEN(BIPV2_Relative.matches(InFile).MatchSample,1000),NAMED('MatchSample'));
OBSamples := OUTPUT(CHOOSEN(BIPV2_Relative.matches(InFile).BorderlineMatchSample,10000),NAMED('BorderlineMatchSample'));
OAS := OUTPUT(CHOOSEN(BIPV2_Relative.matches(InFile).AlmostMatchSample,10000),NAMED('AlmostMatchSample'));
EXPORT OutputExtraSamples := PARALLEL(OMatchSamples,OBSamples,OAS); // This is not called automatically - call yourself if you want them!
OS := OUTPUT(BIPV2_Relative.specificities(InFile).specificities,NAMED('Specificities'));
OPRP := OUTPUT(BIPV2_Relative.match_candidates(InFile).prepropogationstats,NAMED('PrePopStats'));
OPP := OUTPUT(BIPV2_Relative.match_candidates(InFile).postpropogationstats,NAMED('PostPopStats'));
PRPPS := OUTPUT(BIPV2_Relative.matches(InFile).PrePatchIdCount,NAMED('PreClusterCount'),all);
PRPP := OUTPUT(BIPV2_Relative.matches(InFile).PreClusters,NAMED('PreClusters'),all);
PPPS := OUTPUT(BIPV2_Relative.matches(InFile).PostPatchIDCount,NAMED('PostClusterCount'),all);
PPP := OUTPUT(BIPV2_Relative.matches(InFile).PostClusters,NAMED('PostClusters'),all);
MP := OUTPUT(BIPV2_Relative.matches(InFile).MatchesPerformed,NAMED('MatchesPerformed'));
SP := OUTPUT(BIPV2_Relative.matches(InFile).SlicesPerformed,NAMED('SlicesPerformed'));
MPPA := OUTPUT(BIPV2_Relative.matches(InFile).MatchesPropAssisted * 100 / BIPV2_Relative.matches(InFile).MatchesPerformed,NAMED('PropagationAssisted_Pcnt'));
MPPR := OUTPUT(BIPV2_Relative.matches(InFile).MatchesPropRequired * 100 / BIPV2_Relative.matches(InFile).MatchesPerformed,NAMED('PropagationRequired_Pcnt'));
RE := OUTPUT(TOPN(matches(InFile).RuleEfficacy,1000,RuleNumber),NAMED('RuleEfficacy'));
CB := OUTPUT(TOPN(matches(InFile).ConfidenceBreakdown,1000,conf),NAMED('ConfidenceLevels'));
SpcS := OUTPUT(BIPV2_Relative.specificities(InFile).SpcShift,NAMED('SPCShift'));
EXPORT ExecutionStats := PARALLEL(OS,SpcS,PRPP,PPP,PRPPS,PPPS,MP,SP,RE,CB,MPPA,MPPR,OPRP,OPP);
d := DATASET([{BIPV2_Relative.matches(InFile).PatchingError0,BIPV2_Relative.matches(InFile).DidsNoRid0,BIPV2_Relative.matches(InFile).DidsAboveRid0,BIPV2_Relative.matches(InFile).DuplicateRids0,COUNT(BIPV2_Relative.match_candidates(InFile).Unlinkables),COUNT(BIPV2_Relative.specificities(InFile).Rejected_file)}],{INTEGER PatchingError0, INTEGER DidsNoRid0, INTEGER DidsAboveRid0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0,UNSIGNED RecordsRejected0});
EXPORT ValidityStats := OUTPUT(d,NAMED('ValidityStatistics'));
EXPORT DebugKeys := Keys(InFile).BuildAll;
Rel8 := BUILDINDEX(keys(InFile).ASSOC,OVERWRITE);
EXPORT RelationshipKeys := PARALLEL(Rel8); // Build the relationship keys
EXPORT OutputFile := OUTPUT(BIPV2_Relative.matches(InFile).patched_infile,,'~temp::Proxid::BIPV2_Relative::it'+iter,COMPRESSED);// Change file for each iteration
EXPORT OutputFileA := OUTPUT(BIPV2_Relative.matches(InFile).patched_infile,,'~temp::Proxid::BIPV2_Relative::it'+iter,OVERWRITE,COMPRESSED);// Change file for each iteration
//EXPORT LoopN(UNSIGNED N,UNSIGNED mt=32) := LOOP(BIPV2_Relative.In_DOT_Base,N,BIPV2_Relative.matches(ROWS(LEFT),mt).patched_infile); // Loop N times
//EXPORT LoopThisN(DATASET(BIPV2_Relative.Layout_DOT_Base)d,UNSIGNED N,UNSIGNED mt=32) := LOOP(d,N,BIPV2_Relative.matches(ROWS(LEFT),mt).patched_infile);
//EXPORT LoopThisK(DATASET(BIPV2_Relative.Layout_DOT_Base)d,UNSIGNED K,UNSIGNED NMax=100) := LOOP(d,COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),Proxid,ALL))>K,BIPV2_Relative.matches(ROWS(LEFT),0).patched_infile); // Loop until K clusters left
SHARED LinkPhase(BOOLEAN again) := PARALLEL(RelationshipKeys,OutputSamples,ExecutionStats,ValidityStats,DebugKeys,IF(again,OutputFileA,OutputFile));
EXPORT DoAll := LinkPhase(FALSE);
EXPORT DoAllAgain := LinkPhase(TRUE);
END;
