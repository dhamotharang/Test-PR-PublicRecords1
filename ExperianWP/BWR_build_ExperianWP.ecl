import ExperianWP;

export BWR_Build_ExperianWP (version) := MACRO

#workunit('name','ExperianWP ' + version);

DoBuild := ExperianWP.Build_All(version);

SampleRecs := choosen(sort(ExperianWP.Files.File_Base,record),1000);
					
sequential(
			//Advo.Spray_Input
			//,
			DoBuild
			,output(SampleRecs)
			)
			: success(ExperianWP.Send_Email(Version).Build_Success)
			, failure(ExperianWP.Send_Email(Version).Build_Failure)
			;

 endmacro
 ;