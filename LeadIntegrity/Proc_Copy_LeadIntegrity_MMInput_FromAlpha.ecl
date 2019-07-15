EXPORT Proc_Copy_LeadIntegrity_MMInput_FromAlpha(Version,dali='Prod',ProcToRun=1) := FUNCTIONMACRO

import std,_control, LeadIntegrity.Constants;

//******************************************************************************************************************
//**                                Copy Lead Integrity Input Data from Alpha Dev to Boca
// Copy(const varstring sourceLogicalName, const varstring destinationGroup, const varstring destinationLogicalName, const varstring sourceDali='', integer4 timeOut=-1, const varstring espServerIpPort=GETENV('ws_fs_server'), integer4 maxConnections=-1, boolean allowoverwrite=false, boolean replicate=false, boolean asSuperfile=false, boolean compress=false, boolean forcePush=false, integer4 transferBufferSize=0, boolean preserveCompression=true) : c,action,context,entrypoint='fsCopy_v2'; 
//******************************************************************************************************************

destGrp 		:= _Control.TargetGroup.Thor400_44;
sourceDali 	:= if (dali = 'Dev',_Control.IPAddress.adataland_dali, _Control.IPAddress.aprod_thor_dali);


srce01_of_15 				:= '~in::marketmagnifier' + LeadIntegrity.Constants.ExtraPrefix + '::leadintegrity::' + Version + '_01_of_15';
srce02_of_15 				:= '~in::marketmagnifier' + LeadIntegrity.Constants.ExtraPrefix + '::leadintegrity::' + Version + '_02_of_15';
srce03_of_15 				:= '~in::marketmagnifier' + LeadIntegrity.Constants.ExtraPrefix + '::leadintegrity::' + Version + '_03_of_15';
srce04_of_15 				:= '~in::marketmagnifier' + LeadIntegrity.Constants.ExtraPrefix + '::leadintegrity::' + Version + '_04_of_15';
srce05_of_15 				:= '~in::marketmagnifier' + LeadIntegrity.Constants.ExtraPrefix + '::leadintegrity::' + Version + '_05_of_15';
srce06_of_15 				:= '~in::marketmagnifier' + LeadIntegrity.Constants.ExtraPrefix + '::leadintegrity::' + Version + '_06_of_15';
srce07_of_15 				:= '~in::marketmagnifier' + LeadIntegrity.Constants.ExtraPrefix + '::leadintegrity::' + Version + '_07_of_15';
srce08_of_15 				:= '~in::marketmagnifier' + LeadIntegrity.Constants.ExtraPrefix + '::leadintegrity::' + Version + '_08_of_15';
srce09_of_15 				:= '~in::marketmagnifier' + LeadIntegrity.Constants.ExtraPrefix + '::leadintegrity::' + Version + '_09_of_15';
srce10_of_15 				:= '~in::marketmagnifier' + LeadIntegrity.Constants.ExtraPrefix + '::leadintegrity::' + Version + '_10_of_15';
srce11_of_15 				:= '~in::marketmagnifier' + LeadIntegrity.Constants.ExtraPrefix + '::leadintegrity::' + Version + '_11_of_15';
srce12_of_15 				:= '~in::marketmagnifier' + LeadIntegrity.Constants.ExtraPrefix + '::leadintegrity::' + Version + '_12_of_15';
srce13_of_15 				:= '~in::marketmagnifier' + LeadIntegrity.Constants.ExtraPrefix + '::leadintegrity::' + Version + '_13_of_15';
srce14_of_15 				:= '~in::marketmagnifier' + LeadIntegrity.Constants.ExtraPrefix + '::leadintegrity::' + Version + '_14_of_15';
srce15_of_15 				:= '~in::marketmagnifier' + LeadIntegrity.Constants.ExtraPrefix + '::leadintegrity::' + Version + '_15_of_15';



 local copy01_of_15 := fileservices.Copy(srce01_of_15,destGrp,srce01_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
 local copy02_of_15 := fileservices.Copy(srce02_of_15,destGrp,srce02_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
 local copy03_of_15 := fileservices.Copy(srce03_of_15,destGrp,srce03_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
 local copy04_of_15 := fileservices.Copy(srce04_of_15,destGrp,srce04_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
 local copy05_of_15 := fileservices.Copy(srce05_of_15,destGrp,srce05_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
 local copy06_of_15 := fileservices.Copy(srce06_of_15,destGrp,srce06_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
 local copy07_of_15 := fileservices.Copy(srce07_of_15,destGrp,srce07_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
 local copy08_of_15 := fileservices.Copy(srce08_of_15,destGrp,srce08_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
 local copy09_of_15 := fileservices.Copy(srce09_of_15,destGrp,srce09_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
 local copy10_of_15 := fileservices.Copy(srce10_of_15,destGrp,srce10_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
 local copy11_of_15 := fileservices.Copy(srce11_of_15,destGrp,srce11_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
 local copy12_of_15 := fileservices.Copy(srce12_of_15,destGrp,srce12_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
 local copy13_of_15 := fileservices.Copy(srce13_of_15,destGrp,srce13_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
 local copy14_of_15 := fileservices.Copy(srce14_of_15,destGrp,srce14_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
 local copy15_of_15 := fileservices.Copy(srce15_of_15,destGrp,srce15_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
								 
#IF (ProcToRun = 1)
local mycopy := SEQUENTIAL(copy01_of_15,copy02_of_15,copy03_of_15,copy04_of_15,copy05_of_15
										      ,copy06_of_15,copy07_of_15,copy08_of_15,copy09_of_15,copy10_of_15
											    ,copy11_of_15,copy12_of_15,copy13_of_15,copy14_of_15,copy15_of_15
												  );
#ELSEIF (ProcToRun = 2)			
local mycopy := SEQUENTIAL(copy02_of_15,copy03_of_15,copy04_of_15,copy05_of_15
										      ,copy06_of_15,copy07_of_15,copy08_of_15,copy09_of_15,copy10_of_15
											    ,copy11_of_15,copy12_of_15,copy13_of_15,copy14_of_15,copy15_of_15
												  );
#ELSEIF (ProcToRun = 3)			
local mycopy := SEQUENTIAL(copy03_of_15,copy04_of_15,copy05_of_15
										      ,copy06_of_15,copy07_of_15,copy08_of_15,copy09_of_15,copy10_of_15
											    ,copy11_of_15,copy12_of_15,copy13_of_15,copy14_of_15,copy15_of_15
												  );													
#ELSEIF (ProcToRun = 4)			
local mycopy := SEQUENTIAL(copy04_of_15,copy05_of_15
										      ,copy06_of_15,copy07_of_15,copy08_of_15,copy09_of_15,copy10_of_15
											    ,copy11_of_15,copy12_of_15,copy13_of_15,copy14_of_15,copy15_of_15
												  );													
#ELSEIF (ProcToRun = 5)			
local mycopy := SEQUENTIAL(copy05_of_15
										      ,copy06_of_15,copy07_of_15,copy08_of_15,copy09_of_15,copy10_of_15
											    ,copy11_of_15,copy12_of_15,copy13_of_15,copy14_of_15,copy15_of_15
												  );																										
#ELSEIF (ProcToRun = 6)			
local mycopy := SEQUENTIAL(copy06_of_15,copy07_of_15,copy08_of_15,copy09_of_15,copy10_of_15
											    ,copy11_of_15,copy12_of_15,copy13_of_15,copy14_of_15,copy15_of_15
												  );													
#ELSEIF (ProcToRun = 7)			
local mycopy := SEQUENTIAL(copy07_of_15,copy08_of_15,copy09_of_15,copy10_of_15
											    ,copy11_of_15,copy12_of_15,copy13_of_15,copy14_of_15,copy15_of_15
												  );													
#ELSEIF (ProcToRun = 8)			
local mycopy := SEQUENTIAL(copy08_of_15,copy09_of_15,copy10_of_15
											    ,copy11_of_15,copy12_of_15,copy13_of_15,copy14_of_15,copy15_of_15
												  );													
#ELSEIF (ProcToRun = 9)			
local mycopy := SEQUENTIAL(copy09_of_15,copy10_of_15
											    ,copy11_of_15,copy12_of_15,copy13_of_15,copy14_of_15,copy15_of_15
												  );													
#ELSEIF (ProcToRun = 10)			
local mycopy := SEQUENTIAL(copy10_of_15
											    ,copy11_of_15,copy12_of_15,copy13_of_15,copy14_of_15,copy15_of_15
												  );													
#ELSEIF (ProcToRun = 11)			
local mycopy := SEQUENTIAL(copy11_of_15,copy12_of_15,copy13_of_15,copy14_of_15,copy15_of_15);													
#ELSEIF (ProcToRun = 12)			
local mycopy := SEQUENTIAL(copy12_of_15,copy13_of_15,copy14_of_15,copy15_of_15);													
#ELSEIF (ProcToRun = 13)			
local mycopy := SEQUENTIAL(copy13_of_15,copy14_of_15,copy15_of_15);													
#ELSEIF (ProcToRun = 14)			
local mycopy := SEQUENTIAL(copy14_of_15,copy15_of_15);													
#ELSEIF (ProcToRun = 15)			
local mycopy := SEQUENTIAL(copy15_of_15 );	
#ELSE 
	  ERROR('LeadIntegrity.Proc_Copy_LeadIntegrity_MMInput_FromAlpha - Invalid Parm for ProcToRun');
#END					 												
																										
Return mycopy;

ENDMACRO;