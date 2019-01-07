IMPORT	Business_Credit,	MDR,	ut,	_control;
EXPORT	Constants(string	pFileDate='')	:=
INLINE MODULE

	//	Source
	EXPORT	source		:=	MDR.sourceTools.src_Business_Credit;
	
	//	Server IP to Spray from
	EXPORT	serverIP	:=	IF(	_control.thisenvironment.name='Dataland',
														_Control.IPAddress.bctlpedata12,
														_Control.IPAddress.bctlpedata11);
	
	//	Directory to Spray from
	EXPORT	Directory	:=	IF(	_control.thisenvironment.name='Dataland',
														'/data/hds_2/dunn_data_marketing/',
														'/data/hds_2/dunn_data_marketing/');

	EXPORT FileToSpray := '*.TXT';
	

END;
