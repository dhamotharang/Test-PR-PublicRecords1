//Executable code
EXPORT Proc_Iterate(STRING iter) := MODULE
SHARED InFile := bell_thrive.In_files().input.used;
OMatchSamples := OUTPUT(CHOOSEN(bell_thrive.matches(InFile).MatchSample,1000),NAMED('MatchSample'));
OBSamples := OUTPUT(CHOOSEN(bell_thrive.matches(InFile).BorderlineMatchSample,10000),NAMED('BorderlineMatchSample'));
OAS := OUTPUT(CHOOSEN(bell_thrive.matches(InFile).AlmostMatchSample,10000),NAMED('AlmostMatchSample'));
OSR := OUTPUT(CHOOSEN(bell_thrive.matches(InFile).MatchSampleRecords,10000),NAMED('MatchSampleRecords'));
OSL := OUTPUT(CHOOSEN(bell_thrive.matches(InFile).ToSlice,1000),NAMED('SliceOutCandidates'));
//EXPORT OutputSamples := PARALLEL(OMatchSamples,OBSamples,OAS,OSR,OSL);
EXPORT OutputSamples := PARALLEL(OSR,OSL);// Most people only want the records!
OS := OUTPUT(bell_thrive.specificities(InFile).specificities,NAMED('Specificities'));
PRPP := OUTPUT(bell_thrive.matches(InFile).PreClusters,NAMED('PreClusters'),all);
PPP := OUTPUT(bell_thrive.matches(InFile).PostClusters,NAMED('PostClusters'),all);
MP := OUTPUT(bell_thrive.matches(InFile).MatchesPerformed,NAMED('MatchesPerformed'));
SP := OUTPUT(bell_thrive.matches(InFile).SlicesPerformed,NAMED('SlicesPerformed'));
MPPA := OUTPUT(bell_thrive.matches(InFile).MatchesPropAssisted * 100 / bell_thrive.matches(InFile).MatchesPerformed,NAMED('PropagationAssisted_Pcnt'));
MPPR := OUTPUT(bell_thrive.matches(InFile).MatchesPropRequired * 100 / bell_thrive.matches(InFile).MatchesPerformed,NAMED('PropagationRequired_Pcnt'));
RE := OUTPUT(TOPN(matches(InFile).RuleEfficacy,1000,RuleNumber),NAMED('RuleEfficacy'));
CB := OUTPUT(TOPN(matches(InFile).ConfidenceBreakdown,1000,conf),NAMED('ConfidenceLevels'));
SpcS := OUTPUT(bell_thrive.specificities(InFile).SpcShift,NAMED('SPCShift'));
EXPORT ExecutionStats := PARALLEL(OS,SpcS,PRPP,PPP,MP,SP,RE,CB,MPPA,MPPR);
d := DATASET([{bell_thrive.matches(InFile).PatchingError0,bell_thrive.matches(InFile).DidsNoRid0,bell_thrive.matches(InFile).DidsAboveRid0,bell_thrive.matches(InFile).DuplicateRids0,COUNT(bell_thrive.match_candidates(InFile).Unlinkables)}],{INTEGER PatchingError0, INTEGER DidsNoRid0, INTEGER DidsAboveRid0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0});
EXPORT ValidityStats := OUTPUT(d,NAMED('ValidityStatistics'));
KC := BUILDINDEX(keys(InFile).candidates,OVERWRITE);
KS := BUILDINDEX(keys(InFile).MatchSample,OVERWRITE);
KSS := BUILDINDEX(keys(InFile).Specificities_Key,OVERWRITE,FEW);
EXPORT DebugKeys := PARALLEL(KC,KS,KSS);
EXPORT OutputCandidates := BUILDINDEX(keys(InFile).PatchedCandidates,OVERWRITE);
EXPORT OutputFile := OUTPUT(bell_thrive.matches(InFile).patched_infile,,'~temp::::bell_thrive::it'+iter,COMPRESSED);// Change file for each iteration
EXPORT OutputFileA := OUTPUT(bell_thrive.matches(InFile).patched_infile,,'~temp::::bell_thrive::it'+iter,OVERWRITE,COMPRESSED);// Change file for each iteration
//EXPORT LoopN(UNSIGNED N,UNSIGNED mt=0) := LOOP(bell_thrive.In_files().input.used,N,bell_thrive.matches(ROWS(LEFT),mt).patched_infile); // Loop N times
//EXPORT LoopThisN(DATASET(bell_thrive.Layout_files().input.used)d,UNSIGNED N,UNSIGNED mt=0) := LOOP(d,N,bell_thrive.matches(ROWS(LEFT),mt).patched_infile);
//EXPORT LoopThisK(DATASET(bell_thrive.Layout_files().input.used)d,UNSIGNED K,UNSIGNED NMax=100) := LOOP(d,COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),,ALL))>K,bell_thrive.matches(ROWS(LEFT),0).patched_infile); // Loop until K clusters left
EXPORT DoAll := PARALLEL(OutputSamples,ExecutionStats,ValidityStats,DebugKeys,OutputFile,OutputCandidates);
EXPORT DoAllAgain := PARALLEL(OutputSamples,ExecutionStats,ValidityStats,DebugKeys,OutputFileA,OutputCandidates);
end;
