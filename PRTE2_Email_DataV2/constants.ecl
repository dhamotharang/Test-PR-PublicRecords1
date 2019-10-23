EXPORT Constants := MODULE
EXPORT key_prefix 				:= '~prte::key::email_dataV2::';
EXPORT key_FCRA_prefix 		:= '~prte::key::email_dataV2::fcra::';

// autokey
		EXPORT autokeyname						 					:= key_prefix+ 'autokey::';
		EXPORT ak_keyname 											:= key_prefix+ 'autokey::@version@::';
		EXPORT ak_logical(string filedate) 			:= key_prefix+ filedate + '::autokey::';
		EXPORT ak_qa_keyname 										:= autokeyname+'qa::';
		EXPORT ak_skipSet 											:= ['P','B'];
		EXPORT ak_typeStr												:= 'BC';
		EXPORT STRING srcType										:= 'email_datav2';


End;