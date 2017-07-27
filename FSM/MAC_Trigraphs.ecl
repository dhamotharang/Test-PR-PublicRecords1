export MAC_Trigraphs(f,field,cnt_field,o) := macro

#uniquename(r)
%r% := record
  string3 s;
	unsigned4 weight;
	end;
	
#uniquename(tri)	
%r% %tri%(f le,unsigned cnt) := transform
  self.s := map ( length(trim(le.field))=1 => '_' + trim(le.field) + '_',
	                cnt = 1 => '_' + le.field[1..2],
									cnt = length(trim(le.field)) => le.field[cnt-1 .. cnt] + '_',
									le.field[cnt-1..cnt+1] );
  self.weight := le.cnt_field;									
  end;	

#uniquename(n)
%n% := normalize(f,length(trim(left.field)),%tri%(left,counter));
#uniquename(rt)
%rt% := record
  %n%.s;
	unsigned cnt := sum(group,%n%.weight);
	unsigned rcnt := 0;
	unsigned1 pcnt := 0;
  end;
	
#uniquename(sta)	
%sta% := sort(table(%n%,%rt%,s,few),cnt);
#uniquename(t)
%t% := sum(%sta%,cnt);

#uniquename(cum)
%rt% %cum%(%rt% le, %rt% ri) := transform
  self.rcnt := le.rcnt + ri.cnt;
	self.pcnt := 100 * self.rcnt / %t%;
  self := ri;
  end;
	
o := iterate(%sta%,%cum%(left,right));	


  endmacro;