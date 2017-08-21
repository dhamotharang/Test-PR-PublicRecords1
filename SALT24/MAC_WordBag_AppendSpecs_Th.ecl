export MAC_WordBag_AppendSpecs_Th(infile,instring,new_instring,keyname,keyfield,o) := MACRO
#uniquename(ifp)
%ifp% := record
  infile;
	unsigned tot_spec := 0;
	unsigned xxx_unc := 0;
  end;
// Need to add unique number to allow reeults to join back (REF may not be unique)	
import ut;
#uniquename(t)
%t% := table(infile,%ifp%);
#uniquename(nif)
ut.MAC_Sequence_Records(%t%,xxx_unc,%nif%)	
#uniquename(r)
%r% := record
  unsigned xxx_unc;
  unsigned2 pos;
  SALT24.Str4000Type s;
  end;
	
#uniquename(tr)
%r% %tr%(%nif% s_in, unsigned2 c) := transform
  self.pos := c;
	self.s := SALT24.GetNthWord(s_in.instring,c);
	self.xxx_unc := s_in.xxx_unc;
  end;
	
#uniquename(n)
// Split out the words for each wordbag
%n% := normalize(	%nif%, SALT24.WordCount(left.instring), %tr%(left,counter) );
#uniquename(r2)
%r2% := record(%r%)
  integer2 spec;
	end;
	
#uniquename(tr2)
%r2% %tr2%(%n% le, keyname ri) := transform
  self.spec := ri.field_specificity;
  self := le;
  end;	
// Words are now joined to their specificities
#uniquename(j)
%j% := join( %n%, keyname, left.s = right.keyfield, %tr2%(left,right), left outer );
#uniquename(addw)
%ifp% %addw%(%ifp% le, %j% ri) := transform
  self.new_instring := trim(le.new_instring)+' '+trim(ri.s)+' '+(SALT24.StrType)ri.spec;
	self.tot_spec := le.tot_spec + 100*ri.spec;
  self := le;
  end;
#uniquename(sf)
%sf% := denormalize(%nif%,sort(distribute(%j%,(xxx_unc-1)%thorlib.nodes()),xxx_unc,pos,local),left.xxx_unc=right.xxx_unc,%addw%(left,right),local);
#uniquename(sb)
typeof(infile) %sb%(%sf% le) := transform
  self.new_instring := IF(le.instring='','',(SALT24.StrType)le.tot_spec+le.new_instring); // Newstring has space pre-pended by %addw%
  self := le;
  end;
	
o := project(%sf%,%sb%(left));
  ENDMACRO;
