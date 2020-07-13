EXPORT Orbit_Tracking := MODULE

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
	EXPORT STRING OrbitPasswordDev				:=  'i2jk518A4Y'						; // QA (prod too?)
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
	// EXPORT STRING	devOrbit 								:= 	'https://qa.orbit3.risk.regn.net/Orbit3/Orbit3Services/OrbitServiceGeneric.svc';
	EXPORT STRING	devOrbit 								:= 	'https://orbitqa-hc.noam.lnrm.net/Orbit4Services/OrbitServiceGeneric.svc';
	// EXPORT STRING	prodOrbit 							:= 	'https://orbit3.risk.regn.net/Orbit3/Orbit3Services/OrbitServiceGeneric.svc?Wsdl';

	// EXPORT STRING	RoxieServiceName 				:= 	'healthcare_sharecare_eligibility.eligibility_service_v3';
	// EXPORT STRING	certRoxie_url 					:= 	'http://10.176.68.135:9876/';
	// EXPORT STRING	prodRoxie_url						:= 	'http://10.176.71.3:9876/';
	// EXPORT STRING	uatCertRoxie_url				:= 	'http://10.176.68.132:9876/';
	// EXPORT STRING	uatProdRoxie_url				:= 	'http://10.176.71.5:9876/';
  // EXPORT STRING	Env_Var_Name 						:= 	'sharecare_build_version';

  EXPORT STRING	CRKDatasetname 					:= 	'CRK - LexisNexisRiskSolutions';
  // EXPORT STRING	RoxieEnvironmentProd		:= 	'H';
  // EXPORT STRING	RoxieEnvironmentUat			:= 	'HU';
  // EXPORT STRING	UpdateProd_Email_list 	:= 	'BocaRoxiePackageTeam@lexisnexis.com;Richard.Wiggins@lexisnexisrisk.com;David.J.Miller@lexisnexisrisk.com;albert.metzmaier@lexisnexisrisk.com;Jorge.Diaz@lexisnexisrisk.com;Yeng.Vang@lexisnexisrisk.com;Joseph.Schaedler@lexisnexisrisk.com;Jaymes.Kloehn@lexisnexisrisk.com';
  // EXPORT STRING	UpdateUatProd_Email_list:= 	'BocaRoxiePackageTeam@lexisnexis.com;Richard.Wiggins@lexisnexisrisk.com;David.J.Miller@lexisnexisrisk.com;albert.metzmaier@lexisnexisrisk.com;Jorge.Diaz@lexisnexisrisk.com;yeng.vang@lexisnexisrisk.com;joseph.schaedler@lexisnexisrisk.com';

	// EXPORT STRING EligibilityBuildName		:= 	'AutoBuild_Sharecare_Eligibility'		;
	// EXPORT STRING LabsBuildName						:= 	'AutoBuild_Sharecare_Labs'					;
	// EXPORT STRING EmbraceBuildName				:= 	'AutoBuild_Sharecare_Embrace'				;
	// EXPORT STRING MedicalClaimsBuildName	:= 	'AutoBuild_Sharecare_MedicalClaims'	;
	// EXPORT STRING RxClaimsBuildName				:= 	'AutoBuild_Sharecare_RxClaims'			;
	// EXPORT STRING CorrectionsBuildName		:= 	'AutoBuild_Sharecare_Corrections'		;	
	// EXPORT STRING ReferralBuildName				:= 	'Auto_Build_Sharecare_Referral'		;	
	// EXPORT STRING EventsBuildName					:= 	'Auto_Build_Sharecare_Events'		;
	// EXPORT STRING GuidShiftBuildName			:= 	'Auto_Build_Sharecare_GuidShiftTracker'		;
	
	// EXPORT STRING EligibilityMasterBuildName			:= 	'Sharecare_Base_Eligibility'					;
	// EXPORT STRING LabsMasterBuildName				  		:= 	'Sharecare_Base_Labs'									;
	// EXPORT STRING EmbraceMasterBuildName					:= 	'Sharecare_Base_EmbraceID'						;
	// EXPORT STRING MedicalClaimsMasterBuildName		:= 	'Sharecare_Base_MedicalClaims'				;
	// EXPORT STRING RxClaimsMasterBuildName					:= 	'Sharecare_Base_RxClaims'							;
	// EXPORT STRING CorrecctionsMasterBuildName			:= 	'Sharecare_Base_Corrections'					;
	// EXPORT STRING ExternalEventsMasterBuildName		:= 	'Sharecare_Base_Events'								;
	// EXPORT STRING ReferralsMasterBuildName				:= 	'Sharecare_Base_Referrals'						;
	// EXPORT STRING GuidShiftTrackerMasterBuildName	:= 	'Sharecare_Base_GuidShiftTracker'			;
	
	// EXPORT STRING MasterFFProdFromTO			:= 	'Sharecare Production'								;
	// EXPORT STRING MasterFFPreProdFromTO		:= 	'Sharecare PRE Production'						;
	// EXPORT STRING MasterFFCertFromTO			:= 	'Sharecare Certification'							;
	// EXPORT STRING MasterFFUATFromTO				:= 	'Sharecare User Acceptance Test'			;
	
	// Below value differs for Dev 

	// EXPORT STRING EligibilityMasterFFProd			:= 	'6476'	;
	// EXPORT STRING EligibilityMasterFFPreProd	:= 	'6540'	;
	// EXPORT STRING EligibilityMasterFFCert			:= 	'6536'	;
	// EXPORT STRING EligibilityMasterFFUAT			:= 	'6538'	;	
	
	// EXPORT STRING MedClaimsMasterFFProd			:= 	'6484'	;
	// EXPORT STRING MedClaimsMasterFFPreProd	:= 	'6482'	;
	// EXPORT STRING MedClaimsMasterFFCert			:= 	'6478'	;
	// EXPORT STRING MedClaimsMasterFFUAT			:= 	'6480'	;

	// EXPORT STRING LabsMasterFFProd			:= 	'6502'	;
	// EXPORT STRING LabsMasterFFPreProd		:= 	'6504'	;
	// EXPORT STRING LabsMasterFFCert			:= 	'6506'	;
	// EXPORT STRING LabsMasterFFUAT				:= 	'6508'	;
	
	// EXPORT STRING RxClaimsMasterFFProd			:= 	'6524'	;
	// EXPORT STRING RxClaimsMasterFFPreProd		:= 	'6526'	;
	// EXPORT STRING RxClaimsMasterFFCert			:= 	'6528'	;
	// EXPORT STRING RxClaimsMasterFFUAT				:= 	'6530'	;

	// EXPORT STRING ExternalEventsMasterFFProd		:= '6520';
	// EXPORT STRING ExternalEventsMasterFFPreProd	:= '6518';
	// EXPORT STRING ExternalEventsMasterFFCert		:= '6514';
	// EXPORT STRING ExternalEventsMasterFFUAT			:= '6516';

	// EXPORT STRING ReferralsMasterFFProd			:= '6548';
	// EXPORT STRING ReferralsMasterFFPreProd	:= '6546';
	// EXPORT STRING ReferralsMasterFFCert			:= '6544';
	// EXPORT STRING ReferralsMasterFFUAT			:= '6550';

	// EXPORT STRING GuidShiftTrackerMasterFFProd		:= '6586';
	// EXPORT STRING GuidShiftTrackerMasterFFPreProd	:= '6584';
	// EXPORT STRING GuidShiftTrackerMasterFFCert		:= '6582';
	// EXPORT STRING GuidShiftTrackerMasterFFUAT			:= '6588';

	// EXPORT STRING OrbitSubBuildMaster			:= 	'SubmissionBuildMaster'							;
	// EXPORT STRING OrbitCVBuildMaster			:= 	'CVBuildMaster'											;
	// EXPORT STRING OrbitSubBuild						:= 	'SubmissionBuild'										;
	// EXPORT STRING OrbitCVBuild						:= 	'CVBuild'														;
	// EXPORT STRING OrbitGraveyard					:= 	'Graveyard'													;
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
	// EXPORT boolean UseOrbit               := IF(WhereAmI = daliDev, false, true);
	EXPORT boolean UseOrbit               := IF(WhereAmI = daliDev, false, false);   // no orbit yet
	
	EXPORT STRING targetURL	 							:= TRIM	(
																									CASE	( 	WhereAmI
																													, daliProd 	=> devOrbit // prodOrbit
																													,	daliDev 	=> devOrbit
																													// ,	'Unknown' 
																													,	devOrbit
																												)
																								)	;
	EXPORT STRING OrbitPassword 	 				:= TRIM	(
																									CASE	( 	WhereAmI
																													, daliProd 	=> OrbitPasswordDev // OrbitPasswordProd
																													,	daliDev 	=> OrbitPasswordDev
																													,	'Unknown' 
																												)
																								)	;	
	
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
