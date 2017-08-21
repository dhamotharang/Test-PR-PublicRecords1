import ut, Gong_Neustar, mdr;

EXPORT BH_Relative_Match_Gong(

	 dataset(Layout_Business_Header_Temp)	pBH_Basic_Match_ForRels		= BH_Basic_Match_ForRels	()
	,dataset(Layout_Business_Header_New	)	pGong_As_Business_Header	= Gong_Neustar.As_Business_Header().GongV2
	,string																pPersistname							= persistnames().BHRelativeMatchGong													
	,boolean															pShouldRecalculatePersist	= true													

) :=
function

// Initialize match file
BH_File := pBH_Basic_Match_ForRels;

Layout_Gong_Match := record
unsigned6 bdid;             // Seisint Business Identifier
string2   source;
qstring120 company_name;
qstring34 vendor_id;
qstring10 prim_range;
qstring28 prim_name;
qstring8  sec_range;
unsigned3 zip;
end;

Layout_Gong_Match InitGongMatch(Business_Header.Layout_Business_Header_Temp L) := transform
self := L;
end;

// Use only Gong Business (not government) listings
Gong_Match_Init := project(BH_File(MDR.sourceTools.SourceIsGong_Business(source)), InitGongMatch(left));
Gong_Match_Init_Dedup := dedup(Gong_Match_Init, all);
Gong_Match_Init_Dist := distribute(Gong_Match_Init_Dedup, hash(trim(company_name), trim(prim_name), zip));

Layout_Gong_Match InitGongGroupMatch(Business_Header.Layout_Business_Header_New L) := transform
self := L;
end;

Gong_Group_Match_Init := project(pGong_As_Business_Header(MDR.sourceTools.SourceIsGong_Business(source)), InitGongGroupMatch(left));
Gong_Group_Match_Init_Dedup := dedup(Gong_Group_Match_Init, all);
Gong_Group_Match_Init_Dist := distribute(Gong_Group_Match_Init_Dedup, hash(trim(company_name), trim(prim_name), zip));

// Join to get all Gong filings
Layout_BH_Match := record
unsigned6 bdid;
qstring34 vendor_id;
string2 source;
end;

Layout_BH_Match GetGongFilings(Layout_Gong_Match L, Layout_Gong_Match R) := transform
self.bdid := R.bdid;
self.vendor_id := L.vendor_id;
self.source := L.source;
end;

Gong_Filing_Match := join(Gong_Group_Match_Init_Dist,
                         Gong_Match_Init_Dist,
                         left.zip = right.zip and
			               left.prim_name = right.prim_name and
			               left.prim_range = right.prim_range and
			               left.company_name = right.company_name and
                           left.source = right.source and
                           ut.NNEQ(left.sec_range,right.sec_range),
                         GetGongFilings(left,right),
                         local);

Gong_Filing_Match_Dedup := dedup(Gong_Filing_Match, bdid, vendor_id, source, all);
Gong_Filing_Match_Dedup_Dist := distribute(Gong_Filing_Match_Dedup, hash(vendor_id));

Business_Header.Layout_Relative_Match MatchBH(Layout_BH_Match L, Layout_BH_Match R) := transform
self.bdid1 := L.bdid;
self.bdid2 := R.bdid;
self.match_type := L.source;
end;

Gong_Matches := JOIN(Gong_Filing_Match_Dedup_Dist,
                    Gong_Filing_Match_Dedup_Dist,
                    left.source = right.source and 
					left.vendor_id = right.vendor_id and
                    left.bdid > right.bdid,
                    MatchBH(left, right),
                    local);

Gong_Matches_Dedup := DEDUP(Gong_Matches, bdid1, bdid2, all);

BH_Relative_Match_Gong_persisted := Gong_Matches_Dedup 
	: persist(pPersistname);

returndataset := if(pShouldRecalculatePersist = true, BH_Relative_Match_Gong_persisted
																										, persists().BHRelativeMatchGong
									);
return returndataset;

end;