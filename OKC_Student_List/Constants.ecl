IMPORT	Business_Credit,	MDR,	ut,	_control;
EXPORT	Constants(string	pFileDate='')	:=
MODULE

	//	Source
	EXPORT	source		:=	MDR.sourceTools.src_OKC_Student_List;
	
	//	Server IP to Spray from
	EXPORT	serverIP	:=	IF(	_control.thisenvironment.name='Dataland',
														'bctlpedata12.risk.regn.net',
														'bctlpedata10.risk.regn.net');
	
	//	Directory to Spray from
	EXPORT	Directory	:=	IF(	_control.thisenvironment.name='Dataland',
														'/data/data_build_1/american_student/',
														'/data/data_build_1/american_student/');

	//	Scrubs email notification
	EXPORT 	email_notification_scrubs := 'cathy.tio@lexisnexisrisk.com';
	EXPORT 	email_notification_strata := 'cathy.tio@lexisnexisrisk.com';
	EXPORT 	email_notification_missign_college_names := 'cathy.tio@lexisnexisrisk.com';
	EXPORT 	email_notification_missign_major_mapping := 'margaret.worob@lexisnexisrisk.com;cathy.tio@lexisnexisrisk.com';

END;