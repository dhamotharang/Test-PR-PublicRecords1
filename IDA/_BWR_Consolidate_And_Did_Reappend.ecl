import std,ida;

EXPORT _BWR_Consolidate_And_Did_Reappend(string pversion='',boolean pUseProd=false) := function
version:=if(pversion='',IDA._Constants(pUseProd).filesdate,pversion);
return IDA.FN_Consolidate_And_Reappend_Did(pversion,pUseProd,false).All;

end;
