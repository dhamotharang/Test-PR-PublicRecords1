import ut,mdr;

EXPORT BH_Relative_Match_Mail_Addr(

	 dataset(Layout_Business_Header_Temp)	pBH_Basic_Match_ForRels		= BH_Basic_Match_ForRels	()
	,string																pPersistname							= persistnames().BHRelativeMatchMailAddr													
	,boolean															pShouldRecalculatePersist	= true													

) :=
function

// Initialize match file
BH_File := pBH_Basic_Match_ForRels;

Layout_BH_Match := record
unsigned6 bdid;             // Seisint Business Identifier
string2   source;           // Source file type
unsigned6 group1_id;        // Group1 identifier (integer) for groups of records pre-linked
end;

Layout_BH_Match InitMatchFile(Business_Header.Layout_Business_Header_Temp L) := transform
self := L;
end;

// Match D&B, Edgar sources only which have split a record with
// primary and secondary addresses (but not prior addresses)
Mail_Addr_Match_Init := project(BH_File(group1_id <> 0, 
		MDR.sourceTools.SourceIsDunn_Bradstreet	(source)
or	MDR.sourceTools.SourceIsEdgar						(source)
), InitMatchFile(left));
Mail_Addr_Match_Dedup := dedup(Mail_Addr_Match_Init, bdid, source, group1_id, all);

Business_Header.Layout_Relative_Match MatchBH(Layout_BH_Match L, Layout_BH_Match R) := transform
self.bdid1 := L.bdid;
self.bdid2 := R.bdid;
self.match_type := 'MA';
end;


// Match Rule 1 - Match on Source, Group1_ID
Mail_Addr_Match_Dist := distribute(Mail_Addr_Match_Dedup, hash(source, group1_id));

Mail_Addr_Matches := join(Mail_Addr_Match_Dist,
                          Mail_Addr_Match_Dist,
                          left.source = right.source and
                            left.group1_id = right.group1_id and
                            left.bdid > right.bdid,
                          MatchBH(left, right),
                          local);

Mail_Addr_Matches_Dedup := dedup(Mail_Addr_Matches, bdid1, bdid2, all);

BH_Relative_Match_Mail_Addr_persisted := Mail_Addr_Matches_Dedup  
	: persist(pPersistname);

returndataset := if(pShouldRecalculatePersist = true, BH_Relative_Match_Mail_Addr_persisted
																										, persists().BHRelativeMatchMailAddr
									);
return returndataset;

end;