import tools,std;
EXPORT Proc_Iterate(
   STRING                   iter
  ,string                   pversion
  ,dataset(layout_DOT_Base) ih        = In_DOT_Base
) := MODULE

SHARED InFile := ih;
shared	string siter    := (string)iter;
shared  string lversion := pversion;
shared  string combo    := lversion + '_' + siter;
shared  string prevcombo    := lversion + '_' + (string)((unsigned)siter - 1);
shared names            :=    BIPV2_ProxID_dev5.filenames(combo).dall_filenames
                            + BIPV2_ProxID_dev5.keynames(combo).dall_filenames
                            ;
shared psetReviewers           := ['CM','LB','TL','JL','FN','DW','SS'];
shared pNumSamplesPerReviewer  := 15;
shared ConfThreshold           := '21';
shared dotbase                 := BIPV2_ProxID_dev5.In_DOT_Base;
shared kmtch                   := index(BIPV2_ProxID_dev5.Keys(dotbase).MatchSample ,BIPV2_ProxID_dev5.keynames().match_sample_debug.built    );
shared kcand                   := index(BIPV2_ProxID_dev5.Keys(dotbase).Candidates  ,BIPV2_ProxID_dev5.keynames().match_candidates_debug.built);
export outputReviewSamples      := Tools.mac_GetSALTReviewSamples(kmtch,kcand,BIPV2_ProxID_dev5.In_DOT_Base,proxid,ConfThreshold,pNumSamplesPerReviewer,psetReviewers);

shared clearsupers := nothor(Tools.fun_ClearfilesFromSupers(project(names, transform(Tools.Layout_Names,self.name := left.logicalname)), false)); //clear supers if needed
shared preppromote2built := if(iter = '1'  ,BIPV2_ProxID_dev5.Promote('0').new2built  ,BIPV2_ProxID_dev5.Promote(prevcombo).new2built);

