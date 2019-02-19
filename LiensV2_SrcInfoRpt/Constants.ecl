IMPORT	LiensV2_SrcInfoRpt,	MDR,	ut,	_control;
EXPORT	Constants(STRING	pFileDate='')	:=
MODULE

	//	Source
	EXPORT	source		:=	MDR.sourceTools.src_Liens_v2;
	
	//	Server IP to Spray from
	EXPORT	serverIP	:=	IF(	_control.thisenvironment.name='Dataland',
														_Control.IPAddress.bctlpedata12,
														_Control.IPAddress.bctlpedata10);
	
	//	Directory to Spray from
	EXPORT	Directory	:=	IF(	_control.thisenvironment.name='Dataland',
														'/data/hds_2/liensv2/daily_files/SrcInfoRpt/build/'+pFileDate,
														'/data/hds_2/liensv2/daily_files/SrcInfoRpt/build/'+pFileDate);

END;
