EXPORT Constants := module

EXPORT keyname_mfind := 	'~prte::key::mfind::'; 

EXPORT in_mfind := '~prte::in::mfind';

EXPORT base_mfind := '~prte::base::mfind'; 

EXPORT ak_keyname := keyname_mfind +'autokey::@version@::'; 

EXPORT ak_logical(string filedate) := keyname_mfind + filedate + '::autokey::'; 

EXPORT skip_set := ['P','S','B']; 

EXPORT ak_typestr := 'BC'; 

END;