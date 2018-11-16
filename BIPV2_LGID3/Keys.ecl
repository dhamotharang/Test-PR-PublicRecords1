IMPORT SALT311;
EXPORT Keys(DATASET(layout_LGID3) ih) := MODULE
SHARED s := Specificities(ih).Specificities;
 
EXPORT SpecificitiesDebugKeyName := '~'+'key::BIPV2_LGID3::LGID3::Debug::specificities_debug';
 
EXPORT Specificities_Key := INDEX(s,{1},{s},SpecificitiesDebugKeyName);
SHARED Build_Specificities_Key := BUILDINDEX(Specificities_Key, OVERWRITE, FEW);
SHARED mtch := Debug(ih, s[1]).AnnotateMatches(matches(ih).PossibleMatches,matches(ih).All_Attribute_Matches);
 
EXPORT SampleKeyName := '~'+'key::BIPV2_LGID3::LGID3::Debug::match_sample_debug';
ms_temp := SORT(mtch,Conf,LGID31,LGID32,SKEW(1.0)); // Some headers have very skewed IDs
 
EXPORT MatchSample := INDEX(ms_temp,{Conf,LGID31,LGID32},{mtch},SampleKeyName, SORT KEYED);
 
EXPORT PatchedCandidatesKeyName := '~'+'key::BIPV2_LGID3::LGID3::Datafile::patched_candidates';
prop_file := matches(ih).Patched_Candidates; // Available for External ADL2
 
EXPORT PatchedCandidates := INDEX(prop_file,{LGID3},{prop_file},PatchedCandidatesKeyName);
 
EXPORT CandidatesKeyName := '~'+'key::BIPV2_LGID3::LGID3::Debug::match_candidates_debug';
prop_file := match_candidates(ih).candidates; // Use propogated file
 
EXPORT Candidates := INDEX(prop_file,{LGID3},{prop_file},CandidatesKeyName);
 
EXPORT CandidatesForSliceKeyName := '~'+'key::BIPV2_LGID3::LGID3::Debug::match_candidatesforslice_debug';
prop_file_forslice := match_candidates(ih).candidates_ForSlice; // Use propogated file
 
EXPORT CandidatesForSlice := INDEX(prop_file_forslice,{LGID3},{prop_file_forslice},CandidatesForSliceKeyName);
 
EXPORT AttributeMatchesKeyName := '~'+'key::BIPV2_LGID3::LGID3::Datafile::attribute_matches';
am := matches(ih).All_Attribute_Matches;
 
EXPORT Attribute_Matches := INDEX(am,{LGID31,LGID32},{am},AttributeMatchesKeyName);
// Build enough to support the debug services such as the compare service
EXPORT BuildDebug := PARALLEL(Build_Specificities_Key, PARALLEL(BUILDINDEX(Candidates, OVERWRITE),BUILDINDEX(CandidatesForSlice, OVERWRITE),BUILDINDEX(Attribute_Matches, OVERWRITE)));
// Build Everything
EXPORT BuildAll := PARALLEL(BuildDebug, PARALLEL(BUILDINDEX(MatchSample, OVERWRITE),BUILDINDEX(PatchedCandidates, OVERWRITE)),MatchHistory.BuildAll);
END;
 
