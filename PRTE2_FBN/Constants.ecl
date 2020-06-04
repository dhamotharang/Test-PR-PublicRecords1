import data_services;

EXPORT Constants := module

Export In_fbnv2_Business := '~PRTE::IN::fbnv2::business';
Export In_fbnv2_contact := '~PRTE::IN::fbnv2::contact';

Export Base_fbnv2_Business := '~PRTE::base::fbnv2::business';
Export Base_fbnv2_contact := '~PRTE::base::fbnv2::contact';

EXPORT KeyName_fbnv2 := 	'~prte::key::fbnv2::';  

Export ak_keyname := KeyName_fbnv2 + '@version@::autokey::';

EXPORT ak_logical(string filedate) := KeyName_fbnv2 + filedate + '::autokey::'; 

EXPORT dataset_name := 'FBN2KEYS';

END;

