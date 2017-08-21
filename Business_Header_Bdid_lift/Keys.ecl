export Keys(

   dataset(Layout_file_business_header)	pDataset
	,string																pversion
  
) := module

shared s := Specificities(pDataset).Specificities;
shared mtch := debug(pDataset,s[1]).AnnotateMatches(matches(pDataset).PossibleMatches);
prop_file := match_candidates(pDataset).candidates; // Use propogated file

export Candidates					:= index(prop_file,{BDID},{prop_file}		,keynames(pversion).match_candidates_debug.new	);
export MatchSample				:= index(mtch,{Conf,BDID1,BDID2},{mtch}	,keynames(pversion).match_sample_debug.new			);
export Specificities_Key	:= index(s,{1},{s}											,keynames(pversion).specificities_debug.new			);

prop_file := matches(pDataset).Patched_Candidates; // Available for External ADL2
export PatchedCandidates := index(prop_file,{BDID},{prop_file}		,keynames(pversion).patched_candidates.new			);
end;
