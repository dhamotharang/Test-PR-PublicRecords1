// This is for speed - presently only used in the header scoring ...
EXPORT Fn_WordBag_AppendSpecs_Fake(StrType instring,UNSIGNED val = 10) := FUNCTION
r := RECORD
  UNSIGNED2 pos;
  Str4000Type s;
END;
	
d := DATASET([{WordCount(instring),instring}],r);
	
r tr(r s_in, UNSIGNED2 c) := TRANSFORM
  SELF.pos := c;
	SELF.s := GetNthWord(s_in.s,c);
END;
	
n := NORMALIZE(d, LEFT.pos, tr(LEFT,COUNTER));
r2 := RECORD(r)
  INTEGER2 spec;
END;
	
r2 tr2(n le) := TRANSFORM
  SELF.spec := IF(LENGTH(TRIM(le.s)) < 4, 3*LENGTH(TRIM(le.s)), val);
  SELF := le;
END;	
j := PROJECT( n, tr2(LEFT) );
bse := DATASET([{0,(StrType)(100*SUM(j,spec))}],r);
r addw(r le, r2 ri) := TRANSFORM
  SELF.s := TRIM(le.s)+' '+TRIM(ri.s)+' '+(StrType)ri.spec;
  SELF := le;
END;
RETURN IF(instring='','',TRIM(DENORMALIZE(bse,SORT(j,pos),TRUE,addw(LEFT,RIGHT),ALL)[1].s));
END;
