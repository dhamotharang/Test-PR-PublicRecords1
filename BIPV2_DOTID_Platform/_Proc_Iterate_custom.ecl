//Executable code
/*CUSTOM*/import BIPV2_Files, BIPV2;
/*CUSTOM*/EXPORT Proc_Iterate(dataset(BIPV2_Files.layout_dotid) input, STRING iter) := MODULE
/*CUSTOM*/SHARED InFile := input;
OSR := OUTPUT(CHOOSEN(BIPV2_DOTID_PLATFORM.matches(InFile).MatchSampleRecords,10000),NAMED('MatchSampleRecords'));
OSL := OUTPUT(CHOOSEN(BIPV2_DOTID_PLATFORM.matches(InFile).ToSlice,1000),NAMED('SliceOutCandidates'));
EXPORT OutputSamples := PARALLEL(OSR,OSL);// Provide the records!
OMatchSamples := OUTPUT(CHOOSEN(BIPV2_DOTID_PLATFORM.matches(InFile).MatchSample,1000),NAMED('MatchSample'));
OBSamples := OUTPUT(CHOOSEN(BIPV2_DOTID_PLATFORM.matches(InFile).BorderlineMatchSample,10000),NAMED('BorderlineMatchSample'));
OAS := OUTPUT(CHOOSEN(BIPV2_DOTID_PLATFORM.matches(InFile).AlmostMatchSample,10000),NAMED('AlmostMatchSample'));
EXPORT OutputExtraSamples := PARALLEL(OMatchSamples,OBSamples,OAS); // This is not called automatically - call yourself if you want them!
OS := OUTPUT(BIPV2_DOTID_PLATFORM.specificities(InFile).specificities,NAMED('Specificities'));
OPRP := OUTPUT(BIPV2_DOTID_PLATFORM.match_candidates(InFile).prepropogationstats,NAMED('PrePopStats'));
OPP := OUTPUT(BIPV2_DOTID_PLATFORM.match_candidates(InFile).postpropogationstats,NAMED('PostPopStats'));
PRPPS := OUTPUT(BIPV2_DOTID_PLATFORM.matches(InFile).PrePatchIdCount,NAMED('PreClusterCount'),all);
PRPP := OUTPUT(BIPV2_DOTID_PLATFORM.matches(InFile).PreClusters,NAMED('PreClusters'),all);
PPPS := OUTPUT(BIPV2_DOTID_PLATFORM.matches(InFile).PostPatchIDCount,NAMED('PostClusterCount'),all);
PPP := OUTPUT(BIPV2_DOTID_PLATFORM.matches(InFile).PostClusters,NAMED('PostClusters'),all);
MP := OUTPUT(BIPV2_DOTID_PLATFORM.matches(InFile).MatchesPerformed,NAMED('MatchesPerformed'));
SP := OUTPUT(BIPV2_DOTID_PLATFORM.matches(InFile).SlicesPerformed,NAMED('SlicesPerformed'));
MPPA := OUTPUT(BIPV2_DOTID_PLATFORM.matches(InFile).MatchesPropAssisted * 100 / BIPV2_DOTID_PLATFORM.matches(InFile).MatchesPerformed,NAMED('PropagationAssisted_Pcnt'));
MPPR := OUTPUT(BIPV2_DOTID_PLATFORM.matches(InFile).MatchesPropRequired * 100 / BIPV2_DOTID_PLATFORM.matches(InFile).MatchesPerformed,NAMED('PropagationRequired_Pcnt'));
RE := OUTPUT(TOPN(matches(InFile).RuleEfficacy,1000,RuleNumber),NAMED('RuleEfficacy'));
CB := OUTPUT(TOPN(matches(InFile).ConfidenceBreakdown,1000,conf),NAMED('ConfidenceLevels'));
SpcS := OUTPUT(BIPV2_DOTID_PLATFORM.specificities(InFile).SpcShift,NAMED('SPCShift'));
EXPORT ExecutionStats := PARALLEL(OS,SpcS,PRPP,PPP,PRPPS,PPPS,MP,SP,RE,CB,MPPA,MPPR,OPRP,OPP);
d := DATASET([{BIPV2_DOTID_PLATFORM.matches(InFile).PatchingError0,BIPV2_DOTID_PLATFORM.matches(InFile).DidsNoRid0,BIPV2_DOTID_PLATFORM.matches(InFile).DidsAboveRid0,BIPV2_DOTID_PLATFORM.matches(InFile).DuplicateRids0,COUNT(BIPV2_DOTID_PLATFORM.match_candidates(InFile).Unlinkables),COUNT(BIPV2_DOTID_PLATFORM.specificities(InFile).Rejected_file)}],{INTEGER PatchingError0, INTEGER DidsNoRid0, INTEGER DidsAboveRid0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0,UNSIGNED RecordsRejected0});
EXPORT ValidityStats := OUTPUT(d,NAMED('ValidityStatistics'));
EXPORT DebugKeys := Keys(InFile).BuildAll;
/*CUSTOM*/EXPORT OutputFile := OUTPUT(BIPV2_DOTID_PLATFORM.matches(InFile).patched_infile,,BIPV2_Files.files_dotid.FILE_DOT_SALT_OP+iter+'_'+BIPV2.KeySuffix,COMPRESSED);// Change file for each iteration
/*CUSTOM*/EXPORT OutputFileA := OUTPUT(BIPV2_DOTID_PLATFORM.matches(InFile).patched_infile,,'~temp::DotID::BIPV2_DOTID_PLATFORM::it'+iter+'_'+BIPV2.KeySuffix,OVERWRITE,COMPRESSED);// Change file for each iteration
/*CUSTOM*/export possibleMatches := output(BIPV2_DOTID_PLATFORM.matches(InFile).PossibleMatches,,BIPV2_Files.files_dotid.FILE_DOT_SALT_POSSIBLE_MATCH+iter+'_'+BIPV2.KeySuffix,overwrite);// Change file for each iteration
// EXPORT LoopN(UNSIGNED N,UNSIGNED mt=31) := LOOP(BIPV2_DOTID_PLATFORM.In_DOT,N,BIPV2_DOTID_PLATFORM.matches(ROWS(LEFT),mt).patched_infile); // Loop N times
// EXPORT LoopThisN(DATASET(BIPV2_DOTID_PLATFORM.Layout_DOT)d,UNSIGNED N,UNSIGNED mt=31) := LOOP(d,N,BIPV2_DOTID_PLATFORM.matches(ROWS(LEFT),mt).patched_infile);
// EXPORT LoopThisK(DATASET(BIPV2_DOTID_PLATFORM.Layout_DOT)d,UNSIGNED K,UNSIGNED NMax=100) := LOOP(d,COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),DOTid,ALL))>K,BIPV2_DOTID_PLATFORM.matches(ROWS(LEFT),0).patched_infile); // Loop until K clusters left
/*CUSTOM*/SHARED LinkPhase(BOOLEAN again) := PARALLEL(OutputSamples,ExecutionStats,ValidityStats,DebugKeys,IF(again,OutputFileA,OutputFile),possibleMatches);
EXPORT DoAll := LinkPhase(FALSE);
EXPORT DoAllAgain := LinkPhase(TRUE);

/* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */
/* The remaining code is all CUSTOM, and may only be added when -p0 is in effect */
/* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

shared fprefix := '~temp::DotID::BIPV2_DOTID_PLATFORM::';
shared FILE_IT(string it) := BIPV2_Files.files_dotid.FILE_DOT_SALT_OP + it + '_'+BIPV2.KeySuffix;
shared FILE_PM(string it) := BIPV2_Files.files_dotid.FILE_DOT_SALT_POSSIBLE_MATCH + it + '_'+BIPV2.KeySuffix;

SHARED dataset(layout_DOT) ALoop(
	dataset(layout_DOT) ih,
	unsigned MatchThreshold,
	unsigned iter,
	boolean finalLoop) := FUNCTION

	string siter := (string)iter;

	m := matches(ih,MatchThreshold);
	s := specificities(ih);
	mc := match_candidates(ih);

	BuildIndexes(string BIsiter) := FUNCTION
		mtch := debug(ih,s.specificities[1]).AnnotateMatches(m.PossibleMatches);
		prop_file := mc.candidates; // Use propogated file
		Candidates := INDEX(prop_file,{DOTid},{prop_file},fprefix+'match_candidates_debug'+BIsiter);
		ms_temp := sort(mtch,Conf,DOTid1,DOTid2,SKEW(1.0)); // Some headers have very skewed IDs
		MatchSample := INDEX(ms_temp,{Conf,DOTid1,DOTid2},{mtch},fprefix+'match_sample_debug'+BIsiter,SORT KEYED);
		Specificities_Key := INDEX(s.specificities,{1},{s.specificities},fprefix+'specificities_debug'+BIsiter);
		prop_file2 := m.Patched_Candidates; // Available for External ADL2
		PatchedCandidates := INDEX(prop_file2,{DOTid},{prop_file2},fprefix+'patched_candidates'+BIsiter);
		return PARALLEL(BUILDINDEX(Candidates,OVERWRITE),BUILDINDEX(MatchSample,OVERWRITE),BUILDINDEX(Specificities_Key,FEW,OVERWRITE),BUILDINDEX(PatchedCandidates,OVERWRITE));	
	END;

	parallel(
		OUTPUT(CHOOSEN(m.MatchSample,1000),NAMED('MatchSample'+siter))
		,OUTPUT(CHOOSEN(m.BorderlineMatchSample,10000),NAMED('BorderlineMatchSample'+siter))
		,OUTPUT(CHOOSEN(m.AlmostMatchSample,10000),NAMED('AlmostMatchSample'+siter))
		,OUTPUT(CHOOSEN(m.MatchSampleRecords,10000),NAMED('MatchSampleRecords'+siter))
		,OUTPUT(CHOOSEN(m.ToSlice,1000),NAMED('SliceOutCandidates'+siter))
		,OUTPUT(s.specificities,NAMED('Specificities'+siter))
		,OUTPUT(m.PreClusters,NAMED('PreClusters'+siter),all)
		,OUTPUT(m.PostClusters,NAMED('PostClusters'+siter),all)
		,OUTPUT(m.MatchesPerformed,NAMED('MatchesPerformed'+siter))
		,OUTPUT(m.SlicesPerformed,NAMED('SlicesPerformed'+siter))
		,OUTPUT(m.MatchesPropAssisted * 100 / m.MatchesPerformed,NAMED('PropagationAssisted_Pcnt'+siter))
		,OUTPUT(m.MatchesPropRequired * 100 / m.MatchesPerformed,NAMED('PropagationRequired_Pcnt'+siter))
		,OUTPUT(TOPN(m.RuleEfficacy,1000,RuleNumber),NAMED('RuleEfficacy'+siter))
		,OUTPUT(TOPN(m.ConfidenceBreakdown,1000,conf),NAMED('ConfidenceLevels'+siter))
		,OUTPUT(s.SpcShift,NAMED('SPCShift'+siter))
		,OUTPUT(m.PrePatchIdCount,NAMED('PrePatchIdCount'+siter))
		,OUTPUT(m.PostPatchIdCount,NAMED('PostPatchIdCount'+siter))
		,OUTPUT(DATASET([{m.PatchingError0,m.DidsNoRid0,m.DidsAboveRid0,m.DuplicateRids0,COUNT(mc.Unlinkables)}],{INTEGER PatchingError0, INTEGER DidsNoRid0, INTEGER DidsAboveRid0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0}),NAMED('ValidityStatistics'+siter))
		,OUTPUT(m.patched_infile,,FILE_IT(siter),OVERWRITE,COMPRESSED)
		,OUTPUT(m.PossibleMatches,,FILE_PM(siter),OVERWRITE,COMPRESSED)
		,BuildIndexes(siter)
		,IF(FinalLoop, BuildIndexes(''))
	);
	
	return m.patched_infile;
END;

EXPORT Loop1(UNSIGNED mt=31, dataset(Layout_DOT) ih = In_DOT, unsigned offset=0, boolean finalLoop=true) := 
	ALoop(ih, mt, 1+offset, finalLoop) : independent;
EXPORT Loop2(UNSIGNED mt=31, dataset(Layout_DOT) ih = In_DOT, unsigned offset=0, boolean finalLoop = true) := 
	ALoop(Loop1(mt, ih, offset, false), mt, 2+offset, finalLoop) : independent;
EXPORT Loop3(UNSIGNED mt=31, dataset(Layout_DOT) ih = In_DOT, unsigned offset=0, boolean finalLoop = true) := 
	ALoop(Loop2(mt, ih, offset, false), mt, 3+offset, finalLoop) : independent;
EXPORT Loop4(UNSIGNED mt=31, dataset(Layout_DOT) ih = In_DOT, unsigned offset=0, boolean finalLoop = true) := 
	ALoop(Loop3(mt, ih, offset, false), mt, 4+offset, finalLoop) : independent;
EXPORT Loop5(UNSIGNED mt=31, dataset(Layout_DOT) ih = In_DOT, unsigned offset=0, boolean finalLoop = true) := 
	ALoop(Loop4(mt, ih, offset, false), mt, 5+offset, finalLoop) : independent;

END;
