IMPORT	MDR,	Tools;
EXPORT	Constants(STRING	pFileDate='')	:=
INLINE MODULE
	
	//	Server IP to Spray from
	EXPORT	serverIP	:=	IF(	Tools._Constants.IsDataland,
																								'bctlpedata12.risk.regn.net',
																								'bctlpedata11.risk.regn.net');
	
	//	Directory to Spray from
	EXPORT	Directory	:=	IF(	Tools._Constants.IsDataland,
																									'/data/hds_180/FirstData/build/',
																									'/data/hds_180/FirstData/build/');
	
END;
