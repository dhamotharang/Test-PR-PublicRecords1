import ut;

// Initialize match file
BH_File := BH_Basic_Match_ForRels;

Layout_BH_Match := record
unsigned6 bdid;             // Seisint Business Identifier
string2   source;           // Source file type
qstring81 clean_company_name;
qstring10 prim_range;
qstring28 prim_name;
qstring8  sec_range;
unsigned3 zip;
end;

Layout_BH_Match InitMatchFile(Business_Header.Layout_Business_Header_Temp L) := transform
self.clean_company_name := ut.CleanCompany(L.company_name);
self := L;
end;

NameAddr_Match_Init := project(BH_File(zip<>0, prim_name <> '', prim_name not in Bad_Address_List,
                              (integer)prim_range <> 0 or 
                                 (prim_name[1..7] = 'PO BOX ' and
                                 (integer)(prim_name[8..LENGTH((string)prim_name)]) <> 0) or
                                 (prim_name[1..3] in ['RR ', 'HC '] and
                                 (integer)(prim_name[4..LENGTH((string)prim_name)]) <> 0)),
                              InitMatchFile(left));


Business_Header.Layout_Relative_Match MatchBH(Layout_BH_Match L, Layout_BH_Match R) := transform
self.bdid1 := L.bdid;
self.bdid2 := R.bdid;
self.match_type := 'NA';
end;

NameAddr_Match_Dedup := dedup(NameAddr_Match_Init, clean_company_name, zip, prim_range, prim_name, bdid, all);

NameAddr_Match_Dist := distribute(NameAddr_Match_Dedup, hash(zip, trim(prim_name), trim(prim_range)));

ut.MAC_Split_Withdups_Local(NameAddr_Match_Dist, hash(zip, trim(prim_name), trim(prim_range)), 4000, NameAddr_Match_Dist_Reduced, NameAddr_Match_Remainder)

boolean CompanyMatchSource(string2 source1, string120 company1,
                           string2 source2, string120 company2) := 
                            ( NOT(source1 = 'GG' or source2 = 'GG') and
                              UT.CompanySimilar100(company1,company2) <= 30 and
															ut.StringSimilar100(datalib.companyclean(company1)[41..80], datalib.companyclean(company2)[41..80]) //check secondary words
															<= 50)
                            or
                            ( (source1 = 'GG' or source2 = 'GG') and
                              company1 = company2);

NameAddr_Matches := JOIN(NameAddr_Match_Dist_Reduced,
                         NameAddr_Match_Dist_Reduced, 
					     left.zip = right.zip and
                           left.prim_name = right.prim_name and
                           left.prim_range = right.prim_range and
						   left.bdid > right.bdid and
                         CompanyMatchSource(left.source, left.clean_company_name,
                                                 right.source, right.clean_company_name),
                         MatchBH(left, right),
                         local);

// Try exact match on full clean company name
NameAddr_Match_Remainder_Dist := distribute(NameAddr_Match_Remainder, hash(trim(clean_company_name), zip, trim(prim_name), trim(prim_range)));
ut.MAC_Remove_Withdups_Local(NameAddr_Match_Remainder_Dist, hash(trim(clean_company_name), zip, trim(prim_name), trim(prim_range)), 4000, NameAddr_Match_Remainder_Reduced)

NameAddr_Matches_Remainder := join(NameAddr_Match_Remainder_Reduced,
                                   NameAddr_Match_Remainder_Reduced,
					               left.zip = right.zip and
                                     left.prim_name = right.prim_name and
                                     left.prim_range = right.prim_range and
                                     left.clean_company_name = right.clean_company_name and
                                     left.bdid > right.bdid,
                                   MatchBH(left, right),
                                   local);

NameAddr_Matches_Dedup := dedup(NameAddr_Matches + NameAddr_Matches_Remainder, bdid1, bdid2, all);

export BH_Relative_Match_NameAddr := NameAddr_Matches_Dedup : persist('TMTEMP::BH_Relative_Match_NameAddr');