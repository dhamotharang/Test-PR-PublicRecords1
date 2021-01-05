import std;

EXPORT _BWR_Bases(string pversion='',boolean pUseProd=false) := function
version:=if(pversion='',IDA._Constants(pUseProd).filesdate,pversion);
seq:=SEQUENTIAL(
IDA.Build_Base(version,pUseProd,true).All,
);

return seq;


end;
