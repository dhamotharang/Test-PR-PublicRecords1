import ut;

// Initialize match file
BH_File := Business_Header.BH_Match_Init;

Layout_BH_Match := record
unsigned6 rcid;
unsigned6 bdid;             // Seisint Business Identifier
string2   source;           // Source file type
qstring120 match_company_name;
qstring20 match_branch_unit;
qstring25 match_geo_city;
qstring10 prim_range;
qstring28 prim_name;
qstring8  sec_range;
unsigned3 zip;
end;

Layout_BH_Match InitMatchFile(Business_Header.Layout_Business_Header_Temp L) := transform
self := L;
end;

Company_Match_Init := project(BH_File(zip<>0, prim_name <> '', prim_name not in Bad_Address_List,
                              (integer)prim_range <> 0 or 
                                 (prim_name[1..7] = 'PO BOX ' and
                                 (integer)(prim_name[8..LENGTH((string)prim_name)]) <> 0) or
                                 (prim_name[1..3] in ['RR ', 'HC '] and
                                 (integer)(prim_name[4..LENGTH((string)prim_name)]) <> 0)),
                          InitMatchFile(left));


Business_Header.Layout_PairMatch MatchBH(Layout_BH_Match L, Layout_BH_Match R, unsigned1 match) := transform
self.old_rid := L.bdid;
self.new_rid := R.bdid;
self.pflag := match;
end;

// Match Rule 4 - Match Company Name and Address
Company_Match_Dedup := dedup(Company_Match_Init, match_company_name, match_branch_unit, match_geo_city, zip, prim_range, prim_name, bdid, all);

Company_Match_Dist := distribute(Company_Match_Dedup, hash(zip, trim(prim_name), trim(prim_range)));

ut.MAC_Remove_Withdups_Local(Company_Match_Dist, hash(zip, trim(prim_name), trim(prim_range)), 4000, Company_Match_Dist_Reduced)

boolean CompanyMatchSource(string2 source1, string120 company1,
                           string2 source2, string120 company2) := 
                            ( not(source1 = 'GG' or source2 = 'GG') and
                              UT.CompanySimilar100(company1,company2) <= 10)
                            or
                            ( (source1 = 'GG' or source2 = 'GG') and
                              company1 = company2);

NameAddr_Matches := join(Company_Match_Dist_Reduced,
                         Company_Match_Dist_Reduced, 
						 left.zip = right.zip and
                           left.prim_name = right.prim_name and
                           left.prim_range = right.prim_range and
                           left.match_branch_unit = right.match_branch_unit and
                           left.match_geo_city = right.match_geo_city and
						   left.bdid > right.bdid and
                         CompanyMatchSource(left.source, left.match_company_name,
                                            right.source, right.match_company_name),
                         MatchBH(left, right, 4),
                         local);

NameAddr_Matches_Dedup := dedup(NameAddr_Matches, new_rid, old_rid, all);

// Transitive closure of match pairs
ut.MAC_Reduce_Pairs(NameAddr_Matches_Dedup, new_rid, old_rid, pflag, Business_Header.Layout_PairMatch, NameAddr_Matches_Reduced)

// Patch new BDIDs
ut.MAC_Patch_Id(BH_File, bdid, NameAddr_Matches_Reduced, old_rid, new_rid, BH_File_Patched)

export BH_Basic_Match_NameAddr := BH_File_Patched : persist('TEMP::BH_Basic_Match_NameAddr');