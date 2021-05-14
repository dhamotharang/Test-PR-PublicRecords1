IMPORT PRTE2_UCC;

EXPORT Constants := MODULE
		
		//Base/Input/Key Prefix
		EXPORT IN_PREFIX 		:= '~prte::in::ucc::';
		EXPORT BASE_PREFIX	:= '~prte::base::ucc::';
		EXPORT KEY_PREFIX		:= '~prte::key::ucc::';
		
		// autokey
		EXPORT	ak_keyname 									:= KEY_PREFIX + '@version@::autokey::';
		EXPORT	ak_logical(string filedate) := KEY_PREFIX + filedate + '::autokey::';
		EXPORT	ak_qa_keyname 							:= KEY_PREFIX + 'qa::autokey::';
		EXPORT	ak_skipSet	:= [];
						// P in this set to skip personal phones
						// Q in this set to skip business phones
						// S in this set to skip SSN
						// F in this set to skip FEIN
						// C in this set to skip ALL personal (Contact) data
						// B in this set to skip ALL Business data

		EXPORT ak_typeStr := 'BC';
		
 export dops_name                    :='UCCV2Keys';
 export fcra_dops_name               :='FCRA_UCCKeys';
		
END;