EXPORT fn_Set_Union(SET OF INTEGER l,SET OF INTEGER r) := FUNCTION
  ld := DATASET(l,{INTEGER i});
	rd := DATASET(r,{INTEGER i});
	d := DEDUP( SORT( ld+rd, i ), i );
	RETURN SET(d,i);
	END;
