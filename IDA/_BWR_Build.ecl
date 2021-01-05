import std;

EXPORT _BWR_Build(string pversion='',boolean pUseProd=false) := FUNCTION
version:=if(pversion='',IDA._Constants(pUseProd).filesdate,pversion);
RD:=STD.File.RemoteDirectory(IDA._Constants(pUseProd).Source_IP,IDA._Constants(pUseProd).spray_path);

return if((EXISTS(rd) and IDA._Flags().IDA_Daily_Base_Build_Active='' and IDA._Flags().IDA_Monthly_Base_Build_Active=''),IDA.Build_All(version,pUseProd).built,OUTPUT('THERE IS NO NEW FILES TO SPRAY OR DAILY OR MONTHLY BASE BUILD RUNNING'));

end;

