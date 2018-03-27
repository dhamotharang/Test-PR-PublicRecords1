export Fn_String_To_WordStream(StrType si) := FUNCTION
r := record
  unsigned4 hsh;
	unsigned2 spec;
  end;
rd := record,maxlength(10000)
  StrType s;
	end;
	
d := dataset([{si}],rd); // Parameter into dataset to allow normalize
r split(d le,unsigned2 c) := transform
  self.spec := (unsigned2)GetNthWord(le.s,c+1);
  self.hsh := hash32(GetNthWord(le.s,c));
  end;
unsigned2 nwds := WordCount(si)/2; // Use rounding to 'strim' of extra word
return sort(normalize(d,nwds,split(left,counter*2)),-spec);
  END;
