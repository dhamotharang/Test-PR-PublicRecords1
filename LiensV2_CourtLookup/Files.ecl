//	Needed in file_liens_fcra_main
IMPORT	data_services;
EXPORT Files(BOOLEAN	pUseProd	=	TRUE) := MODULE
	filename := Map(pUseProd => data_services.foreign_prod +	'thor_data400::liens::courtsetupslj',
	                '~thor_data400::liens::courtsetupslj');
									
	EXPORT	CourtIn	  :=	DATASET(filename, Layouts.rCourtlookupIn , 
																					CSV(HEADING(1),
																							SEPARATOR([',']),
																							QUOTE('\"'),
																							TERMINATOR(['\n','\r\n','\n\r']))
																			);
	EXPORT  CourtBase := 	DATASET('~thor_data400::base::liens::courtsetupslj',Layouts.rBaseCourtLookup ,flat);												
END;                        
                             