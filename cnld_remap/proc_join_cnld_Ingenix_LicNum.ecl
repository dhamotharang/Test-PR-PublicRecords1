IMPORT ingenix_natlprof
       , lib_stringlib;

rsCnldProvSlim					:=	PROJECT(cnld_remap.files.cmcprov, cnld_remap.slim_layouts.cmcprov);
rsCnldProvDist					:=	DISTRIBUTE(rsCnldProvSlim, HASH(GENNUM));
rsCnldProvSort					:=	SORT(rsCnldProvDist, GENNUM, LOCAL);

rsCnldLicNumSlim				:=	PROJECT(cnld_remap.files.cmcsl(LIC_STATE != '' AND SLNUM != ''), cnld_remap.slim_layouts.cmcsl);
rsCnldLicNumDist				:=	DISTRIBUTE(rsCnldLicNumSlim, HASH(GENNUM));
rsCnldLicNumSort				:=	SORT(rsCnldLicNumDist, GENNUM, LOCAL);

rsCnldProvLicNumJoin		:=	JOIN(rsCnldProvSort,
														rsCnldLicNumSort,
														left.GENNUM = right.GENNUM,
														INNER,
														LOCAL
													);

rsCnldLicNumSlimDist		:=	DISTRIBUTE(rsCnldProvLicNumJoin, HASH(LIC_STATE, SLNUM));
rsCnldLicNumSlimSort		:=	SORT(rsCnldLicNumSlimDist, LIC_STATE, SLNUM, LOCAL);
rsCnldLicNumDD					:=	DEDUP(rsCnldLicNumSlimSort, LIC_STATE, SLNUM, LOCAL);

// OUTPUT(COUNT(rsCnldLicNumDD));

rsIngxNameSlim					:=	PROJECT(cnld_remap.files.ProviderName, cnld_remap.slim_layouts.ProviderName);
rsIngxNameDist					:=	DISTRIBUTE(rsIngxNameSlim, HASH(ProviderID));
rsIngxNameSort					:=	SORT(rsIngxNameDist, ProviderID, LOCAL);

rsIngxLicNumSlim				:=	PROJECT(cnld_remap.files.ProviderLicense(State != '' AND LicenseNumber != ''), layouts.ProviderLicense);
rsIngxLicNumDist				:=	DISTRIBUTE(rsIngxLicNumSlim, HASH(ProviderID));
rsIngxLicNumSort				:=	SORT(rsIngxLicNumDist, ProviderID, LOCAL);

rsIngxNameLicNumJoin		:=	JOIN(rsIngxNameSort,
															rsIngxLicNumSort,
															left.ProviderID = right.ProviderID,
															INNER,
															LOCAL
														);

rsIngxLicNumSlimDist		:=	DISTRIBUTE(rsIngxNameLicNumJoin, HASH(State, LicenseNumber));
rsIngxLicNumSlimSort		:=	SORT(rsIngxLicNumSlimDist, State, LicenseNumber, LOCAL);
rsIngxLicNumDD					:=	DEDUP(rsIngxLicNumSlimSort, State, LicenseNumber, LOCAL);

// OUTPUT(COUNT(rsIngxLicNumDD));

rsLicNumJoin						:=	JOIN(rsCnldLicNumDD,
														rsIngxLicNumDD,
														TRIM(left.LIC_STATE) = TRIM(right.State)
												AND TRIM(left.SLNUM) = TRIM(right.LicenseNumber)
												AND StringLib.StringToUpperCase(TRIM(left.LAST_NAME)) = StringLib.StringToUpperCase(TRIM(right.LastName))
												AND StringLib.StringToUpperCase(TRIM(left.FIRST_NAME)) = StringLib.StringToUpperCase(TRIM(right.FirstName)),
														INNER,
														local
														);

// rsLicNumJoinDist				:=	DISTRIBUTE(rsLicNumJoin, HASH(ProviderID));
// rsLicNumJoinDistSort		:=	SORT(rsLicNumJoinDist, ProviderID, LOCAL);
// rsLicNumJoinUnique			:=	DEDUP(rsLicNumJoinDistSort, ProviderID, LOCAL);

rsLicNumJoinDist				:=	DISTRIBUTE(rsLicNumJoin, HASH(GENNUM));
rsLicNumJoinDistSort		:=	SORT(rsLicNumJoinDist, GENNUM, LOCAL);
rsLicNumJoinUnique			:=	DEDUP(rsLicNumJoinDistSort, GENNUM, LOCAL);

pLicNumJoinUnique				:=	PROJECT(rsLicNumJoinUnique, cnld_remap.slim_layouts.GennumProviderID);

export proc_join_cnld_Ingenix_LicNum :=	pLicNumJoinUnique:PERSIST('~thor_200::persist::rsCnldIngxLicNumJoin');