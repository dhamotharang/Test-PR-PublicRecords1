export BWR_build_TN (version) := MACRO

#IF (TransunionCred.IsFullUpdate = false)
#workunit('protect',true);
#workunit('name','TransunionCred update ' + version);
#ELSE
#workunit('name','TransunionCred load ' + version);
#END
#workunit('priority','high');
#option('AllowedClusters','thor400_44_eclcc');
//#option('AllowAutoQueueSwitch',TRUE);
//#option ('activitiesPerCpp', 50);
#option('multiplePersistInstances',FALSE);
import std;


DoBuild := TransunionCred.Build_All(version);

SampleRecs := choosen(sort(TransunionCred.Files.Base,record),1000);
					
sequential(
			DoBuild
			,output(SampleRecs)
			,Orbit3.Proc_Orbit3_CreateBuild_npf(version,'TransunionCred')
			,Orbit3.proc_Orbit3_CreateBuild_AddItem ( 'TransunionCred',version,'N',runaddcomponentsonly := true)
			,_control.fSubmitNewWorkunit('#workunit(\'name\',\'Scrubs_Transunion_Monthly\');\r\n'+
																	'Scrubs_Transunion_Monthly.proc_generate_report();',std.system.job.target())
			)
			 :  success(TransunionCred.Send_Email(Version).Build_Success)
			 ,  failure(TransunionCred.Send_Email(Version).Build_Failure)
			;

 endmacro
 ;