IMPORT PRTE2_FCC;
EXPORT Constants	:= MODULE
		
		//Base/Input/Key Prefix
		EXPORT IN_PREFIX 		:= '~prte::in::';
		EXPORT BASE_PREFIX	:= '~prte::base::';
		EXPORT KEY_PREFIX		:= '~prte::key::fcc::';
	
			// autokey
		EXPORT	ak_keyname 									:= KEY_PREFIX + '@version@::autokey::';
		EXPORT	ak_logical(string filedate) := KEY_PREFIX + filedate + '::autokey::';
		EXPORT	ak_skipSet	:= ['S','F'];
						// P in this set to skip personal phones
						// Q in this set to skip business phones
						// S in this set to skip SSN
						// F in this set to skip FEIN
						// C in this set to skip ALL personal (Contact) data
						// B in this set to skip ALL Business data

		EXPORT ak_typeStr := 'AK';
	
END;