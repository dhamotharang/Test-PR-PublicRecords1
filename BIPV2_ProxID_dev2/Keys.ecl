EXPORT Keys(DATASET(layout_DOT_Base) ih) := MODULE
SHARED s := Specificities(ih).Specificities;
 
EXPORT SpecificitiesDebugKeyName := '~'+'key::BIPV2_ProxID_dev2::Proxid::Debug::specificities_debug';
 
EXPORT Specificities_Key := INDEX(s,{1},{s},SpecificitiesDebugKeyName);
SHARED Build_Specificities_Key := BUILDINDEX(Specificities_Key, OVERWRITE, FEW);
SHARED mtch := debug(ih,s[1]).AnnotateMatches(matches(ih).PossibleMatches,matches(ih).All_Attribute_Matches);
 
EXPORT SampleKeyName := '~'+'key::BIPV2_ProxID_dev2::Proxid::Debug::match_sample_debug';
ms_temp := SORT(mtch,Conf,Proxid1,Proxid2,SKEW(1.0)); // Some headers have very skewed IDs
 
EXPORT MatchSample := INDEX(ms_temp,{Conf,Proxid1,Proxid2},{mtch},SampleKeyName, SORT KEYED);
 
EXPORT PatchedCandidatesKeyName := '~'+'key::BIPV2_ProxID_dev2::Proxid::Datafile::patched_candidates';
prop_file := matches(ih).Patched_Candidates; // Available for External ADL2
 
EXPORT PatchedCandidates := INDEX(prop_file,{Proxid},{prop_file},PatchedCandidatesKeyName);
 
EXPORT CandidatesKeyName := '~'+'key::BIPV2_ProxID_dev2::Proxid::Debug::match_candidates_debug';
prop_file := match_candidates(ih).candidates; // Use propogated file
 
EXPORT Candidates := INDEX(prop_file,{Proxid},{prop_file},CandidatesKeyName);
 
EXPORT AttributeMatchesKeyName := '~'+'key::BIPV2_ProxID_dev2::Proxid::Datafile::attribute_matches';
am := matches(ih).All_Attribute_Matches;
 
EXPORT Attribute_Matches := INDEX(am,{Proxid1,Proxid2},{am},AttributeMatchesKeyName);
// Build enough to support the debug services such as the compare service
EXPORT BuildDebug := PARALLEL(Build_Specificities_Key, PARALLEL(BUILDINDEX(Candidates, OVERWRITE),BUILDINDEX(Attribute_Matches, OVERWRITE)));
// Build Everything
EXPORT BuildAll := PARALLEL(BuildDebug, PARALLEL(BUILDINDEX(MatchSample, OVERWRITE),BUILDINDEX(PatchedCandidates, OVERWRITE)));
END;
 
