import std;

EXPORT _BWR_Build(string pversion='',boolean pUseProd=false) := FUNCTION

version:=if(pversion='',(string8)std.date.today(),pversion);

RD:=STD.File.RemoteDirectory(IDA._Constants(version,pUseProd).Source_IP,IDA._Constants(version,pUseProd).spray_path);

return if(EXISTS(rd),IDA.Build_All(version,pUseProd).built,OUTPUT('THERE IS NO NEW FILES TO SPRAY'));

end;

