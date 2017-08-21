IMPORT _Control,PRTE2_Prof_License_Mari;

EXPORT Constants := MODULE

		EXPORT in_prefix_name           := '~prte::in::proflic_mari::';
    EXPORT base_prefix_name         := '~prte::base::proflic_mari::';
		
		//roxie keys
		EXPORT KEY_PREFIX 							:= '~prte::key::proflic_mari::';
		EXPORT KEY_PREFIX_FCRA					:= '~prte::key::proflic_mari::fcra::';
		EXPORT SuperKeyName 						:= KEY_PREFIX+'@version@::';
		EXPORT SuperKeyName_FCRA 				:= KEY_PREFIX_FCRA+'@version@::';
    
		
		// autokey
		EXPORT autokeyname						 			:= KEY_PREFIX+ 'autokey::';
		EXPORT ak_keyname 									:= KEY_PREFIX+ 'autokey::@version@::';
		EXPORT ak_logical(string filedate) 	:= KEY_PREFIX+ filedate + '::autokey::';
		EXPORT ak_qa_keyname 								:= autokeyname+'qa::';
		EXPORT set_skip := [];
						// P in this set to skip personal phones
						// Q in this set to skip business phones
						// S in this set to skip SSN
						// F in this set to skip FEIN
						// C in this set to skip ALL personal (Contact) data
						// B in this set to skip ALL Business data

		EXPORT TYPE_STR := 'ak';
		EXPORT USE_ALL_LOOKUPS := TRUE;

		
END;	