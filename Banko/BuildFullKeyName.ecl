IMPORT	data_services;

EXPORT	BuildFullKeyName(BOOLEAN	isFCRA	=	FALSE)	:=	FUNCTION
	prefix	:=	IF(isFCRA, 
								data_services.Data_location.prefix('Banko')+ 'thor_data400::KEY::Banko::fcra::qa::courtcode.fullcasenumber.caseId.payload', 
								data_services.Data_location.prefix('Banko')+ 'thor_data400::KEY::Banko::qa::courtcode.fullcasenumber.caseId.payload');
	RETURN	prefix;
END;
