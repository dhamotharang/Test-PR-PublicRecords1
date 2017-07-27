import ut;

// Initialize match file
BH_File := BH_Basic_Match_ForRels;

Layout_BH_Match := record
unsigned6 bdid;             // Seisint Business Identifier
qstring10 prim_range;
qstring28 prim_name;
qstring8  sec_range;
unsigned3 zip;
end;

Layout_BH_Match InitMatchFile(Business_Header.Layout_Business_Header_Temp L) := transform
self := L;
end;

Addr_Match_Init := project(BH_File(zip<>0, prim_name <> '', prim_name not in Bad_Address_List,
                              (integer)prim_range <> 0 or 
                                 (prim_name[1..3] in ['RR ', 'HC '] and
                                 (integer)(prim_name[4..LENGTH((string)prim_name)]) <> 0) and
																 (integer)sec_range <> 0), //only RR and HC if valid sr
                              InitMatchFile(left));


Business_Header.Layout_Relative_Match MatchBH(Layout_BH_Match L, Layout_BH_Match R) := transform
self.bdid1 := L.bdid;
self.bdid2 := R.bdid;
self.match_type := 'AD';
end;

Addr_Match_Dedup := dedup(Addr_Match_Init, zip, prim_range, prim_name, bdid, all);

Addr_Match_Dist := distribute(Addr_Match_Dedup, hash(zip, trim(prim_name), trim(prim_range)));

ut.MAC_Split_Withdups_Local(Addr_Match_Dist, hash(zip, trim(prim_name), trim(prim_range)), 4000, Addr_Match_Dist_Reduced, Addr_Match_Remainder)

Addr_Matches := JOIN(Addr_Match_Dist_Reduced,
                     Addr_Match_Dist_Reduced, 
										 left.zip = right.zip and
                     left.prim_name = right.prim_name and
                     left.prim_range = right.prim_range and
										 left.bdid > right.bdid and
										 ((integer)left.prim_range <> 0 or left.sec_range = right.sec_range), //must have valid match on pr or sr
                     MatchBH(left, right),
                     local);

Addr_Matches_Dedup := dedup(Addr_Matches, bdid1, bdid2, all);

export BH_Relative_Match_Addr := Addr_Matches_Dedup : persist('TMTEMP::BH_Relative_Match_Addr');