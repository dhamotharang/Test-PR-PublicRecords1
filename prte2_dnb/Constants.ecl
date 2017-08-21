EXPORT Constants := module

EXPORT KeyName_DNB := 	'~prte::key::dnb::'; 

EXPORT ak_keyname := KeyName_DNB +'autokey::@version@::'; 

EXPORT ak_logical(string filedate) := KeyName_DNB +  filedate + '::autokey::'; 

EXPORT skip_set := ['P', 'S','C', 'F'];

EXPORT ak_typestr := 'BC'; 

END;