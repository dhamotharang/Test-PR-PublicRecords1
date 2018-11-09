EXPORT MAC_WordBag_AppendSpecs_Rx(instring,keyname,keyfield,o) := MACRO
#UNIQUENAME(r)
%r% := RECORD
  UNSIGNED2 pos;
  SALT37.Str4000Type s;
  END;
	
#UNIQUENAME(d)
%d% := DATASET([{SALT37.WordCount(instring),instring}],%r%);
	
#UNIQUENAME(tr)
%r% %tr%(%r% s_in, UNSIGNED2 c) := TRANSFORM
  SELF.pos := c;
	SELF.s := SALT37.GetNthWord(s_in.s,c);
  END;
	
#UNIQUENAME(n)
%n% := NORMALIZE(	%d%, LEFT.pos, %tr%(LEFT,COUNTER) );
#UNIQUENAME(r2)
%r2% := RECORD(%r%)
  INTEGER2 spec;
	END;
	
#UNIQUENAME(tr2)
%r2% %tr2%(%n% le, keyname ri) := TRANSFORM
	sLen := LENGTH(TRIM(le.s));
  SELF.spec := ri.field_specificity;
  SELF := le;
  END;	
#UNIQUENAME(j0)
%j0% := JOIN( %n%, keyname, LEFT.s = RIGHT.keyfield, %tr2%(LEFT,RIGHT), LEFT OUTER, LIMIT(SALT37._Config.Constants.JoinLimit) );

#UNIQUENAME(j1)
%j1% := PROJECT(%j0%,TRANSFORM(%r2%,SELF.spec:=IF(LEFT.spec>0,LEFT.spec,IF(LENGTH(TRIM(LEFT.s)) < 4, 3*LENGTH(TRIM(LEFT.s)), 10)),SELF:=LEFT));

#UNIQUENAME(j)
%j% := IF(SUM(%j0%,spec)>0,%j1%,%j0%);

#UNIQUENAME(bse)
%bse% := DATASET([{0,(SALT37.StrType)(100*SUM(%j%,spec))}],%r%);
//%bse% := dataset([{0,(SALT37.StrType) 0}],%r%);
#UNIQUENAME(addw)
%r% %addw%(%r% le, %r2% ri) := TRANSFORM
  SELF.s := TRIM(le.s)+' '+TRIM(ri.s)+' '+(SALT37.StrType)ri.spec;
  SELF := le;
  END;
SALT37.StrType o := IF ( instring='','',TRIM(DENORMALIZE(%bse%,SORT(%j%,pos),TRUE,%addw%(LEFT,RIGHT),ALL)[1].s) );
  ENDMACRO;
