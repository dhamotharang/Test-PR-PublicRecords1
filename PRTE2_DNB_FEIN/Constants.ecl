IMPORT PRTE2_DNB_FEIN;

EXPORT Constants := MODULE

		//Base/Input/Key Prefix
		EXPORT IN_PREFIX 		:= '~prte::in::dnbfein::';
		EXPORT BASE_PREFIX	:= '~prte::base::dnbfein::';
		EXPORT EXP_BASE_PREFIX	:= '~prte::base::experian_fein::';
		EXPORT KEY_PREFIX		:= '~prte::key::dnbfein::';
		EXPORT EXP_KEY_PREFIX	:= '~prte::key::experian_fein::';
		
		// autokey
		EXPORT	ak_keyname 									:= KEY_PREFIX + '@version@::autokey::';
		EXPORT	ak_logical(string filedate) := KEY_PREFIX + filedate + '::autokey::';
		EXPORT	ak_qa_keyname 							:= KEY_PREFIX + 'qa::autokey::';
		EXPORT	ak_skipSet	:= ['C'];
						// P in this set to skip personal phones
						// Q in this set to skip business phones
						// S in this set to skip SSN
						// F in this set to skip FEIN
						// C in this set to skip ALL personal (Contact) data
						// B in this set to skip ALL Business data

		//EXPORT ak_typeStr := 'BC';
		
END;
