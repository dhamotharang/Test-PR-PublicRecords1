//Executable code
EXPORT Proc_Iterate(STRING iter) := MODULE
SHARED InFile := Business_Research.In_pDataset;
OMatchSamples := OUTPUT(CHOOSEN(Business_Research.matches(InFile).MatchSample,1000),NAMED('MatchSample'));
OBSamples := OUTPUT(CHOOSEN(Business_Research.matches(InFile).BorderlineMatchSample,10000),NAMED('BorderlineMatchSample'));
OAS := OUTPUT(CHOOSEN(Business_Research.matches(InFile).AlmostMatchSample,10000),NAMED('AlmostMatchSample'));
OSR := OUTPUT(CHOOSEN(Business_Research.matches(InFile).MatchSampleRecords,10000),NAMED('MatchSampleRecords'));
OSL := OUTPUT(CHOOSEN(Business_Research.matches(InFile).ToSlice,1000),NAMED('SliceOutCandidates'));
//EXPORT OutputSamples := PARALLEL(OMatchSamples,OBSamples,OAS,OSR,OSL);
EXPORT OutputSamples := PARALLEL(OSR,OSL);// Most people only want the records!
OS := OUTPUT(Business_Research.specificities(InFile).specificities,NAMED('Specificities'));
PRPP := OUTPUT(Business_Research.matches(InFile).PreClusters,NAMED('PreClusters'),all);
PPP := OUTPUT(Business_Research.matches(InFile).PostClusters,NAMED('PostClusters'),all);
MP := OUTPUT(Business_Research.matches(InFile).MatchesPerformed,NAMED('MatchesPerformed'));
SP := OUTPUT(Business_Research.matches(InFile).SlicesPerformed,NAMED('SlicesPerformed'));
MPPA := OUTPUT(Business_Research.matches(InFile).MatchesPropAssisted * 100 / Business_Research.matches(InFile).MatchesPerformed,NAMED('PropagationAssisted_Pcnt'));
MPPR := OUTPUT(Business_Research.matches(InFile).MatchesPropRequired * 100 / Business_Research.matches(InFile).MatchesPerformed,NAMED('PropagationRequired_Pcnt'));
RE := OUTPUT(TOPN(matches(InFile).RuleEfficacy,1000,RuleNumber),NAMED('RuleEfficacy'));
CB := OUTPUT(TOPN(matches(InFile).ConfidenceBreakdown,1000,conf),NAMED('ConfidenceLevels'));
SpcS := OUTPUT(Business_Research.specificities(InFile).SpcShift,NAMED('SPCShift'));
EXPORT ExecutionStats := PARALLEL(OS,SpcS,PRPP,PPP,MP,SP,RE,CB,MPPA,MPPR);
d := DATASET([{Business_Research.matches(InFile).PatchingError0,Business_Research.matches(InFile).DidsNoRid0,Business_Research.matches(InFile).DidsAboveRid0,Business_Research.matches(InFile).DuplicateRids0,COUNT(Business_Research.match_candidates(InFile).Unlinkables)}],{INTEGER PatchingError0, INTEGER DidsNoRid0, INTEGER DidsAboveRid0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0});
EXPORT ValidityStats := OUTPUT(d,NAMED('ValidityStatistics'));
KC := BUILDINDEX(keys(InFile).candidates,OVERWRITE);
KS := BUILDINDEX(keys(InFile).MatchSample,OVERWRITE);
KSS := BUILDINDEX(keys(InFile).Specificities_Key,OVERWRITE,FEW);
EXPORT DebugKeys := PARALLEL(KC,KS,KSS);
EXPORT OutputCandidates := BUILDINDEX(keys(InFile).PatchedCandidates,OVERWRITE);
EXPORT OutputFile := OUTPUT(Business_Research.matches(InFile).patched_infile,,'~temp::::Business_Research::it'+iter,COMPRESSED);// Change file for each iteration
EXPORT OutputFileA := OUTPUT(Business_Research.matches(InFile).patched_infile,,'~temp::::Business_Research::it'+iter,OVERWRITE,COMPRESSED);// Change file for each iteration
//EXPORT LoopN(UNSIGNED N,UNSIGNED mt=0) := LOOP(Business_Research.In_pDataset,N,Business_Research.matches(ROWS(LEFT),mt).patched_infile); // Loop N times
//EXPORT LoopThisN(DATASET(Business_Research.layout_as_bh)d,UNSIGNED N,UNSIGNED mt=0) := LOOP(d,N,Business_Research.matches(ROWS(LEFT),mt).patched_infile);
//EXPORT LoopThisK(DATASET(Business_Research.layout_as_bh)d,UNSIGNED K,UNSIGNED NMax=100) := LOOP(d,COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),,ALL))>K,Business_Research.matches(ROWS(LEFT),0).patched_infile); // Loop until K clusters left
EXPORT DoAll := PARALLEL(OutputSamples,ExecutionStats,ValidityStats,DebugKeys,OutputFile,OutputCandidates);
EXPORT DoAllAgain := PARALLEL(OutputSamples,ExecutionStats,ValidityStats,DebugKeys,OutputFileA,OutputCandidates);
end;
