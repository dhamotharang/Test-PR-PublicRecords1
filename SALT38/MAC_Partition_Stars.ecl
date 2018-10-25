// Infile must be distributed by didfield
// Any records with a non-blank partition field that also have a blank partition field in the same cluster will be turned into a *
EXPORT MAC_Partition_Stars(infile,partfield,didfield) := FUNCTIONMACRO
  jbad := infile(partfield<>'');
	jclean := infile(partfield='');
	jgood := DEDUP(SORT(jclean,didfield,LOCAL),didfield,LOCAL);
	infile tr(infile le,infile ri) := TRANSFORM
	  SELF.partfield := IF( ri.didfield=0,le.partfield,'*' );
	  SELF := le;
	END;
	jdone := JOIN(jbad,jgood,LEFT.didfield=RIGHT.didfield,tr(LEFT,RIGHT),LEFT OUTER,LOCAL);
	RETURN jdone + jclean;
  ENDMACRO;
