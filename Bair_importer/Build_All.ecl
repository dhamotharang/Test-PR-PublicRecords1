IMPORT Bair, versioncontrol, _control, ut, tools, STD,lib_fileservices;
EXPORT Build_all( 
				STRING pFileType,
				STRING pBuildName,
				STRING pBuildVersion,
				STRING pLandingZone,
				STRING pFileExtension,
				STRING pAgency,
				STRING pPreppedAgencyBuildVersion,
				STRING pReprocess,
				STRING pReceivings,
				STRING pDaliServer = _control.IPAddress.bair_batchlz01,
				STRING pThorServer = 'thor40'		
			):= FUNCTION

			cntVersions := COUNT(nothor(STD.File.LogicalFileList('*thor_data400::in::bair::rdi*'+pBuildVersion+'*')));
			fileVersion := IF (cntVersions = 0, pBuildVersion, pBuildVersion+'_'+ (string)(cntVersions + 1) ) + '::' + pPreppedAgencyBuildVersion:INDEPENDENT;

			ReceivingsS := STD.STR.SplitWords(pReceivings,' ');
			ReceivingsD := Dataset(ReceivingsS,{string ReceivingID});
			
			
			
			built := SEQUENTIAL(
									output(ReceivingsD,named('Receivings')),
									if(pFileType = 'EVENT', SEQUENTIAL(Bair_Importer.Validate_Input.fn_GetMORecordID(true))),
									if(pFileType = 'EVENT', SEQUENTIAL(Bair_Importer.Validate_Input.fn_GetPersonRecordID(true))),										
									Bair.Orbit_Update.SetOrbitForPrepBuild (
										pBuildName, 
										pBuildVersion),									
									Bair_Importer.CleanUp.PrepareFiles(
										pDaliServer,
										pLandingZone,
										pBuildVersion,
										pReprocess),
									bair_importer.fun_Spray(
										Bair_Importer.fSpray( pBuildVersion,
																					fileVersion,
																					pDaliServer,
																					pLandingZone,
																					pThorServer,
																					pFileType,
																					pFileExtension
																			)),																											
									APPLY(ReceivingsD , 
										Bair.Orbit_Update.UpdatePrepBuildStatus (
											pBuildName,
											pBuildVersion,
											'SPRAYED',
											ReceivingID,
											pPreppedAgencyBuildVersion)),
									Bair_Importer.Build_Inputs(
															pBuildName,
															fileVersion,
															REGEXFIND('([0-9]+)',pBuildVersion,1),
															pAgency,
															pFileType,
															pFileExtension
													).Update_Daily_input,
									Bair_Importer.ReKickJob(pBuildName,pBuildVersion,pLandingZone,pPreppedAgencyBuildVersion,pReceivings).BuildSuccess				
								):FAILURE( Bair_Importer.ReKickJob(pBuildName,pBuildVersion,pLandingZone,pPreppedAgencyBuildVersion,pReceivings).BuildFailure);
									
			RETURN built;

END;

