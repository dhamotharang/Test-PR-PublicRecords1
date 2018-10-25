EXPORT MAC_Edit_Distance_Pairs(infile,infield,countfield,thresh,phonetics,outfile) := MACRO
	#UNIQUENAME(infilePlus)
	#DECLARE(last3Type);
	#SET(last3Type, REGEXREPLACE('\\d*', #GETDATATYPE(infile.infield), '') + '3');
	#DECLARE(last4Type);
	#SET(last4Type, REGEXREPLACE('\\d*', #GETDATATYPE(infile.infield), '') + '4');
	%infilePlus% := PROJECT(infile, TRANSFORM({RECORDOF(infile), %last3Type% _last3, %last4Type% _last4},
			UNSIGNED len := LENGTH(TRIM(LEFT.infield));
			SELF._last3 := LEFT.infield[len - 2..];
			SELF._last4 := LEFT.infield[len - 3..];
			SELF := LEFT));	

	#UNIQUENAME(matchrec)
	%matchrec% := RECORD
	  TYPEOF(infile.infield) id1;
		TYPEOF(infile.countfield) count1;
		TYPEOF(infile.infield) id2;
		TYPEOF(infile.countfield) count2;
		UNSIGNED1       distance;
		BOOLEAN         phonetic;
	 END;
		
	#UNIQUENAME(trans)
	%matchrec% %trans%(%infilePlus% le,%infilePlus% ri) := TRANSFORM
	  SELF.id1 := le.infield;
		SELF.id2 := ri.infield;
		SELF.count1 := le.countfield;
		SELF.count2 := ri.countfield;
		SELF.distance := MAP( le.infield=ri.infield => 0,
													~SALT38.WithinEditN(le.infield,ri.infield,2) => 10,
													SALT38.WithinEditN(le.infield,ri.infield,1) => 1, 2 );
		SELF.phonetic := phonetics AND metaphonelib.dmetaphone1((STRING)le.infield) = metaphonelib.dmetaphone1((STRING)ri.infield);
	END;	
		
		// An error of 1 place in a 4 char document counts as a 2.5; given our lowest threshold is 2 this means
		// the lowest 'hit' will be a 5 char document with one error. Thus we can assert that at least 4 chars will always be fixed ...
		// the below would miss a 2 on a word where it was the two ends .... such is life ....
  // Use ,all for <= 4; allows the 'tiddlers' to get correct (and v.low) specificities
	#UNIQUENAME(inf4)
	%inf4% := %infilePlus%(thresh>0,LENGTH(TRIM(infield))<=4);
	#UNIQUENAME(j0)
	%j0% := JOIN(%inf4%,%inf4%,SALT38.WithinEditN(LEFT.infield,RIGHT.infield,thresh),%trans%(LEFT,RIGHT),ALL);	
	// Use the 4 fixed places for strings <= 7	
	#UNIQUENAME(inf7)
	%inf7% := %infilePlus%(thresh>0,LENGTH(TRIM(infield))<=7);
	#UNIQUENAME(inf)
	%inf% := %infilePlus%(thresh>0,LENGTH(TRIM(infield))>=5);
	#UNIQUENAME(j1)
	%j1% := JOIN(%inf7%,%inf7%,LEFT.infield[1..2]=RIGHT.infield[1..2] AND  LEFT.infield[3..*]=RIGHT.infield[3..*] AND SALT38.WithinEditN(LEFT.infield,RIGHT.infield,thresh),%trans%(LEFT,RIGHT),ATMOST(LEFT.infield[1..2]=RIGHT.infield[1..2] AND  LEFT.infield[3..*]=RIGHT.infield[3..*],3500),HINT(unsorted_output),HINT(parallel_match));
	#UNIQUENAME(j2)
	%j2% := JOIN(%inf%,%inf%,LEFT.infield[1..3]=RIGHT.infield[1..3] AND  LEFT.infield[4..*]=RIGHT.infield[4..*] AND SALT38.WithinEditN(LEFT.infield,RIGHT.infield,thresh),%trans%(LEFT,RIGHT),ATMOST(LEFT.infield[1..3]=RIGHT.infield[1..3] AND  LEFT.infield[4..*]=RIGHT.infield[4..*],5000),HINT(unsorted_output),HINT(parallel_match));
	#UNIQUENAME(j3)
	%j3% := JOIN(%inf7%,%inf7%,LEFT.infield[3..*]=RIGHT.infield[3..*] AND LEFT._last3 = RIGHT._last3 AND SALT38.WithinEditN(LEFT.infield,RIGHT.infield,thresh),%trans%(LEFT,RIGHT),ATMOST(LEFT.infield[3..*]=RIGHT.infield[3..*] AND LEFT._last3 = RIGHT._last3,3500),HINT(unsorted_output),HINT(parallel_match));
	#UNIQUENAME(j4)
	%j4% := JOIN(%inf%,%inf%,LEFT.infield[4..*]=RIGHT.infield[4..*] AND LEFT._last4 = RIGHT._last4 AND SALT38.WithinEditN(LEFT.infield,RIGHT.infield,thresh),%trans%(LEFT,RIGHT),ATMOST(LEFT.infield[4..*]=RIGHT.infield[4..*] AND LEFT._last4 = RIGHT._last4,2500),HINT(unsorted_output),HINT(parallel_match));
	#UNIQUENAME(j5)
	// Allow positions 4&5 to vary
	%j5% := JOIN(%inf%,%inf%,LEFT.infield[1..*]=RIGHT.infield[1..*] AND LEFT._last3 = RIGHT._last3 AND SALT38.WithinEditN(LEFT.infield,RIGHT.infield,thresh),%trans%(LEFT,RIGHT),ATMOST(LEFT.infield[1..*]=RIGHT.infield[1..*] AND LEFT._last3 = RIGHT._last3,2500),HINT(unsorted_output),HINT(parallel_match));
	#UNIQUENAME(jnull)
	// Make sure the 'fullmatch' case always gets through
	#IF(phonetics)
		%jnull% := JOIN(%infilePlus%,%infilePlus%,metaphonelib.dmetaphone1((STRING)LEFT.infield) = metaphonelib.dmetaphone1((STRING)RIGHT.infield),%trans%(LEFT,RIGHT),KEEP(512),HINT(parallel_match));
	#ELSE
		%jnull% := JOIN(%infilePlus%,%infilePlus%,LEFT.infield=RIGHT.infield,%trans%(LEFT,RIGHT));
	#END
	#UNIQUENAME(aj)
	%aj% := DEDUP( SORT( %j0%+%j1%+%j2%+%j3%+%j4%+%j5%+%jnull%, WHOLE RECORD, SKEW(1) ), WHOLE RECORD );
	
