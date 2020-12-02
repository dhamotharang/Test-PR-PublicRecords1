import std;

EXPORT _BWR_Did_Reappend(string pversion='',boolean pUseProd=false, boolean pDaily=false) := function

version:=if(pversion='',(string8)std.date.today(),pversion):INDEPENDENT;

seq:=SEQUENTIAL(
IDA._FN_Did_Reappend (version,pUseProd,false).all
);

return seq;
end;
