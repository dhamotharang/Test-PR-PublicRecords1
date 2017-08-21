import Business_Header;

//  Rollup Relative Group
export BH_Rels_Group_Rollup(

	 dataset(Layouts.Temporary.Layout_Rel_Types	) pBH_Relative_Groups				= BH_Relative_Groups()
	,string																				pPersistname							= persistnames().BHRelativeGroupRollup													
	,boolean																			pShouldRecalculatePersist	= true													

) := function

	// all relative group records only
	dBH_Rels_Group_only := pBH_Relative_Groups(rel_type in ['NM','AD','DT']);
	
	dBH_Rels_Group_combined := project(dBH_Rels_Group_only, transform(Business_Header.Layout_Relative_Match, self.match_type := trim(left.rel_type), self := left));
	
	out_rel_grp_comb := Business_Header.BH_Relative_Group_Rollup(dBH_Rels_Group_combined, pPersistname, pShouldRecalculatePersist);
	
	return out_rel_grp_comb;
	
end;