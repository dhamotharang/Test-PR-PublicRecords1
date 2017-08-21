export BWR_Build_OptinCellphones (version) := MACRO

#workunit('name','OptinCellphones_Build ' + version);

DoBuild := OptinCellphones.Build_All(version);

SampleRecs := choosen(sort(OptinCellphones.Files.File_Base,record),1000);
					
sequential(
			DoBuild
			,output(SampleRecs)
			)
			: success(OptinCellphones.Send_Email(Version).Build_Success)
			, failure(OptinCellphones.Send_Email(Version).Build_Failure)
			;

 endmacro
 ;