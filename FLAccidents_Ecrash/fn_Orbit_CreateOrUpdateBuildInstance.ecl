IMPORT Orbit3, STD, _control;

EXPORT fn_Orbit_CreateOrUpdateBuildInstance(STRING pdate
																					 ,STRING productName
																					 ,STRING buildStatus
                                           ,BOOLEAN runCreateBuild = FALSE
																					 ,BOOLEAN addComponentsToBuild = TRUE
																					 ,STRING componentFileName = ''
																					 ,DATASET(Orbit3.Layouts.rPlatformStatus)  pPlatform    = DATASET([], Orbit3.Layouts.rPlatformStatus)																					
																					 ,STRING emailList = Orbit3IConstants(productName).orbit_creBuildErr_email
																					 ) := FUNCTION
																					 
	
	wuid := WORKUNIT;
  tokenval := Orbit3.GetToken():INDEPENDENT;
  pBuildname := TRIM(Orbit3IConstants(productName).buildname, LEFT, RIGHT);
	
	//Create build
	lCreateBuild := Orbit3.CreateBuild(pBuildname,
																		  pdate,
																		  tokenval,		
																		 ).retcode;																				 

	lGetBuildInstance := Orbit3.GetBuildInstance(pBuildname,
																								pdate,
																								tokenval,		
	 																						 ).retcode;

  buildID := IF(runcreatebuild,
                lCreateBuild.BuildID,
								lGetBuildInstance.BuildId);

	//Get receive instance based on the component filename															
	lGetReceive := Orbit3.GetReceiveInstanceID(componentFileName,
	                                            tokenval
	 																					 ).retcode ;
																																			
	receiveID := TRIM(lGetReceive.ReceiveInstanceId);	 
	
	//Add receive instance to build
	lAddComponents := Orbit3.AddItemtoBuild(tokenval,
																					 pBuildname,
																					 pdate,
																					 buildID,
																					 [receiveID] 
																					).retcode; 		
																			
	lUpdateBuildInstance := Orbit3.UpdateBuildInstance(pBuildname,
																										  pdate,
																											tokenval,
																											buildStatus,
																											pPlatform
																										 ).retcode;																			
 
  sendEmail := STD.System.Email.SendEmail ( emailList
                                           , _control.ThisEnvironment.Name + ': ' + WORKUNIT + ' ' + pBuildname + ' Orbit3 Create Build:'+ pdate +': Failed'
                                           , 'Orbit3 Create Build failed. Reason: ' + lCreateBuild.Message
                                           , , , 'Orbit3SOA.CreateOrUpdateBuildInstance@lexisnexisrisk.com' );

  getBuildStatus := STD.Str.ToUpperCase(lCreateBuild.Status) = 'SUCCESS';
	
	getCompStatus := if (addComponentsToBuild, STD.Str.ToUpperCase(lAddComponents.Status) = 'SUCCESS', FALSE);

  RETURN ORDERED(MAP( runcreatebuild  AND getBuildStatus AND getCompStatus => ORDERED(OUTPUT(DATASET(lCreateBuild), NAMED('CreateBuildResults'), EXTEND), 
																																										  OUTPUT(DATASET(lGetReceive), NAMED('GetReceiveResults'), EXTEND),
																																										  OUTPUT(DATASET(lAddComponents), NAMED('AddComponentResults'), EXTEND))
                     ,runcreatebuild  AND getBuildStatus => OUTPUT(DATASET(lCreateBuild), NAMED('CreateBuildResults'), EXTEND)
                     ,runcreatebuild => ORDERED(OUTPUT(DATASET([{'Create Build Failed'}], {STRING message}), NAMED('CreateBuildFailed'), EXTEND), sendEmail)
                     ,OUTPUT(DATASET(lUpdateBuildInstance), NAMED('UpdateBuildResults'), EXTEND))
                 ,STD.System.Debug.Sleep(10000)); //10 seconds;
END;