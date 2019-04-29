export BWR_Build_ExperianCred (version) := MACRO
#workunit('protect',true);
#workunit('name','Yogurt:ExperianCred ' + version);
#workunit('priority','high');
#workunit('priority',10);

#OPTION('multiplePersistInstances',FALSE);


IsFullUpdate := false;// need to determine the build type

DoBuild := ExperianCred.Build_All(version,IsFullUpdate);

SampleRecs := choosen(sort(ExperianCred.Files.Base_File_Out,record),1000);
					
sequential(
			DoBuild
			,output(SampleRecs)
			,Orbit3.Proc_Orbit3_CreateBuild_npf('Credit Header',version)
			,_control.fSubmitNewWorkunit('#workunit(\'name\',\'Scrubs_Experian_Monthly\');\r\n'+
																	'Scrubs_Experian_Monthly.proc_generate_report();',std.system.job.target())
			)
			: success(ExperianCred.Send_Email(Version).Build_Success)
			, failure(ExperianCred.Send_Email(Version).Build_Failure)
			;

 endmacro
 ;