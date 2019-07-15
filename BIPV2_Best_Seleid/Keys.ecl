EXPORT Keys(DATASET(layout_Base) ih) := MODULE
SHARED s := Specificities(ih).Specificities;
 
EXPORT SpecificitiesDebugKeyName := '~'+'key::BIPV2_Best_Seleid::Seleid::Debug::specificities_debug';
 
EXPORT Specificities_Key := INDEX(s,{1},{s},SpecificitiesDebugKeyName);
SHARED Build_Specificities_Key := BUILDINDEX(Specificities_Key, OVERWRITE, FEW);
SHARED mtch := debug(ih,s[1]).AnnotateMatches(matches(ih).PossibleMatches);
 
EXPORT SampleKeyName := '~'+'key::BIPV2_Best_Seleid::Seleid::Debug::match_sample_debug';
ms_temp := SORT(mtch,Conf,Seleid1,Seleid2,SKEW(1.0)); // Some headers have very skewed IDs
 
EXPORT MatchSample := INDEX(ms_temp,{Conf,Seleid1,Seleid2},{mtch},SampleKeyName, SORT KEYED);
 
EXPORT PatchedCandidatesKeyName := '~'+'key::BIPV2_Best_Seleid::Seleid::Datafile::patched_candidates';
prop_file := matches(ih).Patched_Candidates; // Available for External ADL2
 
EXPORT PatchedCandidates := INDEX(prop_file,{Seleid},{prop_file},PatchedCandidatesKeyName);
 
EXPORT CandidatesKeyName := '~'+'key::BIPV2_Best_Seleid::Seleid::Debug::match_candidates_debug';
prop_file := match_candidates(ih).candidates; // Use propogated file
 
EXPORT Candidates := INDEX(prop_file,{Seleid},{prop_file},CandidatesKeyName);
 
// Create logic to manage the match history key
EXPORT MatchHistoryName := '~keep::BIPV2_Best_Seleid::Seleid::MatchHistory';
EXPORT MatchHistoryFile := DATASET(MatchHistoryName,Matches(ih).id_shift_r,THOR); // Read in all the change history
 
EXPORT MatchHistoryKeyName := '~'+'key::BIPV2_Best_Seleid::Seleid::History::Match';
  MH := MatchHistoryFile;
 
EXPORT MatchHistoryKey := INDEX(MH,{Seleid_after},{MH},MatchHistoryKeyName);
// Build enough to support the data services such as cleave/best
 
EXPORT InDataKeyName := '~'+'key::BIPV2_Best_Seleid::Seleid::Datafile::in_data';
 
EXPORT InData := INDEX(ih,{Seleid},{ih},InDataKeyName);
SHARED Build_InData := BUILDINDEX(InData, OVERWRITE);
EXPORT BuildData := PARALLEL(Build_Specificities_Key,Build_InData);
// Build enough to support the debug services such as the compare service
EXPORT BuildDebug := PARALLEL(Build_Specificities_Key, PARALLEL(BUILDINDEX(Candidates, OVERWRITE),BUILDINDEX(MatchHistoryKey, OVERWRITE)));
// Build Everything
EXPORT BuildAll := PARALLEL(BuildDebug, PARALLEL(BUILDINDEX(MatchSample, OVERWRITE),BUILDINDEX(PatchedCandidates, OVERWRITE)),Build_InData);
END;
 
