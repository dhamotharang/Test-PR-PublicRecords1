export BWR_build_TN (version) := MACRO

#IF (TransunionCred.IsFullUpdate = false)
#workunit('name','TransunionCred update ' + version);
#ELSE
#workunit('name','TransunionCred load ' + version);
#END

DoBuild := TransunionCred.Build_All(version);

SampleRecs := choosen(sort(TransunionCred.Files.Base,record),1000);
					
sequential(
			DoBuild
			,output(SampleRecs)
			)
			// : success(TransunionCred.Send_Email(Version).Build_Success)
			// , failure(TransunionCred.Send_Email(Version).Build_Failure)
			;

 endmacro
 ;