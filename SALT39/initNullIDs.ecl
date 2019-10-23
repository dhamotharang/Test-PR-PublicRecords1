// Assign the best available value to null IDFIELDs
EXPORT initNullIDs := MODULE
	// With single-level linking, a record's IDFIELD should be initialized to the value of its
	// RIDFIELD.  That is also the case for the lowest level of a multi-level ID hierarchy.  At
	// higher levels, however, we need to look at the nearest child cluster to benefit from any
	// linking that may have already occurred.
	
	EXPORT baseLevel(ds,ridfield,idfield) := FUNCTIONMACRO
		RETURN PROJECT(ds, TRANSFORM(RECORDOF(ds), SELF.idfield:=IF(LEFT.idfield<>0, LEFT.idfield, LEFT.ridfield), SELF:=LEFT));
	ENDMACRO;
	
	EXPORT upperLevel(ds,childid,idfield) := FUNCTIONMACRO
		// Example: childid=DotID and idfield=ProxID
		
		needed	:= EXISTS(ds(idfield=0));
		ds_dist := DISTRIBUTE(ds, HASH32(childid));
		ds_sort := SORT(ds_dist, childid, -idfield, LOCAL);
		ds_grp	:= GROUP(ds_sort, childid, LOCAL);
		
		ds_grp setIDFIELD(ds_grp L, ds_grp R) := TRANSFORM
			SELF.idfield := MAP(
				R.idfield<>0 => R.idfield,	// If this record already has an idfield value don't mess with it
				L.idfield<>0 => L.idfield,	// If this childid cluster already has an idfield value, use it
				R.childid										// If _none_ of the records in this childid cluster have an idfield value, init idfield:=childid
			);
			SELF := R;
		END;
		ds_iter := ITERATE(ds_grp, setIDFIELD(LEFT,RIGHT));
		
		RETURN IF(needed, UNGROUP(ds_iter), ds);
	ENDMACRO;
	
	// Create a patch file to allow "upperLevel" initialization to be applied repeatedly
	EXPORT upperLevelPatch(ds,ridfield,childid,idfield) := FUNCTIONMACRO
		ds_thin := TABLE(ds,{ridfield,childid,idfield,TYPEOF(idfield) oldfield:=idfield});
		ds_init := SALT39.initNullIDs.upperLevel(ds_thin,childid,idfield);
		ds_patch := TABLE(ds_init(idfield<>oldfield), {ridfield, idfield});
		RETURN ds_patch;
	ENDMACRO;
	
	// Called like...
	// patchfile := SALT39.initNullIDs.upperLevelPatch(ds_in,rcid,dotid,proxid);
	// ut.MAC_Append_Id(ds_in,rcid,proxid,patchfile,rcid,proxid,ds_out);
END;
