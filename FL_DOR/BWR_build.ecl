export BWR_build (pVersion='default',isFirstBuild='flase') := MACRO

#workunit('name','FL DOR Addresses ' + pVersion);

DoBuild := FL_DOR.Build_All(pVersion,isFirstBuild);

SampleRecs := if(isFirstBuild,choosen(sample(FL_DOR.Files.Base,1000,1),1000),choosen(sample(FL_DOR.Files.Base,10,1),500));
					
sequential(
			DoBuild
			,output(SampleRecs,named('File_Sample'))
			)
			: success(FL_DOR.Send_Email(pVersion).Build_Success)
			, failure(FL_DOR.Send_Email(pVersion).Build_Failure)
			;

 endmacro
 ;