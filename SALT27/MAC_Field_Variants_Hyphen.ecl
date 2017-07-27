export MAC_Field_Variants_Hyphen(fieldvals,ufield,infield,sout) := MACRO
// For specificity scoring a fairly simple model of one must least or tail the other is allowed for
#uniquename(apfx)
typeof(fieldvals) %apfx%(fieldvals le,unsigned c) := transform
  self.infield := le.infield[1..c];
  self.ufield := le.ufield;
  end;
	
#uniquename(n)
%n% := distributed(normalize(fieldvals,length(trim(left.infield)),%apfx%(left,counter)),ufield);	
#uniquename(s1)
%s1% := dedup(sort(%n%,infield,ufield,local),infield,ufield,local);
#uniquename(apfx1)
typeof(fieldvals) %apfx1%(fieldvals le,unsigned c) := transform
  self.infield := le.infield[c+1..];
  self.ufield := le.ufield;
  end;
	
#uniquename(nr)
%nr% := distributed(normalize(fieldvals,IF(length(trim(left.infield))=0,0,length(trim(left.infield))-1),%apfx1%(left,counter)),ufield);	
#uniquename(sr1)
%sr1% := dedup(sort(%nr%,infield,ufield,local),infield,ufield,local);
sout := %s1%+%sr1%;
  ENDMACRO;
