import ut,mdr;

EXPORT BH_Relative_Match_ID(

	 dataset(Layout_Business_Header_Temp)	pBH_Basic_Match_ForRels		= BH_Basic_Match_ForRels	()
	,string																pPersistname							= persistnames().BHRelativeMatchID													
	,boolean															pShouldRecalculatePersist	= true													

) :=
function

// Initialize match file
BH_File := pBH_Basic_Match_ForRels;

Layout_BH_Match := record
unsigned6 bdid;             // Seisint Business Identifier
string2   source;           // Source file type
qstring34 source_group;     // Source id for group
end;

Layout_BH_Match InitMatchFile(Business_Header.Layout_Business_Header_Temp L) := transform
self.source :=  L.source;  // SEC Broker file uses CIK as key
self := L;
end;

ID_Match_Init := project(BH_File(
			MDR.sourceTools.SourceIsBankruptcy							(source)
	or	MDR.sourceTools.SourceIsBusiness_Registration		(source)
	or	MDR.sourceTools.SourceIsCorpV2									(source)
	or	MDR.sourceTools.SourceIsDunn_Bradstreet					(source)
	or	MDR.sourceTools.SourceIsDCA											(source)
	or	MDR.sourceTools.SourceIsSEC_Broker_Dealer				(source)
	, source_group <> ''
), InitMatchFile(left));

ID_Match_Init_Dedup := dedup(ID_Match_Init, bdid, source, source_group, all);

Business_Header.Layout_Relative_Match MatchBH(Layout_BH_Match L, Layout_BH_Match R) := transform
self.bdid1 := L.bdid;
self.bdid2 := R.bdid;
self.match_type := map(
										 MDR.sourceTools.SourceIsBankruptcy							(l.source)	=> 'B'
										,MDR.sourceTools.SourceIsBusiness_Registration	(l.source)	=> 'BR'
										,MDR.sourceTools.SourceIsCorpV2									(l.source)	=> 'C'
										,MDR.sourceTools.SourceIsDunn_Bradstreet				(l.source)	=> 'D'
										,MDR.sourceTools.SourceIsDCA										(l.source)	=> 'DC'
										,MDR.sourceTools.SourceIsSEC_Broker_Dealer			(l.source)	=> 'E'
										,''
									);
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

BH_Relative_Match_ID_persisted := ID_Matches_Dedup 
	: persist(pPersistname);

returndataset := if(pShouldRecalculatePersist = true, BH_Relative_Match_ID_persisted
																										, persists().BHRelativeMatchID
									);
return returndataset;

end;