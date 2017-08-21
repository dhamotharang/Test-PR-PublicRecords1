IMPORT BAIR, STD;
EXPORT Orbit_SOAPCalls := MODULE

// This Module contains the SOAP Calls functions that are used to create, query and update Orbit database related to the Bair files processing.
// These are the functions and their required parameters: 
//
//  1- AddArchiveInstance (STRING ArchiveStatus, STRING ExpirationDate, STRING FileName, 
//    										 STRING ReceivingID, STRING Server, STRING Token )
//
//  2- AddComponentsToABuild ( STRING BuildName, STRING BuildVersion,	STRING ReceivingID, STRING Token )
//
//  3- AddReceiveFile	( STRING ReceivingId,	STRING Cluster,	STRING FileInstanceId, STRING FileName, STRING FilePath, STRING FileStatus
//			,	STRING QueueName,	STRING RecordCount, STRING ReportingEndDate, STRING ReportingStartDate, STRING Token )
//
//  4- AddScrubBuildComponents ( STRING inBuildID, STRING inBuildName, STRING inBuildVersion, DATASET(layout) SBIDs, STRING Token )	
//
//  5- GetBuildInstance ( STRING BuildName, STRING BuildVersion, STRING Token )
//
//  6- GetCandidates ( STRING BuildName, STRING BuildVersion, STRING TOKEN ) 
//
//  7- GetContributionData ( STRING FileSourceId, STRING MemberId, STRING Token )
//
//  8- LoginBAIR (	STRING UserName,	STRING Password,	STRING TargetURL = _SystemConstants.TargetURL,	STRING Domain = Constants.Domain )
//
//  9- CreateBuild ( STRING BuildName, STRING BuildStatus, STRING BuildVersion, STRING HpccWorkUnit, STRING MasterBuild, STRING TOKEN	) 
//
// 10- GetFileInstance( String Scrubbuildinstance, String ExternalID  )
//
// 11- ReceiveItem	(STRING CoverageEndDate,	STRING Description,	STRING IsItemOnHold,	STRING IsTestInstance,	STRING Item
//			,STRING MediaType,	STRING NextExpectedDate,	STRING ReceiveDate,	STRING ReceivingType,	STRING SourceName
//			,STRING UpdateType,	STRING Token )
//
// 12- getScrubBuildCandidates (	STRING BuildName, STRING BuildVersion, STRING TOKEN	)
//
// 13- ScrubAddComponents ( STRING BuildId, STRING BuildName, STRING BuildVersion, DATASET (inDS_Layout) ReceivingIDs, STRING TOKEN )
//
// 14- SetSubStatus ( STRING ReceivingId, STRING Status, STRING Token )
//
// 15- SubmissionAddComponents ( STRING BuildId,	STRING BuildName, STRING BuildVersion,	DATASET (inDS_Layout) ReceivingIDs, STRING Token )
//
// 16- UpdateBuildStatus ( STRING BuildName, STRING BuildStatus, STRING BuildVersion, STRING TOKEN )
//
// 17- UpdateReceive	( STRING ReceiveDate, STRING ReceivingId, STRING Status, STRING Token )
//
// 18- UpdateReceiveFile ( STRING Cluster, STRING FileInstanceId, STRING FileName, STRING FilePath, STRING FileStatus, STRING QueueName
//                        , STRING RecordCount, STRING ReportingEndDate, STRING ReportingStartDate, STRING ReceivingID, STRING Token )	
// 19- UpdateReceiveItem	( STRING IsItemOnHold, STRING IsTestInstance, STRING ReceiveDate, STRING ReceivingId, STRING ReceivingType, STRING Status, STRING Token	)
//
// 20- UpdateRecordCount( STRING RecordCount, STRING ReceivingID, STRING Token )
//
// 21- VerifyStatus ( STRING InstanceID, STRING Token )	

EXPORT _SystemConstants := MODULE
    
	EXPORT STRING OrbitUser 							:= 'svc_bair_orbit_hpcc@mbs'	;
	EXPORT STRING OrbitPassword 					:= 'g1HvKqVND712'										;
	EXPORT STRING SOAPService(STRING s) 	:= 'lex:' + s	;
	EXPORT STRING OrbitRR(STRING s)				:= s + 'Response/' + s + 'Result';
	EXPORT STRING Domain 									:= 'PublicSafety'	;
	EXPORT STRING TargetURL 						  := 'https://orbitbair.risk.regn.net/Orbit3/Orbit3Services/OrbitServiceGeneric.svc'; 
	//EXPORT STRING TargetURL 						  := 'https://dev.orbitbair.risk.regn.net/OrbitFunctionalSOA/OrbitServiceV2.svc'; 
	//EXPORT STRING TargetURL 						  := 'https://BCTWTORBIT101.risk.regn.net/OrbitFunctionalSOA/OrbitServiceV2.svc'; 
	//EXPORT STRING TargetURL 							:= 'http://bctwpsbfe001.risk.regn.net/OrbitFunctionalSOA/OrbitServiceV2.svc';
	EXPORT STRING Namespace_A 						:= 'http://lexisnexis.com/" xmlns:lex="http://lexisnexis.com/';
	EXPORT STRING Namespace_B 						:= 'http://lexisnexis.com/" xmlns:orb="http://schemas.datacontract.org/2004/07/OrbitDataContractsV2" xmlns:lex="http://lexisnexis.com/';
	EXPORT STRING Namespace_C 						:= 'http://lexisnexis.com/" xmlns:orb="http://schemas.datacontract.org/2004/07/OrbitDataContractsV2" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays" xmlns:lex="http://lexisnexis.com/';
	EXPORT STRING Namespace_D 						:= 'http://lexisnexis.com/" xmlns:orb="http://schemas.datacontract.org/2004/07/OrbitDataContractsV2" xmlns:orb1="http://schemas.datacontract.org/2004/07/OrbitDataContracts" xmlns:lex="http://lexisnexis.com/';
	EXPORT STRING Namespace_E 						:= 'http://lexisnexis.com/" xmlns:xs="http://www.w3.org/2001/XMLSchema';
	//EXPORT STRING SoapPath(STRING s)			:= 'http://lexisnexis.com/IOrbitServiceV2/' + s ;
	EXPORT STRING SoapPath(STRING s)			:= 'http://lexisnexis.com/IOrbitServiceGeneric/' + s;
	EXPORT STRING BatchIds								:= 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNPQRSTUVWXYZ';
		
END;

EXPORT Constants := MODULE
	// ------------------------------------------------------------------------------------------------

  EXPORT STRING OrbitUser 							:= 'svc_bair_orbit_hpcc@mbs'	;
	EXPORT STRING OrbitPassword 					:= 'g1HvKqVND712'		;	
	EXPORT STRING SOAPService(STRING s) 	:= 'lex:' + s	;
	EXPORT STRING OrbitRR(STRING s)				:= s + 'Response/' + s + 'Result';
	EXPORT STRING Domain 									:= 'PublicSafety'	;
	EXPORT STRING TargetURL 						  := 'https://orbitbair.risk.regn.net/Orbit3/Orbit3Services/OrbitServiceGeneric.svc'; 	
  //EXPORT STRING TargetURL 						  := 'https://dev.orbitbair.risk.regn.net/OrbitFunctionalSOA/OrbitServiceV2.svc'; 	
	//EXPORT STRING TargetURL 							:= 'https://BCTWTORBIT101.risk.regn.net/OrbitFunctionalSOA/OrbitServiceV2.svc'; //'http://bctwdsql001.risk.regn.net/SOAv7/OrbitServiceV2.svc';
	// EXPORT STRING TargetURL 							:= 'http://bctwpsbfe001.risk.regn.net/OrbitFunctionalSOA/OrbitServiceV2.svc';
	EXPORT STRING Namespace_A 						:= 'http://lexisnexis.com/" xmlns:lex="http://lexisnexis.com/';
	
	EXPORT STRING Namespace_B 						:= 'http://lexisnexis.com/" xmlns:orb="http://schemas.datacontract.org/2004/07/OrbitDataContractsV2" xmlns:lex="http://lexisnexis.com/';
	EXPORT STRING Namespace_C 						:= 'http://lexisnexis.com/" xmlns:orb="http://schemas.datacontract.org/2004/07/OrbitDataContractsV2" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays" xmlns:lex="http://lexisnexis.com/';
	EXPORT STRING Namespace_D 						:= 'http://lexisnexis.com/" xmlns:orb="http://schemas.datacontract.org/2004/07/OrbitDataContractsV2" xmlns:orb1="http://schemas.datacontract.org/2004/07/OrbitDataContracts" xmlns:lex="http://lexisnexis.com/';
 //	EXPORT STRING SoapPath(STRING s)			:= 'http://lexisnexis.com/IOrbitServiceV2/' + s ;
  EXPORT STRING SoapPath(STRING s)			:= 'http://lexisnexis.com/IOrbitServiceGeneric/' + s ; 
	EXPORT STRING BatchIds								:= 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNPQRSTUVWXYZ';
	EXPORT INTEGER filesToBeProcessed     := 31;
		// ------------------------------------------------------------------------------------------------
END ;	// End Constants Module

EXPORT orbitConstants := MODULE	
  EXPORT STRING OrbitUser 							:= 'svc_bair_orbit_hpcc@mbs'	;
	EXPORT STRING OrbitPassword 					:= 'g1HvKqVND712'									;	
	EXPORT STRING SOAPService	(STRING s) 				:= 	'lex:' + s			;
	EXPORT STRING OrbitRR			(STRING s)				:= 	s + 'Response/' + s + 'Result'	;
	EXPORT STRING Domain 												:= 	'PublicSafety'			;
	EXPORT STRING Namespace_A 									:= 	'http://lexisnexis.com/" xmlns:lex="http://lexisnexis.com/'		;
	EXPORT STRING Namespace_B 									:= 	'http://lexisnexis.com/" xmlns:orb="http://schemas.datacontract.org/2004/07/OrbitDataContractsV2" xmlns:lex="http://lexisnexis.com/';
	EXPORT STRING Namespace_C 									:= 	'http://lexisnexis.com/" xmlns:orb="http://schemas.datacontract.org/2004/07/OrbitDataContractsV2" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays" xmlns:lex="http://lexisnexis.com/';
	EXPORT STRING Namespace_D 									:= 	'http://lexisnexis.com/" xmlns:orb="http://schemas.datacontract.org/2004/07/OrbitDataContractsV2" xmlns:orb1="http://schemas.datacontract.org/2004/07/OrbitDataContracts" xmlns:lex="http://lexisnexis.com/';
	EXPORT STRING SoapPath(STRING s)						:= 	'http://lexisnexis.com/IOrbitServiceGeneric/' + s 					;
	EXPORT STRING BatchIds											:= 	'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNPQRSTUVWXYZ'				;
  EXPORT STRING devOrbit 						          := 'https://stg.orbit3.risk.regn.net/Orbit3/Orbit3Services/OrbitServiceGeneric.svc'; 
	//EXPORT STRING devOrbit 											:= 	'https://BCTWTORBIT101.risk.regn.net/OrbitFunctionalSOA/OrbitServiceV2.svc';
	//EXPORT STRING prodOrbit 										:= 	'https://BCTWTORBIT101.risk.regn.net/OrbitFunctionalSOA/OrbitServiceV2.svc';
	EXPORT STRING prodOrbit 						         := 'https://orbitbair.risk.regn.net/Orbit3/Orbit3Services/OrbitServiceGeneric.svc'; 	
	EXPORT STRING OrbitSubBuildMaster						:= 	'SubmissionBuildMaster'								;
	EXPORT STRING OrbitCVBuildMaster						:= 	'CVBuildMaster'									;
	EXPORT STRING OrbitSubBuild									:= 	'SubmissionBuild'								;
	EXPORT STRING OrbitCVBuild									:= 	'CVBuild'									;
	EXPORT STRING OrbitGraveyard								:= 	'Graveyard'									;
	EXPORT STRING OrbitFailed										:= 	'Failed'									;
	EXPORT STRING OrbitLoaded										:= 	'Loaded'									;
	EXPORT STRING OrbitReceived									:= 	'Received'									;
	EXPORT STRING OrbitSprayed									:= 	'Sprayed'									;
	EXPORT STRING OrbitReformatted							:= 	'Reformatted'									;
	EXPORT STRING OrbitScrubbed									:= 	'Scrubbed'									;
	EXPORT STRING OrbitBuildInProgress					:= 	'BuildInProgress'								;
	EXPORT STRING OrbitNew											:= 	'New'										;
	EXPORT STRING OrbitBuildOnHold							:= 	'BuildOnHold'									;
	EXPORT STRING OrbitBuilt										:= 	'Built'										;
	EXPORT STRING OrbitHeldThresholds						:= 	'HeldThresholds'								;
	EXPORT STRING OrbitQuarantine								:= 	'Quarantine'									;
	EXPORT STRING OrbitSubFailedSpray						:= 	'SPR'										;
	EXPORT STRING OrbitSubFailedReformat				:= 	'RFM'										;
	EXPORT STRING OrbitSubFailedScrub						:= 	'SCR'										;
	EXPORT STRING OrbitSubFailedOther						:= 	'OTH'										;
	EXPORT STRING OrbitDate (STRING s)					:= 	s[1..4] + '-' +	s[5..6] + '-' + s[7..8]						;
	EXPORT STRING OrbitTrue											:= 	'true'										;
	EXPORT STRING OrbitFalse										:= 	'false'										;
	//----------------------------------------------------------------------------------------------
