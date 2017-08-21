EXPORT Keys(DATASET(layout_DOT_Base) ih,string liter = 'qa') := MODULE
SHARED s := Specificities(ih).Specificities;
SHARED mtch := debug(ih,s[1]).AnnotateMatches(matches(ih).PossibleMatches);
prop_file := match_candidates(ih).candidates; // Use propogated file
EXPORT Candidates := INDEX(prop_file,{Proxid},{prop_file},keynames(liter).match_candidates_debug.logical);
ms_temp := sort(mtch,Conf,Proxid1,Proxid2,SKEW(1.0)); // Some headers have very skewed IDs
EXPORT MatchSample := INDEX(ms_temp,{Conf,Proxid1,Proxid2},{mtch},keynames(liter).match_sample_debug.logical,SORT KEYED);
EXPORT Specificities_Key := INDEX(s,{1},{s},keynames(liter).specificities_debug.logical);
//am := matches(ih).All_Attribute_Matches;
//EXPORT Attribute_Matches := INDEX(am,{Proxid1,Proxid2},{am},keynames(liter).attribute_matches.logical);
prop_file := matches(ih).Patched_Candidates; // Available for External ADL2
EXPORT PatchedCandidates := INDEX(prop_file,{Proxid},{prop_file},keynames(liter).patched_candidates.logical);
// Build enough to support the debug services such as the compare service
EXPORT BuildDebug := PARALLEL(BUILDINDEX(Candidates,keynames(liter).match_candidates_debug.logical,OVERWRITE),BUILDINDEX(Specificities_Key,keynames(liter).specificities_debug.logical,FEW,OVERWRITE)/*,BUILDINDEX(Attribute_Matches,keynames(liter).attribute_matches.logical,OVERWRITE)*/);
// Build Everything
EXPORT BuildAll := PARALLEL(BUILDINDEX(Candidates,keynames(liter).match_candidates_debug.logical,OVERWRITE),BUILDINDEX(MatchSample,keynames(liter).match_sample_debug.logical,OVERWRITE),BUILDINDEX(Specificities_Key,keynames(liter).specificities_debug.logical,FEW,OVERWRITE),BUILDINDEX(PatchedCandidates,keynames(liter).patched_candidates.logical,OVERWRITE)/*,BUILDINDEX(Attribute_Matches,keynames(liter).attribute_matches.logical,OVERWRITE)*/);
END;