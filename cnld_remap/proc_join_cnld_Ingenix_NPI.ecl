IMPORT ingenix_natlprof
     , lib_stringlib;
		 
rsCnldProvSlim			:=	PROJECT(cnld_remap.files.cmcprov, cnld_remap.slim_layouts.cmcprov);
rsCnldProvDist			:=	DISTRIBUTE(rsCnldProvSlim, HASH(GENNUM));
rsCnldProvSort			:=	SORT(rsCnldProvDist, GENNUM, LOCAL);

rsCnldNPISlim				:=	PROJECT(cnld_remap.files.cmcfed(FED_TAXID != '' AND TAX_TYPE = 'N'), cnld_remap.slim_layouts.cmcfed);
rsCnldNPIDist				:=	DISTRIBUTE(rsCnldNPISlim, HASH(GENNUM));
rsCnldNPISort				:=	SORT(rsCnldNPIDist, GENNUM, LOCAL);

rsCnldProvLicNumJoin		:=	JOIN(rsCnldProvSort,
														rsCnldNPISort,
														left.GENNUM = right.GENNUM,
														INNER,
														LOCAL
													);

rsCnldNPISlimDist		:=	DISTRIBUTE(rsCnldProvLicNumJoin, HASH(FED_TAXID));
rsCnldNPISlimSort		:=	SORT(rsCnldNPISlimDist, FED_TAXID, LOCAL);
rsCnldNPIDD					:=	DEDUP(rsCnldNPISlimSort, FED_TAXID, LOCAL);

// OUTPUT(COUNT(rsCnldNPIDD));

rsIngxNameSlim					:=	PROJECT(cnld_remap.files.ProviderName, cnld_remap.slim_layouts.ProviderName);
rsIngxNameDist					:=	DISTRIBUTE(rsIngxNameSlim, HASH(ProviderID));
rsIngxNameSort					:=	SORT(rsIngxNameDist, ProviderID, LOCAL);

rsIngxNPISlim						:=	PROJECT(cnld_remap.files.ProviderNPI(NPI != ''), layouts.ProviderNPI);
rsIngxNPIDist						:=	DISTRIBUTE(rsIngxNPISlim, HASH(ProviderID));
rsIngxNPISort						:=	SORT(rsIngxNPIDist, ProviderID, LOCAL);

rsIngxNameNPIJoin				:=	JOIN(rsIngxNameSort,
															rsIngxNPISort,
															left.ProviderID = right.ProviderID,
															INNER,
															LOCAL
														);

rsIngxNPISlimDist		:=	DISTRIBUTE(rsIngxNameNPIJoin, HASH(NPI));
rsIngxNPISlimSort		:=	SORT(rsIngxNPISlimDist, NPI, LOCAL);
rsIngxNPIDD					:=	DEDUP(rsIngxNPISlimSort, NPI, LOCAL);


// OUTPUT(COUNT(rsIngxNPIDD));

rsNPIJoin						:=	JOIN(rsCnldNPIDD,
														rsIngxNPIDD,
														TRIM(left.FED_TAXID) = TRIM(right.NPI)
												AND StringLib.StringToUpperCase(TRIM(left.LAST_NAME)) = StringLib.StringToUpperCase(TRIM(right.LastName))
												AND StringLib.StringToUpperCase(TRIM(left.FIRST_NAME)) = StringLib.StringToUpperCase(TRIM(right.FirstName)),
														INNER,
														local
														);

// rsNPIJoinDist				:=	DISTRIBUTE(rsNPIJoin, HASH(ProviderID));
// rsNPIJoinDistSort		:=	SORT(rsNPIJoinDist, HASH(ProviderID), LOCAL);
// rsNPIJoinUnique			:=	DEDUP(rsNPIJoinDistSort, HASH(ProviderID), LOCAL);

rsNPIJoinDist				:=	DISTRIBUTE(rsNPIJoin, HASH(GENNUM));
rsNPIJoinDistSort		:=	SORT(rsNPIJoinDist, HASH(GENNUM), LOCAL);
rsNPIJoinUnique			:=	DEDUP(rsNPIJoinDistSort, HASH(GENNUM), LOCAL);

pNPIUnique				:=	PROJECT(rsNPIJoinUnique, cnld_remap.slim_layouts.GennumProviderID);

export proc_join_cnld_Ingenix_NPI :=	pNPIUnique:PERSIST('~thor_200::persist::rsCnldIngxNPIJoin');