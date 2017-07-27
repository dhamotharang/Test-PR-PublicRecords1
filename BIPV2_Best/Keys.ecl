EXPORT Keys(DATASET(layout_Base) ih) := MODULE
SHARED s := Specificities(ih).Specificities;
SHARED mtch := debug(ih,s[1]).AnnotateMatches(matches(ih).PossibleMatches);
prop_file := match_candidates(ih).candidates; // Use propogated file
EXPORT Candidates := INDEX(prop_file,{Proxid},{prop_file},'~temp::Proxid::BIPV2_Best::match_candidates_debug');
ms_temp := sort(mtch,Conf,Proxid1,Proxid2,SKEW(1.0)); // Some headers have very skewed IDs
EXPORT MatchSample := INDEX(ms_temp,{Conf,Proxid1,Proxid2},{mtch},'~temp::Proxid::BIPV2_Best::match_sample_debug',SORT KEYED);
EXPORT Specificities_Key := INDEX(s,{1},{s},'~temp::Proxid::BIPV2_Best::specificities_debug');
prop_file := matches(ih).Patched_Candidates; // Available for External ADL2
EXPORT PatchedCandidates := INDEX(prop_file,{Proxid},{prop_file},'~temp::Proxid::BIPV2_Best::patched_candidates');
// Build enough to support the data services such as cleave/best
EXPORT InData := INDEX(ih,{Proxid},{ih},'~temp::Proxid::BIPV2_Best::in_data');
EXPORT BuildData := PARALLEL(BUILDINDEX(Specificities_Key,FEW,OVERWRITE),BUILDINDEX(InData,OVERWRITE));
// Build enough to support the debug services such as the compare service
EXPORT BuildDebug := PARALLEL(BUILDINDEX(Candidates,OVERWRITE),BUILDINDEX(Specificities_Key,FEW,OVERWRITE));
// Build Everything
EXPORT BuildAll := PARALLEL(BUILDINDEX(Candidates,OVERWRITE),BUILDINDEX(MatchSample,OVERWRITE),BUILDINDEX(Specificities_Key,FEW,OVERWRITE),BUILDINDEX(PatchedCandidates,OVERWRITE),BUILDINDEX(InData,OVERWRITE));
END;
