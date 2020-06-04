IMPORT _control, LiensV2;
EXPORT Constants	:= MODULE
		
		//Base/Input/Key Prefix
		EXPORT IN_PREFIX 		:= '~prte::in::liensV2::';
		EXPORT BASE_PREFIX	:= '~prte::base::liensV2::';
		EXPORT KEY_PREFIX		:= '~prte::key::liensV2::';
	
			// autokey
		EXPORT	ak_keyname 									:= KEY_PREFIX + '@version@::autokey::';
		EXPORT	ak_logical(string filedate) := KEY_PREFIX + filedate + '::autokey_';
		EXPORT	ak_qa_keyname 							:= KEY_PREFIX + 'qa::autokey::';
		EXPORT	set_skip := [];
						// P in this set to skip personal phones
						// Q in this set to skip business phones
						// S in this set to skip SSN
						// F in this set to skip FEIN
						// C in this set to skip ALL personal (Contact) data
						// B in this set to skip ALL Business data

		//EXPORT TYPE_STR := 'ak';
	
	
	EXPORT fields_to_clear_main_id_fcra 	:=  LiensV2.Constants.fields_to_clear_main_id_fcra;
	EXPORT fields_to_clear_party_id_fcra 	:= LiensV2.Constants.fields_to_clear_party_id_fcra;
	
	export dops_name                    :='LiensV2Keys';
 export fcra_dops_name                :='FCRA_LiensV2Keys';
END;