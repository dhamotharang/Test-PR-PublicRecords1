import ut, dcav2,mdr;

EXPORT BH_Relative_Match_DCA_Hierarchy(

	 dataset(Layout_Business_Header_Temp	)	pBH_Basic_Match_ForRels		= BH_Basic_Match_ForRels	()
	,dataset(dcav2.layouts.base.companies	) pDcaBase									= DCAv2.Files().base.companies.qa
	,string																	pPersistname							= persistnames().BHRelativeMatchDCAHierarchy													
	,boolean																pShouldRecalculatePersist	= true			
	,boolean																pUsingInGroupCalculation	= false

) :=
function
/*
Here I could join to the dca file on enterprise number(vendor_id in business header)
 in Business_Header.BH_Relative_Match_DCA_Hierarchy and only take the matches
to create relatives records, since the dca file only contains current records.
*/
dDcaEnterprise_num 	:= table(pDcaBase(record_type in [dcav2.Utilities.RecordType.Updated,dcav2.Utilities.RecordType.New]), {qstring34 vendor_id := rawfields.enterprise_num	,lncaGID,lncaGHID});

dbhDCArecords 			:= pBH_Basic_Match_ForRels(MDR.sourceTools.SourceIsDCA(source), vendor_id <> '');

Layout_BH_Match_full := record
unsigned6 bdid;             // Seisint Business Identifier
unsigned3 lncaGID;     			// lnca groupid.  complete hierarchy for each company has same lncagid    
unsigned3 lncaGHID;         // lnca group holding company id.  Each hierarchy subdivided into multiple sub-hierarchies to break links of holdings with their parent companies
end;

Layout_BH_Match := record
unsigned6 bdid;             // Seisint Business Identifier
unsigned3 gid;         
end;

dbhCurrentDCARecords := join(
	 distribute(dbhDCArecords			, hash(vendor_id))
	,distribute(dDcaEnterprise_num, hash(vendor_id))
	,left.vendor_id = right.vendor_id
	,transform(Layout_BH_Match_full, self.bdid := left.bdid;self.lncaGID := right.lncaGID;self.lncaGHID := right.lncaGHID;)
	,local
);

dbhCurrentDCARecords4groups 		:= project(dbhCurrentDCARecords	,transform(Layout_BH_Match,self.gid := left.lncaGHID,self := left));
dbhCurrentDCARecordsNot4groups	:= project(dbhCurrentDCARecords	,transform(Layout_BH_Match,self.gid := left.lncaGID	,self := left));

// Initialize match file
BH_File := if(pUsingInGroupCalculation	,dbhCurrentDCARecords4groups	,dbhCurrentDCARecordsNot4groups);

ID_Match_Init_Dedup := dedup(BH_File, all);

Business_Header.Layout_Relative_Match MatchBH(Layout_BH_Match L, Layout_BH_Match R) := transform
self.bdid1 := L.bdid;
self.bdid2 := R.bdid;
self.match_type := 'DH';
end;

ID_Match_Dist := distribute(ID_Match_Init_Dedup, gid);

ID_Matches := join(ID_Match_Dist,
                   ID_Match_Dist,
                   left.gid = right.gid and
                     left.bdid > right.bdid,
                   MatchBH(left, right),
                   local);

ID_Matches_Dedup := dedup(ID_Matches, bdid1, bdid2, match_type, all);

BH_Relative_Match_DCA_Hierarchy_persisted := ID_Matches_Dedup 
	: persist(pPersistname);

returndataset := if(pShouldRecalculatePersist = true, BH_Relative_Match_DCA_Hierarchy_persisted
																										, persists().BHRelativeMatchDCAHierarchy
									);
return returndataset;

end;