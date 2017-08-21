export MAC_Field_Variants_WordBag(fieldvals,ufield,infield,sout) := MACRO
#uniquename(apfx)
typeof(fieldvals) %apfx%(fieldvals le,unsigned c) := transform
  self.infield := SALT30.GetNthWord(le.infield,c);
  self.ufield := le.ufield;
  end;
	
#uniquename(n)
%n% := distributed(normalize(fieldvals,SALT30.WordCount(left.infield),%apfx%(left,counter)),ufield);	
sout := dedup(sort(%n%,infield,ufield,local),infield,ufield,local);
  ENDMACRO;
