// This is for speed - presently only used in the header scoring ...
export Fn_WordBag_AppendSpecs_Fake(StrType instring,unsigned val = 10) := FUNCTION
#uniquename(r)
%r% := record
  unsigned2 pos;
  Str4000Type s;
  end;
	
#uniquename(d)
%d% := dataset([{WordCount(instring),instring}],%r%);
	
#uniquename(tr)
%r% %tr%(%r% s_in, unsigned2 c) := transform
  self.pos := c;
	self.s := GetNthWord(s_in.s,c);
  end;
	
#uniquename(n)
%n% := normalize(	%d%, left.pos, %tr%(left,counter) );
#uniquename(r2)
%r2% := record(%r%)
  integer2 spec;
	end;
	
#uniquename(tr2)
%r2% %tr2%(%n% le) := transform
  self.spec := val;
  self := le;
  end;	
#uniquename(j)
%j% := project( %n%, %tr2%(left) );
#uniquename(bse)
%bse% := dataset([{0,(StrType)(100*SUM(%j%,spec))}],%r%);
#uniquename(addw)
%r% %addw%(%r% le, %r2% ri) := transform
  self.s := trim(le.s)+' '+trim(ri.s)+' '+(StrType)ri.spec;
  self := le;
  end;
return if ( instring='','',trim(denormalize(%bse%,sort(%j%,pos),true,%addw%(left,right),all)[1].s) );
  END;
