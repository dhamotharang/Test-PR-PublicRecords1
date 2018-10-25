#STORED('IsIncrementalBuild', TRUE);
IMPORT InsuranceHeader_xLink, STD,dops,InsuranceHeader,InsuranceHeader_Incremental_Best,orbit;

EXPORT Proc_PromoteToQA (STRING versionUse) := FUNCTION
 
	#workunit('name','IHeaderWeeklyKeys Update');
	
  // Add merged Alpha logical to Alpha QA super 
	String AlphaBuildVersion := versionUse + 'i'; 
	
	promoteIncAlpha := InsuranceHeader_xLink.SuperFiles(AlphaBuildVersion).promoteMergeQA;		
	
	// Dops update for Alpha incremental 
	dopsUpdate	:= dops.updateversion('IHeaderLABKeys',trim(AlphaBuildVersion,ALL),InsuranceHeader.mod_email.emailList,,'N',, , ,	, , 'DR');	
	orbitUpdate := orbit.CreateBuild('IHeaderLAB','IHeaderLAB',trim(AlphaBuildVersion,ALL),'Production NonFCRA',orbit.GetToken());
	
	// promote Boca merged keys to inc_boca super 
	String BocaBuildVersion := versionUse + 'ib'; 
	promotebocaSuperKeys := InsuranceHeader_xLink.CreateUpdateSuperFile(InsuranceHeader_xLink.Constants.INCREMENTAL_BOCA).updateBocaIncSP(BocaBuildVersion);
	BocaKeys:= promotebocaSuperKeys: 
									SUCCESS(STD.System.Email.SendEmail(InsuranceHeader_Incremental.Proc_Constants.emailNotifyBoca,
														'InsuranceHeader_Incremental Boca keys WORKUNIT ' + WORKUNIT + ' has completed','')),
									FAILURE(STD.System.Email.SendEmail(InsuranceHeader_Incremental.Proc_Constants.emailNotifyBoca,
														'InsuranceHeader_Incremental Boca keys WORKUNIT ' + WORKUNIT + ' has failed', FAILMESSAGE));
														
	//best delta key
	promoteBestDeltaKey := InsuranceHeader_Incremental_Best.Filenames(versionUse).updateBestDeltaSF;
	
	// Dops update for IHeaderWeekly keys
	dopsUpdateWeekly := dops.updateversion('IHeaderWeeklyKeys',versionUse,InsuranceHeader.mod_email.emailList,,'N');
	orbitUpdateWeekly := orbit.CreateBuild('IHeaderWeekly','IHeaderWeekly',versionUse,'Production NonFCRA',orbit.GetToken());

	//unique addr key
	promoteUniqueAddrKey := InsuranceHeader_Incremental_Best.Filenames(versionUse).updateAddrUniqueSF;
	
	// 	Notify xlink keys done as full delta waiting for it 
	
	notifyDone	 := NOTIFY(InsuranceHeader_Incremental.Constants.XlinkIncBuildEventName, '*');
	
	RETURN SEQUENTIAL(promoteIncAlpha,
	                  dopsUpdate,
										IF (orbitUpdate[1].retcode = 'Success', 
																fileservices.sendemail(
																		'Anantha.Venkatachalam@lexisnexis.com,' + InsuranceHeader.mod_email.emailList,
																		'Alpharetta IHeaderLab Incremental OrbitI Create Build:' + AlphaBuildVersion + ':SUCCESS',
																		'OrbitI Create build successful: ' + AlphaBuildVersion),
																fileservices.sendemail(
																		'Anantha.Venkatachalam@lexisnexis.com,' + InsuranceHeader.mod_email.emailList,
																		'Alpharetta IHeaderLab Incremental OrbitI Create Build:' + AlphaBuildVersion + ':FAILED',
																		'OrbitI Create build failed. Reason: ' + orbitUpdate[1].retDesc)
															),
										BocaKeys,
										STD.File.StartSuperFileTransaction(),
										promoteBestDeltaKey,
										promoteUniqueAddrKey,
										STD.File.FinishSuperFileTransaction(),
										dopsUpdateWeekly,
										IF (orbitUpdateWeekly[1].retcode = 'Success', 
																fileservices.sendemail(
																		'Anantha.Venkatachalam@lexisnexis.com,' + InsuranceHeader.mod_email.emailList,
																		'Alpharetta IHeaderWeekly OrbitI Create Build:' + versionUse + ':SUCCESS',
																		'OrbitI Create build successful: ' + versionUse),
																fileservices.sendemail(
																		'Anantha.Venkatachalam@lexisnexis.com,' + InsuranceHeader.mod_email.emailList,
																		'Alpharetta IHeaderWeekly OrbitI Create Build:' + versionUse + ':FAILED',
																		'OrbitI Create build failed. Reason: ' + orbitUpdateWeekly[1].retDesc)
															),
										notifyDone);
END;

