IMPORT _Control,PRTE2_Prof_License_Mari;

EXPORT Constants := MODULE
    EXPORT dops_name                :='VehicleV2Keys';

		EXPORT in_prefix_name           := '~prte::in::vehicle::';
    EXPORT base_prefix_name         := '~prte::base::vehicle::';
	
		
		//roxie keys
		EXPORT key_prefix 							:= '~prte::key::vehiclev2::';
		EXPORT SuperKeyName 						:= KEY_PREFIX+'@version@::';
	  
		//wildcard keys
		EXPORT key_prefix_wc						:= '~prte::key::wc_vehicle::';
		EXPORT key_prefix_model					:= '~prte::key::vehicle::';
		EXPORT SuperKeyName_wc					:= key_prefix_wc+'@version@::';
		
		
		//
		EXPORT key_wildcard							:= '~prte::data::vehicle::';
		EXPORT SuperKeyName_wildcard		:= '~prte::hole::wildcard_';
		
		// autokey
		EXPORT autokeyname						 			:= KEY_PREFIX+ 'autokey::';
		EXPORT ak_keyname 									:= KEY_PREFIX+ 'autokey::@version@::';
		EXPORT ak_logical(string filedate) 	:= KEY_PREFIX+ filedate + '::autokey::';
		EXPORT ak_qa_keyname 								:= autokeyname+'qa::';
		EXPORT str_typeStr := 'BC';
		EXPORT ak_skipSet := ['P','Q'];
						// P in this set to skip personal phones
						// Q in this set to skip business phones
						// S in this set to skip SSN
						// F in this set to skip FEIN
						// C in this set to skip ALL personal (Contact) data
						// B in this set to skip ALL Business data
	
END;	