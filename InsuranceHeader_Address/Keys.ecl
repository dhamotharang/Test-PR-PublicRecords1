IMPORT SALT311;
EXPORT Keys(DATASET(layout_Address_Link) ih) := MODULE
SHARED s := Specificities(ih).Specificities;
 
EXPORT SpecificitiesDebugKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::Debug::specificities_debug';
 
EXPORT Specificities_Key := INDEX(s,{1},{s},SpecificitiesDebugKeyName);
SHARED Build_Specificities_Key := BUILDINDEX(Specificities_Key, OVERWRITE, FEW);
SHARED mtch := Debug(ih, s[1]).AnnotateMatches(matches(ih).PossibleMatches);
 
EXPORT SampleKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::Debug::match_sample_debug';
ms_temp := SORT(mtch,Conf,ADDRESS_GROUP_ID1,ADDRESS_GROUP_ID2,SKEW(1.0)); // Some headers have very skewed IDs
 
EXPORT MatchSample := INDEX(ms_temp,{Conf,ADDRESS_GROUP_ID1,ADDRESS_GROUP_ID2},{mtch},SampleKeyName, SORT KEYED);
 
EXPORT PatchedCandidatesKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::Datafile::patched_candidates';
prop_file := matches(ih).Patched_Candidates; // Available for External ADL2
 
EXPORT PatchedCandidates := INDEX(prop_file,{ADDRESS_GROUP_ID},{prop_file},PatchedCandidatesKeyName);
 
EXPORT CandidatesKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::Debug::match_candidates_debug';
prop_file := match_candidates(ih).candidates; // Use propogated file
 
EXPORT Candidates := INDEX(prop_file,{ADDRESS_GROUP_ID},{prop_file},CandidatesKeyName);
 
EXPORT CandidatesForSliceKeyName := '~'+'key::InsuranceHeader_Address::ADDRESS_GROUP_ID::Debug::match_candidatesforslice_debug';
prop_file_forslice := match_candidates(ih).candidates_ForSlice; // Use propogated file
 
EXPORT CandidatesForSlice := INDEX(prop_file_forslice,{ADDRESS_GROUP_ID},{prop_file_forslice},CandidatesForSliceKeyName);
// Build enough to support the debug services such as the compare service
EXPORT BuildDebug := PARALLEL(Build_Specificities_Key, PARALLEL(BUILDINDEX(Candidates, OVERWRITE),BUILDINDEX(CandidatesForSlice, OVERWRITE)));
// Build Everything
EXPORT BuildAll := PARALLEL(BuildDebug, PARALLEL(BUILDINDEX(MatchSample, OVERWRITE),BUILDINDEX(PatchedCandidates, OVERWRITE)),MatchHistory.BuildAll);
END;
 
