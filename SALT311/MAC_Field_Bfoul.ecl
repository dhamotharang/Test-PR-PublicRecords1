export MAC_Field_Bfoul(infile,infield,ufield,null_values,ClSize,add_initials,hyphenate,bfoul) := MACRO
#uniquename(s_nonull0)
//%s_nonull0% := join(infile,null_values,left.infield=right.infield,transform(left),left only,lookup);
%s_nonull0% := infile(infield NOT IN SET(null_values,infield));
#uniquename(s_singles)
%s_singles% := join(%s_nonull0%,ClSize(InCluster>1),left.ufield=right.ufield,transform(left),local);
#uniquename(r1)
%r1% := record
	unsigned8 cnt := count(group);
  end;
#uniquename(t1)		
#if(add_initials or hyphenate)
%t1% := table(dedup(sort(%s_singles%,ufield,-infield,local),left.ufield=right.ufield and left.infield[1..length(trim(right.infield))]=right.infield,local),%r1%,ufield,local);
#else
%t1% := table(%s_singles%,%r1%,ufield,local);
#end
bfoul := if(count(%t1%)=0,0,count(%t1%(cnt>1)) / count(%t1%));
  ENDMACRO;
