import ut;

// Initialize match file
BH_File := Business_Header.BH_Basic_Match_ForRels;

Layout_BH_Match := record
unsigned6 bdid;             // Seisint Business Identifier
string2   source;           // Source file type
qstring34 source_group;     // Source id for group
end;

Layout_BH_Match InitMatchFile(Business_Header.Layout_Business_Header_Temp L) := transform
self.source := if(L.source = 'SB', 'E', L.source);  // SEC Broker file uses CIK as key
self := L;
end;

ID_Match_Init := project(BH_File(source in ['B','BR','C','D','DC','E','IA','ID','SB'], source_group <> ''), InitMatchFile(left));
ID_Match_Init_Dedup := dedup(ID_Match_Init, bdid, source, source_group, all);

Business_Header.Layout_Relative_Match MatchBH(Layout_BH_Match L, Layout_BH_Match R) := transform
self.bdid1 := L.bdid;
self.bdid2 := R.bdid;
self.match_type := L.source;
end;

ID_Match_Dist := distribute(ID_Match_Init_Dedup, hash(source, source_group));

ID_Matches := join(ID_Match_Dist,
                   ID_Match_Dist,
                   left.source = right.source and
                     left.source_group = right.source_group and
                     left.bdid > right.bdid,
                   MatchBH(left, right),
                   local);

ID_Matches_Dedup := dedup(ID_Matches, bdid1, bdid2, match_type, all);

export BH_Relative_Match_ID := ID_Matches_Dedup : persist('TMTEMP::BH_Relative_Match_ID');