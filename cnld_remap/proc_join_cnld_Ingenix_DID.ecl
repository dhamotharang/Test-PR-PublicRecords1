IMPORT ingenix_natlprof;

rsCnldDidInput		:=	DATASET('~thor_200::persist::rsCnldDid', layouts.cnld_clean, THOR);
rsCnldDIDSlim			:=	PROJECT(rsCnldDidInput, layouts.DIDSlim);
rsCmcprovSlimDist	:=	DISTRIBUTE(rsCnldDIDSlim(DID_Score > 74),HASH(DID));

rsIngxDidSlim			:=	PROJECT(ingenix_natlprof.Basefile_Provider_Did, layouts.IngxBaseSlim);
rsIngxDidSlimDist	:=	DISTRIBUTE(rsIngxDidSlim((integer) DID_Score > 74),HASH((integer) DID));

rsDIDJoin					:=	JOIN(rsCmcprovSlimDist,
   												 rsIngxDidSlimDist,
   												 left.DID = (integer) right.DID,
   												 INNER,
   												 local
   												 );

rsDIDJoinDist		:=	DISTRIBUTE(rsDIDJoin, HASH(DID));
rsDIDJoinSort		:=	SORT(rsDIDJoinDist, DID, LOCAL);
rsDIDJoinUnique	:=	DEDUP(rsDIDJoinDist, DID, LOCAL);

rsProvNamedist	:=	DISTRIBUTE(files.ProviderName, HASH(ProviderID));
rsProvNamesort	:=	SORT(rsProvNamedist, ProviderID, LOCAL);

rsDIDProvIDdist	:= 	DISTRIBUTE(rsDIDJoinUnique, HASH(ProviderID));
rsDIDProvIDsort	:=	SORT(rsDIDProvIDdist, ProviderID, LOCAL);

rsJoinexisting	:=	JOIN(rsProvNamesort,
												 rsDIDProvIDsort,
												 left.ProviderId = right.ProviderID,
												 INNER,
												 LOCAL);

pDIDJoinUnique	:=	PROJECT(rsJoinexisting, cnld_remap.slim_layouts.GennumProviderID);

rsGENJoinDist				:=	DISTRIBUTE(pDIDJoinUnique, HASH(GENNUM));
rsGENJoinSort				:=	SORT(rsGENJoinDist, HASH(GENNUM), LOCAL);
rsGENNUMUnique			:=	DEDUP(rsGENJoinSort, HASH(GENNUM), LOCAL);

export proc_join_cnld_Ingenix_DID :=	rsGENNUMUnique:PERSIST('~thor_200::persist::rsCnldIngxDidJoin');