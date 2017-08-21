import _control;
export constants := module
	EXPORT prolicv2_base := '~prte::base::prolicv2';
	EXPORT KeyName_prolicv2 := 	'~prte::key::prolicv2::';
	EXPORT ak_keyname := KeyName_prolicv2 +'@version@::autokey::';
	EXPORT ak_logical(string filedate) := KeyName_prolicv2 + filedate + '::autokey::';
	EXPORT ak_QAname := KeyName_prolicv2 +'qa::autokey::';	
	EXPORT ak_typestr := 'AK';

	export skip_set := ['F','P'];
		
	//Spray constants
	EXPORT IN_PREFIX_NAME := '~PRTE::IN::prolicv2';
	
end;
