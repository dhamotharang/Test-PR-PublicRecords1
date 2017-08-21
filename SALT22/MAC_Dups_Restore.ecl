// This macro is tied to the deduping prior to running an external linking batch - specifically it undoes the dedup
export MAC_Dups_Restore(infile,indups,outfile) := MACRO
  #uniquename(takeid)
  TYPEOF(infile) %takeid%(infile le,indups ri) := TRANSFORM
	  SELF.Reference := ri.UniqueId;
	  SELF := le;
	END;
  outfile := infile + JOIN(infile,indups,LEFT.Reference=RIGHT.__shadow_ref,%takeid%(LEFT,RIGHT),MANY LOOKUP);
  ENDMACRO;