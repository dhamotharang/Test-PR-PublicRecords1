IMPORT SALT311;
EXPORT Keys(DATASET(layout_Hdr) ih) := MODULE
SHARED keys_s := Specificities(ih).Specificities;

EXPORT SpecificitiesDebugKeyName := '~'+'key::Watchdog_best::did::Debug::specificities_debug';

EXPORT Specificities_Key := INDEX(keys_s,{1},{keys_s},SpecificitiesDebugKeyName);
SHARED Build_Specificities_Key := BUILDINDEX(Specificities_Key, OVERWRITE, FEW);
// Build enough to support the data services such as cleave/best

EXPORT InDataKeyName := '~'+'key::Watchdog_best::did::Datafile::in_data';

EXPORT InData := INDEX(ih,{did},{ih},InDataKeyName);
SHARED Build_InData := BUILDINDEX(InData, OVERWRITE);
EXPORT BuildData := PARALLEL(Build_Specificities_Key,Build_InData);
SHARED mtch := Debug(ih, keys_s[1]).AnnotateMatches(matches(ih).PossibleMatches);

EXPORT SampleKeyName := '~'+'key::Watchdog_best::did::Debug::match_sample_debug';
ms_temp := SORT(mtch,Conf,did1,did2,SKEW(1.0)); // Some headers have very skewed IDs

EXPORT MatchSample := INDEX(ms_temp,{Conf,did1,did2},{mtch},SampleKeyName, SORT KEYED);

EXPORT PatchedCandidatesKeyName := '~'+'key::Watchdog_best::did::Datafile::patched_candidates';
prop_file := matches(ih).Patched_Candidates; // Available for External ADL2

EXPORT PatchedCandidates := INDEX(prop_file,{did},{prop_file},PatchedCandidatesKeyName);

EXPORT CandidatesKeyName := '~'+'key::Watchdog_best::did::Debug::match_candidates_debug';
prop_file := match_candidates(ih).candidates; // Use propogated file

EXPORT Candidates := INDEX(prop_file,{did},{prop_file},CandidatesKeyName);

EXPORT CandidatesForSliceKeyName := '~'+'key::Watchdog_best::did::Debug::match_candidatesforslice_debug';
prop_file_forslice := match_candidates(ih).candidates_ForSlice; // Use propogated file

EXPORT CandidatesForSlice := INDEX(prop_file_forslice,{did},{prop_file_forslice},CandidatesForSliceKeyName);
// Build enough to support the debug services such as the compare service
EXPORT BuildDebug := PARALLEL(Build_Specificities_Key, PARALLEL(BUILDINDEX(Candidates, OVERWRITE),BUILDINDEX(CandidatesForSlice, OVERWRITE)));
// Build Everything
EXPORT BuildAll := PARALLEL(BuildDebug, PARALLEL(BUILDINDEX(MatchSample, OVERWRITE),BUILDINDEX(PatchedCandidates, OVERWRITE)),Build_InData,MatchHistory.BuildAll);
END;

