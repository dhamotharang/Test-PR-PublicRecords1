
v1 := NID.NameRepositoryV1;
v2 := NID.NameRepository;

result := JOIN(v2, v1, left.nid=right.nid, TRANSFORM(nid.Layout_Repository,
											self.nametype := IF(left.nametype='T', 'U', left.nametype);
											self := LEFT;), LEFT ONLY, LOCAL);
											
lfn := Nid.Common.filename_NameRepository_Add + '_' + workunit;

SEQUENTIAL(
	OUTPUT(DISTRIBUTE(result, nid),,lfn,COMPRESSED),
	Nid.AddToRepository(lfn, true)
);
