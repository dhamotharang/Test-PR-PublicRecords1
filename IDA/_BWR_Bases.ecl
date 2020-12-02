import std;

EXPORT _BWR_Bases(string pversion='',boolean pUseProd=false) := function

version:=if(pversion='',(string8)std.date.today(),pversion):INDEPENDENT;

seq:=SEQUENTIAL(
IDA.Build_Base(version,pUseProd,true).All,
IDA.Build_Base(version,pUseProd,false).All
);

return seq;


end;
