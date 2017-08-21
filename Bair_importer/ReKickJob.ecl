import VersionControl, _control, Bair, STD;

export ReKickJob(				
					string pBuildName,
					string pBuildVersion,
					string pLandingZone,
					string pPreppedAgencyBuildVersion,
					string pReceivings,
					string pDaliServer = _control.IPAddress.bair_batchlz01,
					string pFailMessage = ''
					 ) := MODULE
   
	ReceivingsS := STD.STR.SplitWords(pReceivings,' ');
	shared ReceivingsD := Dataset(ReceivingsS,{string ReceivingID});
	
	export BuildSuccess		:= sequential(
						APPLY(
							ReceivingsD, 
							Bair.Orbit_Update.UpdatePrepBuildStatus(
								pBuildName,
								pBuildVersion, 
								'REFORMATTED', 	
								trim(ReceivingID,left,right),	
								pPreppedAgencyBuildVersion)),
						Bair.Orbit_Update.pushLastBuildManifest(pBuildName, pPreppedAgencyBuildVersion, pBuildVersion),		
						bair_importer.fFileMoves(pDaliServer,
							pLandingZone,
							pBuildVersion).MoveSprayingToDone,
						Bair_Importer.CleanUp.MoveInputFilesToHistory(pBuildVersion),	
					);
	
	export BuildFailure		:= sequential(
						Send_Email(pBuildName, 
							pBuildVersion,
							pLandingZone,
							pFailMessage).BuildFailure,
						APPLY(ReceivingsD, 
							Bair.Orbit_Update.UpdatePrepBuildStatus(
								pBuildName,
								pBuildVersion, 
								'FAILED', 	
								trim(ReceivingID,left,right),	
								pPreppedAgencyBuildVersion)),
						bair_importer.fFileMoves(
							pDaliServer,
							pLandingZone,
							pBuildVersion).MoveSprayingToError,
						Bair_Importer.CleanUp.MoveInputFilesToHistory(
							pBuildVersion),
					);
END;

