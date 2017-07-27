import ut;

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


					  
br := File_Business_Relatives(not rel_group, bdid2 < bdid1);

br_init := br(business_header.mac_isGroupRel(br));
							  
// Extract match records
Business_Header.Layout_PairMatch ExtractPairMatches(Layout_Business_Relative l) := transform
self.new_rid := l.bdid2;
self.old_rid := l.bdid1;
self.pflag := 0;
end;

br_matches := project(br_init, ExtractPairMatches(left));

// Transitive closure of match pairs
ut.MAC_Reduce_Pairs(br_matches, new_rid, old_rid, pflag, Business_Header.Layout_PairMatch, br_matches_reduced, true)

// Project Stat file to group format
Layout_BH_Super_Group InitGroupID(Layout_Business_Header_Stat l) := transform
self.group_id := l.bdid;
self.bdid := l.bdid;
end;

br_group_init := project(/* BH_Stat */ File_Business_Header_Stats, InitGroupID(left));

// Patch Group IDs
ut.MAC_Patch_Id(br_group_init, group_id, br_matches_reduced, old_rid, new_rid, br_group_patched)



export BH_Super_Group := br_group_patched : persist('TEMP::BH_Super_Group');