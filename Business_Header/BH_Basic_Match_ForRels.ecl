import dnb_dmi,ut,mdr;

EXPORT BH_Basic_Match_ForRels(

	 dataset(Layout_Business_Header_Temp)	pBH_Basic_Match_Clean			= BH_Basic_Match_Clean	()
	,dataset(Layout_Business_Header_New	)	pDNB_As_Business_Header		= dnb_dmi.As_Business_Header()
	,string																pPersistname							= persistnames().BHBasicMatchForRels													
	,boolean															pShouldRecalculatePersist	= true													

) :=
function


bmc := filters.keys.business_headers_temp(pBH_Basic_Match_Clean);

isbad := mdr.sourcetools.sourceisdunn_bradstreet_fein(bmc.source);

bmc_bad := bmc(isbad); 

//2.  Project the DNB_As_Business_Header to company_name, source_group, zip, prim_name, prim_range and dedup
dbh_slim := table(pDNB_As_Business_Header, {company_name, source_group, zip, prim_name, prim_range});
dbh_ddp := dedup(dbh_slim, all); 

	
//3.  Join D&B FEIN records from (1) with D&B records from (2) 
	//on ut.CleanCompany( company name), source_group, zip, prim_name, and prim_range 
	//to select records from (1) that also exist in (2).  Transform should set the fein to 0.
	
bmc tra(bmc_bad l) := transform	
	self.fein := 0;
	self := l;
end;

bmc_cleaned := join(bmc_bad, dbh_ddp, 
										left.source_group = right.source_group and
										left.zip = right.zip and
										left.prim_name = right.prim_name and
										left.prim_range = right.prim_range and
										ut.CleanCompany(left.company_name) = ut.CleanCompany(right.company_name),
										tra(left), hash);
	
//4.  Combine BH_Basic_Match_Clean(source <> 'D' or (source='D' and fein=0)) and records from (3)

bmc_safe := bmc(not(isbad));
BH_Basic_Match_ForRels_persisted := bmc_safe + bmc_cleaned
	: persist(pPersistname);

returndataset := if(pShouldRecalculatePersist = true, BH_Basic_Match_ForRels_persisted
																										, persists().BHBasicMatchForRels
									);
return returndataset;

end;