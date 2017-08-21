IMPORT PRTE2_SexOffender;

EXPORT Constants := MODULE

		//Base/Input/Key Prefix
		EXPORT IN_PREFIX 		:= '~prte::in::SexOffender::';
		EXPORT BASE_PREFIX	:= '~prte::base::SexOffender::';
		EXPORT KEY_PREFIX		:= '~prte::key::SexOffender::';
	
			// autokey
		EXPORT  ENH_ak_keyname							:= KEY_PREFIX + '@version@::enhpublic';
		EXPORT	SPK_ak_keyname							:= KEY_PREFIX + '@version@::public';
		EXPORT	ak_keyname 									:= KEY_PREFIX + '@version@::autokey::';
		EXPORT	ak_logical(string filedate) := KEY_PREFIX + filedate + '::autokey::';
		EXPORT	ak_qa_keyname 							:= KEY_PREFIX + 'qa::autokey::';
		EXPORT	ak_skipSet	:= ['P','B'];  //skip personal phones and all business data
						// P in this set to skip personal phones
						// Q in this set to skip business phones
						// S in this set to skip SSN
						// F in this set to skip FEIN
						// C in this set to skip ALL personal (Contact) data
						// B in this set to skip ALL Business data

		EXPORT ak_typeStr := 'AK';
END;