OSR := OUTPUT(CHOOSEN(BIPV2_ProxID_dev5.matches(InFile).MatchSampleRecords,1000),NAMED('MatchSampleRecords'));
OSL := OUTPUT(CHOOSEN(BIPV2_ProxID_dev5.matches(InFile).ToSlice,1000),NAMED('SliceOutCandidates'));
EXPORT OutputSamples := PARALLEL(OSR,OSL);// Provide the records!
OMatchSamples := OUTPUT(CHOOSEN(BIPV2_ProxID_dev5.matches(InFile).MatchSample,1000),NAMED('MatchSample'));
OBSamples := OUTPUT(CHOOSEN(BIPV2_ProxID_dev5.matches(InFile).BorderlineMatchSample,1000),NAMED('BorderlineMatchSample'));
OAS := OUTPUT(CHOOSEN(BIPV2_ProxID_dev5.matches(InFile).AlmostMatchSample,1000),NAMED('AlmostMatchSample'));
EXPORT OutputExtraSamples := PARALLEL(OMatchSamples,OBSamples,OAS); // This is not called automatically - call yourself if you want them!
OS := OUTPUT(BIPV2_ProxID_dev5.specificities(InFile).specificities,NAMED('Specificities'));
OPRP := OUTPUT(BIPV2_ProxID_dev5.match_candidates(InFile).prepropogationstats,NAMED('PrePopStats'));
OPP := OUTPUT(BIPV2_ProxID_dev5.match_candidates(InFile).postpropogationstats,NAMED('PostPopStats'));
PRPPS := OUTPUT(BIPV2_ProxID_dev5.matches(InFile).PrePatchIdCount,NAMED('PreClusterCount'),all);
PRPP := OUTPUT(BIPV2_ProxID_dev5.matches(InFile).PreClusters,NAMED('PreClusters'),all);
PPPS := OUTPUT(BIPV2_ProxID_dev5.matches(InFile).PostPatchIDCount,NAMED('PostClusterCount'),all);
PPP := OUTPUT(BIPV2_ProxID_dev5.matches(InFile).PostClusters,NAMED('PostClusters'),all);
MP := OUTPUT(BIPV2_ProxID_dev5.matches(InFile).MatchesPerformed,NAMED('MatchesPerformed'));
SP := OUTPUT(BIPV2_ProxID_dev5.matches(InFile).SlicesPerformed,NAMED('SlicesPerformed'));
MPPA := OUTPUT(BIPV2_ProxID_dev5.matches(InFile).MatchesPropAssisted * 100 / BIPV2_ProxID_dev5.matches(InFile).MatchesPerformed,NAMED('PropagationAssisted_Pcnt'));
MPPR := OUTPUT(BIPV2_ProxID_dev5.matches(InFile).MatchesPropRequired * 100 / BIPV2_ProxID_dev5.matches(InFile).MatchesPerformed,NAMED('PropagationRequired_Pcnt'));
RE := OUTPUT(TOPN(matches(InFile).RuleEfficacy,1000,RuleNumber),NAMED('RuleEfficacy'));
CB := OUTPUT(TOPN(matches(InFile).ConfidenceBreakdown,1000,conf),NAMED('ConfidenceLevels'));
SpcS := OUTPUT(BIPV2_ProxID_dev5.specificities(InFile).SpcShift,NAMED('SPCShift'));
/*CUSTOM*/PC := OUTPUT(BIPV2_ProxID_dev5.specificities(InFile).PartitionCounts,NAMED('PartitionCounts'));
EXPORT ExecutionStats := PARALLEL(OS,SpcS,PRPP,PPP,PRPPS,PPPS,MP,SP,RE,CB,MPPA,MPPR,OPRP,OPP,/*CUSTOM*/PC);
d := DATASET([{BIPV2_ProxID_dev5.matches(InFile).PatchingError0,BIPV2_ProxID_dev5.matches(InFile).DidsNoRid0,BIPV2_ProxID_dev5.matches(InFile).DidsAboveRid0,BIPV2_ProxID_dev5.matches(InFile).DuplicateRids0,COUNT(BIPV2_ProxID_dev5.match_candidates(InFile).Unlinkables)}],{INTEGER PatchingError0, INTEGER DidsNoRid0, INTEGER DidsAboveRid0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0});
EXPORT ValidityStats := OUTPUT(d,NAMED('ValidityStatistics'));
EXPORT DebugKeys := Keys(InFile,combo).BuildAll;
EXPORT OutputFile := OUTPUT(BIPV2_ProxID_dev5.matches(InFile).patched_infile,,filenames(combo).base.logical,OVERWRITE,COMPRESSED);// Change file for each iteration
EXPORT OutputFileA := OUTPUT(BIPV2_ProxID_dev5.matches(InFile).patched_infile,,filenames(combo).base.logical,OVERWRITE,COMPRESSED);// Change file for each iteration
export outputpossiblematches := OUTPUT(BIPV2_ProxID_dev5.matches(InFile).PossibleMatches,,filenames(combo).possiblematches.logical,OVERWRITE,COMPRESSED);
EXPORT LoopN(UNSIGNED N,UNSIGNED mt=21) := LOOP(ih,N,BIPV2_ProxID_dev5.matches(ROWS(LEFT),mt).patched_infile); // Loop N times
EXPORT OutputLoopN(UNSIGNED N,UNSIGNED mt=21) := OUTPUT(LoopN(N,mt),,filenames(combo).base.logical,OVERWRITE,COMPRESSED);// Change file for each iteration
EXPORT LoopThisN(DATASET(BIPV2_ProxID_dev5.Layout_DOT_Base)d,UNSIGNED N,UNSIGNED mt=21) := LOOP(d,N,BIPV2_ProxID_dev5.matches(ROWS(LEFT),mt).patched_infile);
EXPORT LoopThisK(DATASET(BIPV2_ProxID_dev5.Layout_DOT_Base)d,UNSIGNED K,UNSIGNED NMax=100) := LOOP(d,COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),Proxid,ALL))>K,BIPV2_ProxID_dev5.matches(ROWS(LEFT),0).patched_infile); // Loop until K clusters left
SHARED LinkPhase(BOOLEAN again) := sequential(if(iter = '1' ,sequential(output(In_DOT_Base)))/*,preppromote2built*/,clearsupers,PARALLEL(OutputSamples,OutputExtraSamples,ExecutionStats,ValidityStats,DebugKeys,IF(again,OutputFileA,OutputFile),outputpossiblematches),promote(combo).new2built,outputReviewSamples);
EXPORT DoAll := LinkPhase(FALSE);
EXPORT DoAllAgain := LinkPhase(TRUE);
END;

