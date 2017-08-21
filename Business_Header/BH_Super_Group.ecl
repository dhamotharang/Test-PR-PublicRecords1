import ut, dca;

// Define Super Group of closely-related Businesses
// using the following relations:
//
//   corp_charter_number
//   business_registration
//   bankruptcy_filing
//   duns_number
//   edgar_cik
//   name_address
//   name_phone (limited to < 100 per bdid)
//   (ucc_filing and (name or name_phone))
//	fbn_filing
//   fein
//   mail_addr
//	dca_company_number or
//	dca_hierarchy or
//	abi_number or
//	abi_hierarchy
//
export BH_Super_Group(

	 dataset(Layout_Business_Relative			)	pBusinessRelatives	= Files().Base.Business_Relatives.built
	,dataset(Layout_Business_Header_Stat	)	pStat								= Files().Base.Stat.built
	,dataset(Layout_Relative_Match				) pDCAHierarchy				= BH_Relative_Match_DCA_Hierarchy(pPersistname	:= persistnames().BHRelativeMatchDCAHierarchy + '.BH_Super_Group', pUsingInGroupCalculation := true)
	,string																	pPersistName				= persistnames().BHSuperGroup
	,boolean																pShouldDoOldWay			= false

) :=
function

br := pBusinessRelatives;
		
dbr_filtered_dca 		:= br(dca_hierarchy);
dbr_filtered_notdca := br(not(dca_hierarchy));

dbr_dca4groups := pDCAHierarchy;

//join to br and confirm good associations, remove bad ones
dJoin2fixDCA := join(
	 dbr_filtered_dca
	,dbr_dca4groups
	,		left.bdid1 = right.bdid1
	and left.bdid2 = right.bdid2
	,transform(
		Layout_Business_Relative,
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
		Layout_Business_Relative,
		self.dca_hierarchy	:= if(right.bdid1 != 0, true, false);
		self								:= left;
	)
	,left outer
);


dbr_concat := dbr_filtered_notdca + dJoin2fixDCA2;

br2 := dbr_concat(not rel_group, bdid2 < bdid1);

br_init := br2(business_header.mac_isGroupRel(br2));

// Extract match records
Business_Header.Layout_PairMatch ExtractPairMatches(Layout_Business_Relative l) := transform
self.new_rid := l.bdid2;
self.old_rid := l.bdid1;
self.pflag := 0;
end;

br_matches := project(br_init, ExtractPairMatches(left));

// Transitive closure of match pairs
ut.MAC_Reduce_Pairs(br_matches, new_rid, old_rid, pflag, Business_Header.Layout_PairMatch, br_matches_reduced, false)

// Project Stat file to group format
Layout_BH_Super_Group InitGroupID(Layout_Business_Header_Stat l) := transform
self.group_id := l.bdid;
self.bdid := l.bdid;
end;

br_group_init := project(pStat, InitGroupID(left));

// Patch Group IDs
ut.MAC_Patch_Id(br_group_init, group_id, br_matches_reduced, old_rid, new_rid, br_group_patched)

BH_Super_Group_persisted := br_group_patched 
	: persist(pPersistName);
	
return BH_Super_Group_persisted;

end;