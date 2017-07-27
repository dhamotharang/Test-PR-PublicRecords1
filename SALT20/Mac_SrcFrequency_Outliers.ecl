export mac_srcfrequency_outliers(infile,infield,srcfield,o) := macro
  #uniquename(r)
  %r% := record
	  string30 fieldname := #TEXT(infield);
	  SALT20.StrType fieldvalue {maxlength(2000)} := (SALT20.StrType)infile.infield ;
		SALT20.StrType src {maxlength(30)} := infile.srcfield ;
		unsigned c := count(group);
	  end;
		
	#uniquename(t)
	%t% := table( infile, %r%, infield, srcfield, local );// Dedup to avoid high frequency errors
	
  #uniquename(r1)
  %r1% := record
	  %t%.fieldname;
	  %t%.fieldvalue;
		%t%.src;
		unsigned c := sum(group,%t%.c);
	  end;
		
	#uniquename(t1)
	%t1% := table( %t%, %r1%, fieldname, fieldvalue, src );// Dedup to avoid high frequency errors
  #uniquename(r2)
  %r2% := record
	  %t1%.fieldname;
	  %t1%.fieldvalue;		
		unsigned c := sum(group,%t1%.c);
	  end;
		
	#uniquename(tots)
	%tots% := topn( table( %t1%, %r2%, fieldname, fieldvalue ), 1000, -c );// Dedup to avoid high frequency errors
  #uniquename(sg)
	%sg% := dedup( sort( distribute(%t1%, hash(src)), src, -c,local ), src, keep(50),local );
  export o := sort(join( %sg%, %tots%, left.fieldvalue=right.fieldvalue,transform(left), left only ), -c, src );
	
  endmacro;
