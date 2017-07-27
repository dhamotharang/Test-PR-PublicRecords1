import advo;

export BWR_Build_Advo (version) := MACRO

#workunit('name','Advo ' + version);

DoBuild := Advo.Build_All(version);

SampleRecs := choosen(sort(Advo.Files.File_Cleaned_Base,record),1000);
					
sequential(
			//Advo.Spray_Input
			//,
			DoBuild
			,output(SampleRecs)
			)
			: success(Advo.Send_Email(Version).Build_Success)
			, failure(Advo.Send_Email(Version).Build_Failure)
			;

 endmacro
 ;