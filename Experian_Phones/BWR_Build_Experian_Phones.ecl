export BWR_Build_Experian_Phones (version, incr_update) := MACRO

#workunit('name','Experian Index Phone ' + version);

DoBuild := Experian_Phones.Build_All(version,incr_update);

SampleRecs := choosen(sort(Experian_Phones.Files.Base,record),1000);

UpdateDops := Roxiekeybuild.updateversion('ExperianPhonesKeys',version, 'john.freibaum@lexisnexis.com,Angela.Herzberg@lexisnexis.com',,'N');
					
sequential(
			DoBuild, UpdateDops
		
			)
			: success(Experian_Phones.Send_Email(Version).Build_Success)
			, failure(Experian_Phones.Send_Email(Version).Build_Failure)
			;

 endmacro
 ;