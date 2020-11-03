EXPORT Proc_Copy_ProfileBooster_FromAlpha(Version,dali='Prod',ProcToRun=1) := FUNCTIONMACRO
import std,_Control, ProfileBooster.Constants;

//******************************************************************************************************************
//**                                Copy Profile Booster Data from Alpa to Boca
// Copy(const varstring sourceLogicalName, const varstring destinationGroup, const varstring destinationLogicalName, const varstring sourceDali='', integer4 timeOut=-1, const varstring espServerIpPort=GETENV('ws_fs_server'), integer4 maxConnections=-1, boolean allowoverwrite=false, boolean replicate=false, boolean asSuperfile=false, boolean compress=false, boolean forcePush=false, integer4 transferBufferSize=0, boolean preserveCompression=true) : c,action,context,entrypoint='fsCopy_v2';
//******************************************************************************************************************

destGrp           := _Control.TargetGroup.Thor400_44;
sourceDali   := if (dali = 'Dev',_Control.IPAddress.adataland_dali, _Control.IPAddress.aprod_thor_dali);
pbcpy_semail := Fileservices.Sendemail(ProfileBooster.Constants.QC_email_target , 'ProfileBooster Copies: ' + Version, 'ProfileBooster Copies have started for version: ' + Version,,,'ProfileBooster@lexisnexisrisk.com');

pbsrce01_of_05 := ProfileBooster.Files.MMdain + Version + '_01_of_05';
pbsrce02_of_05 := ProfileBooster.Files.MMdain + Version + '_02_of_05';
pbsrce03_of_05 := ProfileBooster.Files.MMdain + Version + '_03_of_05';
pbsrce04_of_05 := ProfileBooster.Files.MMdain + Version + '_04_of_05';
pbsrce05_of_05 := ProfileBooster.Files.MMdain + Version + '_05_of_05';


local pbcopy01_of_05 := fileservices.Copy(pbsrce01_of_05,destGrp,pbsrce01_of_05,sourceDali,-1,,-1,true,true,false,true,,,true);
local pbcopy02_of_05 := fileservices.Copy(pbsrce02_of_05,destGrp,pbsrce02_of_05,sourceDali,-1,,-1,true,true,false,true,,,true);
local pbcopy03_of_05 := fileservices.Copy(pbsrce03_of_05,destGrp,pbsrce03_of_05,sourceDali,-1,,-1,true,true,false,true,,,true);
local pbcopy04_of_05 := fileservices.Copy(pbsrce04_of_05,destGrp,pbsrce04_of_05,sourceDali,-1,,-1,true,true,false,true,,,true);
local pbcopy05_of_05 := fileservices.Copy(pbsrce05_of_05,destGrp,pbsrce05_of_05,sourceDali,-1,,-1,true,true,false,true,,,true);


local pbkeys         := ProfileBooster.Proc_Transfer_Needed_Keys();

#IF (ProcToRun = 1)
local mypbcopy := SEQUENTIAL(pbcopy01_of_05,pbcopy02_of_05,pbcopy03_of_05,pbcopy04_of_05,pbcopy05_of_05
                            ,pbcpy_semail,pbkeys);
#ELSEIF (ProcToRun = 2)
local mypbcopy := SEQUENTIAL(pbcopy02_of_05,pbcopy03_of_05,pbcopy04_of_05,pbcopy05_of_05
                            ,pbcpy_semail,pbkeys);
#ELSEIF (ProcToRun = 3)
local mypbcopy := SEQUENTIAL(pbcopy03_of_05,pbcopy04_of_05,pbcopy05_of_05
                            ,pbcpy_semail,pbkeys);
#ELSEIF (ProcToRun = 4)
local mypbcopy := SEQUENTIAL(pbcopy04_of_05,pbcopy05_of_05
                            ,pbcpy_semail,pbkeys);
#ELSEIF (ProcToRun = 5)
local mypbcopy := SEQUENTIAL(pbcopy05_of_05
                            ,pbcpy_semail,pbkeys);
#ELSEIF (ProcToRun = 6)
local mypbcopy := SEQUENTIAL(pbcpy_semail,pbkeys);
#ELSEIF (ProcToRun = 99)
local mypbcopy := SEQUENTIAL(pbcopy01_of_05,pbcopy02_of_05,pbcopy03_of_05,pbcopy04_of_05,pbcopy05_of_05);
#ELSE
local mypbcopy := output(ERROR('LeadIntegrity.Proc_Copy_LeadIntegrity_MMInput_FromAlpha - Invalid Parm for ProcToRun'));
#END

Return mypbcopy;

ENDMACRO;