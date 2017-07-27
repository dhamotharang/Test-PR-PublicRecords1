import ut;

// Initialize match file
BH_File := BH_Basic_Match_ForRels;

Layout_BH_Match := record
unsigned6 bdid;                // Seisint Business Identifier
qstring10 prim_range;
qstring28 prim_name;
qstring8  sec_range;
unsigned3 zip;
end;

Layout_BH_Match InitMatchFile(Business_Header.Layout_Business_Header_Temp L) := transform
self.prim_range := if((integer)l.prim_range <> 0, l.prim_range, l.sec_range); //make sec range group if no prim name
self := L;
end;

Addr_Match_Init := project(BH_File(zip<>0, prim_name <> '', prim_name not in Bad_Address_List,
                              (integer)prim_range <> 0 or 
                                 (prim_name[1..3] in ['RR ', 'HC '] and
                                 (integer)(prim_name[4..LENGTH((string)prim_name)]) <> 0) and
																 (integer)sec_range <> 0), //only RR and HC if valid sr
                              InitMatchFile(left));

Addr_Match_Dedup := dedup(Addr_Match_Init, zip, prim_range, prim_name, bdid, all);

Addr_Match_Dist := distribute(Addr_Match_Dedup, hash(zip, trim(prim_name), trim(prim_range)));

ut.MAC_Split_Withdups_Local(Addr_Match_Dist, hash(zip, trim(prim_name), trim(prim_range)), 4000, Addr_Match_Dist_Reduced, Addr_Match_Remainder)

Layout_Addr_Match_Group := record
unsigned6 group_id;
Layout_BH_Match;
end;

Layout_Addr_Match_Group InitRemainder(Layout_BH_Match l) := transform
self.group_id := l.bdid;
self := l;
end;

Addr_Match_Remainder_Init := project(Addr_Match_Remainder, InitRemainder(left));

Addr_Match_Remainder_Sort := sort(Addr_Match_Remainder_Init, zip, prim_name, prim_range, group_id, local);
Addr_Match_Remainder_Grp := group(Addr_Match_Remainder_Sort, zip, prim_name, prim_range, local);

Layout_Addr_Match_Group SetGroupId(Layout_Addr_Match_Group l, Layout_Addr_Match_Group r) := transform
self.group_id := if(l.group_id = 0, r.group_id, l.group_id);
self := r;
end;

Addr_Match_Remainder_Iter := group(iterate(Addr_Match_Remainder_Grp, SetGroupId(left, right)));

Business_Header.Layout_Relative_Match FormatRelativeGroup(Layout_Addr_Match_Group L) := transform
self.match_type := 'AD';
self.bdid1 := l.group_id;
self.bdid2 := l.bdid;
end;

Addr_Relative_Group := project(Addr_Match_Remainder_Iter, FormatRelativeGroup(left));

export BH_Relative_Group_Addr := Addr_Relative_Group : persist('TMTEMP::BH_Relative_Group_Addr');