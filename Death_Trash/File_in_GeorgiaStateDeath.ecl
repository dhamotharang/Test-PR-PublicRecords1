ga_file	:=	'~thor_data400::in::ga_deathm_raw::sprayed::data';

EXPORT File_in_GeorgiaStateDeath :=	IF(NOTHOR(FileServices.GetSuperFileSubCount(ga_file) <> 0),
																			DATASET(ga_file,Death_Master.Layout_States.Georgia,
																			CSV(SEPARATOR('\t'), TERMINATOR(['\n', '\r\n']),MAXLENGTH(100000))));
																				
