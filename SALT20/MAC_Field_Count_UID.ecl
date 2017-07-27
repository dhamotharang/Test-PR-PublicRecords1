export MAC_Field_Count_UID(fieldvals,infield,sout) := MACRO
/*
#uniquename(r)
%r% := record
  fieldvals.infield;
	unsigned8 cnt := count(group);
  end;
	
sout := table(fieldvals,%r%,infield,merge); // uses new thor feature
*/
// Old School Approach
#uniquename(r)
%r% := record
  fieldvals.infield;
	unsigned8 cnt := count(group);
  end;
#uniquename(t)		
shared %t% := table(fieldvals,%r%,infield,local); // first count infield values locally
#uniquename(r0)
shared %r0% := record
  %t%.infield;
	unsigned8 cnt := sum(group,%t%.cnt);
  end;
#uniquename(t00)
#uniquename(t01)
sout := table(%t%,%r0%,infield); // then count them globally, two stage process to avoid skew
  ENDMACRO;
