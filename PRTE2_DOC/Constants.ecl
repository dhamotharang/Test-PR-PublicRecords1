IMPORT doxie_build;
EXPORT Constants := module

EXPORT KeyName_corrections := 	'~prte::key::corrections::'; 

EXPORT corrections_keys_logicalname(string filedate) := '~prte::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::';

EXPORT corrections_keys_root := '~prte::key::corrections_'+doxie_build.buildstate;

EXPORT ak_keyname := KeyName_corrections +'autokey::@version@::'; 

EXPORT ak_logical(string filedate) := KeyName_corrections + filedate + '::autokey::'; 

EXPORT skip_set :=  ['B','P']; 

EXPORT ak_typestr := 'AK'; 

END;

