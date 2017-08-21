mi_file	:=	'~thor_data400::in::mi_deathm_raw::sprayed::data';
file_in := 	DATASET(mi_file,Death_Master.Layout_States.Michigan,THOR);
EXPORT File_in_MichiganStateDeath :=	IF(NOTHOR(FileServices.GetSuperFileSubCount(mi_file) <> 0),
																				file_in(alias_code in [' ','0','1']));


