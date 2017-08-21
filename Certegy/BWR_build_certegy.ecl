#workunit('name', 'Certegy Build') ;

DoBuild := Certegy.Build_all(Certegy.version);

SampleRecs := choosen(sort(Certegy.Files.certegy_base,record),1000);
					
sequential(
			Certegy.SpryInput
			,DoBuild
			,output(SampleRecs)
			)
			: success(Certegy.Send_Email(Certegy.version).Build_Success)
			, failure(Certegy.Send_Email(Certegy.version).Build_Failure)
			;