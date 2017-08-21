EXPORT Constants := module
Import MDR;

	EXPORT KeyName_paw := 	'~prte::key::paw::'; 

	EXPORT ak_keyname := KeyName_paw +'@version@::autokey::'; 

	EXPORT ak_logical(string filedate) := KeyName_paw + filedate + '::autokey::'; 

	EXPORT skip_set := [ ]; 

	EXPORT ak_typestr := 'PAW'; 
	
	EXPORT PAW_FCRA_sources := MDR.sourceTools.set_Paw;

END;