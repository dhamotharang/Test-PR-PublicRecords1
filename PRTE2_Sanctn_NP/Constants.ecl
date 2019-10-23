import prte2_sanctn_np, data_services;

EXPORT Constants := module

		EXPORT in_prefix_name					:= '~prte::in::sanctn_np::';
		EXPORT base_prefix_name				:= '~prte::base::sanctn::np::';
		
		EXPORT key_prefix 						:= '~prte::key::sanctn::np::';
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
		
		export set_state_abbr := ['AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC',
															'FM','FL','GA','GU','HI','ID','IL','IN','IA','KS',
															'KY','LA','ME','MH','MD','MA','MI','MN','MS','MO',
															'MT','NE','NV','NH','NJ','NM','NY','NC','ND','MP',
															'OH','OK','OR','PW','PA','PR','RI','SC','SD','TN',
															'TX','UT','VT','VI','VA','WA','WV','WI','WY','AE',
															'AA','AP'
															];


	
	end;