IMPORT STD, _control, MDR;

EXPORT Constants(string	pVersion='') := MODULE

	//	Source
	EXPORT	source		:=	MDR.sourceTools.src_NeustarWireless;
	
	//	Server IP to Spray from
	EXPORT	serverIP	:=	IF(	_control.thisenvironment.name='Dataland',
														_Control.IPAddress.bctlpedata12,
														_Control.IPAddress.bctlpedata11);
	
	//	Directory to Spray from
	EXPORT	Directory	:=	'/data/hds_2/neustar_wireless/data/'+ pVersion + '/';

	EXPORT FileToSpray := 'Wireless2_' + pVersion + '.txt';
	
	EXPORT ThorGroup := STD.System.Thorlib.Group();
	
	EXPORT ThorCluster := 'Thor_Data400';
	
END;