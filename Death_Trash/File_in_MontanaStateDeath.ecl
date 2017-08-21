
mt_file	:=	'~thor_data400::in::mt_deathm_raw::sprayed::data';
EXPORT File_in_MontanaStateDeath :=	IF(NOTHOR(FileServices.GetSuperFileSubCount(mt_file) <> 0),
																			DATASET(mt_file,Death_Master.Layout_States.Montana,
																			CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']),MAXLENGTH(100000))));
																				
