EXPORT Constants := module

EXPORT busreg_in := '~prte::in::busreg';

EXPORT busreg_base := '~prte::base::busreg_company';

EXPORT KeyName_busreg := 	'~prte::key::busreg_company';

EXPORT KeyName_busreg2 := '~prte::key::busreg::';

EXPORT ak_keyname := KeyName_busreg +'autokey::@version@::'; 

EXPORT ak_logical(string filedate) := KeyName_busreg + filedate + '::autokey::'; 


END;