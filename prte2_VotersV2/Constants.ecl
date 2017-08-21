EXPORT Constants := module

EXPORT In_VotersV2 := '~PRTE::IN::voters';

EXPORT Base_VotersV2 := '~PRTE::BASE::voters';

EXPORT KeyName_voters := 	'~prte::key::voters::'; 

EXPORT ak_keyname := KeyName_voters +'autokey::@version@::'; 

EXPORT ak_logical(string filedate) := KeyName_voters + filedate + '::autokey::'; 

EXPORT skip_set := ['B','F','Q']; 

EXPORT ak_typestr := 'AK'; 

END;