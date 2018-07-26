// NOTE: This macro references SALT39.Config.LookupMaxSize when determining whether
// it's possible to use a LOOKUP JOIN given the data provided.  If users experience
// OOM issues in that JOIN ("j1s" below), it likely indicates LookupMaxSize has been
// set incorrectly for the environment -- it is a measure of the amount of RAM
// available per node.
EXPORT MAC_WordBag_AppendSpecs_Th(infile,instring,new_instring,keyname,keyfield,AsIndex='true') := FUNCTIONMACRO
IFP := RECORD
  infile;
	UNSIGNED tot_spec := 0;
	UNSIGNED xxx_unc := 0;
  END;
// Need to add unique number to allow reeults to join back (REF may not be unique)	
t := TABLE(infile,ifp);
SALT39.utMAC_Sequence_Records(t,xxx_unc,nif)	
r := RECORD
  UNSIGNED xxx_unc;
  UNSIGNED2 pos;
  SALT39.StrType s;
  end;
	
r tr(nif s_in, unsigned2 c) := transform
  self.pos := c;
	self.s := SALT39.GetNthWord(s_in.instring,c);
	self.xxx_unc := s_in.xxx_unc;
  end;
	
// Split out the words for each wordbag
n := NORMALIZE(	nif, SALT39.WordCount(LEFT.instring), tr(LEFT,COUNTER) );
r2 := RECORD(r)
  INTEGER2 spec;
	END;
r2 tr2(n le, keyname ri) := TRANSFORM
  SELF.spec := ri.field_specificity;
  SELF := le;
  END;	
// Words are now joined to their specificities
pk := PULL(keyname);
j1s := JOIN( n, pk, LEFT.s = RIGHT.keyfield, tr2(LEFT,RIGHT), LOOKUP, LEFT OUTER );
lowspec := pk.field_specificity<8;
keytop := pk(lowspec); // Pull off the most frequent items of zipf distribution
j1b_1 := JOIN( n, keytop, LEFT.s = RIGHT.keyfield, tr2(LEFT,RIGHT), LOOKUP );
j1b_1pass := JOIN( n, keytop, LEFT.s = RIGHT.keyfield, TRANSFORM(LEFT), LOOKUP, LEFT ONLY );
j1b_2 := JOIN( j1b_1pass, pk(~lowspec), LEFT.s = RIGHT.keyfield, tr2(LEFT,RIGHT), HASH, LEFT OUTER );
j1 := IF ( COUNT(keyname)*SIZEOF(pk,max) < SALT39.Config.LookupMaxSize, j1s, j1b_1+j1b_2 ); // Use a pure lookup if you can
j0 := JOIN( n, keyname, LEFT.s = RIGHT.keyfield, tr2(LEFT,RIGHT), LEFT OUTER, LIMIT(SALT39._Config.Constants.JoinLimit) );
j := IF(AsIndex,j0,j1);
ifp addw(ifp le, j ri) := TRANSFORM
  SELF.new_instring := TRIM(le.new_instring)+' '+TRIM(ri.s)+' '+(SALT39.StrType)ri.spec;
	SELF.tot_spec := le.tot_spec + 100*ri.spec;
  SELF := le;
  END;
sf := DENORMALIZE(nif,SORT(DISTRIBUTE(j,(xxx_unc-1)%thorlib.nodes()),xxx_unc,pos,LOCAL),LEFT.xxx_unc=RIGHT.xxx_unc,addw(LEFT,RIGHT),LOCAL);
TYPEOF(infile) sb(sf le) := TRANSFORM
  SELF.new_instring := IF(le.instring='','',(SALT39.StrType)le.tot_spec+le.new_instring); // Newstring has space pre-pended by %addw%
  SELF := le;
  END;
	
RETURN PROJECT(sf,sb(LEFT));
  ENDMACRO;
