IMPORT Bankrupt, Gong, ut, UCC, Corporate, YellowPages, Domains;

EXPORT BH_Matches(

	 dataset(Layout_Business_Header_New)	pBH_Init									= BH_Init()
	,dataset(Layout_Business_Header_New)	pWhois_As_Business_Header	= Domains.Whois_As_Business_Header
	,string																pPersistnameAppend				= persistnames().BHMatchesAppend													
	,string																pPersistname							= persistnames().BHMatches													
	,boolean															pShouldRecalculatePersist	= true													
	,string																pFileVersion							= 'built'
	,boolean															pUseOtherEnvironment			= _Dataset().IsDataland

) :=
function

// Business Header Combined Sources
BH_Init_Sources := pBH_Init;

// Select Matching Domain Records
Domains_Init := pWhois_As_Business_Header(zip<>0);

//COUNT(Domains_Init);

ut.MAC_Sequence_Records(Domains_Init, rcid, Domains_Seq)

Domains_Dist := DISTRIBUTE(Domains_Seq, HASH(zip, TRIM(prim_name), TRIM(prim_range)));

// Remove most of the Domain name brokers
ut.MAC_Remove_Withdups_Local(Domains_Dist, HASH(zip, TRIM(prim_name), TRIM(prim_range)), 4000, Domains_Dist_Reduced)

BH_Init_Dedup := DEDUP(BH_Init_Sources(zip<>0), company_name, zip, prim_name, prim_range, sec_range, ALL);
BH_Init_Dist := DISTRIBUTE(BH_Init_Dedup, HASH(zip, TRIM(prim_name), TRIM(prim_range)));

Business_Header.Layout_Business_Header_New SelectDomains(Business_Header.Layout_Business_Header_New L, Business_Header.Layout_Business_Header_New R) := TRANSFORM
SELF := L;
END;

// Match Businesses to Domain Records to filter out garbage
Domains_Match := JOIN(Domains_Dist_Reduced,
                      BH_Init_Dist,
                        LEFT.zip = RIGHT.zip AND
                        LEFT.prim_name = RIGHT.prim_name AND
                        LEFT.prim_range = RIGHT.prim_range AND
                        ut.NNEQ(LEFT.sec_range, RIGHT.sec_range) AND
                        ut.CompanySimilar100(LEFT.company_name, RIGHT.company_name) <= 35,
                      SelectDomains(LEFT, RIGHT),
                      LOCAL);

//COUNT(Domains_Match);

Domains_Match_Dedup := DEDUP(Domains_Match, rcid, ALL);

//COUNT(Domains_Match_Dedup);

// Append Businesses and Domains
BH_Append := BH_Init_Sources + Domains_Match_Dedup : PERSIST(pPersistnameAppend) ;

//COUNT(BH_Append);

// Project to format for match with additional unique id
Layout_Match := RECORD
Business_Header.Layout_Business_Header_New;
unsigned6 uid;
END;

Layout_Match InitForMatch(Business_Header.Layout_Business_Header_New L) := TRANSFORM
// ensure all ids are 0
SELF.rcid := 0;
SELF.bdid := 0;
SELF.uid := 0;
SELF := L;
END;

BH_ToMatch := PROJECT(BH_Append, InitForMatch(LEFT));

BH_ToMatch_With_Vendor := BH_ToMatch(source IN Set_Source_Vendor_Id_Unique, vendor_id <> '');
BH_ToMatch_With_Phone := BH_ToMatch(source IN Set_Source_Phone,
                                    source NOT IN Set_Source_Vendor_Id_Unique, phone <> 0);
BH_ToMatch_Other := BH_ToMatch(source NOT IN Set_Source_Vendor_Id_Unique
                               OR (source IN Set_Source_Vendor_Id_Unique AND vendor_id = ''),
                               source NOT IN Set_Source_Phone
							   OR (source IN Set_Source_Phone and phone = 0));

// Perform basic match to current business headers
Business_Header.MAC_Basic_Match				(BH_ToMatch_Other				,BH_Matched_Other				,TRUE,pFileVersion,pUseOtherEnvironment)
Business_Header.MAC_Basic_Match_Vendor(BH_ToMatch_With_Vendor	,BH_Matched_With_Vendor	,TRUE,pFileVersion,pUseOtherEnvironment)
Business_Header.MAC_Basic_Match_Phone	(BH_ToMatch_With_Phone	,BH_Matched_With_Phone	,TRUE,pFileVersion,pUseOtherEnvironment)


BH_Matched := BH_Matched_With_Vendor + BH_Matched_With_Phone + BH_Matched_Other;

BH_NotMatched := BH_Matched(rcid = 0) /* : PERSIST('TEMP::BH_NotMatched') */;

//COUNT(BH_NotMatched);

// Sequence the non-matched records
ut.MAC_Sequence_Records(BH_NotMatched, uid, BH_NotMatched_Seq)

BH_Matched_Seq := BH_Matched(rcid <> 0) + BH_NotMatched_Seq;

//COUNT(BH_Matched_Seq);

// Assign new record ids to non-matched records
Business_Header.Layout_Business_Header_New AssignNewIDs(Layout_Match L) := TRANSFORM
SELF.rcid := IF (L.rcid = 0, Business_Header.Max_RCID() + L.uid, L.rcid);
SELF.bdid := IF (L.bdid = 0, Business_Header.Max_RCID() + L.uid, L.bdid);
self := l;
end;

BH_Assigned := PROJECT(BH_Matched_Seq, AssignNewIDs(LEFT));

BH_Matches_persist := DISTRIBUTE(BH_Assigned, HASH(rcid)) 
	: PERSIST(pPersistname);

returndataset := if(pShouldRecalculatePersist = true, BH_Matches_persist
																										, persists().BHMatches
									);
									
return returndataset;
	
end;