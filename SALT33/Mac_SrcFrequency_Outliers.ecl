EXPORT mac_srcfrequency_outliers(infile,infield,srcfield,o) := MACRO
  #uniquename(r)
  %r% := RECORD
	  SALT33.Str30Type fieldname := #TEXT(infield);
	  SALT33.StrType fieldvalue {maxlength(200000)} := (SALT33.StrType)infile.infield ;
		SALT33.StrType src {maxlength(30)} := infile.srcfield ;
		UNSIGNED c := COUNT(GROUP);
	  END;
		
	#uniquename(t1)
	%t1% := TABLE( infile, %r%, infield, srcfield, MERGE );
	
  #uniquename(r2)
  %r2% := RECORD
	  %t1%.fieldname;
	  %t1%.fieldvalue;		
		UNSIGNED c := SUM(GROUP,%t1%.c);
	  END;
		
	#uniquename(tots)
	%tots% := TOPN( TABLE( %t1%, %r2%, fieldname, fieldvalue ), 1000, -c );// Dedup to avoid high frequency errors
  #uniquename(sg)
	%sg% := DEDUP( SORT( DISTRIBUTE(%t1%, HASH(src)), src, -c, fieldvalue,LOCAL ), src, KEEP(50),LOCAL );
  EXPORT o := SORT(JOIN( %sg%, %tots%, LEFT.fieldvalue=RIGHT.fieldvalue,TRANSFORM(LEFT), LEFT ONLY ), -c, src );
	
  ENDMACRO;
