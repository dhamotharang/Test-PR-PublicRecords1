EXPORT MAC_Field_Count_UID(fieldvals,infield,ufield,sout,tclusters) := MACRO
#uniquename(r)
%r% := RECORD
  fieldvals.infield;
	UNSIGNED8 cnt := count(group);
	UNSIGNED t_cnt := SUM(GROUP,fieldvals.cnt); // NAUGHTY - ASSUMES INPUTS CONSTRUCTED BY MAC_FIELD_BY_UID
  END;
	
sout := TABLE(fieldvals,%r%,infield,MERGE); // uses new thor feature
tclusters := COUNT( DEDUP( fieldvals, ufield, ALL ) );
  ENDMACRO;
// Old School Approach
/*#uniquename(r)
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
*/
