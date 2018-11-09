IMPORT	LiensV2_SrcInfoRpt,	MDR,	ut,	_control;
EXPORT	Constants(STRING	pFileDate='')	:=
MODULE

	//	Source
	EXPORT	source		:=	MDR.sourceTools.src_Liens_v2;
	
	//	Server IP to Spray from
	EXPORT	serverIP	:=	IF(	_control.thisenvironment.name='Dataland',
														'bctlpedata12.risk.regn.net',
														'bctlpedata12.risk.regn.net');
	
	//	Directory to Spray from
	EXPORT	Directory	:=	IF(	_control.thisenvironment.name='Dataland',
														'/data/hds_180/SBFE/_in/TEMP/',
														'/data/hds_180/SBFE/_in/TEMP/');

END;
