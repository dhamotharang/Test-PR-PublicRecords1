// This macro is tied to the deduping prior to running an external linking batch - specifically it undoes the dedup
export MAC_Dups_Restore(infile,indups,outfile, uniqueIDField = 'uniqueid', useLocalJoin = 'false') := MACRO
  #uniquename(takeid)
  TYPEOF(infile) %takeid%(infile le,indups ri) := TRANSFORM
	  SELF.Reference := ri.uniqueIDField;
	  SELF := le;
	END;
//outfile := infile + JOIN(infile,indups,LEFT.Reference=RIGHT.__shadow_ref,%takeid%(LEFT,RIGHT),MANY LOOKUP);
	#uniquename(j1)
	%j1% := infile + JOIN(infile,indups,LEFT.Reference=RIGHT.__shadow_ref,%takeid%(LEFT,RIGHT),MANY LOOKUP);
	#uniquename(j2)
	%j2% := infile + JOIN(infile,indups,LEFT.Reference=RIGHT.__shadow_ref,%takeid%(LEFT,RIGHT),HASH);
	#uniquename(j3)
	%j3% := infile + JOIN(infile,indups,LEFT.Reference=RIGHT.__shadow_ref,%takeid%(LEFT,RIGHT),LOCAL);	
  // outfile := if(count(indups)*sizeof(indups,max)<SALT28.Config.LookupMaxSize,%j1%,%j2%);
  outfile := 
	#if(useLocalJoin)
		%j3%;
	#else
		%j2%;
	#end
  ENDMACRO;