END;

// Begin AddArchiveInstance Function
EXPORT AddArchiveInstance ( 	STRING ArchiveStatus
														, STRING ExpirationDate
														, STRING FileName
														, STRING ReceivingID
														, STRING Server
														, STRING Token
													)	:= FUNCTION
	IMPORT BAIR;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'AddArchiveInstance'	;	
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	rArchiveI	:=	RECORD
			STRING		orbArchiveStatus						{	XPATH('orb:ArchiveStatus'					)	}	:=	ArchiveStatus		; // 'New'
			STRING		orbExpirationDate						{	XPATH('orb:ExpirationDate'				)	}	:= 	ExpirationDate	; // '2013-08-30'
			STRING		orbFileName									{	XPATH('orb:FileName'							)	}	:=	FileName				; // 'ImImportantData'
			STRING		orbReceivingID							{	XPATH('orb:ReceivingId'						)	}	:= 	ReceivingID			; // '268469'
			STRING		orbServer										{	XPATH('orb:Server'								)	}	:= 	Server					; // 'SomeServer'					
	END	;
	//	-
	rArchives	:= 	RECORD
		rArchiveI		orbArchiveInstance 					{	XPATH('orb:ArchiveInstance'				)	}											;								
	END	;
	// -
	rLex			:= 	RECORD
		rArchives		orbArchives 								{	XPATH('orb:Archives'							)	}											;
		STRING 			orbToken 										{	XPATH('orb:Token'									)	}	:=	Token						;	
	END	;
	// -
	rRequest	:= 	RECORD
		rLex				lexRequest									{	XPATH('lex:request'								)	}											;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - RESPONSE
	rStatus 	:= 	RECORD
		STRING			Code												{	XPATH('Code'															)	}											;
		STRING			Description									{	XPATH('Description'												)	}											;
		STRING			Status											{	XPATH('Status'														)	}											;
	END	;
	//-
	rOrbit 		:= 	RECORD
		STRING			OrbitStatusCode							{	XPATH('OrbitStatusCode'										)	}											;
		STRING			OrbitStatusDescription			{	XPATH('OrbitStatusDescription'						)	}											;
	END;
	//-	
	rArchiveIR := RECORD
		STRING			ArchiveInstanceId						{	XPATH('ArchiveInstanceId'									)	}											;
		STRING			ArchiveStatus								{	XPATH('ArchiveStatus'											)	}											;
		STRING			BuildInstanceId							{	XPATH('BuildInstanceId'										)	}											;
		STRING			ExpirationDate							{	XPATH('ExpirationDate'										)	}											;
		STRING			FileName										{	XPATH('FileName'													)	}											;
		STRING			ReceivingId									{	XPATH('ReceivingId'												)	}											;
		STRING			Server											{	XPATH('Server'														)	}											;
		rStatus			Status											{ XPATH('Status'														)	}											;
	END;
	//-
	rArchivesR := RECORD
		rArchiveIR 	ArchiveInstance							{	XPATH('ArchiveInstance'										)	}											;
	END;
	//-
	rResponse	 := RECORD
		rArchivesR	Archives		 								{	XPATH('Archives'													)	}											; 
		rOrbit 			OrbitStatus									{	XPATH('OrbitStatus'												)	}											;
		STRING 			OriginalRequest							{	XPATH('OriginalRequest'										)	}											;
	END;
	//------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(	_SystemConstants.TargetURL
													,	_SystemConstants.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(_SystemConstants.OrbitRR(sService)	)
													,	NAMESPACE(_SystemConstants.Namespace_B)
													,	LITERAL
													,	SOAPACTION(_SystemConstants.SoapPath(sService) )
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	RETURN	OrbitCall	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
END	;	// End AddArchiveInstance Function

// Begin AddComponentsToABuild Function	

