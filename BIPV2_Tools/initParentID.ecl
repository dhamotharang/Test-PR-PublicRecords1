// Assign the best available value to null ParentIDs

EXPORT initParentID(ds,did,pid,force=false) := FUNCTIONMACRO
	// Example: did=DotID and pid=ProxID
	
	needed	:= force OR EXISTS(ds(pid=0));
	ds_dist := DISTRIBUTE(ds, HASH32(did));
	ds_sort := SORT(ds_dist, did, -pid, LOCAL);
	ds_grp	:= GROUP(ds_sort, did, LOCAL);
	
	ds_grp setPid(ds_grp L, ds_grp R) := TRANSFORM
		SELF.pid := MAP(
			R.pid<>0 => R.pid,	// If this record already has a pid don't mess with it
			L.pid<>0 => L.pid,	// If this did cluster already has a pid, use it
			R.did								// If _none_ of the records in this did have a pid, init pid:=did
		);
		SELF := R;
	END;
	ds_iter := ITERATE(ds_grp, setPid(LEFT,RIGHT));
	
	RETURN IF(needed, UNGROUP(ds_iter), ds);
ENDMACRO;