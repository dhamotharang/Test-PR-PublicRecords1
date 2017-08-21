IMPORT ingenix_natlprof
     , lib_stringlib;

rsCnldProvSlim			:=	PROJECT(cnld_remap.files.cmcprov, cnld_remap.slim_layouts.cmcprov);
rsCnldProvDist			:=	DISTRIBUTE(rsCnldProvSlim, HASH(GENNUM));
rsCnldProvSort			:=	SORT(rsCnldProvDist, GENNUM, LOCAL);

rsCnldDEASlim				:=	PROJECT(cnld_remap.files.cmcdea(DEANBR != ''), cnld_remap.slim_layouts.cmcdea);
rsCnldDEADist				:=	DISTRIBUTE(rsCnldDEASlim, HASH(GENNUM));
rsCnldDEASort				:=	SORT(rsCnldDEADist, GENNUM, LOCAL);

rsCnldProvLicNumJoin		:=	JOIN(rsCnldProvSort,
														rsCnldDEASort,
														left.GENNUM = right.GENNUM,
														INNER,
														LOCAL
													);

rsCnldDEASlimDist		:=	DISTRIBUTE(rsCnldProvLicNumJoin, HASH(DEANBR));
rsCnldDEASlimSort		:=	SORT(rsCnldDEASlimDist, DEANBR, LOCAL);
rsCnldDEADD					:=	DEDUP(rsCnldDEASlimSort, DEANBR, LOCAL);

// OUTPUT(COUNT(rsCnldDEADD));

rsIngxNameSlim			:=	PROJECT(cnld_remap.files.ProviderName, cnld_remap.slim_layouts.ProviderName);
rsIngxNameDist			:=	DISTRIBUTE(rsIngxNameSlim, HASH(ProviderID));
rsIngxNameSort			:=	SORT(rsIngxNameDist, ProviderID, LOCAL);

rsIngxDEASlim				:=	PROJECT(cnld_remap.files.ProviderAddressDEANumber(DEANumber != ''), layouts.ProviderAddressDEANumber);
rsIngxDEADist				:=	DISTRIBUTE(rsIngxDEASlim, HASH(ProviderID));
rsIngxDEASort				:=	SORT(rsIngxDEADist, ProviderID, LOCAL);

rsIngxNameDEAJoin		:=	JOIN(rsIngxNameSort,
															rsIngxDEASort,
															left.ProviderID = right.ProviderID,
															INNER,
															LOCAL
														);

rsIngxDEASlimDist		:=	DISTRIBUTE(rsIngxNameDEAJoin, HASH(DEANumber));
rsIngxDEASlimSort		:=	SORT(rsIngxDEASlimDist, DEANumber, LOCAL);
rsIngxDEADD					:=	DEDUP(rsIngxDEASlimSort, DEANumber, LOCAL);

// OUTPUT(COUNT(rsIngxDEADD));

rsDEAJoin						:=	JOIN(rsCnldDEADD,
														rsIngxDEADD,
														TRIM(left.DEANBR) = TRIM(right.DEANumber)
												AND StringLib.StringToUpperCase(TRIM(left.LAST_NAME)) = StringLib.StringToUpperCase(TRIM(right.LastName))
												AND StringLib.StringToUpperCase(TRIM(left.FIRST_NAME)) = StringLib.StringToUpperCase(TRIM(right.FirstName)),
														INNER,
														local
														);

// rsDEAJoinDist				:=	DISTRIBUTE(rsDEAJoin, HASH(ProviderID));
// rsDEAJoinDistSort		:=	SORT(rsDEAJoinDist, HASH(ProviderID), LOCAL);
// rsDEAJoinUnique			:=	DEDUP(rsDEAJoinDistSort, HASH(ProviderID), LOCAL);

rsDEAJoinDist				:=	DISTRIBUTE(rsDEAJoin, HASH(GENNUM));
rsDEAJoinDistSort		:=	SORT(rsDEAJoinDist, HASH(GENNUM), LOCAL);
rsDEAJoinUnique			:=	DEDUP(rsDEAJoinDistSort, HASH(GENNUM), LOCAL);

pDEAJoinUnique				:=	PROJECT(rsDEAJoinUnique, cnld_remap.slim_layouts.GennumProviderID);

export proc_join_cnld_Ingenix_DEA :=	pDEAJoinUnique:PERSIST('~thor_200::persist::rsCnldIngxDEAJoin');