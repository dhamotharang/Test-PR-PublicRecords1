export Keys(dataset(layout_files().input.used) ih) := module
shared s := Specificities(ih).Specificities;
shared mtch := debug(ih,s[1]).AnnotateMatches(matches(ih).PossibleMatches);
prop_file := match_candidates(ih).candidates; // Use propogated file
export Candidates := index(prop_file,{},{prop_file},'~temp::::bell_thrive_LT::match_candidates_debug');
ms_temp := sort(mtch,Conf,1,2,skew(1.0)); // Some headers have very skewed IDs
export MatchSample := index(ms_temp,{Conf,1,2},{mtch},'~temp::::bell_thrive_LT::match_sample_debug',sort keyed);
export Specificities_Key := index(s,{1},{s},'~temp::::bell_thrive_LT::specificities_debug');
prop_file := matches(ih).Patched_Candidates; // Available for External ADL2
export PatchedCandidates := index(prop_file,{},{prop_file},'~temp::::bell_thrive_LT::patched_candidates');
end;
