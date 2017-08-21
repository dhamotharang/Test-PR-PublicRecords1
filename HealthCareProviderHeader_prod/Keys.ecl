EXPORT Keys(DATASET(layout_HealthProvider) ih) := MODULE
SHARED s := Specificities(ih).Specificities;

EXPORT SpecificitiesDebugKeyName := '~'+'key::HealthCareProviderHeader_prod::LNPID::Debug::specificities_debug';

EXPORT Specificities_Key := INDEX(s,{1},{s},SpecificitiesDebugKeyName);
SHARED Build_Specificities_Key := BUILDINDEX(Specificities_Key, OVERWRITE, FEW);
SHARED mtch := debug(ih,s[1]).AnnotateMatches(matches(ih).PossibleMatches);

EXPORT SampleKeyName := '~'+'key::HealthCareProviderHeader_prod::LNPID::Debug::match_sample_debug';
ms_temp := SORT(mtch,Conf,LNPID1,LNPID2,SKEW(1.0)); // Some headers have very skewed IDs

EXPORT MatchSample := INDEX(ms_temp,{Conf,LNPID1,LNPID2},{mtch},SampleKeyName, SORT KEYED);

EXPORT PatchedCandidatesKeyName := '~'+'key::HealthCareProviderHeader_prod::LNPID::Datafile::patched_candidates';
prop_file := matches(ih).Patched_Candidates; // Available for External ADL2

EXPORT PatchedCandidates := INDEX(prop_file,{LNPID},{prop_file},PatchedCandidatesKeyName);

EXPORT CandidatesKeyName := '~'+'key::HealthCareProviderHeader_prod::LNPID::Debug::match_candidates_debug';
prop_file := match_candidates(ih).candidates; // Use propogated file

EXPORT Candidates := INDEX(prop_file,{LNPID},{prop_file},CandidatesKeyName);
// Build enough to support the data services such as cleave/best

EXPORT InDataKeyName := '~'+'key::HealthCareProviderHeader_prod::LNPID::Datafile::in_data';

EXPORT InData := INDEX(ih,{LNPID},{ih},InDataKeyName);
SHARED Build_InData := BUILDINDEX(InData, OVERWRITE);
EXPORT BuildData := PARALLEL(Build_Specificities_Key,Build_InData);
// Build enough to support the debug services such as the compare service
EXPORT BuildDebug := PARALLEL(Build_Specificities_Key, BUILDINDEX(Candidates, OVERWRITE));
// Build Everything
EXPORT BuildAll := PARALLEL(BuildDebug, PARALLEL(BUILDINDEX(MatchSample, OVERWRITE),BUILDINDEX(PatchedCandidates, OVERWRITE)),Build_InData);
END;

