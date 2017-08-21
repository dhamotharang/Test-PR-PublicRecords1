EXPORT Constants := module

EXPORT In_Corp2_AR := '~PRTE::IN::corp2::ar';
EXPORT Base_Corp2_AR := '~PRTE::Base::corp2::ar';
Export In_Prefix := '~prte::in::corp2::';
Export Base_Prefix := '~prte::base::corp2::';

EXPORT In_Corp2_event := '~PRTE::IN::corp2::event';
EXPORT Base_Corp2_event := '~PRTE::Base::corp2::event';

EXPORT In_Corp2_stock := '~PRTE::IN::corp2::stock';
EXPORT Base_Corp2_stock := '~PRTE::Base::corp2::stock';

EXPORT In_Corp2_cont := '~PRTE::IN::corp2::cont';
EXPORT Base_Corp2_cont := '~PRTE::Base::corp2::cont';

EXPORT In_Corp2_corp := '~PRTE::IN::corp2::corp';
EXPORT Base_Corp2_corp := '~PRTE::Base::corp2::corp';

EXPORT KeyName_corp2 := 	'~prte::key::corp2::'; 

EXPORT ak_keyname := KeyName_corp2 +'@version@::autokey::';

EXPORT ak_logical(string filedate) := KeyName_corp2 + filedate + '::autokey::'; 

EXPORT skip_set := [/* Fill in appropriate values */ ]; 

EXPORT ak_typestr := 'AK'; 

END;