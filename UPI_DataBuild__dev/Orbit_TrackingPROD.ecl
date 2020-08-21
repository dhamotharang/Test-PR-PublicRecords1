EXPORT Orbit_TrackingPROD := MODULE

import std, AID_Support;

	EXPORT ThorDev										:= '10.173.14.207'              ; // Boca Dataland used for development
	EXPORT ThorProd										:= 'prod_esp.br.seisint.com'    ; // Boca Prod Thor (Public Records) - production
	
	EXPORT daliDev                    := AID_Support.Constants.knowndalis.bocadev;
  EXPORT daliProd                   := AID_Support.Constants.knowndalis.bocaprod;
	
	EXPORT EclWatchDev                := 'http://' + ThorDev + ':8010/';
	EXPORT EclWatchProd               := 'http://' + ThorProd + ':8010/';

	EXPORT WUServerDev               	:= EclWatchDev + 'WsWorkunits'  ;
	EXPORT WUServerProd             	:= EclWatchProd + 'WsWorkunits' ;

// The following "constants" are set based on the Thor where you are running
	// EXPORT WhereAmI 									:= thorlib.DaliServers();
  EXPORT WhereAmINoPort             := regexreplace('(:\\d+)',thorlib.DaliServers(),'');  // IP only, no port
  EXPORT WhereAmI                   := WhereAmINoPort;//thorlib.DaliServers();	
	
	EXPORT STRING thorEsp 		:= 	TRIM	(
																					CASE	( 	WhereAmI
																									, daliDev 	=> ThorDev
																									, daliProd 	=> ThorProd
																									,	'Unknown' 
																								)
																				)	;	
	
	EXPORT STRING SystemName 		:= 	TRIM	(
																					CASE	( 	WhereAmI
																									, daliDev 	=> 'DatalandDevelopment'
																									, daliProd 	=> 'PublicRecordsBocaProduction'
																									,	'Unknown' 
																								)
																				)	;
																				
	EXPORT STRING EclWatch 			:=  TRIM	(
																						CASE	( 	WhereAmI
																										, daliDev 	=> EclWatchDev
																										, daliProd 	=> EclWatchProd
																										,	'Unknown' 
																									)
																				)	;

	EXPORT STRING WuServer	 		:=  TRIM	(
																					CASE	( 	WhereAmI
																										, daliDev 	=> WUServerDev
																										, daliProd 	=> WUServerProd
																										,	'Unknown' 
																								)
																				)	;	
	
	EXPORT STRING SprayCommon	 	:=   TRIM	(
																					CASE	( 	WhereAmI
																									, daliDev 	=> ThorDev
																									, daliProd 	=> ThorProd
																									,	'Unknown' 
																								)
																				)	;

	EXPORT isProduction     	:=	CASE ( 		WhereAmI
																										, daliProd 	=> TRUE
																										,	FALSE 
																			)	;

	//----------------------------------------------------------------------------------------------																					
	EXPORT MailServerBoca		:= GETENV ('SMTPserver'	,	'appmail-bct.risk.regn.net'	)	;
	EXPORT MailServerAlpha	:= GETENV ('SMTPserver'	,	'appmail.risk.regn.net'			)	;
	
	EXPORT mailServer		:=  TRIM	(
																	CASE	( 	WhereAmI
																					, daliDev 	=> MailServerBoca
																					, daliProd 	=> MailServerBoca
																					,	'Unknown' 
																				)
																)	;
	EXPORT mailPort			:=	(UNSIGNED4) GETENV ( 'SMTPport' , '25' )				;
	
	
	
	//----------------------------------------------------------------------------------------------
	EXPORT STRING emailSystemErrorFrom 	:= 'SystemError@' + SystemName 	+ '.ecl.seisint.com'	;
	EXPORT STRING emailDataErrorFrom 		:= 'DataError@' 	+ SystemName 	+ '.ecl.seisint.com'	;
	EXPORT STRING emailNonErrorFrom 		:= 'Autonotify@' 	+ SystemName 	+ '.ecl.seisint.com'	;
	EXPORT STRING emailClientFrom 			:= 'SVC-SCDWSupport@lexisnexisrisk.com'	;
	//----------------------------------------------------------------------------------------------
	EXPORT STRING	atLexisNexis					:= '@LexisNexisRisk.com'															;
	EXPORT STRING JenniferEmail					:=  TRIM( 'Jennifer.Hennigar'   + atLexisNexis );
	EXPORT STRING AdamEmail							:=  TRIM( 'Adam.Ewing'   + atLexisNexis );
	EXPORT STRING VijayEmail						:=  TRIM( 'Vijay.Regonda'   + atLexisNexis );
	 
	export layout_users := record
		string userid;
		string emailaddr;
	end;
	export table_users := dataset( [
	      {'jhennigar', JenniferEmail}
			 ,{'aewing', AdamEmail}
			 ,{'vregonda', VijayEmail}
			 

			 ], layout_users );
	getEmail := function
		string user := std.str.ToLowerCase( STD.System.Job.User() );
		string email := table_users(userid=user)[1].emailaddr;
		return IF(email<>'',email,JenniferEmail);
	end;
			 
	EXPORT STRING TargetDev             	:= 	getEmail;

	// ---------------------------------------------------------------------------------------------
	EXPORT STRING emailTarget	          := TRIM	(
																										CASE ( 		WhereAmI
																														,	daliDev 	=> TargetDev
																														,	TargetDev // TargetProd 
																													)
																								)	;

	//----------------------------------------------------------------------------------------------
	EXPORT wu_status_active 	:= [	'running'	, 'blocked'	, 'submitted'	, 'compiling', 'paused', 'wait'		]	;
	EXPORT wu_status_complete := [	'completed'																				]	;
	//----------------------------------------------------------------------------------------------
	// These need adjusted for CRK (copied from Sharecare for example)
	EXPORT STRING OrbitUser 							:= 	'svc_orbithc_crk@mbs';
	// EXPORT STRING OrbitPasswordProd				:=  'i2jk518A4Y'						; 
	// EXPORT STRING OrbitPasswordDev				:=  'i2jk518A4Y'						; // QA
	EXPORT STRING OrbitPasswordProd				:=  '7bB3Ubom73'						; // Prod
	EXPORT STRING SOAPService	(STRING s) 	:= 	'lex:' + s													;
	EXPORT STRING OrbitRR			(STRING s)	:= 	s + 'Response/' + s + 'Result'			;
	EXPORT STRING Domain 									:= 	'HC'												;
	EXPORT STRING Namespace_A 						:= 	'http://lexisnexis.com/" xmlns:lex="http://lexisnexis.com/'		;
	EXPORT STRING Namespace_B 						:= 	'http://lexisnexis.com/" xmlns:orb="http://schemas.datacontract.org/2004/07/OrbitDataContractsV2" xmlns:lex="http://lexisnexis.com/';
	EXPORT STRING Namespace_C 						:= 	'http://lexisnexis.com/" xmlns:orb="http://schemas.datacontract.org/2004/07/OrbitDataContractsV2" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays" xmlns:lex="http://lexisnexis.com/';
	EXPORT STRING Namespace_D 						:= 	'http://lexisnexis.com/" xmlns:orb="http://schemas.datacontract.org/2004/07/OrbitDataContractsV2" xmlns:orb1="http://schemas.datacontract.org/2004/07/OrbitDataContracts" xmlns:lex="http://lexisnexis.com/';
	EXPORT STRING Namespace_E             :=  'http://lexisnexis.com/" xmlns:orb="http://lexisnexis.com/Orbit/" xmlns:lex="http://lexisnexis.com/';
	EXPORT STRING Namespace_F             :=  'http://lexisnexis.com/" xmlns:lex="http://lexisnexis.com/" xmlns:orb="http://lexisnexis.com/Orbit/" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays';
	EXPORT STRING SoapPath(STRING s)			:= 	'http://lexisnexis.com/IOrbitServiceGeneric/' + s ;
	// EXPORT STRING BatchIds								:= 	'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNPQRSTUVWXYZ';
	// EXPORT STRING	devOrbit 								:= 	'https://orbitqa-hc.noam.lnrm.net/Orbit4Services/OrbitServiceGeneric.svc';
	EXPORT STRING	prodOrbit 							:= 	'https://orbithc.noam.lnrm.net/Orbit4Services/OrbitServiceGeneric.svc?wsdl';

  EXPORT STRING	CRKDatasetname 					:= 	'CRK - LexisNexisRiskSolutions';
	
	EXPORT STRING OrbitFailed							:= 	'Failed'														;
	EXPORT STRING OrbitLoaded							:= 	'Loaded'														;
	EXPORT STRING OrbitReceived						:= 	'Received'													;
	EXPORT STRING OrbitSprayed						:= 	'Sprayed'														;
	EXPORT STRING OrbitReformatted				:= 	'Reformatted'												;
	EXPORT STRING OrbitScrubbed						:= 	'Scrubbed'													;
	EXPORT STRING OrbitDataError					:=  'Data_Error'												;
	// EXPORT STRING OrbitReprocess					:= 	'Built'															;
	EXPORT STRING OrbitBuildInProgress		:= 	'BuildInProgress'										;
	// EXPORT STRING OrbitBuildAvailableForUse		:= 	'BuildAvailableForUse'					;
	EXPORT STRING OrbitNew								:= 	'New'																;
	// EXPORT STRING OrbitBuildOnHold				:= 	'BuildOnHold'												;
	EXPORT STRING OrbitBuilt							:= 	'Built'															;
	// EXPORT STRING OrbitHeldThresholds			:= 	'HeldThresholds'										;
	// EXPORT STRING OrbitQuarantine					:= 	'Quarantine'												;
	// EXPORT STRING OrbitSubFailedSpray			:= 	'SPR'																;
	// EXPORT STRING OrbitSubFailedReformat	:= 	'RFM'																;
	// EXPORT STRING OrbitSubFailedScrub			:= 	'SCR'																;
	// EXPORT STRING OrbitSubFailedOther			:= 	'OTH'																;
	EXPORT STRING OrbitDate (STRING s)		:= 	s[1..4] + '-' + 
																						s[5..6] + '-' + 
																						s[7..8]															;
	EXPORT STRING OrbitTrue								:= 	'true'															;
	EXPORT STRING OrbitFalse							:= 	'false'															;
	// EXPORT STRING OrbitFullProduction			:= 	'Updating'													;
	// EXPORT STRING OrbitPreProduction			:= 	'Available for Production'					;
	// EXPORT STRING OrbitUAT								:= 	'User Acceptance Test'							;
	// EXPORT STRING OrbitCertification			:=  'Certification'											;
	// EXPORT STRING	OrbitPOC								:=  'Proof of Concept'									;
	// EXPORT STRING	OrbitHistorical					:=  'Historical'												;
	// EXPORT BOOLEAN OrbitItemStatusIsNotProduction( string status ) := status not in [OrbitFullProduction,OrbitPreProduction,OrbitCertification,OrbitPOC];
	// EXPORT BOOLEAN OrbitItemStatusIsProduction( string status ) := status IN [OrbitFullProduction,OrbitPreProduction];
	// EXPORT BOOLEAN OrbitItemStatusIsUAT( string status ) := status IN [OrbitUAT];

	//----------------------------------------------------------------------------------------------
	// The following will cause dev to skip Orbit interactions.  Sandbox to test in Dev
	EXPORT boolean UseOrbit               := true;
	// EXPORT boolean UseOrbit               := IF(WhereAmI = daliDev, false, false);   // no orbit yet
	
	EXPORT STRING targetURL	 							:= prodOrbit; 
																						// TRIM	(
																									// CASE	( 	WhereAmI
																													// , daliProd 	=> prodOrbit
																													// ,	daliDev 	=> devOrbit
																													// ,	'Unknown' 
																													// ,	devOrbit
																												// )
																								// )	;
	EXPORT STRING OrbitPassword 	 				:= OrbitPasswordProd;
																						// TRIM	(
																									// CASE	( 	WhereAmI
																													// , daliProd 	=> OrbitPasswordProd
																													// ,	daliDev 	=> OrbitPasswordDev
																													// ,	'Unknown' 
																												// )
																								// )	;	
	
	EXPORT vStatus	(		BOOLEAN status
										, STRING oStatus
										, STRING wStatus	)	:= IF ( 	WhereAmI = daliDev	
																								,	ASSERT (		status	
																														, 'Dataset not currently in ' + wStatus + 
																															' status. Currently in ' + oStatus 		+ ' status.'
																															//	, FAIL
																													) 
																								,	ASSERT (		status	
																														, 'Dataset not currently in ' + wStatus +
																															' status. Currently in ' + oStatus 		+ ' status.'
																														, FAIL
																													)
																							)	;
																																						
	EXPORT vStatusUpdate	(		BOOLEAN status
													, STRING oStatus
													, STRING wStatus	)	:= IF ( 	WhereAmI = daliDev	
																											,	ASSERT (		status	
																																	, 'Orbit was unable to update the Dataset to ' + 
																																		wStatus + ' status. It is currently in ' + 
																																		oStatus + ' status.'
																																		//, FAIL
																																) 
																											,	ASSERT (		status	
																																	, 'Orbit was unable to update the Dataset to ' + 
																																		wStatus + ' status. It is currently in ' +
																																		oStatus + ' status.'
																																	, FAIL
																																)
																										)	;
	// The following constants will be used to identify the Master Build and Build name from its datamodel
	
	EXPORT ModuleName := 'Identity_';
	EXPORT ProjectName := 'CRK';
	EXPORT ScrubProcess := 'Scrub';
	EXPORT NameSeparatorforScrubMasterBuild := '_';
	EXPORT NameSeparatorforScrubBuild := '_';
 

	EXPORT layout_systems := record
		string name; 
		string dali;
		string eclwatch;
		// string landingzone;
		string datacluster;
	end;
	
	// EXPORT systems := dataset([
	            // {'HealthcareProdAlpha',  		'10.194.152.52',   '10.194.152.54', lz_alpha_primary, 'thor100_152'}
	           // ,{'HealthcareProdAlphaUAT',  '10.194.152.52',   '10.194.152.54', lz_alpha_primary, 'thor100_152'} 
	           // ,{'HealthcareProdBoca',   		'10.173.71.60',    '10.173.71.54',  lz_alpha_primary, 'thor100_71'}
	           // ,{'HealthcareProdBocaUAT',		'10.173.71.60',    '10.173.71.54',  lz_alpha_primary, 'thor100_71'}
	           // ,{'HealthcareProdAlphaPHI',  '10.194.22.22',    '10.194.22.23',  lz_alpha_primary, 'thor100_22'}
	           // ,{'HealthcareProdBocaPHI',   '10.237.22.22',    '10.237.22.23',  lz_alpha_primary, 'thor100_22'}
	           // ,{'HealthcareDevelopment',   '10.241.70.52',    '10.241.70.54',  lz_alpha_primary, 'thor100_70'}
						// ], layout_systems); 

  // EXPORT WhereAmINoPort				:= regexreplace('(:\\d+)',thorlib.DaliServers(),'');  // IP only, no port
	EXPORT FileServerSuffix			      :=  'FileSpray'		;
	EXPORT WUServerSuffix     				:=  'WsWorkunits'	;

	// EXPORT STRING DataCluster		:= 	TRIM	( systems(dali=WhereAmINoPort)[1].datacluster );
	// EXPORT STRING EclWatchIP		:= 	TRIM	( systems(dali=WhereAmINoPort)[1].eclwatch );
						  
END	;
