import ut;

//  Rollup Relative Group

Layout_Relative_Group_Temp := record
unsigned6 group_id := 0;
Layout_Relative_Match;
end;


Relative_Group_Append := BH_Relative_Group_Name
                        + BH_Relative_Group_Addr
						+ BH_Relative_Group_DUNS_Tree;

/*
Relative_Group_Append := dataset('TMTEMP::BH_Relative_Group_Name',Layout_Relative_Match, flat) +
                       dataset('TMTEMP::BH_Relative_Group_Addr',Layout_Relative_Match, flat) +
                       dataset('TEMP::BH_Relative_Group_DUNS_Tree',Layout_Relative_Match, flat);
*/

Layout_Relative_Group_Temp InitRelativeGroup(Layout_Relative_Match l) := transform
self := l;
end;

Relative_Group_Init := project(Relative_Group_Append, InitRelativeGroup(left));

ut.MAC_Sequence_Records(Relative_Group_Init, group_id, Relative_Group_Seq)

Relative_Group_Dist := distribute(Relative_Group_Seq, hash(bdid1, match_type));
Relative_Group_Sort := sort(Relative_Group_Dist, bdid1, match_type, bdid2, local);
Relative_Group_Grp := group(Relative_Group_Sort, bdid1, match_type, local);

Layout_Relative_Group_Temp AssignGroupID(Layout_Relative_Group_Temp l, Layout_Relative_Group_Temp r) := transform
self.group_id := if(l.group_id = 0, r.group_id, l.group_id);
self := r;
end;

Relative_Group_Iter := group(iterate(Relative_Group_Grp, AssignGroupID(left,right)));

Layout_Business_Relative_Group FormatRelativeGroup(Layout_Relative_Group_Temp l) := transform
self.group_id := l.group_id;
self.group_type := l.match_type;
self.bdid := L.bdid2;
end;

Relative_Group_Out := project(Relative_Group_Iter, FormatRelativeGroup(left));
Relative_Group_Out_Sort := sort(Relative_Group_Out, group_id);

export BH_Relative_Group_Rollup := Relative_Group_Out_Sort : persist('TMTEMP::BH_Relative_Group_Rollup');