export Keys := module
shared s := Specificities(In_HEADER).Specificities;
shared mtch := debug(In_HEADER,s[1]).AnnotateMatches(matches(In_HEADER).PossibleMatches);
prop_file := match_candidates(In_HEADER).candidates; // Use propogated file
export Candidates := index(prop_file,{DID},{prop_file},'~thor_data400::temp::DID::NGADL::match_candidates_debug');
export MatchSample := index(mtch,{Conf,DID1,DID2},{mtch},'~thor_data400::temp::DID::NGADL::match_sample_debug');
export Specificities_Key := index(s,{1},{s},'~thor_data400::temp::DID::NGADL::specificities_debug');
prop_file := matches(In_HEADER).Patched_Candidates; // Available for External ADL2
export PatchedCandidates := index(prop_file,{DID},{prop_file},'~thor_data400::temp::DID::NGADL::patched_candidates');
end;
