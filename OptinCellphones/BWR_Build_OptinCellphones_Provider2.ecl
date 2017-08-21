export BWR_Build_OptinCellphones_Provider2 (version) := MACRO

#workunit('name','OptinCellphones_Build ' + version);

DoBuild := Build_Provider2(version);

SampleRecs := choosen(sort(Files.Base_File_Out,record),1000);
					
sequential(
			DoBuild
			,output(SampleRecs)
			)
			: success(Send_Email(Version).Build_Success)
			, failure(Send_Email(Version).Build_Failure)
			;

 endmacro
 ;