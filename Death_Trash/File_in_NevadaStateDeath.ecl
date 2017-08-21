nv_in1980_2012_file	:=	'~thor_data400::in::nv1980_2012_deathm_raw::sprayed::data';
nv_file							:=	'~thor_data400::in::nv_deathm_raw::sprayed::data';

nv_in1980_2012 := DATASET(nv_in1980_2012_file,
									Death_Master.Layout_States.Nevada_1980_2012,
									CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n', '\r\n']),MAXLENGTH(100000)));
						
// Transform 1980-2012 data to include name_suffix row
nv_in1980_2012_transformed := PROJECT(nv_in1980_2012, TRANSFORM(Death_Master.Layout_States.Nevada, SELF.name_suffix := '', SELF := LEFT));

nv_in := DATASET(	nv_file,
									Death_Master.Layout_States.Nevada,
									CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n', '\r\n']),MAXLENGTH(100000)));

// 1980-2012 is the old format and may only be run the first time.
EXPORT File_in_NevadaStateDeath :=	IF(NOTHOR(FileServices.GetSuperFileSubCount(nv_in1980_2012_file) = 0),
																			IF(NOTHOR(FileServices.GetSuperFileSubCount(nv_file) <> 0),nv_in),
																			nv_in1980_2012_transformed + nv_in);

