export BWR_Build_ExperianIRSG (version) := MACRO

#workunit('name','ExperianIRSG_Build ' + version);

DoBuild := ExperianIRSG_Build.Build_All(version);

SampleRecs := choosen(sort(ExperianIRSG_Build.Files.Base_File_Out,record),1000);
					
sequential(
			DoBuild
			,output(SampleRecs)
			)
			: success(ExperianIRSG_Build.Send_Email(Version).Build_Success)
			, failure(ExperianIRSG_Build.Send_Email(Version).Build_Failure)
			;

 endmacro
 ;