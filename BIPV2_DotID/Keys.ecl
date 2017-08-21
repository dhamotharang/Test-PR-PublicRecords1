EXPORT Keys(DATASET(layout_DOT) ih) := MODULE
SHARED s := Specificities(ih).Specificities;
 
EXPORT SpecificitiesDebugKeyName := '~'+'key::BIPV2_DotID::DOTid::Debug::specificities_debug';
 
EXPORT Specificities_Key := INDEX(s,{1},{s},SpecificitiesDebugKeyName);
SHARED Build_Specificities_Key := BUILDINDEX(Specificities_Key, OVERWRITE, FEW);
SHARED mtch := debug(ih,s[1]).AnnotateMatches(matches(ih).PossibleMatches,matches(ih).All_Attribute_Matches);
 
EXPORT SampleKeyName := '~'+'key::BIPV2_DotID::DOTid::Debug::match_sample_debug';
ms_temp := SORT(mtch,Conf,DOTid1,DOTid2,SKEW(1.0)); // Some headers have very skewed IDs
 
EXPORT MatchSample := INDEX(ms_temp,{Conf,DOTid1,DOTid2},{mtch},SampleKeyName, SORT KEYED);
 
EXPORT PatchedCandidatesKeyName := '~'+'key::BIPV2_DotID::DOTid::Datafile::patched_candidates';
prop_file := matches(ih).Patched_Candidates; // Available for External ADL2
 
EXPORT PatchedCandidates := INDEX(prop_file,{DOTid},{prop_file},PatchedCandidatesKeyName);
 
EXPORT CandidatesKeyName := '~'+'key::BIPV2_DotID::DOTid::Debug::match_candidates_debug';
prop_file := match_candidates(ih).candidates; // Use propogated file
 
EXPORT Candidates := INDEX(prop_file,{DOTid},{prop_file},CandidatesKeyName);
 
EXPORT AttributeMatchesKeyName := '~'+'key::BIPV2_DotID::DOTid::Datafile::attribute_matches';
am := matches(ih).All_Attribute_Matches;
 
EXPORT Attribute_Matches := INDEX(am,{DOTid1,DOTid2},{am},AttributeMatchesKeyName);
 
// Create logic to manage the match history key
EXPORT MatchHistoryName := '~keep::BIPV2_DotID::DOTid::MatchHistory';
EXPORT MatchHistoryFile := DATASET(MatchHistoryName,Matches(ih).id_shift_r,THOR); // Read in all the change history
 
EXPORT MatchHistoryKeyName := '~'+'key::BIPV2_DotID::DOTid::History::Match';
  MH := MatchHistoryFile;
 
EXPORT MatchHistoryKey := INDEX(MH,{DOTid_after},{MH},MatchHistoryKeyName);
// Build enough to support the data services such as cleave/best
 
EXPORT InDataKeyName := '~'+'key::BIPV2_DotID::DOTid::Datafile::in_data';
 
EXPORT InData := INDEX(ih,{DOTid},{ih},InDataKeyName);
SHARED Build_InData := BUILDINDEX(InData, OVERWRITE);
EXPORT BuildData := PARALLEL(Build_Specificities_Key,Build_InData);
// Build enough to support the debug services such as the compare service
EXPORT BuildDebug := PARALLEL(Build_Specificities_Key, PARALLEL(BUILDINDEX(Candidates, OVERWRITE)/*,BUILDINDEX(Attribute_Matches, OVERWRITE),BUILDINDEX(MatchHistoryKey, OVERWRITE)*//*HACK no att matches or match history*/));
// Build Everything
EXPORT BuildAll := PARALLEL(BuildDebug, PARALLEL(BUILDINDEX(MatchSample, OVERWRITE)/*,BUILDINDEX(PatchedCandidates, OVERWRITE)*/)/*,Build_InData*//*HACK no patched candidates*/);
EXPORT RelationshipKeys := PARALLEL(BUILDINDEX(Candidates, OVERWRITE)/*,BUILDINDEX(Attribute_Matches, OVERWRITE),BUILDINDEX(MatchHistoryKey, OVERWRITE)*//*HACK no att matches or match history*/);
END;
 
