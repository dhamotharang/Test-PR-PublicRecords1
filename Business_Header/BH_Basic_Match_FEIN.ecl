import ut, mdr;

EXPORT BH_Basic_Match_FEIN(

	 dataset(Layout_Business_Header_Temp)	pBH_Basic_Match_NameAddr	= BH_Basic_Match_NameAddr	()
	,string																pPersistname							= persistnames().BHBasicMatchFEIN													
	,boolean															pShouldRecalculatePersist	= true													

) :=
function

// Initialize match file
BH_File := pBH_Basic_Match_NameAddr;

Layout_BH_Match := record
unsigned6 bdid;             // Seisint Business Identifier
qstring120 match_company_name;
qstring20 match_branch_unit;
qstring25 match_geo_city;
qstring10 prim_range;
qstring28 prim_name;
qstring8  sec_range;
unsigned3 zip;
unsigned4 fein;             // Federal Tax ID
end;

Layout_BH_Match InitMatchFile(Business_Header.Layout_Business_Header_Temp L) := transform
self := L;
end;

FEIN_Match := project(BH_File(fein <> 0 and ~mdr.sourceTools.SourceIsIRS_5500(source),
															zip<>0, prim_name <> '', prim_name not in Bad_Address_List,															
                              (integer)prim_range <> 0 or 
                                 (prim_name[1..7] = 'PO BOX ' and
                                 (integer)(prim_name[8..LENGTH((string)prim_name)]) <> 0) or
                                 (prim_name[1..3] in ['RR ', 'HC '] and
                                 (integer)(prim_name[4..LENGTH((string)prim_name)]) <> 0)), InitMatchFile(left));

Business_Header.Layout_PairMatch MatchBH(Layout_BH_Match L, Layout_BH_Match R, unsigned1 match) := transform
self.old_rid := L.bdid;
self.new_rid := R.bdid;
self.pflag := match;
end;

// Match Rule 5 - Company Name and FEIN
FEIN_Match_Dist := distribute(FEIN_Match, hash(fein));

FEIN_Matches := join(FEIN_Match_Dist,
                     FEIN_Match_Dist,
                     left.fein = right.fein and
					   left.zip = right.zip and
                       left.prim_name = right.prim_name and
                       left.prim_range = right.prim_range and
                       left.match_branch_unit = right.match_branch_unit and
					   left.match_geo_city = right.match_geo_city and
                       left.bdid > right.bdid and
                       ut.CompanySimilar100(left.match_company_name, right.match_company_name) <= 45,
                     MatchBH(left, right, 5),
                     local);

FEIN_Matches_Dedup := dedup(FEIN_Matches, new_rid, old_rid, all);

// Transitive closure of match pairs
ut.MAC_Reduce_Pairs(FEIN_Matches_Dedup, new_rid, old_rid, pflag, Business_Header.Layout_PairMatch, FEIN_Matches_Reduced)

// Patch new BDIDs
ut.MAC_Patch_Id(BH_File, bdid, FEIN_Matches_Reduced, old_rid, new_rid, BH_File_Patched)

BH_Basic_Match_FEIN_persisted := BH_File_Patched : persist(pPersistname);

returndataset := if(pShouldRecalculatePersist = true, BH_Basic_Match_FEIN_persisted
																										, persists().BHBasicMatchFEIN
									);
									
return returndataset;

end;