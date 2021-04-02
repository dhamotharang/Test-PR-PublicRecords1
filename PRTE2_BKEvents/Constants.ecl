IMPORT _Control, Data_Services, std;

EXPORT Constants := MODULE

    Export dops_name                     := 'BKeventskeys';
		Export dops_fcra_name                :='FCRA_BKeventskeys';
		

    EXPORT todaysdate 							:= (STRING8)Std.Date.Today();
		EXPORT in_prefix_name						:= '~prte::in::banko';
		EXPORT base_prefix_name					:= '~prte::base::banko::';
	
		//roxie keys
		EXPORT KEY_PREFIX 							:= '~prte::key::banko::';
		EXPORT KEY_PREFIX_FCRA					:= KEY_PREFIX+'fcra::';
		EXPORT SuperKeyName 						:= KEY_PREFIX+'@version@::';
		EXPORT SuperKeyName_FCRA 				:= KEY_PREFIX_FCRA+'@version@::';
		
END;	