import ut,mdr;

EXPORT BH_Relative_Match_Name_Phone(

	 dataset(Layout_Business_Header_Temp)	pBH_Basic_Match_ForRels		= BH_Basic_Match_ForRels	()
	,string																pPersistname							= persistnames().BHRelativeMatchNamePhone													
	,boolean															pShouldRecalculatePersist	= true													

) :=
function


// Initialize match file
BH_File := pBH_Basic_Match_ForRels;

Layout_BH_Match := record
unsigned6 bdid;             // Seisint Business Identifier
string2   source;           // Source file type
qstring81 clean_company_name;
qstring10 prim_range;
qstring28 prim_name;
qstring8  sec_range;
unsigned3 zip;
unsigned6 phone;
end;

Layout_BH_Match InitMatchFile(Business_Header.Layout_Business_Header_Temp L) := transform
self.clean_company_name := ut.CleanCompany(L.company_name);
self := L;
end;

Phone_Match_Init := project(BH_File((not MDR.sourceTools.SourceIsWhois_domains(source)) and isMatchablePhone(phone) and phone != 9999999999),
                            InitMatchFile(left));

Business_Header.Layout_Relative_Match MatchBH(Layout_BH_Match L, Layout_BH_Match R) := transform
self.bdid1 := L.bdid;
self.bdid2 := R.bdid;
self.match_type := 'NP';
end;

Phone_Match_Dedup := dedup(Phone_Match_Init, phone, bdid, zip, clean_company_name, all);

Phone_Match_Dist := distribute(Phone_Match_Dedup, hash(phone));

/*
ut.MAC_Remove_Withdups_Local(Phone_Match_Dist, hash(phone), 1200, Phone_Match_Dist_Reduced)
*/

Phone_Matches := 
join(
	 Phone_Match_Dist
	,Phone_Match_Dist
	,		left.phone	= right.phone
	and left.bdid		> right.bdid

	and (
					(			not(
													MDR.sourceTools.SourceIsGong_Government	(left.source)
											or	MDR.sourceTools.SourceIsGong_Government	(right.source)
											or	MDR.sourceTools.SourceIsJigsaw					(left.source)
											or	MDR.sourceTools.SourceIsJigsaw					(right.source)
											or	MDR.sourceTools.SourceIsZoom						(left.source)
											or	MDR.sourceTools.SourceIsZoom						(right.source)
											or	MDR.sourceTools.SourceIsSpoke						(left.source)
											or	MDR.sourceTools.SourceIsSpoke						(right.source)
								) 
						and	(
										(				UT.CompanySimilar100(left.clean_company_name				, right.clean_company_name				) <= 30
												and ut.StringSimilar100	(left.clean_company_name[41..80], right.clean_company_name[41..80]) <= 50
										)
								OR	(				Business_Header.Address_Match(left.zip, right.zip, left.prim_range, right.prim_range, left.prim_name, right.prim_name, left.sec_range, right.sec_range)
												and ut.CompanySimilar100(left.clean_company_name, right.clean_company_name) < 40
										)
								)
					)
			OR	(			(					MDR.sourceTools.SourceIsGong_Government	(left.source)
											or	MDR.sourceTools.SourceIsGong_Government	(right.source)
											or	MDR.sourceTools.SourceIsJigsaw					(left.source)
											or	MDR.sourceTools.SourceIsJigsaw					(right.source)
											or	MDR.sourceTools.SourceIsZoom						(left.source)
											or	MDR.sourceTools.SourceIsZoom						(right.source)
											or	MDR.sourceTools.SourceIsSpoke						(left.source)
											or	MDR.sourceTools.SourceIsSpoke						(right.source)
								)
						and  left.clean_company_name = right.clean_company_name
					)
			)

	,MatchBH(left, right)
	,atmost(left.phone = right.phone, 1500)
	,local
);

Phone_Matches_Dedup := DEDUP(Phone_Matches, bdid1, bdid2, all);

BH_Relative_Match_Name_Phone_persisted := Phone_Matches_Dedup 
	: persist(pPersistname);

returndataset := if(pShouldRecalculatePersist = true, BH_Relative_Match_Name_Phone_persisted
																										, persists().BHRelativeMatchNamePhone
									);
return returndataset;

end;