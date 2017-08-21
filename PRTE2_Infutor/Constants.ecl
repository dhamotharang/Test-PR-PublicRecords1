EXPORT Constants := module

EXPORT KeyName_infutor := 	'~prte::key::infutor::'; 

EXPORT ak_keyname := KeyName_infutor +'autokey::@version@::'; 

EXPORT ak_logical(string filedate) := KeyName_infutor + filedate + '::autokey::'; 

EXPORT skip_set := [/* Fill in appropriate values */ ]; 

EXPORT ak_typestr := 'AK'; 

END;