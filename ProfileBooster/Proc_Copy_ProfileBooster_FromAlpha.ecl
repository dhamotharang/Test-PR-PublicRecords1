EXPORT Proc_Copy_ProfileBooster_FromAlpha(Version,dali='Prod',ProcToRun=1) := FUNCTIONMACRO
import std,_Control, ProfileBooster.Constants;

//******************************************************************************************************************
//**                                Copy Profile Booster Data from Alpa to Boca
// Copy(const varstring sourceLogicalName, const varstring destinationGroup, const varstring destinationLogicalName, const varstring sourceDali='', integer4 timeOut=-1, const varstring espServerIpPort=GETENV('ws_fs_server'), integer4 maxConnections=-1, boolean allowoverwrite=false, boolean replicate=false, boolean asSuperfile=false, boolean compress=false, boolean forcePush=false, integer4 transferBufferSize=0, boolean preserveCompression=true) : c,action,context,entrypoint='fsCopy_v2'; 
//******************************************************************************************************************

destGrp 		  := _Control.TargetGroup.Thor400_44;
sourceDali 	:= if (dali = 'Dev',_Control.IPAddress.adataland_dali, _Control.IPAddress.aprod_thor_dali);

pbsrce01_of_15 := ProfileBooster.Files.MMdain + Version + '_01_of_15';
pbsrce02_of_15 := ProfileBooster.Files.MMdain + Version + '_02_of_15';
pbsrce03_of_15 := ProfileBooster.Files.MMdain + Version + '_03_of_15';
pbsrce04_of_15 := ProfileBooster.Files.MMdain + Version + '_04_of_15';
pbsrce05_of_15 := ProfileBooster.Files.MMdain + Version + '_05_of_15';
pbsrce06_of_15 := ProfileBooster.Files.MMdain + Version + '_06_of_15';
pbsrce07_of_15 := ProfileBooster.Files.MMdain + Version + '_07_of_15';
pbsrce08_of_15 := ProfileBooster.Files.MMdain + Version + '_08_of_15';
pbsrce09_of_15 := ProfileBooster.Files.MMdain + Version + '_09_of_15';
pbsrce10_of_15 := ProfileBooster.Files.MMdain + Version + '_10_of_15';
pbsrce11_of_15 := ProfileBooster.Files.MMdain + Version + '_11_of_15';
pbsrce12_of_15 := ProfileBooster.Files.MMdain + Version + '_12_of_15';
pbsrce13_of_15 := ProfileBooster.Files.MMdain + Version + '_13_of_15';
pbsrce14_of_15 := ProfileBooster.Files.MMdain + Version + '_14_of_15';
pbsrce15_of_15 := ProfileBooster.Files.MMdain + Version + '_15_of_15';

