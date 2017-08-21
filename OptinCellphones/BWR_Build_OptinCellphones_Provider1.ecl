export BWR_Build_OptinCellphones_Provider1 (version) := MACRO

#workunit('name','OptinCellphones_Build_Provider1 ' + version);

DoBuild := Build_Provider1(version);

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