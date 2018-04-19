IMPORT	OKC_Probate,	MDR,	Tools, _Control;
EXPORT	Constants(STRING	pFileDate='')	:=
INLINE MODULE

	//	Source
	EXPORT	source	:=	MDR.sourceTools.src_OKC_Probate;
	
	//	Server IP to Spray from
	EXPORT	serverIP	:=	IF(	Tools._Constants.IsDataland,
																								_Control.IPAddress.bctlpedata12,
																								_Control.IPAddress.bctlpedata10);
	
	//	Directory to Spray from
	EXPORT	Directory	:=	IF(	Tools._Constants.IsDataland,
																									'/data/hds_4/death_master/in/_okc_probate',
																									'/data/hds_4/death_master/in/okc_probate');
	
END;
