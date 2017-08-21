import ut, mdr;

EXPORT BH_Relative_Match_FEIN(

	 dataset(Layout_Business_Header_Temp)	pBH_Basic_Match_ForRels		= BH_Basic_Match_ForRels	()
	,string																pPersistname							= persistnames().BHRelativeMatchFEIN													
	,boolean															pShouldRecalculatePersist	= true													

) :=
function

// Initialize match file
BH_File := pBH_Basic_Match_ForRels;

Layout_BH_Match := record
unsigned6 bdid;             // Seisint Business Identifier
unsigned4 fein;             // Federal Employer Identification Number
end;

Layout_BH_Match InitMatchFile(Business_Header.Layout_Business_Header_Temp L) := transform
self := L;
end;

FEIN_Match_Init := project(BH_File(Business_Header.ValidFEIN(fein) and fein <> 0 and ~mdr.sourceTools.SourceIsIRS_5500(source)), InitMatchFile(left));
FEIN_Match_Init_Dedup := dedup(FEIN_Match_Init, bdid, fein, all);

Business_Header.Layout_Relative_Match MatchBH(Layout_BH_Match L, Layout_BH_Match R) := transform
self.bdid1 := L.bdid;
self.bdid2 := R.bdid;
self.match_type := 'FE';
end;

FEIN_Match_Dist := distribute(FEIN_Match_Init_Dedup, hash(fein));

FEIN_Matches := join(FEIN_Match_Dist,
                     FEIN_Match_Dist,
                     left.fein = right.fein and
                     left.bdid > right.bdid,
                   MatchBH(left, right),
                   local);

FEIN_Matches_Dedup := dedup(FEIN_Matches, bdid1, bdid2, all);

BH_Relative_Match_FEIN_persisted := FEIN_Matches_Dedup 
	: persist(pPersistname);
	
returndataset := if(pShouldRecalculatePersist = true, BH_Relative_Match_FEIN_persisted
																										, persists().BHRelativeMatchFEIN
									);
return returndataset;
	
end;