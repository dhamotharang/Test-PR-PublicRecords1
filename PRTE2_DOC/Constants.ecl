IMPORT doxie_build, hygenics_crim;
EXPORT Constants := module

EXPORT KeyName_corrections := 	'~prte::key::corrections::'; 

EXPORT corrections_keys_logicalname(string filedate) := '~prte::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::';

EXPORT corrections_keys_root := '~prte::key::corrections_'+doxie_build.buildstate;

EXPORT ak_keyname := KeyName_corrections +'autokey::@version@::'; 

EXPORT ak_logical(string filedate) := KeyName_corrections + filedate + '::autokey::'; 

EXPORT skip_set :=  ['B','P']; 

EXPORT ak_typestr := 'AK'; 

//DF-21868 followings are fields to be deprecated in FCRA_
EXPORT fields_to_clear_offenders 							:= hygenics_crim.constants('').fields_to_clear_offenders;
EXPORT fields_to_clear_offender_key       		:= hygenics_crim.constants('').fields_to_clear_offender_key;
EXPORT fields_to_clear_punishment_type    		:= hygenics_crim.constants('').fields_to_clear_punishment_type;
EXPORT fields_to_clear_court_offenses      		:= hygenics_crim.constants('').fields_to_clear_court_offenses;
EXPORT fields_to_clear_offenders_offenderkey 	:= hygenics_crim.constants('').fields_to_clear_offenders_offenderkey;


END;

