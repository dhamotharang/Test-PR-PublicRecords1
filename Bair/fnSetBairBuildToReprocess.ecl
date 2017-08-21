IMPORT Bair, ut;

EXPORT fnSetBairBuildToReprocess (STRING buildVersionToReprocess) := FUNCTION

STRING36  	oLogin			 := Bair.Orbit_SOAPCalls.login.creds		: INDEPENDENT	;

buildName := 'bair_input_update';

CurrentBuildStatus       := Bair.Orbit_SOAPCalls.GetBuildInstance(buildName, buildVersionToReprocess, oLogin).Builds.BuildIBR.BuildStatus:INDEPENDENT;	

SeqFromBuiltORInProgress := Sequential(Bair.Orbit_SOAPCalls.UpdateBuildStatus(buildName, 'FailedQA',buildVersionToReprocess, ' ', oLogin)
																		  ,Bair.Orbit_SOAPCalls.UpdateBuildStatus(buildName, 'BuildOnHold',buildVersionToReprocess, ' ', oLogin)
                                      ,Bair.Orbit_SOAPCalls.UpdateBuildStatus(buildName, 'BuildAvailableForUse',buildVersionToReprocess, ' ', oLogin)
																			,Bair.fnUpdateBairReprocessVersion.fn_setVersionToReprocess(buildVersionToReprocess) 
																			);

SeqFromFailedQA          := Sequential(Bair.Orbit_SOAPCalls.UpdateBuildStatus(buildName, 'BuildOnHold',buildVersionToReprocess, ' ', oLogin)
                                      ,Bair.Orbit_SOAPCalls.UpdateBuildStatus(buildName, 'BuildAvailableForUse',buildVersionToReprocess, ' ', oLogin)
																			,Bair.fnUpdateBairReprocessVersion.fn_setVersionToReprocess(buildVersionToReprocess) 
																			);
																		 
SeqFromBuildOnHold       := Sequential(Bair.Orbit_SOAPCalls.UpdateBuildStatus(buildName, 'BuildAvailableForUse',buildVersionToReprocess, ' ', oLogin)
                                      ,Bair.fnUpdateBairReprocessVersion.fn_setVersionToReprocess(buildVersionToReprocess) 
																			);
																		 
changeStatus             := MAP (currentBuildStatus = 'BuildInProgress' => SeqFromBuiltORInProgress,
                                 currentBuildStatus = 'Built' 					=> SeqFromBuiltORInProgress,																 
                                 currentBuildStatus = 'FailedQA' 			 	=> SeqFromFailedQA,
																 currentBuildStatus = 'BuildOnHold' 		=> SeqFromBuildOnHold);
															

Return changeStatus;
 
END;


