import HealthCareProvider;
EXPORT Proc_Iterate(STRING iter,DATASET (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header) hdr,STRING OutFileNameP = HealthCareProvider.Files.Person_Salt_Output,UNSIGNED MatchThreshold = 42,BOOLEAN Debugging = true) := MODULE
SHARED InFile := hdr;
SHARED MM := HealthCareProviderHeader_prod.matches(InFile,MatchThreshold); // Get the matching module
OSR := OUTPUT(CHOOSEN(MM.MatchSampleRecords,10000),NAMED('MatchSampleRecords'));
OSL := OUTPUT(CHOOSEN(MM.ToSlice,1000),NAMED('SliceOutCandidates'));
EXPORT OutputSamples := PARALLEL(OSR,OSL);// Provide the records!
OMatchSamples := OUTPUT(CHOOSEN(MM.MatchSample,1000),NAMED('MatchSample'));
OBSamples := OUTPUT(CHOOSEN(MM.BorderlineMatchSample,10000),NAMED('BorderlineMatchSample'));
OAS := OUTPUT(CHOOSEN(MM.AlmostMatchSample,10000),NAMED('AlmostMatchSample'));
EXPORT OutputExtraSamples := PARALLEL(OMatchSamples,OBSamples,OAS); // This is not called automatically - call yourself if you want them!
OS := OUTPUT(HealthCareProviderHeader_prod.specificities(InFile).specificities,NAMED('Specificities'));
OPRP := OUTPUT(HealthCareProviderHeader_prod.match_candidates(InFile).prepropogationstats,NAMED('PrePopStats'));
OPP := OUTPUT(HealthCareProviderHeader_prod.match_candidates(InFile).postpropogationstats,NAMED('PostPopStats'));
PRPPS := OUTPUT(MM.PrePatchIdCount,NAMED('PreClusterCount'),all);
PRPP := OUTPUT(MM.PreClusters,NAMED('PreClusters'),all);
PPPS := OUTPUT(MM.PostPatchIDCount,NAMED('PostClusterCount'),all);
PPP := OUTPUT(MM.PostClusters,NAMED('PostClusters'),all);
MP := PARALLEL( OUTPUT(MM.MatchesPerformed,NAMED('MatchesPerformed')),OUTPUT(HealthCareProviderHeader_prod.BasicMatch(InFile).basic_match_count,NAMED('BasicMatchesPerformed')));
SP := OUTPUT(MM.SlicesPerformed,NAMED('SlicesPerformed'));
MPPA := OUTPUT(MM.MatchesPropAssisted * 100 / MM.MatchesPerformed,NAMED('PropagationAssisted_Pcnt'));
MPPR := OUTPUT(MM.MatchesPropRequired * 100 / MM.MatchesPerformed,NAMED('PropagationRequired_Pcnt'));
RE := OUTPUT(TOPN(MM.RuleEfficacy,1000,RuleNumber),NAMED('RuleEfficacy'));
CB := OUTPUT(TOPN(MM.ConfidenceBreakdown,1000,conf),NAMED('ConfidenceLevels'));
SpcS := OUTPUT(HealthCareProviderHeader_prod.specificities(InFile).SpcShift,NAMED('SPCShift'));
FLG := OUTPUT(Best(InFile).In_Flagged_Summary,NAMED('FlagSummary'));
FLG1 := OUTPUT(CHOOSEN(Best(InFile).In_Flagged_Summary_BySrc,10000),NAMED('FlagSrcSummary'));
EXPORT ExecutionStats := PARALLEL(OS,SpcS,PRPP,PPP,PRPPS,PPPS,MP,SP,RE,CB,MPPA,MPPR,OPRP,OPP,FLG,FLG1);
d := DATASET([{MM.PatchingError0,MM.DidsNoRid0,MM.DidsAboveRid0,MM.DuplicateRids0,COUNT(HealthCareProviderHeader_prod.match_candidates(InFile).Unlinkables)}],{INTEGER PatchingError0, INTEGER DidsNoRid0, INTEGER DidsAboveRid0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0});
EXPORT ValidityStats := OUTPUT(d,NAMED('ValidityStatistics'));
EXPORT DebugKeys := Keys(InFile).BuildAll;
EXPORT OutputFileName := OutFileNameP+iter;
EXPORT OutputFile := OUTPUT(MM.patched_infile,,OutputFileName,OVERWRITE,COMPRESSED);// Change file for each iteration
EXPORT OutputFileA := OUTPUT(MM.patched_infile,,OutputFileName,OVERWRITE,COMPRESSED);// Change file for each iteration
EXPORT OutputChanges := OUTPUT(MM.IdChanges,,HealthCareProvider.Files.Person_PossibleMatches+iter,OVERWRITE,COMPRESSED);// Changes made
//EXPORT LoopN(UNSIGNED N,UNSIGNED mt=42) := LOOP(HealthCareProviderHeader_prod.In_HealthProvider,N,HealthCareProviderHeader_prod.matches(ROWS(LEFT),mt).patched_infile); // Loop N times
//EXPORT LoopThisN(DATASET(HealthCareProviderHeader_prod.Layout_HealthProvider)d,UNSIGNED N,UNSIGNED mt=42) := LOOP(d,N,HealthCareProviderHeader_prod.matches(ROWS(LEFT),mt).patched_infile);
//EXPORT LoopThisK(DATASET(HealthCareProviderHeader_prod.Layout_HealthProvider)d,UNSIGNED K,UNSIGNED NMax=100) := LOOP(d,COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),LNPID,ALL))>K,HealthCareProviderHeader_prod.matches(ROWS(LEFT),0).patched_infile); // Loop until K clusters left
SHARED LinkPhase(BOOLEAN again) := PARALLEL(OutputSamples,ExecutionStats,ValidityStats,IF(Debugging,DebugKeys),IF(again,OutputFileA,OutputFile),OutputChanges);
EXPORT DoAll := LinkPhase(FALSE);
EXPORT DoAllAgain := LinkPhase(TRUE);
END;
