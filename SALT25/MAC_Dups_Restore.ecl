// This macro is tied to the deduping prior to running an external linking batch - specifically it undoes the dedup
export MAC_Dups_Restore(infile,indups,outfile) := MACRO
  #uniquename(takeid)
  TYPEOF(infile) %takeid%(infile le,indups ri) := TRANSFORM
	  SELF.Reference := ri.UniqueId;
	  SELF := le;
	END;
//outfile := infile + JOIN(infile,indups,LEFT.Reference=RIGHT.__shadow_ref,%takeid%(LEFT,RIGHT),MANY LOOKUP);

	#uniquename(j1)
	%j1% := infile + JOIN(infile,indups,LEFT.Reference=RIGHT.__shadow_ref,%takeid%(LEFT,RIGHT),MANY LOOKUP);
	#uniquename(j2)
	%j2% := infile + JOIN(infile,indups,LEFT.Reference=RIGHT.__shadow_ref,%takeid%(LEFT,RIGHT),HASH);
  outfile := if(count(indups)*sizeof(indups,max)<SALT25.Config.LookupMaxSize,%j1%,%j2%);
  ENDMACRO;
