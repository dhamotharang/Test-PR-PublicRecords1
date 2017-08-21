
EXPORT Constants := module

		EXPORT in_prefix_name           := '~prte::in::utility_file';
    EXPORT base_prefix_name         := '~prte::base::utility_file';
	
		
		//roxie keys
		EXPORT key_prefix 							:= '~prte::key::utility::';
		EXPORT key_prefix_util					:= '~prte::key::';
		EXPORT key_prefix_date					:= '~prte::key::dateCorrect::';
		
		
		EXPORT SuperKeyName 						:= KEY_PREFIX+'@version@::';
		EXPORT SuperKeyName_util				:= KEY_PREFIX_UTIL+'@version@::';
		EXPORT SuperKeyName_date				:= key_prefix_date+'@version@::';
		EXPORT autokeyname 							:= KEY_PREFIX+'@version@::daily.';
		
END;	