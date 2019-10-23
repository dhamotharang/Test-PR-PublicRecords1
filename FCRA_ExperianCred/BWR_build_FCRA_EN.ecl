export BWR_build_FCRA_EN (version) := MACRO

#stored ('_Validate_Year_Range_Low', '1800'); 
#stored ('_Validate_Year_Range_high', ut.GetDate[1..4]); 
#workunit('protect',true);
#IF (FCRA_ExperianCred.IsFullUpdate = false)
#workunit('name','Yogurt:FCRA_ExperianCred update ' + version);
#ELSE
#workunit('name','Yogurt:FCRA_ExperianCred load ' + version);
#END
#workunit('priority','high');
#option('AllowedClusters','thor400_44,thor400_60');
#OPTION('AllowAutoQueueSwitch',TRUE);
#OPTION('multiplePersistInstances',FALSE);

IsFullUpdate := false;// need to determine the build type
DoBuild := FCRA_ExperianCred.Build_All(version, IsFullUpdate);

SampleRecs := choosen(sample(FCRA_ExperianCred.Files.Base,1000,1),1000);
					
sequential(
			DoBuild
			,output(SampleRecs)
			,Orbit3.Proc_Orbit3_CreateBuild_npf('Credit Header FCRA Experian',version)
			)
			: success(FCRA_ExperianCred.Send_Email(Version).Build_Success)
			, failure(FCRA_ExperianCred.Send_Email(Version).Build_Failure)
			;

 endmacro
 ;