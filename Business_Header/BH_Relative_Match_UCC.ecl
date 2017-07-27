import ut, UCC;

// Initialize match file
BH_File := BH_Basic_Match_ForRels;

Layout_UCC_Match := record
unsigned6 bdid;             // Seisint Business Identifier
qstring120 company_name;
qstring34 vendor_id;
qstring10 prim_range;
qstring28 prim_name;
qstring8  sec_range;
unsigned3 zip;
end;

Layout_UCC_Match InitUCCMatch(Business_Header.Layout_Business_Header_Temp L) := transform
self := L;
end;

UCC_Match_Init := project(BH_File(source='U'), InitUCCMatch(left));
UCC_Match_Init_Dedup := dedup(UCC_Match_Init, all);
UCC_Match_Init_Dist := distribute(UCC_Match_Init_Dedup, hash(trim(company_name), trim(vendor_id), trim(prim_name), zip));

Layout_UCC_Match InitUCCPartyMatch(Business_Header.Layout_Business_Header L) := transform
self := L;
end;

UCC_Party_Match_Init := project(UCC.UCC_Party_As_Business_Header, InitUCCPartyMatch(left));
UCC_Party_Match_Init_Dedup := dedup(UCC_Party_Match_Init, all);
UCC_Party_Match_Init_Dist := distribute(UCC_Party_Match_Init_Dedup, hash(trim(company_name), trim(vendor_id), trim(prim_name), zip));

// Join to get all UCC filings
Layout_BH_Match := record
unsigned6 bdid;
qstring34 vendor_id;
end;

Layout_BH_Match GetUCCFilings(Layout_UCC_Match L, Layout_UCC_Match R) := transform
self.bdid := R.bdid;
self.vendor_id := L.vendor_id;
end;

UCC_Filing_Match := join(UCC_Party_Match_Init_Dist,
                         UCC_Match_Init_Dist,
                         left.zip = right.zip and
			               left.prim_name = right.prim_name and
			               left.prim_range = right.prim_range and
			               left.company_name = right.company_name and
                           left.vendor_id = right.vendor_id,
                         GetUCCFilings(left,right),
                         local);

UCC_Filing_Match_Dedup := dedup(UCC_Filing_Match, bdid, vendor_id, all);
UCC_Filing_Match_Dedup_Dist := distribute(UCC_Filing_Match_Dedup, hash(vendor_id));

Business_Header.Layout_Relative_Match MatchBH(Layout_BH_Match L, Layout_BH_Match R) := transform
self.bdid1 := L.bdid;
self.bdid2 := R.bdid;
self.match_type := 'U';
end;

UCC_Matches := JOIN(UCC_Filing_Match_Dedup_Dist,
                    UCC_Filing_Match_Dedup_Dist, 
					left.vendor_id = right.vendor_id and
                    left.bdid > right.bdid,
                    MatchBH(left, right),
                    local);

UCC_Matches_Dedup := DEDUP(UCC_Matches, bdid1, bdid2, all);

export BH_Relative_Match_UCC := UCC_Matches_Dedup : persist('TMTEMP::BH_Relative_Match_UCC');