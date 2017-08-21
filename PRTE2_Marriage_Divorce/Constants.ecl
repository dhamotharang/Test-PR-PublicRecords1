IMPORT PRTE2_Marriage_Divorce;

EXPORT Constants := MODULE
		
		//Base/Input/Key Prefix
		EXPORT IN_PREFIX 		:= '~prte::in::mar_div::';
		EXPORT BASE_PREFIX	:= '~prte::base::mar_div::';
		EXPORT KEY_PREFIX		:= '~prte::key::mar_div::';
		
		// autokey
		EXPORT	ak_keyname 									:= KEY_PREFIX + 'autokey::';
		EXPORT	ak_logical(string filedate) := KEY_PREFIX + filedate + '::autokey::';
		EXPORT	ak_qa_keyname 							:= KEY_PREFIX + 'qa::autokey::';
		EXPORT	ak_skipSet	:= ['P','S','B','Q','F'];
						// P in this set to skip personal phones
						// Q in this set to skip business phones
						// S in this set to skip SSN
						// F in this set to skip FEIN
						// C in this set to skip ALL personal (Contact) data
						// B in this set to skip ALL Business data

		EXPORT ak_typeStr := 'BC';
		
END;