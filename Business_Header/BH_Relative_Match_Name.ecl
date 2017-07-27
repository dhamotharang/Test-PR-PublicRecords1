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

Business_Header.Layout_Relative_Match MatchBH(Layout_BH_Match L, Layout_BH_Match R) := transform
self.bdid1 := L.bdid;
self.bdid2 := R.bdid;
self.match_type := 'NM';
end;

Name_Match_Dist := distribute(Name_Match_Init_Dedup, hash(clean_company_name[1..8]));
ut.MAC_Split_Withdups_Local(Name_Match_Dist, hash(clean_company_name[1..8]), 4000, Name_Match_Dist_Reduced, Name_Match_Remainder)

Name_Matches := join(Name_Match_Dist_Reduced,
                     Name_Match_Dist_Reduced,
                     left.clean_company_name[1..8] = right.clean_company_name[1..8] and
                       ut.CompanySimilar100(left.clean_company_name, right.clean_company_name) <= 10 and
                       left.bdid > right.bdid,
                     MatchBH(left, right),
                     local);

// Try exact match on full clean company name
Name_Match_Remainder_Dist := distribute(Name_Match_Remainder, hash(clean_company_name));
ut.MAC_Remove_Withdups_Local(Name_Match_Remainder_Dist, hash(clean_company_name), 4000, Name_Match_Remainder_Reduced)

Name_Matches_Remainder := join(Name_Match_Remainder_Reduced,
                               Name_Match_Remainder_Reduced,
                               left.clean_company_name = right.clean_company_name and
                                 left.bdid > right.bdid,
                               MatchBH(left, right),
                               local);

Name_Matches_Dedup := dedup(Name_Matches + Name_Matches_Remainder, bdid1, bdid2, all);

export BH_Relative_Match_Name := Name_Matches_Dedup : persist('TMTEMP::BH_Relative_Match_Name');