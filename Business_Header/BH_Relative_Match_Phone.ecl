import ut;

// Initialize match file
BH_File := Business_Header.BH_Basic_Match_ForRels;

Layout_BH_Match := record
unsigned6 bdid;             // Seisint Business Identifier
unsigned6 phone;
end;

Layout_BH_Match InitMatchFile(Business_Header.Layout_Business_Header_Temp L) := transform
self := L;
end;

Phone_Match_Init := project(BH_File(source <> 'W' and isMatchablePhone(phone) and phone != 9999999999),
                      InitMatchFile(left));

Business_Header.Layout_Relative_Match MatchBH(Layout_BH_Match L, Layout_BH_Match R) := transform
self.bdid1 := L.bdid;
self.bdid2 := R.bdid;
self.match_type := 'PH';
end;

Phone_Match_Dedup := dedup(Phone_Match_Init, phone, bdid, all);

Phone_Match_Dist := distribute(Phone_Match_Dedup, hash(phone));

/*
ut.MAC_Remove_Withdups_Local(Phone_Match_Dist, hash(phone), 1200, Phone_Match_Dist_Reduced)
*/

Phone_Matches := join(Phone_Match_Dist,
                      Phone_Match_Dist,
                      left.phone = right.phone and
                      left.bdid > right.bdid,
                      MatchBH(left, right),
                      local);

Phone_Matches_Dedup := DEDUP(Phone_Matches, bdid1, bdid2, all);

export BH_Relative_Match_Phone := Phone_Matches_Dedup : persist('TMTEMP::BH_Relative_Match_Phone');