import ut;

// Initialize match file
BH_File := Business_Header.BH_Basic_Match_ForRels;

Layout_BH_Match := record
unsigned6 bdid;             // Seisint Business Identifier
string6   dca_root;         // Root portion of DCA Company Number
end;

Layout_BH_Match InitMatchFile(Business_Header.Layout_Business_Header_Temp L) := transform
self.dca_root := L.source_group[1..6];
self := L;
end;

ID_Match_Init := project(BH_File(source = 'DC', source_group <> ''), InitMatchFile(left));
ID_Match_Init_Dedup := dedup(ID_Match_Init, all);

Business_Header.Layout_Relative_Match MatchBH(Layout_BH_Match L, Layout_BH_Match R) := transform
self.bdid1 := L.bdid;
self.bdid2 := R.bdid;
self.match_type := 'DH';
end;

ID_Match_Dist := distribute(ID_Match_Init_Dedup, hash(dca_root));

ID_Matches := join(ID_Match_Dist,
                   ID_Match_Dist,
                   left.dca_root = right.dca_root and
                     left.bdid > right.bdid,
                   MatchBH(left, right),
                   local);

ID_Matches_Dedup := dedup(ID_Matches, bdid1, bdid2, match_type, all);

export BH_Relative_Match_DCA_Hierarchy := ID_Matches_Dedup : persist('TEMP::BH_Relative_Match_DCA-Hierarchy');