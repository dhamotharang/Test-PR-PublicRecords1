IMPORT	Business_Credit,	MDR,	ut,	_control;
EXPORT	Constants(string	pFileDate='')	:=
INLINE MODULE

	//	Source
	EXPORT	source		:=	mdr.sourceTools.src_Infutornarc; // may need to change this
	
	//	Server IP to Spray from
	EXPORT	serverIP	:=	IF(	_control.thisenvironment.name='Dataland',
														_Control.IPAddress.bctlpedata12,
														_Control.IPAddress.bctlpedata11);
														
	//EXPORT	serverIP	:=	_Control.IPAddress.bctlpedata12;
	
	//	Directory to Spray from
	EXPORT	Directory	:=	IF(	_control.thisenvironment.name='Dataland',
														'/data/projects/infutor_narc3/'+pFileDate,
														'/data/projects/infutor_narc3/'+pFileDate);
	

END;
