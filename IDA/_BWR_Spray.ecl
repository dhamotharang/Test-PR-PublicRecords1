import std,IDA;

EXPORT _BWR_Spray(string pversion='',boolean pUseProd=false) := FUNCTION

version:=if(pversion='',(string8)std.date.today(),pversion):INDEPENDENT;

return IDA.fSpray(version,pUseProd)._spray;

end;


