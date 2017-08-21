import ut, UCCV2,mdr;

EXPORT BH_Relative_Match_UCC(

	 dataset(Layout_Business_Header_Temp)	pBH_Basic_Match_ForRels		= BH_Basic_Match_ForRels				()
	,dataset(Layout_Business_Header_New	)	pUCCV2_As_Business_Header	= UCCV2.UCCV2_As_Business_Header()
	,string																pPersistname							= persistnames().BHRelativeMatchUCC													
	,boolean															pShouldRecalculatePersist	= true													

) :=
function

// Initialize match file
BH_File := pBH_Basic_Match_ForRels;

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

UCC_Match_Init := project(BH_File(MDR.sourceTools.SourceIsUCCS(source)), InitUCCMatch(left));
UCC_Match_Init_Dedup := dedup(UCC_Match_Init, all);
UCC_Match_Init_Dist := distribute(UCC_Match_Init_Dedup, hash(trim(company_name), trim(vendor_id), trim(prim_name), zip));

Layout_UCC_Match InitUCCPartyMatch(Business_Header.Layout_Business_Header_New L) := transform
self := L;
end;

UCC_Party_Match_Init := project(pUCCV2_As_Business_Header, InitUCCPartyMatch(left));
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

// Process vendor_ids with many dups separately, to prevent long skewed join
ds0             := distribute(UCC_Filing_Match_Dedup, hash(vendor_id));
ds1             := sort(ds0, vendor_id, local);
ds2             := table(ds1, {vendorID := vendor_id, tot := COUNT(GROUP)}, vendor_id, local);
ds3             := ds2(tot > 1000);  // Anything above this will cause nasty skews
ds4             := set(ds3, vendorid);
goodVendors     := UCC_Filing_Match_Dedup(vendor_id not in ds4);
badVendors      := UCC_Filing_Match_Dedup(vendor_id in ds4);
goodVendorsDist := distribute(goodVendors, hash(vendor_id));
badVendorsDist  := distribute(badVendors, hash(random())); // Can't use vendor_id so can only be random


Business_Header.Layout_Relative_Match MatchBH(Layout_BH_Match L, Layout_BH_Match R) := transform
  self.bdid1 := L.bdid;
  self.bdid2 := R.bdid;
  self.match_type := 'U';
end;

// Original join
UCC_MatchesGoodVendors := JOIN(goodVendorsDist,
                               goodVendorsDist, 
					                     left.vendor_id = right.vendor_id and
                               left.bdid > right.bdid,
                               MatchBH(left, right),
                               local);

// "All" join to cope better (i.e. prevent 22 minute skew) with many vendor id's that are the same
UCC_MatchesBadVendors  := JOIN(badVendorsDist,
                               badVendors, 
					                     left.vendor_id = right.vendor_id and
                               left.bdid > right.bdid,
                               MatchBH(left, right),
                               all);


UCC_Matches_Dedup := DEDUP(UCC_MatchesGoodVendors + UCC_MatchesBadVendors, bdid1, bdid2, all);

BH_Relative_Match_UCC_persisted := UCC_Matches_Dedup 
	: persist(pPersistname);

returndataset := if(pShouldRecalculatePersist = true, BH_Relative_Match_UCC_persisted
																										, persists().BHRelativeMatchUCC
									);
return returndataset;

end;