import std;

EXPORT _BWR_Build(string pversion='',boolean pUseProd=false) := FUNCTION
version:=if(pversion='',IDA._Constants(pUseProd).filesdate,pversion);
RD:=STD.File.RemoteDirectory(IDA._Constants(pUseProd).Source_IP,IDA._Constants(pUseProd).spray_path);

return if((IDA._Flags().IDA_Daily_Base_Build_Active='' and IDA._Flags().IDA_Monthly_Base_Build_Active=''),
       if(IDA._Flags().headerflag=TRUE, notify(IDA._CRON_ECL('IDA REAPPEND',false,false).EVENT_NAME, '*'),
       if(EXISTS(rd), IDA.Build_All(version,pUseProd).built,output('THERE IS NO NEW FILES TO SPRAY'))),
       OUTPUT('DAILY OR MONTHLY BASE BUILD STILL RUNNING'));

end;

