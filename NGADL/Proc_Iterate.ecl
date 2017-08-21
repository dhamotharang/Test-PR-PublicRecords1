//Executable code
export Proc_Iterate(string iter, dataset(ngadl.Layout_Header) ih = NGADL.In_HEADER) := module
OMatchSamples := output(choosen(NGADL.matches(ih).MatchSample,1000),named('MatchSample'));
OBSamples := output(choosen(NGADL.matches(ih).BorderlineMatchSample,10000),named('BorderlineMatchSample'));
OAS := output(choosen(NGADL.matches(ih).AlmostMatchSample,10000),named('AlmostMatchSample'));
OSR := output(choosen(NGADL.matches(ih).MatchSampleRecords,10000),named('MatchSampleRecords'));
//export OutputSamples := PARALLEL(OMatchSamples,OBSamples,OAS,OSR);
export OutputSamples := PARALLEL(OSR);// Most people only want the records!
OS := output(NGADL.specificities(ih).specificities,named('Specificities'));
OPRP := output(NGADL.match_candidates(ih).prepropogationstats,named('PrePopStats'));
OPP := output(NGADL.match_candidates(ih).postpropogationstats,named('PostPopStats'));
PRPP := output(NGADL.matches(ih).PrePatchIdCount,named('PrePatchIdCount'));
PPP := output(NGADL.matches(ih).PostPatchIdCount,named('PostPatchIdCount'));
MP := output(NGADL.matches(ih).MatchesPerformed,named('MatchesPerformed'));
MPPA := output(NGADL.matches(ih).MatchesPropAssisted * 100 / NGADL.matches(ih).MatchesPerformed,named('PropogationAssisted_Pcnt'));
MPPR := output(NGADL.matches(ih).MatchesPropRequired * 100 / NGADL.matches(ih).MatchesPerformed,named('PropogationRequired_Pcnt'));
RE := output(choosen(matches(ih).RuleEfficacy,1000),named('RuleEfficacy'));
CB := output(choosen(matches(ih).ConfidenceBreakdown,1000),named('ConfidenceLevels'));
export ExecutionStats := PARALLEL(OS,OPRP,OPP,PRPP,PPP,MP,RE,CB,MPPA,MPPR);
d := dataset([{NGADL.matches(ih).PatchingError0,NGADL.matches(ih).DidsNoRid0,NGADL.matches(ih).DidsAboveRid0,NGADL.matches(ih).DuplicateRids0,count(NGADL.match_candidates(ih).Unlinkables)}],{integer PatchingError0, integer DidsNoRid0, integer DidsAboveRid0, integer DuplicateRids0, unsigned UnlinkableRecords0});
export ValidityStats := output(d,named('ValidityStatistics'));
KC := buildindex(keys(ih).candidates,overwrite);
KS := buildindex(keys(ih).MatchSample,overwrite);
KSS := buildindex(keys(ih).Specificities_Key,overwrite,few);
export DebugKeys := parallel(KC,KS,KSS);
export OutputCandidates := buildindex(keys(ih).PatchedCandidates,overwrite);
export OutputFile := output(NGADL.matches(ih).patched_infile,,'~thor_data400::temp::DID::it'+iter);// Change file for each iteration
export OutputFileA := output(NGADL.matches(ih).patched_infile,,'~thor_data400::temp::DID::it'+iter,overwrite);// Change file for each iteration
export DoAll := PARALLEL(OutputSamples,ExecutionStats,ValidityStats,DebugKeys,OutputFile,OutputCandidates);
export DoAllAgain := PARALLEL(OutputSamples,ExecutionStats,ValidityStats,DebugKeys,OutputFileA,OutputCandidates);
end;
