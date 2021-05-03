IMPORT	MDR,	Tools, _control;
EXPORT	Constants(STRING	pFileDate='')	:=
INLINE MODULE
	
	//	Server IP to Spray from
	EXPORT	serverIP	:=	IF( Tools._Constants.IsDataland,
																								_control.IPAddress.bctlpedata12,
																								_control.IPAddress.bctlpedata11);

	//	Directory to Spray from
	EXPORT	Directory	:=	IF(	Tools._Constants.IsDataland,
																								'/data/temp/reederkx/repository/build_library/builds/whois_data/data/processing/',
																								'/data/temp/reederkx/repository/build_library/builds/whois_data/data/processing/');
	
END;