EXPORT AddComponentsToABuild ( 		STRING BuildName
																, STRING BuildVersion
																,	STRING ReceivingID
																// , STRING BuildVersion2
																// , STRING MasterBuildId
																, STRING Token
															) := FUNCTION
	IMPORT BAIR;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'AddComponentsToABuild'	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	rCompAdd	:=	RECORD
		STRING			orbReceivingId							{	XPATH('orb:ReceivingId'						)	}	:=  ReceivingId		;	// 'ReceivingId'
	END	;
	// -
	rComp			:=	RECORD
		rCompAdd		orbComponentToAdd						{ XPATH('orb:ComponentToAdd'				)	}										;
	END	;
	// -
	rBuild		:= 	RECORD
		STRING			orbBuildName		 						{	XPATH('orb:BuildName'							)	}	:= 	BuildName			; // 'BUILD-NAME'
		STRING			orbBuildVersion							{	XPATH('orb:BuildVersion'					)	}	:= 	BuildVersion	; // 'BUILD VERSION'
		rComp				orbComponents								{ XPATH('orb:Components'						)	}										;			
	END	;
	//	-
	rBuilds		:= 	RECORD
		rBuild			orbBuild 										{	XPATH('orb:BuildInstanceToAdd'		)	}										;								
	END	;
	// -
	rLex			:= 	RECORD
		rBuilds		 	orbBuilds		 								{	XPATH('orb:Builds'								)	}										;
		STRING 			orbToken 										{	XPATH('orb:Token'									)	}	:= 	Token					;	
		END	;
	// -
	rRequest	:= 	RECORD
		rLex				lexRequest									{	XPATH('lex:request'								)	}										;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - RESPONSE
	rOrbit 		:= 	RECORD
		STRING			OrbitStatusCode							{	XPATH('OrbitStatusCode'						)	}										;
		STRING			OrbitStatusDescription			{	XPATH('OrbitStatusDescription'		)	}										;	
	END;
	//-
	rCompAddR	:=	RECORD
		STRING			BuildId2										{	XPATH('BuildId'										)	}										;
		STRING			BuildName2									{	XPATH('BuildName'									)	}										;
		STRING			BuildVersion2								{	XPATH('BuildVersion'							)	}										;
		STRING			MasterBuildId2							{	XPATH('MasterBuildId'							)	}										;
		STRING			ReceivingId									{	XPATH('ReceivingId'								)	}										;
		STRING			Status											{	XPATH('Status'										)	}										;
	END	;
	//-
	rCompR		:=	RECORD
		rCompAddR		ComponentToAddR							{ XPATH('ComponentToAdd'						)	}										;
	END	;
	//-	
	rInstance	:=	RECORD
		STRING			BuildId											{	XPATH('BuildId'										)	}										;
		STRING			BuildName										{	XPATH('BuildName'									)	}										;
		STRING			BuildVersion								{	XPATH('BuildVersion'							)	}										;
		rCompR			ComponentsR									{ XPATH('Components'								)	}										;
		STRING			MasterBuildId								{	XPATH('MasterBuildId'							)	}										;
		STRING			Status											{	XPATH('Status'										)	}										;
	END	;
	//-	
	rBuildsR	:=	RECORD
		rInstance		InstanceToAdd								{ XPATH('BuildInstanceToAdd'				)	}										;
	END	;
	//-	
	rResponse :=	RECORD
		rBuildsR		BuildsResponse							{ XPATH('Builds'										)	}										;
		rOrbit			OrbitStatus 								{	XPATH('OrbitStatus'								)	}										;
		STRING 			OriginalRequest							{	XPATH('OriginalRequest'						)	}										;
	END;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(		_SystemConstants.TargetURL
													,	_SystemConstants.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(_SystemConstants.OrbitRR(sService)	)
													,	NAMESPACE(_SystemConstants.Namespace_D)
													,	LITERAL
													,	SOAPACTION(_SystemConstants.SoapPath(sService) )
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	//    RETURN	(UNSIGNED4)OrbitCall.BuildsResponse.InstanceToAdd.BuildId;
	//  RETURN	OrbitCall.OrbitStatus.OrbitStatusDescription; 
	
	RETURN	OrbitCall;
	//-----------------------------------------------------------------------------------------------------------------------------------------
END	;	// End AddComponentsToABuild Function	

// Begin AddReceiveFile Function
EXPORT AddReceiveFile	(		STRING ReceivingId
												,	STRING Cluster
												,	STRING FileInstanceId
												, STRING FileName
												, STRING FilePath
												, STRING FileStatus
												,	STRING QueueName
												,	STRING RecordCount
												, STRING ReportingEndDate
												, STRING ReportingStartDate
												, STRING Token
											)	:= FUNCTION
											
	IMPORT BAIR;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'AddReceiveFile'	;
	//------------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	rReceiveP	:= 	RECORD
			STRING			orbReceivingId		 					{	XPATH('orb:ReceivingId'						)	}	:= 	ReceivingId							; // '268468'
	END	;
	// -
	rReceiveFR	:= 	RECORD
		STRING				orbCluster		 							{	XPATH('orb:Cluster'								)	}	:= 	Cluster									; // 'Dunno'
		STRING				orbFileInstanceId						{	XPATH('orb:FileInstanceId'				)	}	:= 	FileInstanceId					; // '268468'
		STRING				orbFileName									{	XPATH('orb:FileName'							)	}	:= 	FileName								; // 'AmericanExpress-Charge-268468' 
		STRING				orbFilePath									{	XPATH('orb:FilePath'							)	}	:= 	FilePath								; // '//hpcc/IdontKnow/'
		STRING				orbFileStatus								{	XPATH('orb:FileStatus'						)	}	:= 	FileStatus							; // 'Success'
		STRING				orbQueueName								{	XPATH('orb:QueueName'							)	}	:= 	QueueName								; // 'HPCC QUE'
		rReceiveP			orbReceivingParent 					{	XPATH('orb:ReceivingParent'				)	}															;
		STRING				orbRecordCount							{	XPATH('orb:RecordCount'						)	}	:= 	RecordCount							; // '268468'
		STRING				orbReportingEndDate					{	XPATH('orb:ReportingEndDate'			)	}	:= 	ReportingEndDate				; // '2013-08-12'
		STRING				orbReportingStartDate				{	XPATH('orb:ReportingStartDate'		)	}	:= 	ReportingStartDate			; // 	'2013-08-12'							
	END	;
	// -
	rReceiveF		:= 	RECORD
		rReceiveFR		orbReceiveFileRequest 			{	XPATH('orb:ReceiveFileRequest'		)	}															;								
	END	;
	// -
	rReceiveR		:= 	RECORD
		rReceiveF			orbReceiveFiles 						{	XPATH('orb:ReceiveFiles'					)	}															;
		STRING				orbReceivingId2		 					{	XPATH('orb:ReceivingId'						)	}	:= 	ReceivingId							; // '268468'						
	END	;
	// -
	rReceive		:= 	RECORD
		rReceiveR			orbReceivingRecord 					{	XPATH('orb:ReceivingRecord'				)	}															;									
	END	;
	// -
	rLex				:= 	RECORD
		rReceive 			orbItems 										{	XPATH('orb:Receivings'						)	}															;
		STRING 				orbToken 										{	XPATH('orb:Token'									)	}	:= Token 										;	
	END	;
	// -
	rRequest		:= 	RECORD
		rLex					lexRequest									{	XPATH('lex:request'								)	}															;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - RESPONSE
	rOrbit 			:= 	RECORD
		STRING				OrbitStatusCode							{	XPATH('OrbitStatusCode'						)	}																			;
		STRING				OrbitStatusDescription			{	XPATH('OrbitStatusDescription'		)	}																			;	
	END;
	//-	
	rResponse 	:= 	RECORD
		rOrbit				OrbitStatus 								{	XPATH('OrbitStatus'								)	}																			;
		STRING 				OriginalRequest							{	XPATH('OriginalRequest'						)	}																			;
	END;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(		_SystemConstants.TargetURL
													,	_SystemConstants.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(_SystemConstants.OrbitRR(sService)	)
													,	NAMESPACE(_SystemConstants.Namespace_D)
													,	LITERAL
													,	SOAPACTION(_SystemConstants.SoapPath(sService) )
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	RETURN	OrbitCall.OrbitStatus.OrbitStatusCode	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
END	; // End AddReceiveFile Function


// Start AddScrubBuildComponents Function

layout := RECORD
		STRING			inDSBuildID			 						{	XPATH('orb:BuildId'								)	}				; // 'BUILD-NAME'
		STRING			inDSBuildName		 						{	XPATH('orb:BuildName'							)	}				; // 'BUILD-NAME'
		STRING			inDSBuildVersion						{	XPATH('orb:BuildVersion'					)	}		; // 'BUILD VERSION'
END ;



EXPORT AddScrubBuildComponents ( 		STRING inBuildID
																	,	STRING inBuildName
																	, STRING inBuildVersion
																	, DATASET(layout) SBIDs
																	, STRING Token
															) := FUNCTION
	IMPORT BAIR;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'AddComponentsToABuild'	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST

	// -
	rComp			:=	RECORD
		Dataset(layout)		orbComponentToAdd						{ XPATH('orb:ComponentToAdd'				)	}		:= SBIDs								;
	END	;
	// -
	rBuild		:= 	RECORD
		STRING			orbBuildID			 						{	XPATH('orb:BuildId'								)	}	:= 	inBuildID			; // 'BUILD-NAME'
		STRING			orbBuildName		 						{	XPATH('orb:BuildName'							)	}	:= 	inBuildName			; // 'BUILD-NAME'
		STRING			orbBuildVersion							{	XPATH('orb:BuildVersion'					)	}	:= 	inBuildVersion	; // 'BUILD VERSION'
		rComp				orbComponents								{ XPATH('orb:Components'						)	}										;			
	END	;
	//	-
	rBuilds		:= 	RECORD
		rBuild			orbBuild 										{	XPATH('orb:BuildInstanceToAdd'		)	}										;								
	END	;
	// -
	rLex			:= 	RECORD
		rBuilds		 	orbBuilds		 								{	XPATH('orb:Builds'								)	}										;
		STRING 			orbToken 										{	XPATH('orb:Token'									)	}	:= 	Token					;	
		END	;
	// -
	rRequest	:= 	RECORD
		rLex				lexRequest									{	XPATH('lex:request'								)	}										;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - RESPONSE
	rOrbit 		:= 	RECORD
		STRING			OrbitStatusCode							{	XPATH('OrbitStatusCode'						)	}										;
		STRING			OrbitStatusDescription			{	XPATH('OrbitStatusDescription'		)	}										;	
	END;
	//-
	rCompAddR	:=	RECORD
		STRING			BuildId2										{	XPATH('BuildId'										)	}										;
		// STRING			BuildName2									{	XPATH('BuildName'									)	}										;
		// STRING			BuildVersion2								{	XPATH('BuildVersion'							)	}										;
		// STRING			MasterBuildId2							{	XPATH('MasterBuildId'							)	}										;
		// STRING			ReceivingId									{	XPATH('ReceivingId'								)	}										;
		// STRING			Status											{	XPATH('Status'										)	}										;
	END	;
	//-
	rCompR		:=	RECORD
		Dataset(layout)		ComponentToAddR							{ XPATH('ComponentToAdd'						)	}										;
	END	;
	//-	
	rInstance	:=	RECORD
		STRING			BuildId											{	XPATH('BuildId'										)	}										;
		STRING			BuildName										{	XPATH('BuildName'									)	}										;
		STRING			BuildVersion								{	XPATH('BuildVersion'							)	}										;
		rCompR			ComponentsR									{ XPATH('Components'								)	}										;
		STRING			MasterBuildId								{	XPATH('MasterBuildId'							)	}										;
		STRING			Status											{	XPATH('Status'										)	}										;
	END	;
	//-	
	rBuildsR	:=	RECORD
		rInstance		InstanceToAdd								{ XPATH('BuildInstanceToAdd'				)	}										;
	END	;
	//-	
	rResponse :=	RECORD
		rBuildsR		BuildsResponse							{ XPATH('Builds'										)	}										;
		rOrbit			OrbitStatus 								{	XPATH('OrbitStatus'								)	}										;
		STRING 			OriginalRequest							{	XPATH('OriginalRequest'						)	}										;
	END;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(		_SystemConstants.TargetURL
													,	_SystemConstants.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(_SystemConstants.OrbitRR(sService)	)
													,	NAMESPACE(_SystemConstants.Namespace_D)
													,	LITERAL
													,	SOAPACTION(_SystemConstants.SoapPath(sService) )
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// RETURN	output(OrbitCall.BuildsResponse.InstanceToAdd.BuildId);
	RETURN	OrbitCall;
	//-----------------------------------------------------------------------------------------------------------------------------------------
END	;	// End AddScrubBuildComponents Function	


// Start GetBuildInstance Module

EXPORT GetBuildInstance (		STRING BuildName
													,	STRING BuildVersion
													, STRING Token	
												)	:= FUNCTION
												
	IMPORT BAIR;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'GetBuildInstance'	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	rBuildINV		:= 	RECORD
		STRING				orbBuildName										{	XPATH('orb:BuildName'												)	}	:= BuildName			; // 'Scrub-CoreVendor-FIS'
		STRING				orbBuildVersion									{	XPATH('orb:BuildVersion'										)	}	:= BuildVersion		; // '20130815B'
	END	;	
	// -
	rBuilds			:= 	RECORD
		rBuildINV			orbBuildINV											{	XPATH('orb:BuildInstanceNameVersion'				)	}							;
	END	;
	// -
	rLex				:= 	RECORD
		rBuilds			 	orbBuilds												{	XPATH('orb:Builds'													)	}							;
		STRING 				orbToken		 										{	XPATH('orb:Token'														)	}	:= 	Token		;	
	END	;
	// -
	rRequest		:= 	RECORD
		rLex					lexRequest											{	XPATH('lex:request'													)	}							;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - RESPONSE
	rOrbit			:= RECORD
		STRING			 OrbitStatusCode									{	XPATH('OrbitStatusCode'											)	}							;
		STRING			 OrbitStatusDescription						{	XPATH('OrbitStatusDescription'							)	}							;
	END;
	// -
	rStatus 		:= 	RECORD
		STRING				Code														{	XPATH('Code'																)	}							;
		STRING				Description											{	XPATH('Description'													)	}							;
		STRING				bStatus													{	XPATH('Status'															)	}							;
	END;
	// -
	rPlatform		:= 	RECORD			
		STRING				PlatformName		 ;//								{	XPATH('PlatformName'												)	}							;							
		STRING				PlatformStatus	;//	 							{	XPATH('PlatformStatus'											)	}							;							
	END	;
	// -
	rPlatforms	:= 	RECORD
		rPlatform			Platform		 										{	XPATH('Platform'														)	}							;	
	END	;
	// -

  rReceiveAndReceiveFileInfo := RECORD
			STRING                                     BatchNumber					;
			STRING                                     ContentEndDate				;
			STRING                                     ContentStartDate			;
			STRING                                     FileInstanceId				;
			STRING                                     FileName							;
			STRING                                     FilePath							;
			STRING                                     FileStatusDesc				;
			STRING                                     IsReceiveATest				;
			STRING                                     IsReceivingOnHold		;
			STRING                                     Item									;
			STRING                                     ItemStatusDesc				;
			STRING                                     LandingZone					;
			STRING                                     ReceiveDate					;
			STRING                                     ReceiveStatusDesc		;
			STRING                                     ReceiveTypeDesc			;
			STRING                                     ReceivingId					;
			STRING                                     RecordCount					;
			STRING                                     ReportingEndDate			;
			STRING                                     ReportingStartDate		;
   END;

rReceivingDetails := RECORD
        rReceiveAndReceiveFileInfo ReceiveAndReceiveFileInfo { XPATH('ReceiveAndReceiveFileInfo') };
END;	
	
	rBuildIBR		:= 	RECORD
		STRING		Analyst																		{ XPATH('Analyst'												) }       ;
		STRING		BuildId																		{ XPATH('BuildId'												) }       ;
		STRING		BuildInstanceComputedBtr									{ XPATH('BuildInstanceComputedBtr'			) }       ;
		STRING		BuildInstanceCopy													{ XPATH('BuildInstanceCopy'							) }       ;
		STRING		BuildInstanceCreatedBy										{ XPATH('BuildInstanceCreatedBy'				) }       ;
		STRING		BuildInstanceCreatedDate									{ XPATH('BuildInstanceCreatedDate'			) }       ;
		STRING		BuildInstanceDataOne											{ XPATH('BuildInstanceDataOne'					) }       ;
		STRING		BuildInstanceDataTwo											{ XPATH('BuildInstanceDataTwo'					) }       ;
		STRING		BuildInstanceDescription									{ XPATH('BuildInstanceDescription'			) }       ;
		STRING		BuildInstanceDisableScoring								{ XPATH('BuildInstanceDisableScoring'		) }       ;
		STRING		BuildInstanceDocumentation								{ XPATH('BuildInstanceDocumentation'		) }       ;
		STRING		BuildInstanceEndDate											{ XPATH('BuildInstanceEndDate'					) }       ;
		STRING		BuildInstanceExtraBuild										{ XPATH('BuildInstanceExtraBuild'				) }       ;
		STRING		BuildInstanceIssueBugzilla								{ XPATH('BuildInstanceIssueBugzilla'		) }       ;
		STRING		BuildInstanceIssueNote										{ XPATH('BuildInstanceIssueNote'				) }       ;
		STRING		BuildInstanceNewCoverage									{ XPATH('BuildInstanceNewCoverage'			) }       ;
		STRING		BuildInstanceNextBuildDate								{ XPATH('BuildInstanceNextBuildDate'		) }       ;
		STRING		BuildInstanceOverrideBtr									{ XPATH('BuildInstanceOverrideBtr'			) }       ;
		STRING		BuildInstanceQAOwner											{ XPATH('BuildInstanceQAOwner'					) }       ;
		STRING		BuildInstanceQaEndDate										{ XPATH('BuildInstanceQaEndDate'				) }       ;
		STRING		BuildInstanceQaStartDate									{ XPATH('BuildInstanceQaStartDate'			) }       ;
		STRING		BuildInstanceScorecardIgnore							{ XPATH('BuildInstanceScorecardIgnore'	) }       ;
		STRING		BuildInstanceStartDate										{ XPATH('BuildInstanceStartDate'				) }       ;
		STRING		BuildInstanceTargetEndDate								{ XPATH('BuildInstanceTargetEndDate'		) }       ;
		STRING		BuildInstanceTargetReleaseDate 						{ XPATH('BuildInstanceTargetReleaseDate'	) }       ;
		STRING		BuildInstanceTargetStartDate 							{ XPATH('BuildInstanceTargetStartDate'		) }       ;
		STRING		BuildInstanceUpdateDate 									{ XPATH('BuildInstanceUpdateDate'					) }       ;
		STRING		BuildInstanceUpdateFrequency 							{ XPATH('BuildInstanceUpdateFrequency'		) }       ;
		STRING		BuildInstanceUpdateUser 									{ XPATH('BuildInstanceUpdateUser'					) }       ;
		STRING		BuildInstanceVolume 											{ XPATH('BuildInstanceVolume'							) }       ;
		STRING		BuildName 																{ XPATH('BuildName'												) }       ;
		STRING		BuildStatus 															{ XPATH('BuildStatus'											) }       ;
		STRING		BuildStatusDescription 										{ XPATH('BuildStatusDescription'					) }       ;
		STRING		BuildVersion															{ XPATH('BuildVersion'										) }       ;
		STRING		Documentation															{ XPATH('Documentation'										) }       ;
		STRING		HpccWorkUnit															{ XPATH('HpccWorkUnit'										) }       ;
		STRING		MasterBuild																{ XPATH('MasterBuild'											) }       ;
		STRING		MasterBuildStatus													{ XPATH('MasterBuildStatus'								) }       ;
		STRING		MasterBuildType														{ XPATH('MasterBuildType'									) }       ;
		STRING		NewCoverage																{ XPATH('NewCoverage'											) }       ;
		STRING		Notes																			{ XPATH('Notes'														) }       ;
		STRING		OutputFileType														{ XPATH('OutputFileType'									) }       ;
		STRING		OutputFileURL															{ XPATH('OutputFileURL'										) }       ;
		rPlatforms	Platforms																{ XPATH('Platforms'												) }       ;
		STRING		Reason																		{ XPATH('Reason'													) }       ;
//		STRING		ReceivingDetails													{ XPATH('ReceivingDetails'								) }       ;
    Dataset(rReceivingDetails) ReceivingDetails					{ XPATH('ReceivingDetails'								) }       ;
		STRING		ScorecardExclude													{ XPATH('ScorecardExclude'								) }       ;
		STRING		SequenceId																{ XPATH('SequenceId'											) }       ;
		STRING		SequenceStatus														{ XPATH('SequenceStatus'									) }       ;
		STRING		SkippedBuild															{ XPATH('SkippedBuild'										) }       ;
		rStatus		Status																		{ XPATH('Status'													) }       ;
		STRING		VolumeId																	{ XPATH('VolumeId'												) }       ;
	END;
	// -
	rBuildsR 		:= 	RECORD
		rBuildIBR			BuildIBR 											{	XPATH('BuildInstanceBuildResponse'	)	}							;
	END;
	// -
	rResponse		:=	RECORD
		rBuildsR		 	Builds 												{	XPATH('Builds'											)	}							;
		rOrbit			 	OrbitStatus 									{	XPATH('OrbitStatus'									)	}							;
		STRING 				OriginalRequest								{	XPATH('OriginalRequest'							)	}							;
	END;
		//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(		_SystemConstants.TargetURL
													,	_SystemConstants.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(_SystemConstants.OrbitRR(sService)	)
													,	NAMESPACE(_SystemConstants.Namespace_D)
													,	LITERAL
													,	SOAPACTION(_SystemConstants.SoapPath(sService) )
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	RETURN	OrbitCall	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
END ; // End GetBuildInstance Module


// Begin GetCandidates Function	
EXPORT GetCandidates ( 		STRING BuildName
												, STRING BuildVersion
												, STRING TOKEN
											) := FUNCTION
	IMPORT BAIR;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'GetCandidates'	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	// -
	rBuild		:= 	RECORD
		STRING			orbBuildName		 						{	XPATH('orb:BuildName'							)	}	:= 	BuildName			; 
		STRING			orbBuildVersion							{	XPATH('orb:BuildVersion'					)	}	:= 	BuildVersion	; 

	END	;
	//	-
	rBuilds		:= 	RECORD
		rBuild			orbBuild 										{	XPATH('orb:BuildData'		)	}															;								
	END	;
	// -
	rLex			:= 	RECORD
		rBuilds		 	orbBuilds		 								{	XPATH('orb:Builds'								)	}										;
		STRING 			orbToken 										{	XPATH('orb:Token'									)	}	:= 	TOKEN					;	
		END	;
	// -
	rRequest	:= 	RECORD
		rLex				lexRequest									{	XPATH('lex:request'								)	}										;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - RESPONSE
	outDS_Layout := RECORD
		STRING			BuildInstanceDate						{ XPATH('BuildInstanceDate'			)	}	;
		STRING			BuildInstanceID							{ XPATH('BuildInstanceId'				)	}	;
		STRING			BuildInstanceName						{ XPATH('BuildInstanceName'			)	}	;
		STRING			BuildInstanceVersion				{ XPATH('BuildInstanceVersion'	)	}	;
		STRING			BuildStatus									{ XPATH('BuildStatus'						)	}	;
		STRING			FileName										{ XPATH('FileName'							)	}	;
		STRING			ItemId											{ XPATH('ItemId'								)	}	;
		STRING			ItemName										{ XPATH('ItemName'							)	}	;
		STRING			BatchR3LandingZone					{ XPATH('BatchR3LandingZone'		)	}	;
		STRING			ReceiveDate									{ XPATH('ReceiveDate'						)	}	;
		STRING			ReceivingID									{ XPATH('ReceivingID'						)	}	;
		STRING			ReceivingStatus							{ XPATH('ReceivingStatus'				)	}	;
		STRING			SourceName									{ XPATH('SourceName'						)	}	;
	END	;
	
	rCandR := RECORD
		DATASET(outDS_Layout)	outDS							{ XPATH('CandidateInstance'			)	}	;
	END	;
	//-
	rBuildData := RECORD
		STRING			orbBuildName		 						{	XPATH('BuildName'							)	}	; 
		STRING			orbBuildVersion							{	XPATH('BuildVersion'					)	}	; 
		rCandR			CandidatesR									{ XPATH('CandidateInstances'		)	}	;
	END	;
	//-	
	rBuildsR	:=	RECORD
		rBuildData		BuildData								{ XPATH('BuildData'								)	}	;
	END	;
	//-	
	rResponse :=	RECORD
		rBuildsR		BuildsComponents					{ XPATH('BuildComponents'					)	}	;
	END;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(		_SystemConstants.TargetURL
													,	_SystemConstants.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(_SystemConstants.OrbitRR(sService)	)
													,	NAMESPACE(_SystemConstants.Namespace_D)
													,	LITERAL
													,	SOAPACTION(_SystemConstants.SoapPath(sService) )
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	RETURN	OrbitCall;
	//-----------------------------------------------------------------------------------------------------------------------------------------
END	;	// End GetCandidates Function	


// Begin GetContributionData Function
EXPORT GetContributionData (		STRING FileSourceId
															, STRING MemberId
															, STRING Token
														)	:= FUNCTION
	IMPORT BAIR;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'GetContributionData'	;	
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	rInput		:= 	RECORD
		STRING			orbFileSourceId		 						{	XPATH('orb:FileSourceId'						)	}		:= 	FileSourceId		;
		STRING			orbMemberId				 						{	XPATH('orb:MemberId'								)	}		:= 	MemberId				;
	END	;
	// -
	rItems1		:=	RECORD
		rInput			orbInputSourceItem 						{	XPATH('orb:InputSourceItem'					)	}												;						
	END	;
	// -
	rLex			:= 	RECORD
		rItems1 		orbItems 											{	XPATH('orb:Items'										)	}												;
		STRING 			orbToken 											{	XPATH('orb:Token'										)	}		:=	Token						;	
	END	;
	// -
	rRequest	:= 	RECORD
		rLex 				lexRequest										{	XPATH('lex:request'									)	}												;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - RESPONSE
	rOrbit 		:= 	RECORD
		STRING			OrbitStatusCode								{	XPATH('OrbitStatusCode'							)	}												;
		STRING			OrbitStatusDescription				{	XPATH('OrbitStatusDescription'			)	}												;
	END	;
	//-
	rStatus 	:= 	RECORD
		STRING			Code													{	XPATH('Code'												)	}												;
		STRING			Description										{	XPATH('Description'									)	}												;
		STRING			Status												{	XPATH('Status'											)	}												;
	END	;
	//-
	rKey		 	:= 	RECORD
		STRING			Key			 											{	XPATH('Key'													)	}												;
		STRING			Value			 										{	XPATH('Value'												)	}												;
	END	;
	//-
	rExIDs 		:= 	RECORD
		rKey				KeyValueOfstringstring				{	XPATH('KeyValueOfstringstring'			)	}												;
	END	;
	//-	
	rContrib	:= 	RECORD
		STRING			Analyst			 									{	XPATH('Analyst'											)	}												;
		STRING			ContributorId			 						{	XPATH('ContributorId'								)	}												;
		STRING			ContributorType			 					{	XPATH('ContributorType'							)	}												;
		STRING			CustomerNumber			 					{	XPATH('CustomerNumber'							)	}												;
		STRING			DataClassification						{	XPATH('DataClassification'					)	}												;
		STRING			DataType											{	XPATH('DataType'										)	}												;
		STRING			DateSelectionOverride					{	XPATH('DateSelectionOverride'				)	}												;
		// rExIDs 			ExternalIDs 									{	XPATH('ExternalIds'									)	}												;
		STRING 			ExternalIDs 									{	XPATH('ExternalIds'									)	}	:= ''											;
		STRING			FileSourceId									{	XPATH('FileSourceId'								)	}												;
		STRING			IsItemOnHold									{	XPATH('IsItemOnHold'								)	}												;
		STRING			IsRestricted									{	XPATH('IsRestricted'								)	}												;
		STRING			IsTestItem										{	XPATH('IsTestItem'									)	}												;
		STRING			ItemDataType									{	XPATH('ItemDataType'								)	}												;
		STRING			ItemFrequency									{	XPATH('ItemFrequency'								)	}												;
		STRING			ItemId												{	XPATH('ItemId'											)	}												;
		STRING			ItemName											{	XPATH('ItemName'										)	}												;
		STRING			ItemStatus										{	XPATH('ItemStatus'									)	}												;
		STRING			ItemUpdateType								{	XPATH('ItemUpdateType'							)	}												;
		STRING			BatchR3LandingZone						{	XPATH('BatchR3LandingZone'					)	}												;
		STRING			MediaType											{	XPATH('MediaType'										)	}												;
		STRING			MemberId											{	XPATH('MemberId'										)	}												;
		STRING			ProductUsage									{	XPATH('ProductUsage'								)	}												;
		STRING			ReformatCode									{	XPATH('ReformatCode'								)	}												;
		STRING			SourceId											{	XPATH('SourceId'										)	}												;
		STRING			SourceName										{	XPATH('SourceName'									)	}												;
		rStatus			Status												{	XPATH('Status'											)	}												; 
	END	;
	//-	
	rItems2 	:= 	RECORD
		rContrib 		ContributionItem							{	XPATH('ContributionItem'						)	}												;
	END	;
	//-	
	rResponse := 	RECORD
		rItems2 		Items 												{	XPATH('Items'												)	}												;
		rOrbit			OrbitStatus 									{	XPATH('OrbitStatus'									)	}												; 
		STRING 			OriginalRequest								{	XPATH('OriginalRequest'							)	}												;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(		_SystemConstants.TargetURL
													,	_SystemConstants.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(_SystemConstants.OrbitRR(sService)	)
													,	NAMESPACE(_SystemConstants.Namespace_D)
													,	LITERAL
													,	SOAPACTION(_SystemConstants.SoapPath(sService) )
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	RETURN	OrbitCall	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
END	;	// End GetContributionData Function


// Begin LoginBair Function
EXPORT LoginBAIR (		STRING UserName
										,	STRING Password
										,	STRING TargetURL = _SystemConstants.TargetURL
										,	STRING Domain = Constants.Domain
									)	:= FUNCTION

	//-----------------------------------------------------------------------------------------------------------------------------------------
	//   STRING sService := 'LoginBair'	; as per Tatiana's request on 09/01/2015
	     STRING sService := 'LoginSBFE'	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	rRequest	:= 	RECORD
			STRING		OrbitDomain			{	XPATH('lex:orbitDomain'												)	}		:=	Domain				;
			STRING 		OrbitUsername 	{	XPATH('lex:userName'													)	}		:=	UserName			;
			STRING		OrbitPassword 	{	XPATH('lex:password'													)	}		:=	Password			;								
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	rResponse	:=	RECORD
			STRING		OrbitToken			{	XPATH(Constants.OrbitRR(sService)	)	}											;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(		TargetURL
													,	_SystemConstants.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	NAMESPACE(_SystemConstants.Namespace_D)
													,	LITERAL
													,	SOAPACTION(_SystemConstants.SoapPath(sService) )
													, LOG
												)	: GLOBAL	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	RETURN	OrbitCall.OrbitToken; // Returns only the token string
	//-----------------------------------------------------------------------------------------------------------------------------------------
END	; // End LoginBair Function


// Login 
EXPORT Login := MODULE
 EXPORT STRING	Creds := LoginBAIR(Constants.OrbitUser, Constants.OrbitPassword);
END	;// End Login

// Begin CreateBuild Function
EXPORT CreateBuild ( 		STRING BuildName
											, STRING BuildStatus
											, STRING BuildVersion
											, STRING HpccWorkUnit
											, STRING MasterBuild
											, STRING TOKEN
										) := FUNCTION
	IMPORT BAIR;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'CreateBuild'	;
	IMPORT ut;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	rBuild		:= 	RECORD
		STRING			orbBuildName		 						{	XPATH('orb:BuildName'							)	}	:= 	BuildName			; 
		STRING			orbBuildStatus		 					{	XPATH('orb:BuildStatus'						)	}	:= 	BuildStatus		; 
		STRING			orbBuildVersion							{	XPATH('orb:BuildVersion'					)	}	:= 	BuildVersion	; 
		STRING			orbHpccWorkUnit							{	XPATH('orb:HpccWorkUnit'					)	}	:= 	HpccWorkUnit	;	
		STRING			orbMasterBuild							{	XPATH('orb:MasterBuild'						)	}	:= 	MasterBuild		;	
	END	;
	//	-
	rBuilds		:= 	RECORD
		rBuild			orbBuild 										{	XPATH('orb:Build'									)	}										;								
	END	;
	// -
	rLex			:= 	RECORD
		rBuilds		 	orbBuilds		 								{	XPATH('orb:Builds'								)	}										;
		STRING 			orbToken 										{	XPATH('orb:Token'									)	}	:= 	TOKEN					;	
		END	;
	// -
	rRequest	:= 	RECORD
		rLex				lexRequest									{	XPATH('lex:request'								)	}										;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - RESPONSE
	rBuild2		:= 	RECORD
		STRING			BuildId											{	XPATH('BuildId'										)	}										;
	END;
	//-	
	rBuilds2 		:= 	RECORD
		rBuild2			Build2											{	XPATH('BuildResponse'						)	}										;	
	END;
	//-
	rOrbit 		:= 	RECORD
		STRING			OrbitStatusCode							{	XPATH('OrbitStatusCode'						)	}										;
		STRING			OrbitStatusDescription			{	XPATH('OrbitStatusDescription'		)	}										;	
	END;
	//-		
	rResponse :=	RECORD
		rBuilds2		Builds2Response							{	XPATH('Builds'										)	}										;
		rOrbit			OrbitStatus 								{	XPATH('OrbitStatus'								)	}										;
		STRING 			OriginalRequest							{	XPATH('OriginalRequest'						)	}										;
	END;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(		_SystemConstants.TargetURL
													,	_SystemConstants.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(_SystemConstants.OrbitRR(sService)	)
													,	NAMESPACE(_SystemConstants.Namespace_B)
													,	LITERAL
													,	SOAPACTION(_SystemConstants.SoapPath(sService) )
													, LOG
												)	;
	// -----------------------------------------------------------------------------------------------------------------------------------------
	//RETURN	(UNSIGNED4)OrbitCall.Builds2Response.Build2.BuildId	;
	RETURN	OrbitCall.OrbitStatus.OrbitStatusDescription;
	//-----------------------------------------------------------------------------------------------------------------------------------------
END	;	// End CreateBuild Function	

// Start GetFileInstance Function
EXPORT GetFileInstance( String Scrubbuildinstance, String ExternalID  ) := FUNCTION 

IMPORT BAIR;
	STRING36  	oLogin			:= login.creds		: INDEPENDENT	;


	layout_getInstance:= RECORD
		string ScrubBuildInstanceID {xpath('orb:InstanceId')}  := Scrubbuildinstance;
		string SBFEExternalID {xpath('orb:MemberId')} := ExternalID;
	END;
	
		rFileInst := RECORD
					layout_getInstance rFileInstance {xpath('orb:InputInstances')};
		END;
	
	//File Instance Data + token

		rOrbitRequest := record 
					rFileInst FileInstance 	{xpath('orb:Instances')};
					string  LoginToken	{xpath('orb:Token'),maxlength(36)} := oLogin;

		end;

	// request tag
	
		rRequestCapsule	:=  record
					rOrbitRequest				OrbitRequest	{xpath('lex:request')};
		end;

	//Response Layouts

		rStatHistory :=  RECORD
					String  DateTime{xpath('DateTime')};
					String  InstanceId{xpath('InstanceId')};
					String 	StatusId{xpath('StatusId')};
					string 	StatusName{xpath('StatusName')};
					string 	SubStatusCode{xpath('SubStatusCode')};
					string 	SubStatusName{xpath('SubStatusName')};
					string  UserName{xpath('UserName')};
		END;
		
		ritemstatus := RECORD
					String  Code{xpath('Code')};
					String  Description{xpath('Description')};
					String 	Status{xpath('Status')};
		END;


		rBuildStatusResponse := RECORD
					String  BuildInstanceId{xpath('BuildInstanceId')};
					String  BuildName{xpath('BuildName')};
					String  BuildVersion{xpath('BuildVersion')};
					String  DWId{xpath('DWId')};
					String  DataSetId{xpath('DataSetId')};
					String  DataSetName{xpath('DataSetName')};
					String 	FileName{xpath('FileName')};
					String 	InstanceId{xpath('InstanceId')};
					ritemstatus ItemStatus {xpath('ItemStatus')};
					String  MasterBuildDescription{xpath('MasterBuildDescription')};
					String  MasterBuildName{xpath('MasterBuildName')};
					String  MemberId{xpath('MemberId')};
					String  SBFEExternalMemberId{xpath('SBFEExternalMemberId')};
					String  SourceName{xpath('SourceName')};
					dataset(rStatHistory)	rStatusHistory	{xpath('StatusHistoryList/StatusHistory')};
		end;


	// response
	
		rSOAPResponse	:= record	
					string request {xpath('OriginalRequest')};
					dataset(rBuildStatusResponse) GetFileInstanceResult {xpath('Instances/InstanceResponse')};
      		string OrbitStatusCode {xpath('OrbitStatus/OrbitStatusCode')};
					string OrbitStatusDescription {xpath('OrbitStatus/OrbitStatusDescription')};
	  end;
		 
		rSOAPResponse failtransform() := transform
					self.OrbitStatusCode := (string)FAILCODE;
					self.OrbitStatusDescription := FAILMESSAGE;
					self := [];
		end;
		 
    
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'GetFileInstance'	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
		soapresponse1 := SOAPCALL( _SystemConstants.TargetURL
															,_SystemConstants.SOAPService(sService)
															,rRequestCapsule
															,rSOAPResponse
															,XPATH(_SystemConstants.OrbitRR(sService)	)
															,NAMESPACE(_SystemConstants.Namespace_C)
															,LITERAL
															,SOAPACTION(_SystemConstants.SoapPath(sService) )
													    );
															
return soapresponse1;
END; // End GetFileInstance Function


// Begin ReceiveItem Function

EXPORT ReceiveItem	(		STRING CoverageEndDate
											,	STRING Description
											,	STRING IsItemOnHold
											,	STRING IsTestInstance
											,	STRING Item
											,	STRING MediaType
											,	STRING NextExpectedDate
											,	STRING ReceiveDate
											,	STRING ReceivingType
											,	STRING SourceName
											,	STRING UpdateType
											,	STRING Token
										)	:= FUNCTION 
	IMPORT Bair;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'ReceiveItem'	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	rReceiveR		:= 	RECORD
		STRING 				orbCoverageEndDate				{	XPATH('orb:CoverageEndDate'							)	} := CoverageEndDate			; //'2013-08-08'
		STRING 				orbDescription						{	XPATH('orb:Description'									)	} := Description					; //'Testing from SOAP UI'
		STRING 				orbIsItemOnHold						{	XPATH('orb:IsItemOnHold'								)	} := IsItemOnHold					; //'false'
		STRING 				orbIsTestInstance					{	XPATH('orb:IsTestInstance'							)	} := IsTestInstance				; //'false'
		STRING 				orbItem										{	XPATH('orb:Item'												)	} := Item									; //'AMERICAN EXPRESS - CHARGE'	
		STRING 				orbMediaType							{	XPATH('orb:MediaType'										)	} := MediaType						; //'SFTP'
		STRING 				orbNextExpectedDate				{	XPATH('orb:NextExpectedDate'						)	} := NextExpectedDate			; //'2013-08-09'	
		STRING 				orbReceiveDate						{	XPATH('orb:ReceiveDate'									)	} := ReceiveDate					; //'2013-08-08'
		STRING 				orbReceivingType					{	XPATH('orb:ReceivingType'								)	} := ReceivingType				; //'Contribution'	
		STRING 				orbSourceName							{	XPATH('orb:SourceName'									)	} := SourceName						; //'American Express'
		STRING 				orbUpdateType							{	XPATH('orb:UpdateType'									)	} := UpdateType						; //'Full-Append'
	END	;
	// -
	rReceivings	:= 	RECORD
		rReceiveR			orbReceiveRequest 				{	XPATH('orb:ReceiveRequest'							)	}																						;
										
	END	;
	// -
	rLex			 	:= 	RECORD
		rReceivings 	orbReceivings 						{	XPATH('orb:Receivings'									)	}																						;	
		STRING 				orbToken 									{	XPATH('orb:Token'												)	}	:= 	Token																	;
	END	;
	// -
	rRequest		:= 	RECORD
		rLex 					lexRequest								{	XPATH('lex:request'											)	}																						;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - RESPONSE
	rStatus 		:= 	RECORD
		STRING				Code												{	XPATH('Code'														)	}																						;
		STRING				Description									{	XPATH('Description'											)	}																						;
		STRING				Status											{	XPATH('Status'													)	}																						;
	END	;
	//-	
	rReceiving 	:= 	RECORD
		STRING				Item			 									{	XPATH('Item'														)	}																						;
		STRING				ReceivingId			 						{	XPATH('ReceivingId'											)	}																						;
		rStatus				Status											{	XPATH('Status'													)	}																						;
	END	;
	//-	
	rReceivingsR := 	RECORD
		rReceiving 		Receiving										{	XPATH('Receiving'												)	}																						;
	END;
	//-
	rOrbit 			:= 	RECORD
		STRING				OrbitStatusCode							{	XPATH('OrbitStatusCode'									)	}																						;
		STRING				OrbitStatusDescription			{	XPATH('OrbitStatusDescription'					)	}																						;
	END;
	//-
	rResponse 	:= 	RECORD
		rOrbit				OrbitStatus 								{	XPATH('OrbitStatus'											)	}																						; 
		STRING 				OriginalRequest							{	XPATH('OriginalRequest'									)	}																						;
		rReceivingsR 	Receivings 									{	XPATH('Receivings'											)	}																						;
	END;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(		_SystemConstants.TargetURL
													,	_SystemConstants.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(_SystemConstants.OrbitRR(sService)	)
													,	NAMESPACE(_SystemConstants.Namespace_D)
													,	LITERAL
													,	SOAPACTION(_SystemConstants.SoapPath(sService) )
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	RETURN	OrbitCall.Receivings.Receiving.ReceivingId	;
	// RETURN	OrbitCall	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	END	;	// End ReceiveItem Function
	
	
// Begin getScrubBuildCandidates Function	
	EXPORT getScrubBuildCandidates ( 		STRING BuildName
																	, STRING BuildVersion
																	, STRING TOKEN
																) := FUNCTION
	IMPORT BAIR;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'GetCandidates'	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	// -
	rBuild		:= 	RECORD
		STRING			orbBuildName		 						{	XPATH('orb:BuildName'							)	}	:= 	BuildName			; 
		STRING			orbBuildVersion							{	XPATH('orb:BuildVersion'					)	}	:= 	BuildVersion	; 

	END	;
	//	-
	rBuilds		:= 	RECORD
		rBuild			orbBuild 										{	XPATH('orb:BuildData'		)	}															;								
	END	;
	// -
	rLex			:= 	RECORD
		rBuilds		 	orbBuilds		 								{	XPATH('orb:Builds'								)	}										;
		STRING 			orbToken 										{	XPATH('orb:Token'									)	}	:= 	TOKEN					;	
		END	;
	// -
	rRequest	:= 	RECORD
		rLex				lexRequest									{	XPATH('lex:request'								)	}										;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - RESPONSE
	outDS_Layout := RECORD
		STRING			BuildInstanceDate						{ XPATH('BuildInstanceDate'			)	}	;
		STRING			BuildInstanceID							{ XPATH('BuildInstanceId'				)	}	;
		STRING			BuildInstanceName						{ XPATH('BuildInstanceName'			)	}	;
		STRING			BuildInstanceVersion				{ XPATH('BuildInstanceVersion'	)	}	;
		STRING			BuildStatus									{ XPATH('BuildStatus'						)	}	;
		STRING			FileName										{ XPATH('FileName'							)	}	;
		STRING			ItemId											{ XPATH('ItemId'								)	}	;
		STRING			ItemName										{ XPATH('ItemName'							)	}	;
		STRING			BatchR3LandingZone					{ XPATH('BatchR3LandingZone'		)	}	;
		STRING			ReceiveDate									{ XPATH('ReceiveDate'						)	}	;
		STRING			ReceivingID									{ XPATH('ReceivingID'						)	}	;
		STRING			ReceivingStatus							{ XPATH('ReceivingStatus'				)	}	;
		STRING			SourceName									{ XPATH('SourceName'						)	}	;
	END	;
	
	rCandR := RECORD
		DATASET(outDS_Layout)	outDS							{ XPATH('CandidateInstance'			)	}	;
	END	;
	//-
	rBuildData := RECORD
		STRING			orbBuildName		 						{	XPATH('BuildName'							)	}	; 
		STRING			orbBuildVersion							{	XPATH('BuildVersion'					)	}	; 
		rCandR			CandidatesR									{ XPATH('CandidateInstances'		)	}	;
	END	;
	//-	
	rBuildsR	:=	RECORD
		rBuildData		BuildData								{ XPATH('BuildData'								)	}	;
	END	;
	//-	
	rResponse :=	RECORD
		rBuildsR		BuildsComponents					{ XPATH('BuildComponents'					)	}	;
	END;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(		_SystemConstants.TargetURL
													,	_SystemConstants.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(_SystemConstants.OrbitRR(sService)	)
													,	NAMESPACE(_SystemConstants.Namespace_D)
													,	LITERAL
													,	SOAPACTION(_SystemConstants.SoapPath(sService) )
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	AllCandidates := 	OrbitCall.BuildsComponents.BuildData.CandidatesR.outDS;
	AvailableOnly := AllCandidates(BuildStatus = 'BuildAvailableForUse');
	
	RETURN AvailableOnly;
	//-----------------------------------------------------------------------------------------------------------------------------------------
END	;	// End getScrubBuildCandidates Function


// Begin ScrubAddComponents Function
inDS_Layout := RECORD
		STRING			BuildInstanceDate						{ XPATH('BuildInstanceDate'			)	}	;
		STRING			BuildInstanceID							{ XPATH('BuildInstanceId'				)	}	;
		STRING			BuildInstanceName						{ XPATH('BuildInstanceName'			)	}	;
		STRING			BuildInstanceVersion				{ XPATH('BuildInstanceVersion'	)	}	;
END;

EXPORT ScrubAddComponents 		( 		STRING BuildId
																	,	STRING BuildName
																	, STRING BuildVersion
																	,	DATASET (inDS_Layout) ReceivingIDs
																	, STRING TOKEN
															) := FUNCTION
	IMPORT BAIR;
	//--------------------------------------------------------------------------------------------------------------------
	STRING sService := 'AddComponentsToABuild'	;
	//--------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	rComp			:=	RECORD
		DATASET(inDS_Layout)		inDS						{ XPATH('orb:ComponentToAdd'				)	} := ReceivingIDs		;
	END	;
	// -
	rBuild		:= 	RECORD
		STRING			orbBuildName		 						{	XPATH('orb:BuildName'							)	}	:= 	BuildName			; 
		STRING			orbBuildVersion							{	XPATH('orb:BuildVersion'					)	}	:= 	BuildVersion	;
		rComp				orbComponents								{ XPATH('orb:Components'						)	}										;			
	END	;
	//	-
	rBuilds		:= 	RECORD
		rBuild			orbBuild 										{	XPATH('orb:BuildInstanceToAdd'		)	}										;								
	END	;
	// -
	rLex			:= 	RECORD
		rBuilds		 	orbBuilds		 								{	XPATH('orb:Builds'								)	}										;
		STRING 			orbToken 										{	XPATH('orb:Token'									)	}	:= 	TOKEN					;	
		END	;
	// -
	rRequest	:= 	RECORD
		rLex				lexRequest									{	XPATH('lex:request'								)	}										;
	END	;
	//--------------------------------------------------------------------------------------------------------------------
	rOrbit 		:= 	RECORD
		STRING			OrbitStatusCode							{	XPATH('OrbitStatusCode'						)	}										;
		STRING			OrbitStatusDescription			{	XPATH('OrbitStatusDescription'		)	}										;	
	END;
	//-
	outDS_Layout	:=	RECORD
		STRING			BuildId2										{	XPATH('BuildId'										)	}										;
		STRING			BuildName2									{	XPATH('BuildName'									)	}										;
		STRING			BuildVersion2								{	XPATH('BuildVersion'							)	}										;
		STRING			MasterBuildId2							{	XPATH('MasterBuildId'							)	}										;
		STRING			ReceivingId									{	XPATH('ReceivingId'								)	}										;
		STRING			Status											{	XPATH('Status'										)	}										;
	END	;
	//-
	rCompR		:=	RECORD
		DATASET(outDS_Layout)		outDS						{ XPATH('ComponentToAdd'						)	}										;
	END	;
	//-	
	rInstance	:=	RECORD
		STRING			BuildId											{	XPATH('BuildId'										)	}										;
		STRING			BuildName										{	XPATH('BuildName'									)	}										;
		STRING			BuildVersion								{	XPATH('BuildVersion'							)	}										;
		rCompR			ComponentsR									{ XPATH('Components'								)	}										;
		STRING			MasterBuildId								{	XPATH('MasterBuildId'							)	}										;
		STRING			Status											{	XPATH('Status'										)	}										;
	END	;
	//-	
	rBuildsR	:=	RECORD
		rInstance		InstanceToAdd								{ XPATH('BuildInstanceToAdd'				)	}										;
	END	;
	//-	
	rResponse :=	RECORD
		rBuildsR		BuildsResponse							{ XPATH('Builds'										)	}										;
		rOrbit			OrbitStatus 								{	XPATH('OrbitStatus'								)	}										;
		STRING 			OriginalRequest							{	XPATH('OriginalRequest'						)	}										;
	END;
	//--------------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(		_SystemConstants.TargetURL
													,	_SystemConstants.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(_SystemConstants.OrbitRR(sService)	)
													,	NAMESPACE(_SystemConstants.Namespace_D)
													,	LITERAL
													,	SOAPACTION(_SystemConstants.SoapPath(sService) )
													, LOG
												)	;
	//--------------------------------------------------------------------------------------------------------------------
	RETURN	OrbitCall;
	//--------------------------------------------------------------------------------------------------------------------
END	;	// End ScrubAddComponents Function


// Begin SetSubStatus Function

IMPORT BAIR;

EXPORT SetSubStatus ( STRING ReceivingId
												, STRING Status
												, STRING Token
											)	:= FUNCTION

	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'SetSubStatus'	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	rLex			:= 	RECORD
		STRING			orbID									{	XPATH('orb:Id'									)	}		:= 	ReceivingId 	;
		STRING			orbSubStatus					{	XPATH('orb:SubStatus'						)	}		:= 	Status				;
		STRING 			orbToken 							{	XPATH('orb:Token'								)	}		:= 	Token					;	
	END	;
	// -
	rRequest	:= 	RECORD
		rLex 				lexRequest						{	XPATH('lex:request'							)	}											;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - RESPONSE
	rOrbit 		:= 	RECORD
		STRING			OrbitStatusCode								{	XPATH('OrbitStatusCode'									)	}											;
		STRING			OrbitStatusDescription				{	XPATH('OrbitStatusDescription'					)	}											;
	END;
	//-	
	rResponse := 	RECORD
		rOrbit			OrbitStatus 									{	XPATH('OrbitStatus'											)	}											;
		STRING 			OriginalRequest								{	XPATH('OriginalRequest'									)	}											;
	END;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(		_SystemConstants.TargetURL
													,	_SystemConstants.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(_SystemConstants.OrbitRR(sService)	)
													,	NAMESPACE(_SystemConstants.Namespace_D)
													,	LITERAL
													,	SOAPACTION(_SystemConstants.SoapPath(sService) )
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	RETURN	OrbitCall.OrbitStatus.OrbitStatusCode	;
	// RETURN	OrbitCall	;
	// -----------------------------------------------------------------------------------------------------------------------------------------
END	;// End SetSubStatus Function


// Begin SubmissionAddComponents Function

inDS_Layout := RECORD
STRING			orbReceivingIDs		{	XPATH('orb:ReceivingId'	)	} 	;
END;

EXPORT SubmissionAddComponents ( 		STRING BuildId
																	,	STRING BuildName
																	, STRING BuildVersion
																	,	DATASET (inDS_Layout) ReceivingIDs
																	, STRING Token
															) := FUNCTION
	IMPORT BAIR;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'AddComponentsToABuild'	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	// -
	rComp			:=	RECORD
		DATASET(inDS_Layout)		inDS						{ XPATH('orb:ComponentToAdd'				)	} := ReceivingIDs		;
	END	;
	// -
	rBuild		:= 	RECORD
		STRING			orbBuildID			 						{	XPATH('orb:BuildId'								)	}	:= 	BuildId				; 	
		STRING			orbBuildName		 						{	XPATH('orb:BuildName'							)	}	:= 	BuildName			; 
		STRING			orbBuildVersion							{	XPATH('orb:BuildVersion'					)	}	:= 	BuildVersion	; 
		rComp				orbComponents								{ XPATH('orb:Components'						)	}										;		
	END	;
	//	-
	rBuilds		:= 	RECORD
		rBuild			orbBuild 										{	XPATH('orb:BuildInstanceToAdd'		)	}										;								
	END	;
	// -
	rLex			:= 	RECORD
		rBuilds		 	orbBuilds		 								{	XPATH('orb:Builds'								)	}										;
		STRING 			orbToken 										{	XPATH('orb:Token'									)	}	:= 	Token					;	
		END	;
	// -
	rRequest	:= 	RECORD
		rLex				lexRequest									{	XPATH('lex:request'								)	}										;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - RESPONSE
	rOrbit 		:= 	RECORD
		STRING			OrbitStatusCode							{	XPATH('OrbitStatusCode'						)	}										;
		STRING			OrbitStatusDescription			{	XPATH('OrbitStatusDescription'		)	}										;	
	END;
	//-
	outDS_Layout	:=	RECORD
		STRING			BuildId2										{	XPATH('BuildId'										)	}										;
		STRING			BuildName2									{	XPATH('BuildName'									)	}										;
		STRING			BuildVersion2								{	XPATH('BuildVersion'							)	}										;
		STRING			MasterBuildId2							{	XPATH('MasterBuildId'							)	}										;
		STRING			ReceivingId									{	XPATH('ReceivingId'								)	}										;
		STRING			Status											{	XPATH('Status'										)	}										;
	END	;
	//-
	rCompR		:=	RECORD
		DATASET (outDS_Layout)	outDS						{ XPATH('ComponentToAdd'						)	}										;
	END	;
	//-	
	rInstance	:=	RECORD
		STRING			BuildId											{	XPATH('BuildId'										)	}										;
		STRING			BuildName										{	XPATH('BuildName'									)	}										;
		STRING			BuildVersion								{	XPATH('BuildVersion'							)	}										;
		rCompR			ComponentsR									{ XPATH('Components'								)	}										;
		STRING			MasterBuildId								{	XPATH('MasterBuildId'							)	}										;
		STRING			Status											{	XPATH('Status'										)	}										;
	END	;
	//-	
	rBuildsR	:=	RECORD
		rInstance		InstanceToAdd								{ XPATH('BuildInstanceToAdd'				)	}										;
	END	;
	//-	
	rResponse :=	RECORD
		rBuildsR		BuildsResponse							{ XPATH('Builds'										)	}										;
		rOrbit			OrbitStatus 								{	XPATH('OrbitStatus'								)	}										;
		STRING 			OriginalRequest							{	XPATH('OriginalRequest'						)	}										;
	END;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(		_SystemConstants.TargetURL
													,	_SystemConstants.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(_SystemConstants.OrbitRR(sService)	)
													,	NAMESPACE(_SystemConstants.Namespace_D)
													,	LITERAL
													,	SOAPACTION(_SystemConstants.SoapPath(sService) )
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	RETURN	OrbitCall;
	//-----------------------------------------------------------------------------------------------------------------------------------------
END	;	// End SubmissionAddComponents Function


// Begin UpdateBuildStatus Function

EXPORT UpdateBuildStatus (		STRING BuildName
														, STRING BuildStatus
														, STRING BuildVersion
														, STRING Comments 
														, STRING TOKEN
													) := FUNCTION
	IMPORT BAIR;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'UpdateBuildStatus'	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	rBuild		:= 	RECORD
		STRING			orbBuildName		 						{	XPATH('orb:BuildName'							)	}	:= 	BuildName			;
		STRING			orbBuildStatus							{	XPATH('orb:BuildStatus'						)	}	:= 	BuildStatus		;
		STRING			orbBuildVersion							{	XPATH('orb:BuildVersion'					)	}	:= 	BuildVersion	;
		STRING			orbBuildComments						{	XPATH('orb:Comments'			 				)	}	:= 	Comments			;		
	END	;
	//	-
	rBuilds		:= 	RECORD
		rBuild			orbBuild 										{	XPATH('orb:BuildForStatusUpdate'	)	}										;								
	END	;
	// -
	rLex			:= 	RECORD
		rBuilds		 	orbBuilds		 								{	XPATH('orb:Builds'								)	}										;
		STRING 			orbToken 										{	XPATH('orb:Token'									)	}	:= 	TOKEN					;	
		END	;
	// -
	rRequest	:= 	RECORD
		rLex				lexRequest									{	XPATH('lex:request'								)	}										;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - RESPONSE
	rOrbit 		:= 	RECORD
		STRING			OrbitStatusCode							{	XPATH('OrbitStatusCode'						)	}										;
		STRING			OrbitStatusDescription			{	XPATH('OrbitStatusDescription'		)	}										;	
	END;
	//-	
	rStatus 	:= 	RECORD
		STRING			Code												{	XPATH('Code'											)	}										;
		STRING			Description									{	XPATH('Description'								)	}										;
		STRING			Status											{	XPATH('Status'										)	}										;
	END	;
	//-	
	rBuildsSU	:=	RECORD
		STRING			BuildId											{	XPATH('BuildId'										)	}										;
		STRING			BuildName										{	XPATH('BuildName'									)	}										;
		STRING			BuildStatus									{	XPATH('BuildStatus'								)	}										;
		STRING			BuildVersion								{	XPATH('BuildVersion'							)	}										;
		rStatus			Status											{ XPATH('Status'										)	}										;
	END	;
	//-	
	rBuildsR	:=	RECORD
		rBuildsSU		BuildsSU										{ XPATH('BuildRespForStatusUpdate'	)	}										;
	END	;
	//-	
	rResponse :=	RECORD
		rBuildsR		BuildsR			 								{	XPATH('Builds'										)	}										;		
		STRING 			OriginalRequest							{	XPATH('OriginalRequest'						)	}										;
		rOrbit			OrbitStatus 								{	XPATH('StatusCode'								)	}										;		
	END;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(		_SystemConstants.TargetURL
													,	_SystemConstants.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(_SystemConstants.OrbitRR(sService)	)
													,	NAMESPACE(_SystemConstants.Namespace_B)
													,	LITERAL
													,	SOAPACTION(_SystemConstants.SoapPath(sService) )
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	RETURN	IF ( 		OrbitCall.BuildsR.BuildsSU.BuildID = '0'
								,	'Failure - Scrub Build Instance is invalid'
								, OrbitCall.BuildsR.BuildsSU.Status.Status
							)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
  //Return 	OrbitCall;

END	;	// End UpdateBuildStatus Function


// Begin UpdateReceive Function

/* IMPORTANT: This is a 'slimmed down' version of UpdateReceiveItem for the purposes of only having three parameters */

EXPORT UpdateReceive	(		STRING ReceiveDate
												, STRING ReceivingId
												, STRING Status
												, STRING Token
											)	:= FUNCTION
	IMPORT BAIR;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'UpdateReceiveItem'	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	rUpdate		:= 	RECORD	
		STRING			orbReceiveDate		 						{	XPATH('orb:ReceiveDate'									)	}	:= ReceiveDate			; // '2013-08-13'
		STRING			orbReceivingId		 						{	XPATH('orb:ReceivingId'									)	}	:= ReceivingId			; // '268469'
		STRING			orbStatus					 						{	XPATH('orb:Status'											)	}	:= Status						; // 'Received'
	END	;
// -
	rReceive	:= 	RECORD
		rUpdate		orbReceivings									{	XPATH('orb:UpdateReceiveItem'						)	}											;	
	END	;	
	// -
	rLex			:= 	RECORD
		rReceive		orbReceivings									{	XPATH('orb:Receivings'									)	}											;
		STRING 			orbToken 											{	XPATH('orb:Token'												)	}	:= 	Token						;	
	END	;
	// -
	rRequest	:= 	RECORD
		rLex 				lexRequest										{	XPATH('lex:request'											)	}											;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - RESPONSE
	rOrbit 		:= 	RECORD
		STRING			OrbitStatusCode								{	XPATH('OrbitStatusCode'									)	}											;
		STRING			OrbitStatusDescription				{	XPATH('OrbitStatusDescription'					)	}											;
	END;
	//-	
	rResponse := 	RECORD
		rOrbit			OrbitStatus 									{	XPATH('OrbitStatus'											)	}											;
		STRING 			OriginalRequest								{	XPATH('OriginalRequest'									)	}											;
	END;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(		_SystemConstants.TargetURL
													,	_SystemConstants.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(_SystemConstants.OrbitRR(sService)	)
													,	NAMESPACE(_SystemConstants.Namespace_D)
													,	LITERAL
													,	SOAPACTION(_SystemConstants.SoapPath(sService) )
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	//RETURN	OrbitCall.OrbitStatus.OrbitStatusCode	;
		RETURN	OrbitCall.OrbitStatus.OrbitStatusDescription	;
	//RETURN	OrbitCall;
	// -----------------------------------------------------------------------------------------------------------------------------------------
END	;	// End UpdateReceive Function


// Begin UpdateReceiveFile Function
EXPORT UpdateReceiveFile (		STRING Cluster
														, STRING FileInstanceId
														, STRING FileName
														, STRING FilePath
														, STRING FileStatus
														, STRING QueueName
														, STRING RecordCount
														, STRING ReportingEndDate
														, STRING ReportingStartDate
														, STRING ReceivingID 
														, STRING Token
													)	:= FUNCTION
	IMPORT BAIR;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'UpdateReceiveFile'	;	
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	rReceiveFR	:= 	RECORD
		STRING				orbCluster		 							{	XPATH('orb:Cluster'								)	}	:= Cluster							; // 'SOAPUI-'
		STRING				orbFileInstanceId						{	XPATH('orb:FileInstanceId'				)	}	:= FileInstanceId				; // '268577'
		STRING				orbFileName									{	XPATH('orb:FileName'							)	}	:= FileName							; // 'testingUpdateReceiveFile.txt'
		STRING				orbFilePath									{	XPATH('orb:FilePath'							)	}	:= FilePath							; // '\\\\location\\boy\\cat\\dog\\1'
		STRING				orbFileStatus								{	XPATH('orb:FileStatus'						)	}	:= FileStatus						; // 'Success'
		STRING				orbQueueName								{	XPATH('orb:QueueName'							)	}	:= QueueName						;	// 'NoQUEUE'												
		STRING				orbRecordCount							{	XPATH('orb:RecordCount'						)	}	:= RecordCount					; // '201'
		STRING				orbReportingEndDate					{	XPATH('orb:ReportingEndDate'			)	}	:= ReportingEndDate			; // '2013-08-26'
		STRING				orbReportingStartDate				{	XPATH('orb:ReportingStartDate'		)	}	:= ReportingStartDate		;	// '2013-08-26'								
	END	;
	// -
	rReceiveF		:= 	RECORD
		rReceiveFR		orbReceiveFR					 			{	XPATH('orb:ReceiveFileRequest'		)	}													;								
	END	;
	// -
	rReceivingr	:= 	RECORD
		rReceiveF			orbReceiveFiles 						{	XPATH('orb:ReceiveFiles'					)	}													;
		STRING				orbReceivingId2		 					{	XPATH('orb:ReceivingId'						)	}	:= ReceivingID					;	// '268577'							
	END	;
	// -
	rReceivings	:= 	RECORD
		rReceivingr		orbReceivingRecord 					{	XPATH('orb:ReceivingRecord'				)	}													;									
	END	;
	// -
	rLex				:= 	RECORD
		rReceivings 	orbItems 										{	XPATH('orb:Receivings'						)	}													;
		STRING 				orbToken 										{	XPATH('orb:Token'									)	}	:= 	Token								;	
	END	;
	// -
	rRequest		:= 	RECORD
		rLex					lexRequest									{	XPATH('lex:request'								)	}													;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - RESPONSE
	rOrbit 			:= 	RECORD
		STRING				OrbitStatusCode							{	XPATH('OrbitStatusCode'						)	}													;
		STRING				OrbitStatusDescription			{	XPATH('OrbitStatusDescription'		)	}													;	
	END;
	//-	
	rResponse 	:= 	RECORD
		rOrbit				OrbitStatus 								{	XPATH('OrbitStatus'								)	}													;
		STRING 				OriginalRequest							{	XPATH('OriginalRequest'						)	}													;
	END;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(		_SystemConstants.TargetURL
													,	_SystemConstants.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(_SystemConstants.OrbitRR(sService)	)
													,	NAMESPACE(_SystemConstants.Namespace_B)
													,	LITERAL
													,	SOAPACTION(_SystemConstants.SoapPath(sService) )
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	RETURN	OrbitCall	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
END	;	// End UpdateReceiveFile Function


// Begin UpdateReceiveItem Function

EXPORT UpdateReceiveItem	(		STRING IsItemOnHold
														, STRING IsTestInstance
														, STRING ReceiveDate
														, STRING ReceivingId
														, STRING ReceivingType
														, STRING Status
														, STRING Token
													)	:= FUNCTION
	IMPORT BAIR;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'UpdateReceiveItem'	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	rReceivings		:= 	RECORD
		STRING					orbIsItemOnHold		 						{	XPATH('orb:IsItemOnHold'								)	}	:= IsItemOnHold				; // 'true'
		STRING					orbIsTestInstance		 					{	XPATH('orb:IsTestInstance'							)	}	:= IsTestInstance			; // 'false'
		STRING					orbReceiveDate		 						{	XPATH('orb:ReceiveDate'									)	}	:= ReceiveDate				; // '2013-08-13'
		STRING					orbReceivingId		 						{	XPATH('orb:ReceivingId'									)	}	:= ReceivingId				; // '268469'
		STRING					orbReceivingType	 						{	XPATH('orb:ReceivingType'								)	}	:= ReceivingType			; // 'CorrectionFile'
		STRING					orbStatus					 						{	XPATH('orb:Status'											)	}	:= Status							; // 'Received'
	END	;
	// -
	rLex					:= 	RECORD
		rReceivings			orbReceivings									{	XPATH('orb:Receivings'									)	}												;
		STRING 					orbToken 											{	XPATH('orb:Token'												)	}	:= 	Token							;	
	END	;
	// -
	rRequest			:= 	RECORD
		rLex 						lexRequest										{	XPATH('lex:request'											)	}												;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - RESPONSE
	rOrbit 				:= 	RECORD
		STRING					OrbitStatusCode								{	XPATH('OrbitStatusCode'									)	}																;
		STRING					OrbitStatusDescription				{	XPATH('OrbitStatusDescription'					)	}																;
	END;
	//-	
	rResponse 		:= 	RECORD
		rOrbit					OrbitStatus 									{	XPATH('OrbitStatus'											)	}																;
		STRING 					OriginalRequest								{	XPATH('OriginalRequest'									)	}																;
	END;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(		_SystemConstants.TargetURL
													,	_SystemConstants.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(_SystemConstants.OrbitRR(sService)	)
													,	NAMESPACE(_SystemConstants.Namespace_B)
													,	LITERAL
													,	SOAPACTION(_SystemConstants.SoapPath(sService) )
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	RETURN	OrbitCall	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
END	; // End UpdateReceiveItem Function


// Begin UpdateRecordCount Function

EXPORT UpdateRecordCount(			STRING RecordCount
														, STRING ReceivingID 
														, STRING Token
													)	:= FUNCTION
	IMPORT BAIR;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'UpdateReceiveFile'	;	
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	rReceiveFR	:= 	RECORD
		// STRING				orbCluster		 							{	XPATH('orb:Cluster'								)	}	:= Cluster							; // 'SOAPUI-'
		STRING				orbFileInstanceId						{	XPATH('orb:FileInstanceId'				)	}	:= ReceivingID				; // '268577'
		// STRING				orbFileName									{	XPATH('orb:FileName'							)	}	:= FileName							; // 'testingUpdateReceiveFile.txt'
		// STRING				orbFilePath									{	XPATH('orb:FilePath'							)	}	:= FilePath							; // '\\\\location\\boy\\cat\\dog\\1'
		// STRING				orbFileStatus								{	XPATH('orb:FileStatus'						)	}	:= FileStatus						; // 'Success'
		// STRING				orbQueueName								{	XPATH('orb:QueueName'							)	}	:= QueueName						;	// 'NoQUEUE'												
		STRING				orbRecordCount							{	XPATH('orb:RecordCount'						)	}	:= RecordCount					; // '201'
		// STRING				orbReportingEndDate					{	XPATH('orb:ReportingEndDate'			)	}	:= ReportingEndDate			; // '2013-08-26'
		// STRING				orbReportingStartDate				{	XPATH('orb:ReportingStartDate'		)	}	:= ReportingStartDate		;	// '2013-08-26'								
	END	;
	// -
	rReceiveF		:= 	RECORD
		rReceiveFR		orbReceiveFR					 			{	XPATH('orb:ReceiveFileRequest'		)	}													;								
	END	;
	// -
	rReceivingr	:= 	RECORD
		rReceiveF			orbReceiveFiles 						{	XPATH('orb:ReceiveFiles'					)	}													;
		STRING				orbReceivingId2		 					{	XPATH('orb:ReceivingId'						)	}	:= ReceivingID					;	// '268577'							
	END	;
	// -
	rReceivings	:= 	RECORD
		rReceivingr		orbReceivingRecord 					{	XPATH('orb:ReceivingRecord'				)	}													;									
	END	;
	// -
	rLex				:= 	RECORD
		rReceivings 	orbItems 										{	XPATH('orb:Receivings'						)	}													;
		STRING 				orbToken 										{	XPATH('orb:Token'									)	}	:= 	Token								;	
	END	;
	// -
	rRequest		:= 	RECORD
		rLex					lexRequest									{	XPATH('lex:request'								)	}													;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - RESPONSE
	rOrbit 			:= 	RECORD
		STRING				OrbitStatusCode							{	XPATH('OrbitStatusCode'						)	}													;
		STRING				OrbitStatusDescription			{	XPATH('OrbitStatusDescription'		)	}													;	
	END;
	//-	
	rResponse 	:= 	RECORD
		rOrbit				OrbitStatus 								{	XPATH('OrbitStatus'								)	}													;
		STRING 				OriginalRequest							{	XPATH('OriginalRequest'						)	}													;
	END;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(		_SystemConstants.TargetURL
													,	_SystemConstants.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(_SystemConstants.OrbitRR(sService)	)
													,	NAMESPACE(_SystemConstants.Namespace_B)
													,	LITERAL
													,	SOAPACTION(_SystemConstants.SoapPath(sService) )
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	RETURN	OrbitCall	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
END	;	// End UpdateRecordCount Function


// Begin VerifyStatus Function

/* IMPORTANT: This is a actually "GetReceivingDetailsByInstance" */

EXPORT VerifyStatus (		STRING InstanceID
											, STRING Token
										)	:= FUNCTION
	IMPORT BAIR;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'GetReceivingDetailsByInstance'	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	rIDs			:= 	RECORD	
		STRING			orbInstanceID		 							{	XPATH('arr:int'													)	}	:= InstanceID			; // '268338'
	END	;
	// -
	rLex			:= 	RECORD
		rIDs				orbInstanceIDs								{	XPATH('orb:InstanceIds'									)	}											;
		STRING 			orbToken 											{	XPATH('orb:Token'												)	}	:= 	Token						;	
	END	;
	// -
	rRequest	:= 	RECORD
		rLex 				lexRequest										{	XPATH('lex:request'											)	}											;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - RESPONSE
	rOrbit 			:= 	RECORD
		STRING				OrbitStatusCode							{	XPATH('OrbitStatusCode'						)	}																			;
		STRING				OrbitStatusDescription			{	XPATH('OrbitStatusDescription'		)	}																			;	
	END;
	// - 
	rInstanceR	:=	RECORD
		STRING				DWId												{	XPATH('DWId'											)	}																			;
		STRING				DataSetId										{	XPATH('DataSetId'									)	}																			;
		STRING				DataSetName									{	XPATH('DataSetName'								)	}																			;
		STRING				FileName										{	XPATH('FileName'									)	}																			;
		STRING				MemberId										{	XPATH('MemberId'									)	}																			;
		STRING				ReceivingInstanceId					{	XPATH('ReceivingInstanceId'				)	}																			;
		STRING				ReceivingStatus							{	XPATH('ReceivingStatus'						)	}																			;
		STRING				SBFEExternalMemberId				{	XPATH('SBFEExternalMemberId'			)	}																			;
		STRING				SourceName									{	XPATH('SourceName'								)	}																			;
		STRING				StatusHistoryList						{	XPATH('StatusHistoryList'					)	}																			;
	END	;
	// - 
	rInstances	:=	RECORD
		rInstanceR		InstanceR										{	XPATH('ReceiveInstanceResponse'		)	}																			;
	END	;
	// -	
	rResponse 	:= 	RECORD
		rInstances		Instances										{	XPATH('Instances'									)	}																			;
		rOrbit				OrbitStatus 								{	XPATH('OrbitStatus'								)	}																			;
		STRING 				OriginalRequest							{	XPATH('OriginalRequest'						)	}																			;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(		_SystemConstants.TargetURL
													,	_SystemConstants.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(_SystemConstants.OrbitRR(sService)	)
													,	NAMESPACE(_SystemConstants.Namespace_C)
													,	LITERAL
													,	SOAPACTION(_SystemConstants.SoapPath(sService) )
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	//RETURN	OrbitCall.Instances.InstanceR.ReceivingStatus	; // Returns "Receiving Status" only
	RETURN	OrbitCall.Instances.InstanceR.FileName	; // Returns "Receiving Status" only
	// RETURN	OrbitCall;
	//-----------------------------------------------------------------------------------------------------------------------------------------
END ; // End VerifyStatus Function

EXPORT GetReceivingDetailsByInstance(	STRING InstanceID
																		  ,STRING Token
																		)	:= FUNCTION
	IMPORT BAIR;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'GetReceivingDetailsByInstance'	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	rIDs			:= 	RECORD	
		STRING			orbInstanceID		 							{	XPATH('arr:int'													)	}	:= InstanceID			; // '268338'
	END	;
	// -
	rLex			:= 	RECORD
		rIDs				orbInstanceIDs								{	XPATH('orb:InstanceIds'									)	}											;
		STRING 			orbToken 											{	XPATH('orb:Token'												)	}	:= 	Token						;	
	END	;
	// -
	rRequest	:= 	RECORD
		rLex 				lexRequest										{	XPATH('lex:request'											)	}											;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - RESPONSE
	rOrbit 			:= 	RECORD
		STRING				OrbitStatusCode							{	XPATH('OrbitStatusCode'						)	}																			;
		STRING				OrbitStatusDescription			{	XPATH('OrbitStatusDescription'		)	}																			;	
	END;
	// - 
	rInstanceR	:=	RECORD
		STRING				DWId												{	XPATH('DWId'											)	}																			;
		STRING				DataSetId										{	XPATH('DataSetId'									)	}																			;
		STRING				DataSetName									{	XPATH('DataSetName'								)	}																			;
		STRING				FileName										{	XPATH('FileName'									)	}																			;
		STRING				MemberId										{	XPATH('MemberId'									)	}																			;
		STRING				ReceivingInstanceId					{	XPATH('ReceivingInstanceId'				)	}																			;
		STRING				ReceivingStatus							{	XPATH('ReceivingStatus'						)	}																			;
		STRING				SBFEExternalMemberId				{	XPATH('SBFEExternalMemberId'			)	}																			;
		STRING				SourceName									{	XPATH('SourceName'								)	}																			;
		STRING				StatusHistoryList						{	XPATH('StatusHistoryList'					)	}																			;
	END	;
	// - 
	rInstances	:=	RECORD
		rInstanceR		InstanceR										{	XPATH('ReceiveInstanceResponse'		)	}																			;
	END	;
	// -	
	rResponse 	:= 	RECORD
		rInstances		Instances										{	XPATH('Instances'									)	}																			;
		rOrbit				OrbitStatus 								{	XPATH('OrbitStatus'								)	}																			;
		STRING 				OriginalRequest							{	XPATH('OriginalRequest'						)	}																			;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(		_SystemConstants.TargetURL
													,	_SystemConstants.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(_SystemConstants.OrbitRR(sService)	)
													,	NAMESPACE(_SystemConstants.Namespace_C)
													,	LITERAL
													,	SOAPACTION(_SystemConstants.SoapPath(sService) )
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	//RETURN	OrbitCall.Instances.InstanceR.ReceivingStatus	; // Returns "Receiving Status" only
	//RETURN	OrbitCall.Instances.InstanceR.FileName	; // Returns "Receiving Status" only
	RETURN	OrbitCall.Instances.InstanceR;
	//-----------------------------------------------------------------------------------------------------------------------------------------
END ; // End GetReceivingDetailsByInstance Function



EXPORT AddABuildToAConsolidateBuild (   STRING CBuildName
															      	, STRING CBuildVersion
																			, STRING BuildName
																      , STRING BuildVersion
      																, STRING Token
						       									) := FUNCTION
	IMPORT BAIR;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'AddComponentsToABuild'	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	rCompAdd	:=	RECORD
		STRING			orbBuildName							{	XPATH('orb:BuildName'						)	}	:=  BuildName		;	// 'BuildName'
		STRING			orbBuildVersion						{	XPATH('orb:BuildVersion'				)	}	:=  BuildVersion	;	// 'BuildVersion'		
	END	;
	// -
	rComp			:=	RECORD
		rCompAdd		orbComponentToAdd						{ XPATH('orb:ComponentToAdd'				)	}										;
	END	;
	// -
	rBuild		:= 	RECORD
		STRING			orbBuildName		 						{	XPATH('orb:BuildName'							)	}	:= 	CBuildName			; // 'BUILD-NAME'
		STRING			orbBuildVersion							{	XPATH('orb:BuildVersion'					)	}	:= 	CBuildVersion	; // 'BUILD VERSION'
		rComp				orbComponents								{ XPATH('orb:Components'						)	}										;			
	END	;
	//	-
	rBuilds		:= 	RECORD
		rBuild			orbBuild 										{	XPATH('orb:BuildInstanceToAdd'		)	}										;								
	END	;
	// -
	rLex			:= 	RECORD
		rBuilds		 	orbBuilds		 								{	XPATH('orb:Builds'								)	}										;
		STRING 			orbToken 										{	XPATH('orb:Token'									)	}	:= 	Token					;	
		END	;
	// -
	rRequest	:= 	RECORD
		rLex				lexRequest									{	XPATH('lex:request'								)	}										;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - RESPONSE
	rOrbit 		:= 	RECORD
		STRING			OrbitStatusCode							{	XPATH('OrbitStatusCode'						)	}										;
		STRING			OrbitStatusDescription			{	XPATH('OrbitStatusDescription'		)	}										;	
	END;
	//-
	rCompAddR	:=	RECORD
		STRING			BuildId2										{	XPATH('BuildId'										)	}										;
		STRING			BuildName2									{	XPATH('BuildName'									)	}										;
		STRING			BuildVersion2								{	XPATH('BuildVersion'							)	}										;
		STRING			MasterBuildId2							{	XPATH('MasterBuildId'							)	}										;
		STRING			ReceivingId									{	XPATH('ReceivingId'								)	}										;
		STRING			Status											{	XPATH('Status'										)	}										;
	END	;
	//-
	rCompR		:=	RECORD
		rCompAddR		ComponentToAddR							{ XPATH('ComponentToAdd'						)	}										;
	END	;
	//-	
	rInstance	:=	RECORD
		STRING			BuildId											{	XPATH('BuildId'										)	}										;
		STRING			BuildName										{	XPATH('BuildName'									)	}										;
		STRING			BuildVersion								{	XPATH('BuildVersion'							)	}										;
		rCompR			ComponentsR									{ XPATH('Components'								)	}										;
		STRING			MasterBuildId								{	XPATH('MasterBuildId'							)	}										;
		STRING			Status											{	XPATH('Status'										)	}										;
	END	;
	//-	
	rBuildsR	:=	RECORD
		rInstance		InstanceToAdd								{ XPATH('BuildInstanceToAdd'				)	}										;
	END	;
	//-	
	rResponse :=	RECORD
		rBuildsR		BuildsResponse							{ XPATH('Builds'										)	}										;
		rOrbit			OrbitStatus 								{	XPATH('OrbitStatus'								)	}										;
		STRING 			OriginalRequest							{	XPATH('OriginalRequest'						)	}										;
	END;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	OrbitCall	:=	SOAPCALL(		_SystemConstants.TargetURL
													,	_SystemConstants.SOAPService(sService)
													,	rRequest
													,	rResponse
													,	XPATH(_SystemConstants.OrbitRR(sService)	)
													,	NAMESPACE(_SystemConstants.Namespace_D)
													,	LITERAL
													,	SOAPACTION(_SystemConstants.SoapPath(sService) )
													, LOG
												)	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	//RETURN	(UNSIGNED4)OrbitCall.BuildsResponse.InstanceToAdd.BuildId;
	 RETURN	OrbitCall.OrbitStatus.OrbitStatusDescription;
	//-----------------------------------------------------------------------------------------------------------------------------------------
END	;	// End AddABuildToAConsolidateBuild Function


END;