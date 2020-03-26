
EXPORT Constants := module

		EXPORT in_prefix_name           := '~prte::in::utility::utilitydaily';
   
	  Export in_Ins                   := '~prte::in::utility::utilitydailyins';
	  EXPORT base_prefix_name         := '~prte::base::utility_file';
		Export dops_name                := 'UtilityDailyKeys';
	
		
		//roxie keys
		EXPORT key_prefix 							:= '~prte::key::utility::';
		EXPORT key_prefix_util					:= '~prte::key::';
		EXPORT key_prefix_date					:= '~prte::key::dateCorrect::';
		
		
		EXPORT SuperKeyName 						:= KEY_PREFIX+'@version@::';
		EXPORT SuperKeyName_util				:= KEY_PREFIX_UTIL+'@version@::';
		EXPORT SuperKeyName_date				:= key_prefix_date+'@version@::';
		EXPORT autokeyname 							:= KEY_PREFIX+'@version@::daily.';
		
END;	