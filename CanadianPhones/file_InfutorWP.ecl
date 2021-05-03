IMPORT $, Data_Services;

EXPORT file_InfutorWP(BOOLEAN	pUseProd	=	FALSE) := MODULE
	SHARED fileprefix	:= IF(pUseProd, data_services.foreign_prod, '~');

	EXPORT RawIn	:=	DATASET(fileprefix+'thor_data400::in::infutorwp',
										CanadianPhones.Layout_InfutorWP.InputFile,CSV(TERMINATOR('\n'), SEPARATOR('\t'), QUOTE('"')));
										
	EXPORT Base	:= DATASET('~thor_data400::base::infutorwp', CanadianPhones.Layout_InfutorWP.BaseOut, THOR, OPT);
	
END;

										