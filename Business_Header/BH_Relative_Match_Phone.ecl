import ut,mdr;

EXPORT BH_Relative_Match_Phone(

	 dataset(Layout_Business_Header_Temp)	pBH_Basic_Match_ForRels		= BH_Basic_Match_ForRels	()
	,string																pPersistname							= persistnames().BHRelativeMatchPhone													
	,boolean															pShouldRecalculatePersist	= true													

) :=
function


// Initialize match file
BH_File := pBH_Basic_Match_ForRels;

Layout_BH_Match := record
unsigned6 bdid;             // Seisint Business Identifier
unsigned6 phone;
string2   source;
end;

Layout_BH_Match InitMatchFile(Business_Header.Layout_Business_Header_Temp L) := transform
self := L;
end;

Phone_Match_Init := project(BH_File((not MDR.sourceTools.SourceIsWhois_domains(source)) and isMatchablePhone(phone) and phone != 9999999999),
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
                      left.bdid > right.bdid and
											(not(
																MDR.sourceTools.SourceIsGong_Government	(left.source)
														or	MDR.sourceTools.SourceIsGong_Government	(right.source)
														or	MDR.sourceTools.SourceIsJigsaw					(left.source)
														or	MDR.sourceTools.SourceIsJigsaw					(right.source)
														or	MDR.sourceTools.SourceIsZoom						(left.source)
														or	MDR.sourceTools.SourceIsZoom						(right.source)
														or	MDR.sourceTools.SourceIsSpoke						(left.source)
														or	MDR.sourceTools.SourceIsSpoke						(right.source)
													)),
                      MatchBH(left, right),
                      local
											,keep(1000));

Phone_Matches_Dedup := DEDUP(Phone_Matches, bdid1, bdid2, all);

BH_Relative_Match_Phone_persist := Phone_Matches_Dedup 
	: persist(pPersistname);


returndataset := if(pShouldRecalculatePersist = true, BH_Relative_Match_Phone_persist
																										, persists().BHRelativeMatchPhone
									);
return returndataset;

end;