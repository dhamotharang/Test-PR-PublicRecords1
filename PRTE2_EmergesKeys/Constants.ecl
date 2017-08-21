EXPORT Constants := module

Export In_Hunters := '~PRTE::In::CCW::hunting_fishing';
EXPORT Base_Hunters := '~PRTE::Base::CCW::hunting_fishing';

Export In_CCW := '~PRTE::In::CCW::CCW';
EXPORT Base_CCW := '~PRTE::Base::CCW::CCW';

EXPORT KeyName_CCW := 	'~prte::key::CCW::'; 
EXPORT KeyName_Hunting := 	'~prte::key::hunting_fishing::'; 

Export KeyName_CCW_doxie_did := '~prte::key::ccw_doxie_did_';
Export KeyName_CCW_doxie_did_FCRA := '~prte::key::ccw_doxie_did_fcra_';

Export KeyName_Hunting_doxie_did := '~prte::key::hunters_doxie_did_';
Export KeyName_Hunting_doxie_did_FCRA := '~prte::key::hunters_doxie_did_fcra_';

Export KeyName_Emerges := '~prte::key::emerges::';

EXPORT ak_keyname := KeyName_CCW +'@version@::autokey::';

EXPORT ak_keyname_hunting := KeyName_Hunting +'@version@::autokey::';

EXPORT ak_logical(string filedate) := KeyName_CCW + filedate + '::autokey::'; 
EXPORT ak_logical_hunting (string filedate) := KeyName_hunting + filedate + '::autokey::'; 

export ak_skipSet:= ['P','Q','F','B'];  // B is for no business autokeys to be built
export ak_skip_set_hunting := ['P','B'];

EXPORT ak_typestr := 'BC'; 

END;