EXPORT MAC_Transitive_Closure(ifile,did1,did2,ofile) := MACRO
	// Create transitive closure dataset
	#uniquename(favorite)
	%favorite% := DEDUP( SORT( DISTRIBUTE(ifile, HASH(did1) ), did1, did2, LOCAL ), did1, LOCAL );
	// If I can go two steps through confident jumps then I will do so
	// This speeds convergence both by going two steps but also by allowing intermediates to jump
	#uniquename(combine)
	TYPEOF(RECORDOF(ifile)) %combine%(ifile le,ifile ri) := TRANSFORM
			SELF.did2 := IF(ri.did2<>0,ri.did2,le.did2);
	    SELF := le;
	  END;
	
	#uniquename(jmps)
	//TODO - SMART JOINs do not work reliably yet (https://track.hpccsystems.com/browse/HPCC-11937); 
	// Switch back to SMART after the problem is fixed
	%jmps% := JOIN(%favorite%,%favorite%,LEFT.did2 = RIGHT.did1,%combine%(LEFT,RIGHT),LEFT OUTER,HASH);
	// If someone else is about to land upon me then I cannot shift myself
	ofile := JOIN(%jmps%,%jmps%,LEFT.did1 = RIGHT.did2, TRANSFORM(LEFT), LEFT ONLY, HASH);
  
  ENDMACRO;
