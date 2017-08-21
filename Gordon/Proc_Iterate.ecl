//Executable code
export Proc_Iterate(string iter) := module
OMatchSamples := output(choosen(Gordon.matches(Gordon.In_HEADER).MatchSample,1000),named('MatchSample'));
OBSamples := output(choosen(Gordon.matches(Gordon.In_HEADER).BorderlineMatchSample,10000),named('BorderlineMatchSample'));
OAS := output(choosen(Gordon.matches(Gordon.In_HEADER).AlmostMatchSample,10000),named('AlmostMatchSample'));
OSR := output(choosen(Gordon.matches(Gordon.In_HEADER).MatchSampleRecords,10000),named('MatchSampleRecords'));
//export OutputSamples := PARALLEL(OMatchSamples,OBSamples,OAS,OSR);
export OutputSamples := PARALLEL(OSR);// Most people only want the records!
OS := output(Gordon.specificities(Gordon.In_HEADER).specificities,named('Specificities'));
OPRP := output(Gordon.match_candidates(Gordon.In_HEADER).prepropogationstats,named('PrePopStats'));
OPP := output(Gordon.match_candidates(Gordon.In_HEADER).postpropogationstats,named('PostPopStats'));
PRPP := output(Gordon.matches(Gordon.In_HEADER).PreClusters,named('PreClusters'));
PPP := output(Gordon.matches(Gordon.In_HEADER).PostClusters,named('PostClusters'));
MP := output(Gordon.matches(Gordon.In_HEADER).MatchesPerformed,named('MatchesPerformed'));
MPPA := output(Gordon.matches(Gordon.In_HEADER).MatchesPropAssisted * 100 / Gordon.matches(Gordon.In_HEADER).MatchesPerformed,named('PropogationAssisted_Pcnt'));
MPPR := output(Gordon.matches(Gordon.In_HEADER).MatchesPropRequired * 100 / Gordon.matches(Gordon.In_HEADER).MatchesPerformed,named('PropogationRequired_Pcnt'));
RE := output(choosen(matches(In_HEADER).RuleEfficacy,1000),named('RuleEfficacy'));
CB := output(choosen(matches(In_HEADER).ConfidenceBreakdown,1000),named('ConfidenceLevels'));
export ExecutionStats := PARALLEL(OS,OPRP,OPP,PRPP,PPP,MP,RE,CB,MPPA,MPPR);
d := dataset([{Gordon.matches(Gordon.In_HEADER).PatchingError0,Gordon.matches(Gordon.In_HEADER).DidsNoRid0,Gordon.matches(Gordon.In_HEADER).DidsAboveRid0,Gordon.matches(Gordon.In_HEADER).DuplicateRids0,count(Gordon.match_candidates(Gordon.In_HEADER).Unlinkables)}],{integer PatchingError0, integer DidsNoRid0, integer DidsAboveRid0, integer DuplicateRids0, unsigned UnlinkableRecords0});
export ValidityStats := output(d,named('ValidityStatistics'));
KC := buildindex(keys.candidates,overwrite);
KS := buildindex(keys.MatchSample,overwrite);
KSS := buildindex(keys.Specificities_Key,overwrite,few);
export DebugKeys := parallel(KC,KS,KSS);
export OutputCandidates := buildindex(keys.PatchedCandidates,overwrite);
export OutputFile := output(Gordon.matches(Gordon.In_HEADER).patched_infile,,'~thor_data400::temp::DID::NGADL::it'+iter);// Change file for each iteration
export OutputFileA := output(Gordon.matches(Gordon.In_HEADER).patched_infile,,'~thor_data400::temp::DID::NGADL::it'+iter,overwrite);// Change file for each iteration
export LoopN(unsigned N,unsigned mt=5) := LOOP(Gordon.In_HEADER,N,Gordon.matches(ROWS(LEFT),mt).patched_infile); // Loop N times
export LoopThisN(dataset(Gordon.Layout_HEADER)d,unsigned N,unsigned mt=5) := LOOP(d,N,Gordon.matches(ROWS(LEFT),mt).patched_infile);
export LoopThisK(dataset(Gordon.Layout_HEADER)d,unsigned K,unsigned NMax=100) := LOOP(d,COUNTER<=NMax AND count(dedup(rows(left),DID,all))>K,Gordon.matches(ROWS(LEFT),0).patched_infile); // Loop until K clusters left
export DoAll := PARALLEL(OutputSamples,ExecutionStats,ValidityStats,DebugKeys,OutputFile,OutputCandidates);
export DoAllAgain := PARALLEL(OutputSamples,ExecutionStats,ValidityStats,DebugKeys,OutputFileA,OutputCandidates);
end;
