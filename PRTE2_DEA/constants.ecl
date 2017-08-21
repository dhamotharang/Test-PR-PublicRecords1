import _control;
export constants := module
	EXPORT dea_base := '~prte::base::dea';
	EXPORT KeyName_DEA := 	'~prte::key::dea::';
	EXPORT ak_keyname := KeyName_DEA +'@version@::autokey::';
	EXPORT ak_logical(string filedate) := KeyName_DEA + filedate + '::autokey::';
	EXPORT ak_QAname := KeyName_DEA +'qa::autokey::';	
	EXPORT ak_typestr := 'AK';
	EXPORT STRING srcType := 'dea';
	
//P in this set to skip personal phones
//Q in this set to skip business phones
//S in this set to skip SSN
//F in this set to skip FEIN
//C in this set to skip ALL personal (Contact) data
//B in this set to skip ALL Business data
	EXPORT skip_set := ['P','Q','F'];
	
end;




 