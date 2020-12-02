import std;

EXPORT _BWR_Despray(string pversion='',boolean pUseProd=false) := function

version:=if(pversion='',(string8)std.date.today(),pversion):INDEPENDENT;

BuiltDespray:=IDA._Despray(version,pUseProd);

Despray:=STD.File.DeSpray('~thor_data400::out::ida::despray::built',IDA._Constants(version,pUseProd).Source_IP,IDA._Constants(version,pUseProd).despray_path + IDA._Constants(version,pUseProd).despray_filename);

return SEQUENTIAL(BuiltDespray,Despray);

end;
