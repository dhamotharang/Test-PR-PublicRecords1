export Keys(dataset(ngadl.Layout_Header) ih = NGADL.In_HEADER) := module
shared s := table(Specificities(ih).Specificities,Layout_Specificities(ih));
// shared s := table(Specificities(ih).Specificities,Layout_Specificities/*(ih)*/);
shared mtch := debug(ih).AnnotateMatches(matches(ih).PossibleMatches,s[1]);
// shared mtch := debug(ih,s[1]).AnnotateMatches(matches(ih).PossibleMatches);
prop_file := match_candidates(ih).candidates; // Use propogated file
export Candidates := index(prop_file,{DID},{prop_file},'~thor_data400::temp::DID::match_candidates_debug');
export MatchSample := index(mtch,{Conf,DID1,DID2},{mtch},'~thor_data400::temp::DID::match_sample_debug');
export Specificities_Key := index(s,{1},{s},'~thor_data400::temp::DID::specificities_debug');
prop_file := matches(ih).Patched_Candidates; // Available for External ADL2
export PatchedCandidates := index(prop_file,{DID},{prop_file},'~thor_data400::temp::DID::patched_candidates');
end;
