import HealthCareFacility;
EXPORT Proc_Iterate(STRING iter,DATASET(Layout_HealthFacility) InFile0 = HealthCareFacilityHeader.In_HealthFacility,STRING OutFileNameP = HealthCareFacility.Files.Facility_Salt_Output,UNSIGNED MatchThreshold = Config.MatchThreshold,BOOLEAN Debugging = true) := MODULE
SHARED Mask_File := HealthCareFacilityHeader.Mask_Billing_Address (Infile0);
SHARED InFile := Mask_File;
SHARED MM := HealthCareFacilityHeader.matches(InFile,MatchThreshold); // Get the matching module
OSR := OUTPUT(CHOOSEN(MM.MatchSampleRecords,10000),NAMED('MatchSampleRecords'));
OSL := OUTPUT(CHOOSEN(MM.ToSlice,1000),NAMED('SliceOutCandidates'));
EXPORT OutputSamples := PARALLEL(OSR,OSL);// Provide the records!
SHARED BM := HealthCareFacilityHeader.BasicMatch(InFile);
BMS := OUTPUT(CHOOSEN(BM.patch_file, 1000), NAMED('BasicMatch_Patch_File'));
OMatchSamples := OUTPUT(CHOOSEN(MM.MatchSample,1000),NAMED('MatchSample'));
OBSamples := OUTPUT(CHOOSEN(MM.BorderlineMatchSample,10000),NAMED('BorderlineMatchSample'));
OAS := OUTPUT(CHOOSEN(MM.AlmostMatchSample,10000),NAMED('AlmostMatchSample'));
EXPORT OutputExtraSamples := PARALLEL(OMatchSamples, OBSamples, OAS, BMS); // This is not called automatically - call yourself if you want them!
OS := OUTPUT(HealthCareFacilityHeader.specificities(InFile).specificities,NAMED('Specificities'));
OPRP := OUTPUT(HealthCareFacilityHeader.match_candidates(InFile).prepropogationstats,NAMED('PrePopStats'));
OPP := OUTPUT(HealthCareFacilityHeader.match_candidates(InFile).postpropogationstats,NAMED('PostPopStats'));
PRPPS := OUTPUT(MM.PreIds.IdCounts,NAMED('PreClusterCount'));
PRPP := OUTPUT(MM.PreIds.LNPID_Clusters,NAMED('PreClusters'),ALL);
PPPS := OUTPUT(MM.PostIds.IdCounts,NAMED('PostClusterCount'));
PPP := OUTPUT(MM.PostIds.LNPID_Clusters,NAMED('PostClusters'),ALL);
MP := PARALLEL( OUTPUT(MM.MatchesPerformed,NAMED('MatchesPerformed')),OUTPUT(HealthCareFacilityHeader.BasicMatch(InFile).basic_match_count,NAMED('BasicMatchesPerformed')));
SP := OUTPUT(MM.SlicesPerformed,NAMED('SlicesPerformed'));
MPPA := OUTPUT(MM.MatchesPropAssisted * 100 / MM.MatchesPerformed,NAMED('PropagationAssisted_Pcnt'));
MPPR := OUTPUT(MM.MatchesPropRequired * 100 / MM.MatchesPerformed,NAMED('PropagationRequired_Pcnt'));
RE := OUTPUT(TOPN(MM.RuleEfficacy,1000,RuleNumber),NAMED('RuleEfficacy'));
CB := OUTPUT(TOPN(MM.ConfidenceBreakdown,1000,conf),NAMED('ConfidenceLevels'));
SpcS := OUTPUT(HealthCareFacilityHeader.specificities(InFile).SpcShift,NAMED('SPCShift'));
EXPORT ExecutionStats := PARALLEL(OS,SpcS,PRPP,PPP,PRPPS,PPPS,MP,SP,RE,CB,MPPA,MPPR,OPRP,OPP);
d := DATASET([{MM.PatchingError0,MM.DuplicateRids0,COUNT(HealthCareFacilityHeader.match_candidates(InFile).Unlinkables)}],{INTEGER PatchingError0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0});
EXPORT ValidityStats := PARALLEL( OUTPUT(d,NAMED('ValidityStatistics')), OUTPUT(MM.PostIds.Advanced0,NAMED('IdConsistency0')));
EXPORT InputValidityStats := OUTPUT(MM.PreIds.Advanced0,NAMED('InputIdConsistency0'));
EXPORT DebugKeys := Keys(InFile).BuildAll;
EXPORT OutputFileName := OutFileNameP+iter;
EXPORT Unmask_File := HealthCareFacilityHeader.Reinstate_Billing_Address (InFile0,MM.patched_infile);
EXPORT Mask_Output := OUTPUT (InFile0,,'~thor::infile0::'+ workunit,OVERWRITE,COMPRESSED,expire(5));
EXPORT UnMask_Output := OUTPUT (MM.patched_infile,,'~thor::patch::infile::'+ workunit,OVERWRITE,COMPRESSED,expire(5));
EXPORT OutputFile := OUTPUT(Unmask_File,,OutputFileName,COMPRESSED);// Change file for each iteration
EXPORT OutputFileA := OUTPUT(Unmask_File,,OutputFileName,OVERWRITE,COMPRESSED);// Change file for each iteration
ChangeName := HealthCareFacility.Files.Facility_PossibleMatches+iter;
EXPORT OutputChanges := SEQUENTIAL( OUTPUT(MM.IdChanges,,ChangeName,OVERWRITE,COMPRESSED),FileServices.AddSuperFile(Keys(In_HealthFacility).MatchHistoryName,ChangeName));
//EXPORT LoopN(UNSIGNED N,UNSIGNED mt=Config.MatchThreshold) := LOOP(InFile,N,HealthCareFacilityHeader.matches(ROWS(LEFT),mt).patched_infile); // Loop N times
//EXPORT LoopThisN(DATASET(HealthCareFacilityHeader.Layout_HealthFacility)d,UNSIGNED N,UNSIGNED mt=Config.MatchThreshold) := LOOP(d,N,HealthCareFacilityHeader.matches(ROWS(LEFT),mt).patched_infile);
//EXPORT LoopThisK(DATASET(HealthCareFacilityHeader.Layout_HealthFacility)d,UNSIGNED K,UNSIGNED NMax=100) := LOOP(d,COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),LNPID,ALL))>K,HealthCareFacilityHeader.matches(ROWS(LEFT),0).patched_infile); // Loop until K clusters left
//Perform the build of the cleave indexes - prior to remainder of work
SHARED LinkPhase(BOOLEAN again) := SEQUENTIAL(PARALLEL(OutputSamples,ExecutionStats,ValidityStats,IF(again,OutputFileA,OutputFile),OutputChanges),IF(Debugging,DebugKeys));
EXPORT DoAll := LinkPhase(FALSE);
EXPORT DoAllAgain := LinkPhase(TRUE);
END;
