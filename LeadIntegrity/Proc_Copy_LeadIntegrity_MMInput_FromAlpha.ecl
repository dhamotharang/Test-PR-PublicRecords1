EXPORT Proc_Copy_LeadIntegrity_MMInput_FromAlpha(Version,dali='Prod',ProcToRun=1) := FUNCTIONMACRO

import std,_control, LeadIntegrity.Constants;

//******************************************************************************************************************
//**                                Copy Lead Integrity Input Data from Alpha Dev to Boca
// Copy(const varstring sourceLogicalName, const varstring destinationGroup, const varstring destinationLogicalName, const varstring sourceDali='', integer4 timeOut=-1, const varstring espServerIpPort=GETENV('ws_fs_server'), integer4 maxConnections=-1, boolean allowoverwrite=false, boolean replicate=false, boolean asSuperfile=false, boolean compress=false, boolean forcePush=false, integer4 transferBufferSize=0, boolean preserveCompression=true) : c,action,context,entrypoint='fsCopy_v2';
//******************************************************************************************************************

destGrp         := _Control.TargetGroup.Thor400_44;
sourceDali  := if (dali = 'Dev',_Control.IPAddress.adataland_dali, _Control.IPAddress.aprod_thor_dali);

    srce01_of_05       := '~in::marketmagnifier' + LeadIntegrity.Constants.ExtraPrefix + '::leadintegrity::' + Version + '_01_of_05';
    srce02_of_05       := '~in::marketmagnifier' + LeadIntegrity.Constants.ExtraPrefix + '::leadintegrity::' + Version + '_02_of_05';
    srce03_of_05       := '~in::marketmagnifier' + LeadIntegrity.Constants.ExtraPrefix + '::leadintegrity::' + Version + '_03_of_05';
    srce04_of_05       := '~in::marketmagnifier' + LeadIntegrity.Constants.ExtraPrefix + '::leadintegrity::' + Version + '_04_of_05';
    srce05_of_05       := '~in::marketmagnifier' + LeadIntegrity.Constants.ExtraPrefix + '::leadintegrity::' + Version + '_05_of_05';

    local copy01_of_05 := fileservices.Copy(srce01_of_05,destGrp,srce01_of_05,sourceDali,-1,,-1,true,true,false,true,,,true);
    local copy02_of_05 := fileservices.Copy(srce02_of_05,destGrp,srce02_of_05,sourceDali,-1,,-1,true,true,false,true,,,true);
    local copy03_of_05 := fileservices.Copy(srce03_of_05,destGrp,srce03_of_05,sourceDali,-1,,-1,true,true,false,true,,,true);
    local copy04_of_05 := fileservices.Copy(srce04_of_05,destGrp,srce04_of_05,sourceDali,-1,,-1,true,true,false,true,,,true);
    local copy05_of_05 := fileservices.Copy(srce05_of_05,destGrp,srce05_of_05,sourceDali,-1,,-1,true,true,false,true,,,true);


#IF (ProcToRun = 1)
local mycopy := SEQUENTIAL(copy01_of_05,copy02_of_05,copy03_of_05,copy04_of_05,copy05_of_05);
#ELSEIF (ProcToRun = 2)
local mycopy := SEQUENTIAL(copy02_of_05,copy03_of_05,copy04_of_05,copy05_of_05);
#ELSEIF (ProcToRun = 3)
local mycopy := SEQUENTIAL(copy03_of_05,copy04_of_05,copy05_of_05);
#ELSEIF (ProcToRun = 4)
local mycopy := SEQUENTIAL(copy04_of_05,copy05_of_05);
#ELSEIF (ProcToRun = 5)
local mycopy := copy05_of_05;
#ELSE
      mycopy := output(ERROR('LeadIntegrity.Proc_Copy_LeadIntegrity_MMInput_FromAlpha - Invalid Parm for ProcToRun'));
#END

Return mycopy;

ENDMACRO;