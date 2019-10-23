export MAC_Field_Variants_Initials(fieldvals,ufield,infield,sout) := MACRO
#uniquename(apfx)
typeof(fieldvals) %apfx%(fieldvals le,unsigned c) := transform
  self.infield := le.infield[1..c];
  SELF := le;
  end;
	
#uniquename(n)
%n% := distributed(normalize(fieldvals,length(trim(left.infield)),%apfx%(left,counter))(infield<>''),ufield);	
#uniquename(possvals)
%possvals% := dedup(fieldvals,infield,all);
#uniquename(n0)
%n0% := JOIN(%n%,%possvals%,LEFT.infield=RIGHT.infield,TRANSFORM(LEFT),LOOKUP); // Don't create genuinely new values 
sout := dedup(sort(%n0%,infield,ufield,local),infield,ufield,local);
  ENDMACRO;
