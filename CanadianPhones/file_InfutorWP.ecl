IMPORT $, Data_Services;

EXPORT file_InfutorWP := MODULE

	EXPORT RawIn	:=	DATASET('~thor_data400::in::infutorwp',
										CanadianPhones.Layout_InfutorWP,CSV(TERMINATOR('\n'), SEPARATOR('\t'), QUOTE('"')));
										
	EXPORT Base	:= DATASET('~thor_data400::base::infutorwp', CanadianPhones.layoutCanadianWhitepagesBase, THOR);
	
END;

										