local pbcopy01_of_15 := fileservices.Copy(pbsrce01_of_15,destGrp,pbsrce01_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
local pbcopy02_of_15 := fileservices.Copy(pbsrce02_of_15,destGrp,pbsrce02_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
local pbcopy03_of_15 := fileservices.Copy(pbsrce03_of_15,destGrp,pbsrce03_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
local pbcopy04_of_15 := fileservices.Copy(pbsrce04_of_15,destGrp,pbsrce04_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
local pbcopy05_of_15 := fileservices.Copy(pbsrce05_of_15,destGrp,pbsrce05_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
local pbcopy06_of_15 := fileservices.Copy(pbsrce06_of_15,destGrp,pbsrce06_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
local pbcopy07_of_15 := fileservices.Copy(pbsrce07_of_15,destGrp,pbsrce07_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
local pbcopy08_of_15 := fileservices.Copy(pbsrce08_of_15,destGrp,pbsrce08_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
local pbcopy09_of_15 := fileservices.Copy(pbsrce09_of_15,destGrp,pbsrce09_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
local pbcopy10_of_15 := fileservices.Copy(pbsrce10_of_15,destGrp,pbsrce10_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
local pbcopy11_of_15 := fileservices.Copy(pbsrce11_of_15,destGrp,pbsrce11_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
local pbcopy12_of_15 := fileservices.Copy(pbsrce12_of_15,destGrp,pbsrce12_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
local pbcopy13_of_15 := fileservices.Copy(pbsrce13_of_15,destGrp,pbsrce13_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
local pbcopy14_of_15 := fileservices.Copy(pbsrce14_of_15,destGrp,pbsrce14_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);
local pbcopy15_of_15 := fileservices.Copy(pbsrce15_of_15,destGrp,pbsrce15_of_15,sourceDali,-1,,-1,true,true,false,true,,,true);

local pbkeys         := ProfileBooster.Proc_Transfer_Needed_Keys();

#IF (ProcToRun = 1)
local mypbcopy := SEQUENTIAL(pbcopy01_of_15,pbcopy02_of_15,pbcopy03_of_15,pbcopy04_of_15,pbcopy05_of_15
																							  		 ,pbcopy06_of_15,pbcopy07_of_15,pbcopy08_of_15,pbcopy09_of_15,pbcopy10_of_15
																								  	 ,pbcopy11_of_15,pbcopy12_of_15,pbcopy13_of_15,pbcopy14_of_15,pbcopy15_of_15
																										  ,pbkeys
																									  	);
#ELSEIF (ProcToRun = 2)			
local mypbcopy := SEQUENTIAL(pbcopy02_of_15,pbcopy03_of_15,pbcopy04_of_15,pbcopy05_of_15
																										  ,pbcopy06_of_15,pbcopy07_of_15,pbcopy08_of_15,pbcopy09_of_15,pbcopy10_of_15
																										  ,pbcopy11_of_15,pbcopy12_of_15,pbcopy13_of_15,pbcopy14_of_15,pbcopy15_of_15
																										  ,pbkeys																											
																									   );
#ELSEIF (ProcToRun = 3)			
local mypbcopy := SEQUENTIAL(pbcopy03_of_15,pbcopy04_of_15,pbcopy05_of_15
																										  ,pbcopy06_of_15,pbcopy07_of_15,pbcopy08_of_15,pbcopy09_of_15,pbcopy10_of_15
																										  ,pbcopy11_of_15,pbcopy12_of_15,pbcopy13_of_15,pbcopy14_of_15,pbcopy15_of_15
																										  ,pbkeys																											
																									   );
#ELSEIF (ProcToRun = 4)			
local mypbcopy := SEQUENTIAL(pbcopy04_of_15,pbcopy05_of_15
																										  ,pbcopy06_of_15,pbcopy07_of_15,pbcopy08_of_15,pbcopy09_of_15,pbcopy10_of_15
																										  ,pbcopy11_of_15,pbcopy12_of_15,pbcopy13_of_15,pbcopy14_of_15,pbcopy15_of_15
																										  ,pbkeys																											
																									   );
#ELSEIF (ProcToRun = 5)			
local mypbcopy := SEQUENTIAL(pbcopy05_of_15
																										  ,pbcopy06_of_15,pbcopy07_of_15,pbcopy08_of_15,pbcopy09_of_15,pbcopy10_of_15
																										  ,pbcopy11_of_15,pbcopy12_of_15,pbcopy13_of_15,pbcopy14_of_15,pbcopy15_of_15
																										  ,pbkeys																											
																									   );			
#ELSEIF (ProcToRun = 6)			
local mypbcopy := SEQUENTIAL(pbcopy06_of_15,pbcopy07_of_15,pbcopy08_of_15,pbcopy09_of_15,pbcopy10_of_15
																										  ,pbcopy11_of_15,pbcopy12_of_15,pbcopy13_of_15,pbcopy14_of_15,pbcopy15_of_15
																										  ,pbkeys																											
																									   );
#ELSEIF (ProcToRun = 7)			
local mypbcopy := SEQUENTIAL(pbcopy07_of_15,pbcopy08_of_15,pbcopy09_of_15,pbcopy10_of_15
																										  ,pbcopy11_of_15,pbcopy12_of_15,pbcopy13_of_15,pbcopy14_of_15,pbcopy15_of_15
																										  ,pbkeys																											
																									  );
#ELSEIF (ProcToRun = 8)			
local mypbcopy := SEQUENTIAL(pbcopy08_of_15,pbcopy09_of_15,pbcopy10_of_15
																										  ,pbcopy11_of_15,pbcopy12_of_15,pbcopy13_of_15,pbcopy14_of_15,pbcopy15_of_15
																										  ,pbkeys																											
																									  );
#ELSEIF (ProcToRun = 9)			
local mypbcopy := SEQUENTIAL(pbcopy09_of_15,pbcopy10_of_15
																										  ,pbcopy11_of_15,pbcopy12_of_15,pbcopy13_of_15,pbcopy14_of_15,pbcopy15_of_15
																										  ,pbkeys																											
																									   );
#ELSEIF (ProcToRun = 10)			
local mypbcopy := SEQUENTIAL(pbcopy10_of_15
																										  ,pbcopy11_of_15,pbcopy12_of_15,pbcopy13_of_15,pbcopy14_of_15,pbcopy15_of_15
																										  ,pbkeys	
																									   );
#ELSEIF (ProcToRun = 11)			
local mypbcopy := SEQUENTIAL(pbcopy11_of_15,pbcopy12_of_15,pbcopy13_of_15,pbcopy14_of_15,pbcopy15_of_15,pbkeys);													
#ELSEIF (ProcToRun = 12)			
local mypbcopy := SEQUENTIAL(pbcopy12_of_15,pbcopy13_of_15,pbcopy14_of_15,pbcopy15_of_15,pbkeys);													
#ELSEIF (ProcToRun = 13)			
local mypbcopy := SEQUENTIAL(pbcopy13_of_15,pbcopy14_of_15,pbcopy15_of_15,pbkeys);													
#ELSEIF (ProcToRun = 14)			
local mypbcopy := SEQUENTIAL(pbcopy14_of_15,pbcopy15_of_15,pbkeys);													
#ELSEIF (ProcToRun = 15)			
local mypbcopy := SEQUENTIAL(pbcopy15_of_15,pbkeys );	
#ELSEIF (ProcToRun = 16)			
local mypbcopy := SEQUENTIAL(pbkeys);	
#ELSEIF (ProcToRun = 99)			
local mypbcopy := SEQUENTIAL(pbcopy01_of_15,pbcopy02_of_15,pbcopy03_of_15,pbcopy04_of_15,pbcopy05_of_15
																							  		 ,pbcopy06_of_15,pbcopy07_of_15,pbcopy08_of_15,pbcopy09_of_15,pbcopy10_of_15
																								  	 ,pbcopy11_of_15,pbcopy12_of_15,pbcopy13_of_15,pbcopy14_of_15,pbcopy15_of_15
																										  );
#ELSE 
	  ERROR('LeadIntegrity.Proc_Copy_LeadIntegrity_MMInput_FromAlpha - Invalid Parm for ProcToRun');
#END					 												
																										
Return mypbcopy;

ENDMACRO;