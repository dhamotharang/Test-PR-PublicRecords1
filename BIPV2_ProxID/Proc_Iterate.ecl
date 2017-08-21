//Executable code
EXPORT Proc_Iterate(STRING iter,string keyversion/*HACK -- add keyversion*/,DATASET(Layout_DOT_Base) InFile0 = BIPV2_ProxID.In_DOT_Base,STRING OutFileNameP = '~temp::Proxid::BIPV2_ProxID::it',UNSIGNED MatchThreshold = Config.MatchThreshold,BOOLEAN Debugging = true) := MODULE
SHARED InFile := InFile0;
EXPORT MM := BIPV2_ProxID.matches(InFile,MatchThreshold); // Get the matching module
OSR := OUTPUT(CHOOSEN(MM.MatchSampleRecords,10000),NAMED('MatchSampleRecords'));
OSL := OUTPUT(CHOOSEN(MM.ToSlice,1000),NAMED('SliceOutCandidates'));
EXPORT OutputSamples := PARALLEL(OSR,OSL);// Provide the records!
SHARED BM := BIPV2_ProxID.BasicMatch(InFile);
BMS := OUTPUT(CHOOSEN(BM.patch_file, 1000), NAMED('BasicMatch_Patch_File'));
BMSF := OUTPUT(CHOOSEN(BM.Block, 1000), NAMED ('BasicMatch_Block'));
OMatchSamples := OUTPUT(CHOOSEN(MM.MatchSample,1000),NAMED('MatchSample'));
OBSamples := OUTPUT(CHOOSEN(MM.BorderlineMatchSample,10000),NAMED('BorderlineMatchSample'));
OAS := OUTPUT(CHOOSEN(MM.AlmostMatchSample,10000),NAMED('AlmostMatchSample'));
EXPORT OutputExtraSamples := PARALLEL(OMatchSamples, OBSamples, OAS, BMS, BMSF); // This is not called automatically - call yourself if you want them!
OS := OUTPUT(BIPV2_ProxID.specificities(InFile).specificities,NAMED('Specificities'));
OPRP := OUTPUT(BIPV2_ProxID.match_candidates(InFile).prepropogationstats,NAMED('PrePopStats'));
OPP := OUTPUT(BIPV2_ProxID.match_candidates(InFile).postpropogationstats,NAMED('PostPopStats'));
PRPPS := OUTPUT(MM.PreIds.IdCounts,NAMED('PreClusterCount'));
PRPP := OUTPUT(MM.PreIds.Proxid_Clusters,NAMED('PreClusters'),ALL);
PPPS := OUTPUT(MM.PostIds.IdCounts,NAMED('PostClusterCount'));
PPP := OUTPUT(MM.PostIds.Proxid_Clusters,NAMED('PostClusters'),ALL);
MP := PARALLEL( OUTPUT(MM.MatchesPerformed,NAMED('MatchesPerformed')),OUTPUT(BIPV2_ProxID.BasicMatch(InFile).basic_match_count,NAMED('BasicMatchesPerformed')));
SP := OUTPUT(MM.SlicesPerformed,NAMED('SlicesPerformed'));
MPPA := OUTPUT(MM.MatchesPropAssisted * 100 / MM.MatchesPerformed,NAMED('PropagationAssisted_Pcnt'));
MPPR := OUTPUT(MM.MatchesPropRequired * 100 / MM.MatchesPerformed,NAMED('PropagationRequired_Pcnt'));
RE := OUTPUT(TOPN(MM.RuleEfficacy,1000,RuleNumber),NAMED('RuleEfficacy'));
CB := OUTPUT(TOPN(MM.ConfidenceBreakdown,1000,conf),NAMED('ConfidenceLevels'));
SpcS := OUTPUT(BIPV2_ProxID.specificities(InFile).SpcShift,NAMED('SPCShift'));
LBS := OUTPUT(MM.LinkBlocksPerformed,NAMED('LinkBlockSplits'));
EXPORT ExecutionStats := PARALLEL(OS,SpcS,PRPP,PPP,PRPPS,PPPS,MP,SP,RE,CB,MPPA,MPPR,OPRP,OPP,LBS);
d := DATASET([{MM.PatchingError0,MM.DuplicateRids0,COUNT(BIPV2_ProxID.match_candidates(InFile).Unlinkables),COUNT(LinkBlockers(InFile).RuleBreakers0)}],{INTEGER PatchingError0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0,UNSIGNED LinkBlockRuleBreakers0});
EXPORT ValidityStats := PARALLEL( OUTPUT(d,NAMED('ValidityStatistics')), OUTPUT(MM.PostIds.Advanced0,NAMED('IdConsistency0')));
EXPORT InputValidityStats := OUTPUT(MM.PreIds.Advanced0,NAMED('InputIdConsistency0'));
EXPORT DebugKeys := Keys(InFile,keyversion).BuildAll; // HACK keys to add keyersion
EXPORT OutputFileName := OutFileNameP+iter;
EXPORT OutputFile := OUTPUT(MM.patched_infile,,OutputFileName,COMPRESSED);// Change file for each iteration
EXPORT OutputFileA := OUTPUT(MM.patched_infile,,OutputFileName,OVERWRITE,COMPRESSED);// Change file for each iteration
ChangeName := '~temp::Proxid::BIPV2_ProxID::changes_it'+keyversion;/* HACK use keyversion for changes file*/
EXPORT OutputChanges := SEQUENTIAL( OUTPUT(MM.IdChanges,,ChangeName,OVERWRITE,COMPRESSED),FileServices.AddSuperFile(Keys(InFile).MatchHistoryName,ChangeName));
//EXPORT LoopN(UNSIGNED N,UNSIGNED mt=Config.MatchThreshold) := LOOP(InFile,N,BIPV2_ProxID.matches(ROWS(LEFT),mt).patched_infile); // Loop N times
//EXPORT LoopThisN(DATASET(BIPV2_ProxID.Layout_DOT_Base)d,UNSIGNED N,UNSIGNED mt=Config.MatchThreshold) := LOOP(d,N,BIPV2_ProxID.matches(ROWS(LEFT),mt).patched_infile);
//EXPORT LoopThisK(DATASET(BIPV2_ProxID.Layout_DOT_Base)d,UNSIGNED K,UNSIGNED NMax=100) := LOOP(d,COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),Proxid,ALL))>K,BIPV2_ProxID.matches(ROWS(LEFT),0).patched_infile); // Loop until K clusters left
SHARED LinkPhase(BOOLEAN again) := SEQUENTIAL(PARALLEL(OutputSamples,ExecutionStats,ValidityStats,IF(again,OutputFileA,OutputFile),OutputChanges),IF(Debugging,DebugKeys));
//Perform the build of the cleave indexes - prior to remainder of work
SHARED WithCleave(BOOLEAN again) := IF(Config.ByPassCleave,LinkPhase(Again),SEQUENTIAL( Cleave(InFile).BuildAll, LinkPhase(Again) ));
EXPORT DoAll := WithCleave(FALSE);
EXPORT DoAllAgain := WithCleave(TRUE);
END;
