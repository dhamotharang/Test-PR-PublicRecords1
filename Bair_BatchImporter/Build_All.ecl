IMPORT versioncontrol, _control,Bair,wk_ut;
EXPORT Build_all(		
										STRING pBuildVersion  = '',
										STRING pDaliServer  = Bair._constant.bair_batchlz,
										STRING pLandingZone = '/data/batchimport/ready/',
										STRING pThorServer  = 'thor40'):= FUNCTION
		
		#stored('_Validate_Year_Range_Low'	,1900);
		#stored('_Validate_Year_Range_High'	,2099);	


		file_list	:=FileServices.RemoteDirectory(pDaliServer, pLandingZone, 'MANIFEST*'):independent;	
		file_list_f := file_list(regexfind('^MANIFEST_([0-9_]+)$',name));
		pVersion := if(pBuildVersion='',regexfind('([a-z_A-Z]+)_([0-9_]+)',file_list_f[1].name,2),pBuildVersion):independent;

		spray_list 	:= fSpray(pVersion);
		spray_  	 	:= VersionControl.fSprayInputFiles(spray_list, pIsTesting:= false);
		
		
		ECL_OrbitUpdate := 
					'#WORKUNIT(\'name\', \'Bair Orbit Update\');\n'
				+'oupdate := Bair.Orbit_update.SetOrbitForPrepBatch(\''+pVersion+'\',Bair_BatchImporter.filenames().lInputTemplateManifest+\'::'+pVersion+'\',\'built\');\n'
				+'oupdate;\n';
		
		built := SEQUENTIAL(
								CleanUp.PrepareFiles(pVersion),
								spray_,
								PARALLEL(
									build_inputs.build_events(pVersion),
									build_inputs.build_cfs(pVersion),
									build_inputs.build_crash(pVersion),
									build_inputs.build_lpr(pVersion),
									build_inputs.build_offenders(pVersion)),
								build_inputs.build_commons(pVersion),	
								Bair.Orbit_Update.pushLastBuildManifest('batch_importer_input_prep', pVersion, pVersion),
								fFileMoves(pVersion).MoveSprayingToDone,
								CleanUp.MoveInputFilesToHistory(pVersion),
							):FAILURE( PARALLEL(
									Send_Email(FAILMESSAGE).BuildFailure,
									fFileMoves(pVersion).MoveSprayingToError,
									CleanUp.MoveInputFilesToHistory(pVersion),				
								));
									
			RETURN if(pVersion!= '', built);

END;

