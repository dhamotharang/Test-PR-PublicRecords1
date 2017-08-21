EXPORT Constants := module

EXPORT KeyName_gsa := 	'~prte::key::gsa::'; 

EXPORT ak_keyname := KeyName_gsa +'autokey::@version@::'; 

EXPORT ak_logical(string filedate) := KeyName_gsa + filedate + '::autokey::'; 

EXPORT skip_set := ['P','Q','S','F']; 

EXPORT ak_typestr := 'AK'; 

END;

