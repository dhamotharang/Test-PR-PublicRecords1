/*HACK-O-MATIC*/IMPORT SALT311,HealthcareNoMatchHeader_Ingest,STD;
/*HACK-O-MATIC*/EXPORT Keys(STRING pSrc, STRING pVersion =  (STRING)STD.Date.Today(), DATASET(layout_HEADER) ih) := MODULE
SHARED keys_s := /*HACK-O-MATIC*/Specificities(pSrc,pVersion,ih).Specificities;
 
EXPORT SpecificitiesDebugKeyName := /*HACK-O-MATIC*/HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).DebugKeys.Debug_specificities_debug.New;
 
EXPORT Specificities_Key := INDEX(keys_s,{1},{keys_s},SpecificitiesDebugKeyName);
SHARED Build_Specificities_Key := BUILDINDEX(Specificities_Key, OVERWRITE, FEW);
SHARED mtch := /*HACK-O-MATIC*/Debug(pSrc,pVersion,ih, keys_s[1]).AnnotateMatches(/*HACK-O-MATIC*/matches(pSrc,pVersion,ih).PossibleMatches);
 
EXPORT SampleKeyName := /*HACK-O-MATIC*/HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).DebugKeys.Debug_match_sample_debug.New;
ms_temp := SORT(mtch,Conf,nomatch_id1,nomatch_id2,SKEW(1.0)); // Some headers have very skewed IDs
 
EXPORT MatchSample := INDEX(ms_temp,{Conf,nomatch_id1,nomatch_id2},{mtch},SampleKeyName, SORT KEYED);
 
EXPORT PatchedCandidatesKeyName := /*HACK-O-MATIC*/HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).DebugKeys.Datafile_patched_candidates.New;
prop_file := /*HACK-O-MATIC*/matches(pSrc,pVersion,ih).Patched_Candidates; // Available for External ADL2
 
EXPORT PatchedCandidates := INDEX(prop_file,{nomatch_id},{prop_file},PatchedCandidatesKeyName);
 
EXPORT CandidatesKeyName := /*HACK-O-MATIC*/HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).DebugKeys.Debug_match_candidates_debug.New;
prop_file := /*HACK-O-MATIC*/match_candidates(pSrc,pVersion,ih).candidates; // Use propogated file
 
EXPORT Candidates := INDEX(prop_file,{nomatch_id},{prop_file},CandidatesKeyName);
 
EXPORT CandidatesForSliceKeyName := /*HACK-O-MATIC*/HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).DebugKeys.Debug_match_candidatesforslice_debug.New;
prop_file_forslice := /*HACK-O-MATIC*/match_candidates(pSrc,pVersion,ih).candidates_ForSlice; // Use propogated file
 
EXPORT CandidatesForSlice := INDEX(prop_file_forslice,{nomatch_id},{prop_file_forslice},CandidatesForSliceKeyName);
// Build enough to support the debug services such as the compare service
EXPORT BuildDebug := PARALLEL(Build_Specificities_Key, PARALLEL(BUILDINDEX(Candidates, OVERWRITE),BUILDINDEX(CandidatesForSlice, OVERWRITE)));
// Build Everything
EXPORT BuildAll := PARALLEL(BuildDebug, PARALLEL(BUILDINDEX(MatchSample, OVERWRITE),BUILDINDEX(PatchedCandidates, OVERWRITE)),/*HACK-O-MATIC*/MatchHistory(pSrc,pVersion).BuildAll);
END;
 
