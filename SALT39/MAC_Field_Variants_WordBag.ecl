export MAC_Field_Variants_WordBag(fieldvals,ufield,infield,sout) := MACRO
#uniquename(apfx)
typeof(fieldvals) %apfx%(fieldvals le,unsigned c) := transform
  self.infield := SALT39.GetNthWord(le.infield,c);
  self := le;
  end;
	
#uniquename(n)
%n% := distributed(normalize(fieldvals,SALT39.WordCount(left.infield),%apfx%(left,counter)),ufield);	
sout := dedup(sort(%n%,infield,ufield,local),infield,ufield,local);
  ENDMACRO;