#UNIQUENAME(r1)
%r1% := RECORD
  %aj%.id1;
	UNSIGNED6 all_cnt := SUM(GROUP,%aj%.count2);
	UNSIGNED6 e1_cnt := SUM(GROUP,IF(%aj%.distance<=1,%aj%.count2,0));
	UNSIGNED6 e2_cnt := SUM(GROUP,IF(%aj%.distance<=2,%aj%.count2,0));
	UNSIGNED6 e1p_cnt := SUM(GROUP,IF(%aj%.distance<=1 AND %aj%.phonetic,%aj%.count2,0));
	UNSIGNED6 e2p_cnt := SUM(GROUP,IF(%aj%.distance<=2 AND %aj%.phonetic,%aj%.count2,0));
	UNSIGNED6 p_cnt := SUM(GROUP,IF(%aj%.phonetic,%aj%.count2,0));
END;
#UNIQUENAME(t)
%t% := TABLE(%aj%,%r1%,id1,FEW);	
#UNIQUENAME(oform)
// Slim things down to help the match_candidates
%oform% := RECORD
  infile;
	UNSIGNED6 all_cnt;
	#IF (thresh>0)
		UNSIGNED6 e1_cnt;
		UNSIGNED6 e2_cnt;
		#IF (phonetics)
			UNSIGNED6 e1p_cnt;
			UNSIGNED6 e2p_cnt;
		#END
	#END
	#IF (phonetics)
		UNSIGNED6 p_cnt;
	#END
END;
#UNIQUENAME(take_vals)
%oform% %take_vals%(infile le, %t% ri) := TRANSFORM
  SELF := le;
	SELF := ri;
END;
	
outfile := JOIN(infile,%t%,LEFT.infield=RIGHT.id1,%take_vals%(LEFT,RIGHT));
	
ENDMACRO;
