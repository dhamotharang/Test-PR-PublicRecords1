IMPORT ingenix_natlprof
			 ,  lib_stringlib;

rsCnldProvSlim				:=	PROJECT(cnld_remap.files.cmcprov, cnld_remap.slim_layouts.cmcprov);
rsCnldProvDist				:=	DISTRIBUTE(rsCnldProvSlim, HASH(GENNUM));
rsCnldProvSort				:=	SORT(rsCnldProvDist, GENNUM, LOCAL);

rsCnldFEINSlim				:=	PROJECT(cnld_remap.files.cmcfed(FED_TAXID != '' AND TAX_TYPE = 'E'), cnld_remap.slim_layouts.cmcfed);
rsCnldFEINDist				:=	DISTRIBUTE(rsCnldFEINSlim, HASH(GENNUM));
rsCnldFEINSort				:=	SORT(rsCnldFEINDist, GENNUM, LOCAL);

rsCnldProvFEINJoin		:=	JOIN(rsCnldProvSort,
														rsCnldFEINSort,
														left.GENNUM = right.GENNUM,
														INNER,
														LOCAL
													);

rsCnldFEINSlimDist		:=	DISTRIBUTE(rsCnldProvFEINJoin, HASH(FED_TAXID));
rsCnldFEINSlimSort		:=	SORT(rsCnldFEINSlimDist, FED_TAXID, LOCAL);
rsCnldFEINDD					:=	DEDUP(rsCnldFEINSlimSort, FED_TAXID, LOCAL);

// OUTPUT(COUNT(rsCnldFEINDD));

rsIngxNameSlim				:=	PROJECT(cnld_remap.files.ProviderName, cnld_remap.slim_layouts.ProviderName);
rsIngxFEINSlim				:=	PROJECT(cnld_remap.files.ProviderAddressTaxID(TaxID != ''), layouts.ProviderAddressTaxID);

rsIngxNameDist				:=	DISTRIBUTE(rsIngxNameSlim, HASH(ProviderID));
rsIngxFEINDist				:=	DISTRIBUTE(rsIngxFEINSlim, HASH(ProviderID));

rsIngxNameSort				:=	SORT(rsIngxNameDist, ProviderID, LOCAL);
rsIngxFEINSort				:=	SORT(rsIngxFEINDist, ProviderID, LOCAL);

rsIngxNameFEINJoin		:=	JOIN(rsIngxNameSort,
														rsIngxFEINSort,
														left.ProviderID = right.ProviderID,
														INNER,
														LOCAL
													);

rsIngxFEINSlimDist		:=	DISTRIBUTE(rsIngxNameFEINJoin, HASH(TaxID));
rsIngxFEINSlimSort		:=	SORT(rsIngxFEINSlimDist, TaxID, LOCAL);
rsIngxFEINDD					:=	DEDUP(rsIngxFEINSlimSort, TaxID, LOCAL);

// OUTPUT(COUNT(rsIngxFEINDD));

rsFEINJoin						:=	JOIN(rsCnldFEINDD,
														rsIngxFEINDD,
														TRIM(left.FED_TAXID) = TRIM(right.TaxID) 
												AND StringLib.StringToUpperCase(TRIM(left.LAST_NAME)) = StringLib.StringToUpperCase(TRIM(right.LastName))
												AND StringLib.StringToUpperCase(TRIM(left.FIRST_NAME)) = StringLib.StringToUpperCase(TRIM(right.FirstName)),
														INNER,
														local
														);

// rsFEINJoinDist				:=	DISTRIBUTE(rsFEINJoin, HASH(ProviderID));
// rsFEINJoinDistSort		:=	SORT(rsFEINJoinDist, HASH(ProviderID), LOCAL);
// rsFEINJoinUnique			:=	DEDUP(rsFEINJoinDistSort, HASH(ProviderID), LOCAL);

rsFEINJoinDist				:=	DISTRIBUTE(rsFEINJoin, HASH(GENNUM));
rsFEINJoinDistSort		:=	SORT(rsFEINJoinDist, HASH(GENNUM), LOCAL);
rsFEINJoinUnique			:=	DEDUP(rsFEINJoinDistSort, HASH(GENNUM), LOCAL);

pFEINJoinUnique				:=	PROJECT(rsFEINJoinUnique, cnld_remap.slim_layouts.GennumProviderID);

export proc_join_cnld_Ingenix_FEIN :=	pFEINJoinUnique:PERSIST('~thor_200::persist::rsCnldIngxFEINJoin');