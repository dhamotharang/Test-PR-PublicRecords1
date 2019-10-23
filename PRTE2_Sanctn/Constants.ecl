import prte2_sanctn, data_services;

EXPORT Constants := module

		EXPORT in_prefix_name					:='~prte::in::sanctn::';
		EXPORT base_prefix_name				:='~prte::base::sanctn::';
		
		EXPORT key_prefix 						:= '~prte::key::sanctn::';
		EXPORT superkeyname 					:= key_prefix+'@version@::';
		
	
		// autokey
		EXPORT autokeyname						 			:= key_prefix+ 'autokey::';
		EXPORT ak_keyname 									:= key_prefix+ 'autokey::@version@::';
		EXPORT ak_logical(string filedate) 	:= key_prefix + filedate + '::autokey::';
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

	
	end;