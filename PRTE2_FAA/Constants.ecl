IMPORT _Control, Data_Services, faa;

EXPORT Constants := MODULE

		shared boolean pUseProd := true;
		
		EXPORT indiv_ind	:= ['1','2','4','9'];
		EXPORT bus_ind		:= ['3','5','8'];

		EXPORT in_prefix_name						:= '~prte::in::faa::';
		EXPORT base_prefix_name					:= '~prte::base::faa::';
	
		EXPORT thor_cluster_Files				:= 	if(pUseProd 
																					,Data_Services.foreign_prod + 'thor_data400::',
																					'~thor_data400::'
																					);
	
		//roxie keys
		EXPORT KEY_PREFIX 							:= '~prte::key::faa::';
		EXPORT KEY_PREFIX_FCRA					:= KEY_PREFIX+'fcra::';
		EXPORT SuperKeyName 						:= KEY_PREFIX+'@version@::';
		EXPORT SuperKeyName_FCRA 				:= KEY_PREFIX_FCRA+'@version@::';
		
		// autokey
		EXPORT autokeyname						 			:= KEY_PREFIX+ 'autokey::';
		EXPORT ak_keyname 									:= KEY_PREFIX+ 'autokey::@version@::';
		EXPORT ak_logical(string filedate) 	:= KEY_PREFIX+ filedate + '::autokey::';
		EXPORT ak_qa_keyname 								:= autokeyname+'qa::';
		EXPORT set_skip := ['P','Q','F'];
						// P in this set to skip personal phones
						// Q in this set to skip business phones
						// S in this set to skip SSN
						// F in this set to skip FEIN
						// C in this set to skip ALL personal (Contact) data
						// B in this set to skip ALL Business data

		EXPORT autokeyname_airmen									:= KEY_PREFIX+ 'airmen::autokey::';
		EXPORT ak_keyname_airmen 									:= KEY_PREFIX+ 'airmen::autokey::@version@::';
		EXPORT ak_logical_airmen(string filedate) := KEY_PREFIX+ 'airmen::'+filedate+ '::autokey::';
		EXPORT ak_skip_airmen		:= ['P','Q','F','B'];  
		
		EXPORT TYPE_STR := 'BC';
		EXPORT USE_ALL_LOOKUPS := TRUE;


//DF-21803:FCRA Consumer Data Fields Depreciation
		EXPORT key_airmen_cert_set := faa.Constants.fields_to_clear_pilot_certificate;
		EXPORT key_airmen_did_set  := faa.Constants.fields_to_clear_pilot_registration;
		EXPORT key_aircraft_id_set	:= faa.Constants.fields_to_clear_aircraft_registration;
END;	