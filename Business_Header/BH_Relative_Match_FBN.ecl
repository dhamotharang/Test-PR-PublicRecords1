import ut, FBN, govdata;

// Initialize match file
BH_File := BH_Basic_Match_ForRels;

Layout_FBN_Match := record
unsigned6 bdid;             // Seisint Business Identifier
qstring120 company_name;
qstring34 vendor_id;
qstring10 prim_range;
qstring28 prim_name;
qstring8  sec_range;
unsigned3 zip;
end;

Layout_FBN_Match InitFBNMatch(Business_Header.Layout_Business_Header_Temp L) := transform
self := L;
end;

FBN_Match_Init := project(BH_File(source in ['FF']), InitFBNMatch(left));
FBN_Match_Init_Dedup := dedup(FBN_Match_Init, all);
FBN_Match_Init_Dist := distribute(FBN_Match_Init_Dedup, hash(trim(company_name), trim(vendor_id), trim(prim_name), zip));

Layout_FBN_Match InitFBNFilingMatch(Business_Header.Layout_Business_Header L) := transform
self := L;
end;

FBN_Filing_Match_Init := project(govdata.FL_FBN_As_Business_Header, InitFBNFilingMatch(left));
FBN_Filing_Match_Init_Dedup := dedup(FBN_Filing_Match_Init, all);
FBN_Filing_Match_Init_Dist := distribute(FBN_Filing_Match_Init_Dedup, hash(trim(company_name), trim(vendor_id), trim(prim_name), zip));

// Join to get all FBN filings
Layout_BH_Match := record
unsigned6 bdid;
qstring34 vendor_id;
end;

Layout_BH_Match GetFBNFilings(Layout_FBN_Match L, Layout_FBN_Match R) := transform
self.bdid := R.bdid;
self.vendor_id := L.vendor_id;
end;

FBN_Filing_Match := join(FBN_Filing_Match_Init_Dist,
                         FBN_Match_Init_Dist,
                         left.zip = right.zip and
			               left.prim_name = right.prim_name and
			               left.prim_range = right.prim_range and
			               left.company_name = right.company_name and
						   left.vendor_id = right.vendor_id,
                         GetFBNFilings(left,right),
                         local);

FBN_Filing_Match_Dedup := dedup(FBN_Filing_Match(bdid <> 0), bdid, vendor_id, all);
FBN_Filing_Match_Dedup_Dist := distribute(FBN_Filing_Match_Dedup, hash(vendor_id));

Business_Header.Layout_Relative_Match MatchBH(Layout_BH_Match L, Layout_BH_Match R) := transform
self.bdid1 := L.bdid;
self.bdid2 := R.bdid;
self.match_type := 'F';
end;

FBN_Matches := JOIN(FBN_Filing_Match_Dedup_Dist,
                    FBN_Filing_Match_Dedup_Dist, 
					left.vendor_id = right.vendor_id and
                    left.bdid > right.bdid,
                    MatchBH(left, right),
                    local);

FBN_Matches_Dedup := DEDUP(FBN_Matches, bdid1, bdid2, all);

export BH_Relative_Match_FBN := FBN_Matches_Dedup: persist('TMTEMP::BH_Relative_Match_FBN');