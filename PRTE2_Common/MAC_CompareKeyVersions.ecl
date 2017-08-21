
EXPORT MAC_CompareKeyVersions (name,indx1,loc1,loc2) := MACRO
#uniquename(a)
#uniquename(b)
#uniquename(t)
#uniquename(ft)
  %a% := index(indx1,loc1);
  %b% := index(indx1,loc2);
	%t%:= table(%a%,{seq:='A',%a%}) + table(%b%,{seq:='B',%b%});
	%ft%:=table(%t%,{%t%,cnt:=count(group)},record, except seq, few);
	OUTPUT(count(%ft%(cnt=1,seq='A')),NAMED(name+'_AONLY'));
	OUTPUT(CHOOSEN((%ft%(cnt=1,seq='A')),600));
	OUTPUT(count(%ft%(cnt=1,seq='B')),NAMED(name+'_BONLY'));
	OUTPUT(CHOOSEN((%ft%(cnt=1,seq='B')),600));
ENDMACRO;

