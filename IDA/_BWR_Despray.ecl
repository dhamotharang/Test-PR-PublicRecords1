import std;

EXPORT _BWR_Despray(string pversion='',boolean pUseProd=false) := function

version:=if(pversion='',IDA._Constants(pUseProd).filesdate,pversion);

BuiltDespray:=IDA._Despray(version,pUseProd);

Despray:=STD.File.DeSpray('~thor_data400::out::ida::despray::built',IDA._Constants(pUseProd).Source_IP,IDA._Constants(pUseProd).despray_path + IDA._Constants(pUseProd).despray_filename);

seq:=SEQUENTIAL(BuiltDespray,Despray): success(IDA.Send_Email(version,pUseProd).DespraySuccess), failure(IDA.send_email(version,pUseProd).DesprayFailure);

return seq;

end;
