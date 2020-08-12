IMPORT Email_Event, tools, MDR, _Control; 

EXPORT	_Constants	:=
INLINE MODULE
  // 
	EXPORT  Name    :=  'BV Event';
	//	Source
	EXPORT	source	:=	MDR.sourceTools.src_BrightVerify_email;
	
	//	Server IP to Spray from
	EXPORT	serverIP	:=	IF(	Tools._Constants.IsDataland,
																								_Control.IPAddress.bctlpedata12,
																								_Control.IPAddress.bctlpedata10);
	//	Directory to Spray from
	EXPORT	Directory_delta	:=	'/data/data_999/email/delta_gateway/';
	
	EXPORT	Directory	      :=	'/data/hds_180/BrightVerify_email/domain/';
	
	//  Group to spray
	EXPORT GroupName  :=  IF(	Tools._Constants.IsDataland,
																									'thor400_dev01',
																									'thor400_36');
END;