IMPORT DNB_dmi, ut,mdr;

export BH_Relative_Group_DUNS_Tree(

	 dataset(Layout_Business_Header_Temp					)	pBH_Basic_Match_ForRels			= BH_Basic_Match_ForRels	()
	,dataset(DNB_dmi.Layouts.DUNS_2_Ultimate_DUNS	)	pDUNS_To_Ultimate_DUNS			= DNB_dmi.DUNS_To_Ultimate_DUNS	()
	,string																					pPersistname								= persistnames().BHRelativeGroupDUNSTree													
	,boolean																				pShouldRecalculatePersist		= true													

) := FUNCTION

// Initialize match file
BH_File := pBH_Basic_Match_ForRels;

Layout_DT_Match := RECORD
	UNSIGNED6 bdid;           // Seisint Business Identifier
	UNSIGNED4 duns;           // DUNS number from source_group
	UNSIGNED4 ultimate_duns := 0;
END;

Layout_DT_Match InitMatchFile(BH_File L) := TRANSFORM
	SELF.duns := (UNSIGNED4) l.source_group;
	SELF := l;
END;

Match_Init := PROJECT(	BH_File(MDR.sourceTools.SourceIsDunn_Bradstreet(source), source_group <> '',
								source_group[1] != 'D'), 
						InitMatchFile(LEFT));

Match_Init_Dedup := DISTRIBUTE(
	DEDUP(Match_Init, bdid, duns, ALL), HASH(duns));

Layout_DT_Match AddUltimateDUNS(
			Layout_DT_Match l, 
			DNB_dmi.Layouts.DUNS_2_Ultimate_DUNS r) := TRANSFORM
	SELF.ultimate_duns := r.ultimate_duns_number;
	SELF := l;
END;

ud_joined := JOIN(Match_Init_Dedup, pDUNS_To_Ultimate_DUNS,
				LEFT.duns = RIGHT.duns_number,
				AddUltimateDUNS(LEFT, RIGHT), LOCAL);

// Dedup again by bdid & ultimate duns
ud_joined_ded := DEDUP(ud_joined, bdid, ultimate_duns, ALL);

ud_joined_dist_ult := DISTRIBUTE(ud_joined_ded, HASH(ultimate_duns));
ut.MAC_Split_Withdups_Local(ud_joined_dist_ult, ultimate_duns, 4000, ud_match, ud_remainder)

layout_id := RECORD
	UNSIGNED6 group_id := 0;
	UNSIGNED6 bdid;
	UNSIGNED4 ultimate_duns;
END;

layout_id MakeIDLayout(Layout_DT_Match l) := TRANSFORM
	SELF := l;
	self.group_id := l.bdid;
END;

with_id := PROJECT(ud_remainder, MakeIDLayout(LEFT));

// Take the remainder, and assign the groupid as the lowest bdid
// with the same ultimate duns number.
match_sort := SORT(with_id, ultimate_duns, group_id, LOCAL);
match_group := GROUP(match_sort, ultimate_duns, LOCAL);

layout_id AssignGroupId(layout_id l, layout_id r) := TRANSFORM
	SELF.group_id := IF(l.group_id = 0, r.group_id, l.group_id);
	SELF := r;
END;

matches_id := ITERATE(match_group, AssignGroupId(LEFT, RIGHT));

Layout_Relative_Match FormatRelativeGroup(layout_id l) := TRANSFORM
	SELF.match_type := 'DT';
	SELF.bdid1 := l.group_id;
	SELF.bdid2 := l.bdid;
END;

relatives_group_duns_tree := PROJECT(GROUP(matches_id), 
				FormatRelativeGroup(LEFT));

relatives_group_duns_tree_dist := DISTRIBUTE(relatives_group_duns_tree,
								  HASH(bdid1));

BH_Relative_Group_DUNS_Tree_persisted := relatives_group_duns_tree_dist
				: PERSIST(pPersistname);

returndataset := if(pShouldRecalculatePersist = true, BH_Relative_Group_DUNS_Tree_persisted
																										, persists().BHRelativeGroupDUNSTree
									);
return returndataset;

end;