/***

Dedup cache file
Reclean the names
Add to name repository
clear cache file

****/
import Std;

c := nid.CacheFile;
cache := DEDUP(SORT(DISTRIBUTE(c, nid), nid, LOCAL), nid, LOCAL);

repo := Nid.NameRepository;
newnames := JOIN(cache, repo, LEFT.nid=RIGHT.nid,
				TRANSFORM(Nid.Layout_Repository,
					SELF := LEFT;),
				LEFT ONLY, LOCAL);


result := DISTRIBUTE(Nid.RecleanNames(newnames), nid);

lfn := Nid.Common.filename_NameRepository_Base + '::' + workunit;

SEQUENTIAL(
	OUTPUT(COUNT(c),named('n_total')),
	OUTPUT(COUNT(cache),named('n_unique')),
	OUTPUT(COUNT(newnames),named('n_new')),
	OUTPUT(result,,lfn,COMPRESSED),
	Nid.AddToRepository(lfn),
	Nid.EmptyCacheSuperfile
);
