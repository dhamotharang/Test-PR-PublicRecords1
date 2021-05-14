IMPORT	Business_Credit,	MDR,	ut,	_control;
EXPORT	Constants(string	pFileDate='')	:=
MODULE

	//	Source
	//EXPORT	source		:=	MDR.sourceTools.src_OKC_Student_List;
	
	//	Server IP to Spray from
	EXPORT	serverIP	:=	IF(	_control.thisenvironment.name='Dataland',
														'bctlpedata12.risk.regn.net',
														'bctlpedata11.risk.regn.net');
	
	//	Directory to Spray from
	EXPORT	Directory	:= module	
	
	export main:=IF(	_control.thisenvironment.name='Dataland',
														'/data/hds_180/property/Collateral_Analytic/data/processing/',
														'/data/hds_180/property/Collateral_Analytic/data/processing/');
	export exception:=IF(	_control.thisenvironment.name='Dataland',
														'/data/hds_180/property/Collateral_Analytic/data/exception/processing/',
														'/data/hds_180/property/Collateral_Analytic/data/exception/processing/');
	end;
	//	Scrubs email notification
	EXPORT 	email_notification_scrubs := 'david.dittman@lexisnexisrisk.com';
	EXPORT 	email_notification_strata := 'david.dittman@lexisnexisrisk.com';
	EXPORT 	email_notification_missign_college_names := 'david.dittman@lexisnexisrisk.com';
	EXPORT 	email_notification_missign_major_mapping := 'david.dittman@lexisnexisrisk.com';

END;