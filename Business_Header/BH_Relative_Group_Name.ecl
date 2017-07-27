import ut;

// Initialize match file
BH_File := Business_Header.BH_Basic_Match_ForRels;

Layout_BH_Match := record
unsigned6 bdid;                // Seisint Business Identifier
qstring81 clean_company_name;
end;

Layout_BH_Match InitMatchFile(Business_Header.Layout_Business_Header_Temp L) := transform
self.clean_company_name := ut.CleanCompany(L.company_name);
self := L;
end;

Name_Match_Init := project(BH_File(source<>'GG'), InitMatchFile(left));
Name_Match_Init_Dedup := dedup(Name_Match_Init, bdid, clean_company_name, all);

Name_Match_Dist := distribute(Name_Match_Init_Dedup, hash(clean_company_name[1..8]));
ut.MAC_Split_Withdups_Local(Name_Match_Dist, hash(clean_company_name[1..8]), 4000, Name_Match_Dist_Reduced, Name_Match_Remainder)


Name_Match_Remainder_Dist := distribute(Name_Match_Remainder, hash(clean_company_name));
ut.MAC_Split_Withdups_Local(Name_Match_Remainder_Dist, hash(clean_company_name), 4000, Name_Match_Remainder_Reduced, Name_Match_Clean_Remainder)

Layout_Name_Match_Group := record
unsigned6 group_id;
Layout_BH_Match;
end;

Layout_Name_Match_Group InitRemainder(Layout_BH_Match l) := transform
self.group_id := l.bdid;
self := l;
end;

Name_Match_Clean_Remainder_Init := project(Name_Match_Clean_Remainder, InitRemainder(left));

Name_Match_Clean_Remainder_Sort := sort(Name_Match_Clean_Remainder_Init, clean_company_name, group_id, local);
Name_Match_Clean_Remainder_Grp := group(Name_Match_Clean_Remainder_Sort, clean_company_name, local);

Layout_Name_Match_Group SetGroupId(Layout_Name_Match_Group l, Layout_Name_Match_Group r) := transform
self.group_id := if(l.group_id = 0, r.group_id, l.group_id);
self := r;
end;

Name_Match_Clean_Remainder_Iter := group(iterate(Name_Match_Clean_Remainder_Grp, SetGroupId(left, right)));

Business_Header.Layout_Relative_Match FormatRelativeGroup(Layout_Name_Match_Group L) := transform
self.match_type := 'NM';
self.bdid1 := l.group_id;
self.bdid2 := l.bdid;
end;

Name_Relative_Group := project(Name_Match_Clean_Remainder_Iter, FormatRelativeGroup(left));

export BH_Relative_Group_Name := Name_Relative_Group : persist('TMTEMP::BH_Relative_Group_Name');