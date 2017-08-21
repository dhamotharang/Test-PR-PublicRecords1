import business_header, ut;

export BH_Super_Group(

	 dataset(Layouts.Out.Layout_BH_Out										)	pInput_BusHdr_Init	= BH_Init()
	,dataset(business_header.Layout_Business_Relative			)	pBusinessRelatives	= Files().Base.Business_Relatives.built
	,dataset(business_header.Layout_Business_Header_Stat	)	pStat								= Files().Base.Stat.built
	//,dataset(Layout_Relative_Match				) pDCAHierarchy				= BH_Rels_Group_Rollup(match_type = 'DH')
	,dataset(Layouts.Temporary.Layout_Rel_Types						) pBH_DCAHierarchy		= BH_Relative_Groups()
	,string																									pPersistName				= persistnames().BHSuperGroup	
	,boolean																								pHistoricalRecs			= true

) :=
function

bh := pInput_BusHdr_Init(bdid <> 0 and trim(group_id) <> '');
br := pBusinessRelatives;
		
dbr_filtered_dca 		:= br(dca_hierarchy);
dbr_filtered_notdca := br(not(dca_hierarchy));

dbr_dca4groups := project(pBH_DCAHierarchy(rel_type = 'DH'), 
													transform(business_header.Layout_Relative_Match,
																		self.match_type := trim(left.rel_type),
																		self := left)
												 );

//join to br and confirm good associations, remove bad ones
dJoin2fixDCA := join(
	 dbr_filtered_dca
	,dbr_dca4groups
	,		left.bdid1 = right.bdid1
	and left.bdid2 = right.bdid2
	,transform(
		business_header.Layout_Business_Relative,
		self.dca_hierarchy	:= if(right.bdid1 != 0, true, false);
		self								:= left;
	)
	,left outer
);

dJoin2fixDCA2 := join(
	 dJoin2fixDCA
	,dbr_dca4groups
	,		left.bdid2 = right.bdid1
	and left.bdid1 = right.bdid2
	,transform(
		business_header.Layout_Business_Relative,
		self.dca_hierarchy	:= if(right.bdid1 != 0, true, false);
		self								:= left;
	)
	,left outer
);


dbr_concat := dbr_filtered_notdca + dJoin2fixDCA2;

br2 := dbr_concat(not rel_group, bdid2 < bdid1);

br_init := br2(business_header.mac_isGroupRel(br2));

// Extract match records
Business_Header.Layout_PairMatch ExtractPairMatches(business_header.Layout_Business_Relative l) := transform
self.new_rid := l.bdid2;
self.old_rid := l.bdid1;
self.pflag := 0;
end;

br_matches := project(br_init, ExtractPairMatches(left));

// Transitive closure of match pairs
ut.MAC_Reduce_Pairs(br_matches, new_rid, old_rid, pflag, Business_Header.Layout_PairMatch, br_matches_reduced, false)

// Project Stat file to group format
business_header.Layout_BH_Super_Group InitGroupID(business_header.Layout_Business_Header_Stat l) := transform
self.group_id := l.bdid;
self.bdid := l.bdid;
end;

br_group_init := project(pStat, InitGroupID(left));

// Patch Group IDs
ut.MAC_Patch_Id(br_group_init, group_id, br_matches_reduced, old_rid, new_rid, br_group_patched)

br_group_recs := project(bh, 
												 transform(business_header.Layout_BH_Super_Group, 
																	 self.group_id := (unsigned6)left.group_id,
																	 self.bdid     := left.bdid)
												);
												
br_group_recs_ded := dedup(sort(br_group_recs, record), record);

//output(count(br_group_recs), named('cnt_br_group_recs'));
//output(count(br_group_recs_ded), named('cnt_br_group_recs_ded'));

BH_Super_Group_persisted := if(pHistoricalRecs, br_group_recs_ded, br_group_patched)
	: persist(pPersistName);
	
return BH_Super_Group_persisted;

end;