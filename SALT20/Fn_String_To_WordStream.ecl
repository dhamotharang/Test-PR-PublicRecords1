export Fn_String_To_WordStream(string si) := FUNCTION
import ut;
r := record
  unsigned4 hsh;
	unsigned2 spec;
  end;
rd := record,maxlength(10000)
  string s;
	end;
	
d := dataset([{si}],rd); // Parameter into dataset to allow normalize
r split(d le,unsigned2 c) := transform
  self.spec := (unsigned2)ut.Word(le.s,c+1);
  self.hsh := hash32(ut.Word(le.s,c));
  end;
unsigned2 nwds := ut.NoWords(si)/2; // Use rounding to 'strim' of extra word
return normalize(d,nwds,split(left,counter*2));
  END;
