EXPORT mac_allow_transitives(ifile,did1,did2,conf,conf_threshold,rule_num,ofile) := MACRO
	// Am going to try to leave everything going to his favorite
	// Favorite is the lowest numbered target DID for which the link is over the threshold
	#uniquename(favorite)
	%favorite% := DEDUP( SORT( DISTRIBUTE(ifile, HASH(did1) ), did1, conf < conf_threshold, did2, rule_num, LOCAL ), did1, LOCAL );
	// If I can go two steps through confident jumps then I will do so
	// This speeds convergence both by going two steps but also by allowing intermediates to jump
	#uniquename(combine)
	TYPEOF(RECORDOF(ifile)) %combine%(ifile le,ifile ri) := TRANSFORM
			SELF.did2 := IF(ri.did2<>0,ri.did2,le.did2);
			SELF.conf := IF( ri.conf = 0, le.conf, MIN(le.conf,ri.conf));
			SELF.rule_num := IF( ri.rule_num = 0, le.rule_num, MIN(le.rule_num,ri.rule_num));
	    SELF := le;
	  END;
	
	#uniquename(jmps)
	%jmps% := JOIN(%favorite%,%favorite%,LEFT.did2 = RIGHT.did1 AND LEFT.Conf >= Conf_Threshold AND RIGHT.Conf >= Conf_Threshold,%combine%(LEFT,RIGHT),LEFT OUTER,HASH);
	// If someone else is about to land upon be then I cannot shift myself
	ofile := JOIN(%jmps%,%jmps%,LEFT.did1 = RIGHT.did2, TRANSFORM(LEFT), LEFT ONLY, HASH);
  
  ENDMACRO;
