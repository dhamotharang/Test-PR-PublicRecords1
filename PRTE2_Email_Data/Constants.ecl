IMPORT _Control, ut, PRTE, PRTE2, PRTE2_Common;

EXPORT Constants := MODULE

		EXPORT in_prefix_name						:= '~prte::in::email_data::';
		EXPORT base_prefix_name					:= '~prte::base::email_data::';
		EXPORT base_prefix_alpha				:= 'prct::base::ct::email_data_v2';
		EXPORT qaVersion              	:= '::qa::';
																 
	//custom keys		
		EXPORT key_prefix 							:= '~prte::key::email_data::';
		EXPORT key_prefix_fcra 					:= '~prte::key::email_data::fcra::';
		
		EXPORT SuperKeyName 						:= key_prefix+'@version@::';
		EXPORT SuperKeyName_fcra 				:= key_prefix_fcra+'@version@::';
		

	// autokey
		EXPORT autokeyname						 					:= key_prefix+ 'autokey::';
		EXPORT ak_keyname 											:= key_prefix+ 'autokey::@version@::';
		EXPORT ak_logical(string filedate) 			:= key_prefix+ filedate + '::autokey::';
		EXPORT ak_qa_keyname 										:= autokeyname+'qa::';
		EXPORT ak_skipSet 											:= ['P','B'];
		EXPORT ak_typeStr												:= 'BC';
		EXPORT STRING srcType										:= 'email_data';
		
		EXPORT boolean TRIAL_RUN_ONLY_NO_DOPS := PRTE2_Common.Constants.TRIAL_RUN_ONLY_NO_DOPS;
		EXPORT boolean FULL_RUN_WITH_DOPS 		:= PRTE2_Common.Constants.FULL_RUN_WITH_DOPS;
		
		EXPORT dops_name:= 'EmailDataKeys';
		EXPORT FCRA_dops_name:= 'FCRA_EmailDataKeys';
		


//P in this set to skip personal phones
//Q in this set to skip business phones
//S in this set to skip SSN
//F in this set to skip FEIN
//C in this set to skip ALL personal (Contact) data
//B in this set to skip ALL Business data

	
END;