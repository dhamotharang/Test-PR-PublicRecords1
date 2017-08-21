IMPORT ingenix_natlprof
     , lib_stringlib;

rsCnldUPINSlim				:=	PROJECT(cnld_remap.files.cmcprov(UPIN_NUM != ''), cnld_remap.slim_layouts.cmcprov);
rsCnldUPINSlimDist		:=	DISTRIBUTE(rsCnldUPINSlim, HASH(UPIN_NUM));
rsCnldUPINSlimSort		:=	SORT(rsCnldUPINSlimDist, UPIN_NUM, LOCAL);
rsCnldUPINDD					:=	DEDUP(rsCnldUPINSlimSort, UPIN_NUM, LOCAL);

// OUTPUT(COUNT(rsCnldUPINDD));

rsIngxNameSlim				:=	PROJECT(cnld_remap.files.ProviderName, cnld_remap.slim_layouts.ProviderName);
rsIngxNameDist				:=	DISTRIBUTE(rsIngxNameSlim, HASH(ProviderID));
rsIngxNameSort				:=	SORT(rsIngxNameDist, ProviderID, LOCAL);

rsIngxUPINSlim				:=	PROJECT(cnld_remap.files.ProviderUPIN(UPIN != ''), layouts.ProviderUPIN);
rsIngxUPINDist				:=	DISTRIBUTE(rsIngxUPINSlim, HASH(ProviderID));
rsIngxUPINSort				:=	SORT(rsIngxUPINDist, ProviderID, LOCAL);

rsIngxNameUPINJoin		:=	JOIN(rsIngxNameSort,
															rsIngxUPINSort,
															left.ProviderID = right.ProviderID,
															INNER,
															LOCAL
														);

rsIngxUPINSlimDist		:=	DISTRIBUTE(rsIngxNameUPINJoin, HASH(UPIN));
rsIngxUPINSlimSort		:=	SORT(rsIngxUPINSlimDist, UPIN, LOCAL);
rsIngxUPINDD					:=	DEDUP(rsIngxUPINSlimSort, UPIN, LOCAL);

// OUTPUT(COUNT(rsIngxUPINDD));

rsUPINJoin						:=	JOIN(rsCnldUPINDD,
														rsIngxUPINDD,
														TRIM(left.UPIN_NUM) = TRIM(right.UPIN)
												AND StringLib.StringToUpperCase(TRIM(left.LAST_NAME)) = StringLib.StringToUpperCase(TRIM(right.LastName))
												AND StringLib.StringToUpperCase(TRIM(left.FIRST_NAME)) = StringLib.StringToUpperCase(TRIM(right.FirstName)),
														INNER,
														local
														);

// rsUPINJoinDist				:=	DISTRIBUTE(rsUPINJoin, HASH(ProviderID));
// rsUPINJoinDistSort		:=	SORT(rsUPINJoinDist, HASH(ProviderID), LOCAL);
// rsUPINJoinUnique			:=	DEDUP(rsUPINJoinDistSort, HASH(ProviderID), LOCAL);

rsUPINJoinDist				:=	DISTRIBUTE(rsUPINJoin, HASH(GENNUM));
rsUPINJoinDistSort		:=	SORT(rsUPINJoinDist, HASH(GENNUM), LOCAL);
rsUPINJoinUnique			:=	DEDUP(rsUPINJoinDistSort, HASH(GENNUM), LOCAL);

pUPINUnique				:=	PROJECT(rsUPINJoinUnique, cnld_remap.slim_layouts.GennumProviderID);

export proc_join_cnld_Ingenix_UPIN :=	pUPINUnique:PERSIST('~thor_200::persist::rsCnldIngxUPINJoin');