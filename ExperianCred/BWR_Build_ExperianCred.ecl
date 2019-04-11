export BWR_Build_ExperianCred (version) := MACRO
#workunit('protect',true);
#workunit('name','Yogurt:ExperianCred ' + version);
#workunit('priority','high');
#workunit('priority',10);
#option ('activitiesPerCpp', 50);
//#OPTION('AllowedClusters','thor400_60,thor400_44);
//#OPTION('AllowAutoSwitchQueue','1');
#OPTION('multiplePersistInstances',FALSE);


IsFullUpdate := false;// need to determine the build type

DoBuild := ExperianCred.Build_All(version,IsFullUpdate);

SampleRecs := choosen(sort(ExperianCred.Files.Base_File_Out,record),1000);
					
sequential(
			DoBuild
			,output(SampleRecs)
			,Orbit3.Proc_Orbit3_CreateBuild_npf('Credit Header',version)
			,_control.fSubmitNewWorkunit('#workunit(\'name\',\'Scrubs_Experian_Monthly\');\r\n'+
																	'Scrubs_Experian_Monthly.proc_generate_report();','thor400_60')
			)
			: success(ExperianCred.Send_Email(Version).Build_Success)
			, failure(ExperianCred.Send_Email(Version).Build_Failure)
			;

 endmacro
 ;