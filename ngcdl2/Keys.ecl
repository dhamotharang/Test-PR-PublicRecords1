export Keys := module
shared s := table(Specificities(In_HEADER).Specificities,Layout_Specificities);
shared mtch := debug(In_HEADER,s[1]).AnnotateMatches(matches(In_HEADER).PossibleMatches);
prop_file := match_candidates(In_HEADER).candidates; // Use propogated file
export Candidates := index(prop_file,{CDL},{prop_file},'~thor_data400::temp::CDL::NGCDL2::match_candidates_debug');
export MatchSample := index(mtch,{Conf,CDL1,CDL2},{mtch},'~thor_data400::temp::CDL::NGCDL2::match_sample_debug');
export Specificities_Key := index(s,{1},{s},'~thor_data400::temp::CDL::NGCDL2::specificities_debug');
prop_file := matches(In_HEADER).Patched_Candidates; // Available for External ADL2
export PatchedCandidates := index(prop_file,{CDL},{prop_file},'~thor_data400::temp::CDL::NGCDL2::patched_candidates');
end;
