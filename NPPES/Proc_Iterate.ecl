//Executable code
export Proc_Iterate(string iter) := module
shared InFile := NPPES.In_FileIN;
OMatchSamples := output(choosen(NPPES.matches(InFile).MatchSample,1000),named('MatchSample'));
OBSamples := output(choosen(NPPES.matches(InFile).BorderlineMatchSample,10000),named('BorderlineMatchSample'));
OAS := output(choosen(NPPES.matches(InFile).AlmostMatchSample,10000),named('AlmostMatchSample'));
OSR := output(choosen(NPPES.matches(InFile).MatchSampleRecords,10000),named('MatchSampleRecords'));
OSL := output(choosen(NPPES.matches(InFile).ToSlice,1000),named('SliceOutCandidates'));
//export OutputSamples := PARALLEL(OMatchSamples,OBSamples,OAS,OSR,OSL);
export OutputSamples := PARALLEL(OSR,OSL);// Most people only want the records!
OS := output(NPPES.specificities(InFile).specificities,named('Specificities'));
PRPP := output(NPPES.matches(InFile).PreClusters,named('PreClusters'),all);
PPP := output(NPPES.matches(InFile).PostClusters,named('PostClusters'),all);
MP := output(NPPES.matches(InFile).MatchesPerformed,named('MatchesPerformed'));
SP := output(NPPES.matches(InFile).SlicesPerformed,named('SlicesPerformed'));
MPPA := output(NPPES.matches(InFile).MatchesPropAssisted * 100 / NPPES.matches(InFile).MatchesPerformed,named('PropagationAssisted_Pcnt'));
MPPR := output(NPPES.matches(InFile).MatchesPropRequired * 100 / NPPES.matches(InFile).MatchesPerformed,named('PropagationRequired_Pcnt'));
RE := output(TopN(matches(InFile).RuleEfficacy,1000,RuleNumber),named('RuleEfficacy'));
CB := output(TopN(matches(InFile).ConfidenceBreakdown,1000,conf),named('ConfidenceLevels'));
SpcS := output(NPPES.specificities(InFile).SpcShift,named('SPCShift'));
export ExecutionStats := PARALLEL(OS,SpcS,PRPP,PPP,MP,SP,RE,CB,MPPA,MPPR);d := dataset([{NPPES.matches(InFile).PatchingError0,NPPES.matches(InFile).DidsNoRid0,NPPES.matches(InFile).DidsAboveRid0,NPPES.matches(InFile).DuplicateRids0,count(NPPES.match_candidates(InFile).Unlinkables)}],{integer PatchingError0, integer DidsNoRid0, integer DidsAboveRid0, integer DuplicateRids0, unsigned UnlinkableRecords0});
export ValidityStats := output(d,named('ValidityStatistics'));
KC := buildindex(keys(InFile).candidates,overwrite);
KS := buildindex(keys(InFile).MatchSample,overwrite);
KSS := buildindex(keys(InFile).Specificities_Key,overwrite,few);
export DebugKeys := parallel(KC,KS,KSS);
export OutputCandidates := buildindex(keys(InFile).PatchedCandidates,overwrite);
export OutputFile := output(NPPES.matches(InFile).patched_infile,,'~temp::::NPPES::it'+iter,compressed);// Change file for each iteration
export OutputFileA := output(NPPES.matches(InFile).patched_infile,,'~temp::::NPPES::it'+iter,overwrite,compressed);// Change file for each iteration
//export LoopN(unsigned N,unsigned mt=0) := LOOP(NPPES.In_FileIN,N,NPPES.matches(ROWS(LEFT),mt).patched_infile); // Loop N times
//export LoopThisN(dataset(NPPES.Layout_FileIN)d,unsigned N,unsigned mt=0) := LOOP(d,N,NPPES.matches(ROWS(LEFT),mt).patched_infile);
//export LoopThisK(dataset(NPPES.Layout_FileIN)d,unsigned K,unsigned NMax=100) := LOOP(d,COUNTER<=NMax AND count(dedup(rows(left),,all))>K,NPPES.matches(ROWS(LEFT),0).patched_infile); // Loop until K clusters left
export DoAll := PARALLEL(OutputSamples,ExecutionStats,ValidityStats,DebugKeys,OutputFile,OutputCandidates);
export DoAllAgain := PARALLEL(OutputSamples,ExecutionStats,ValidityStats,DebugKeys,OutputFileA,OutputCandidates);
end;
