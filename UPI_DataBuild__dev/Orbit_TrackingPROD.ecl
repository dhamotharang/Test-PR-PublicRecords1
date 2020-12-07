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
	// EXPORT STRING OrbitPasswordDev				:=  'i2jk518A4Y'						; // QA
	EXPORT STRING OrbitPasswordProd				:=  '7bB3Ubom73'						; // Prod
	EXPORT STRING SOAPService	(STRING s) 	:= 	'lex:' + s													;
	EXPORT STRING OrbitRR			(STRING s)	:= 	s + 'Response/' + s + 'Result'			;
	EXPORT STRING Domain 									:= 	'HC'												;
	EXPORT STRING	Namespace		 						:=	'http://lexisnexis.com/';
	EXPORT STRING SoapPath(STRING s)			:= 	'http://lexisnexis.com/IOrbitServiceGeneric/' + s ;
	// EXPORT STRING BatchIds								:= 	'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNPQRSTUVWXYZ';
	EXPORT STRING	prodOrbit 							:= 	'https://orbithc.noam.lnrm.net/Orbit4Services/OrbitServiceGeneric.svc?wsdl';
	
	EXPORT STRING OrbitFailed							:= 	'Failed'														;
	EXPORT STRING OrbitReceived						:= 	'Received'													;
	EXPORT STRING OrbitSprayed						:= 	'Sprayed'														;
	// EXPORT STRING OrbitReprocess					:= 	'Built'															;
	EXPORT STRING OrbitBuildInProgress		:= 	'BuildInProgress'										;
	// EXPORT STRING OrbitNew								:= 	'New'																;
	// EXPORT STRING OrbitBuildOnHold				:= 	'BuildOnHold'												;
	EXPORT STRING OrbitBuilt							:= 	'Built'															;
	EXPORT STRING OrbitDate (STRING s)		:= 	s[1..4] + '-' + 
																						s[5..6] + '-' + 
																						s[7..8]															;
	EXPORT STRING OrbitTrue								:= 	'true'															;
	EXPORT STRING OrbitFalse							:= 	'false'															;

	EXPORT boolean UseOrbit               := true;
	
	EXPORT STRING targetURL	 							:= prodOrbit; // CRK is not running in dataland - from Prod, can write to Prod Orbit or QA Orbit
	EXPORT STRING OrbitPassword 	 				:= OrbitPasswordProd;
	
	// The following constants will be used to identify the Master Build and Build name from its datamodel
	
	EXPORT ModuleName := 'Identity_';
	EXPORT ProjectName := 'CRK';
	EXPORT ScrubProcess := 'Scrub';
	EXPORT NameSeparatorforScrubMasterBuild := '_';
	EXPORT NameSeparatorforScrubBuild := '_';
	
	EXPORT FileServerSuffix			      :=  'FileSpray'		;
	EXPORT WUServerSuffix     				:=  'WsWorkunits'	;
						  
END	;
