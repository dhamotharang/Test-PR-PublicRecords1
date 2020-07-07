EXPORT Constants := module

EXPORT dca_keyname := 	'~prte::key::dca::'; 

EXPORT ak_keyname := dca_keyname + 'autokey::@version@::'; 

EXPORT ak_logical(string filedate) := dca_keyname + filedate + '::autokey::'; 

EXPORT ak_skip_set := ['C','P','Q','F']; 

EXPORT ak_typestr := 'AK';

EXPORT in_dca := '~PRTE::IN::dca';

EXPORT base_dca := '~PRTE::BASE::dca'; 

EXPORT dataset_name := 'DCAKEYS';

END;