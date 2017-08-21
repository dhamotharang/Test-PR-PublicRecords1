
ca1999_file	:=	'~thor_data400::in::ca1999_deathm_raw::sprayed::data';
ca_file			:=	'~thor_data400::in::ca_deathm_raw::sprayed::data';

ca_in1999 := DATASET(ca1999_file,
									Death_Master.Layout_States.California_1999,
									CSV(HEADING(0), SEPARATOR(','), TERMINATOR(['\n', '\r\n']),MAXLENGTH(100000)));
						
// Transform 1999 data to remove st row
ca_1999_transformed := PROJECT(ca_in1999, TRANSFORM(Layout_CaliforniaStateDeath_data,SELF := LEFT));

ca_in := DATASET(ca_file,
									Death_Master.Layout_States.California,
									CSV(HEADING(0), SEPARATOR(','), TERMINATOR(['\n', '\r\n']),MAXLENGTH(100000)));

// 1999 is the old format and may only be run the first time.
EXPORT File_in_CaliforniaStateDeath := 	IF(NOTHOR(FileServices.GetSuperFileSubCount(ca1999_file) = 0),
																					IF(NOTHOR(FileServices.GetSuperFileSubCount(ca_file) <> 0),ca_in),
																					ca_1999_transformed + ca_in);

