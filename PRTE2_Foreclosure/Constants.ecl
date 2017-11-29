// Constants
// Moved over from PRTE2 module to create specialized PRTE2_Foreclosure module.

IMPORT _Control, ut, PRTE, PRTE2, PRTE2_Common;

EXPORT Constants := MODULE

		EXPORT in_prefix_name						:= '~prte::in::foreclosure::';
		EXPORT base_prefix_name					:= '~prte::base::foreclosure';
		
		EXPORT LandingZoneIP						:= PRTE2_Common.Constants.bctlpedata11;
																 
	//custom keys		
		EXPORT key_foreclosure_prefix 		:= '~prte::key::foreclosure::';
		EXPORT foreclosure_SuperKeyName 	:= key_foreclosure_prefix+'@version@::';
		
		EXPORT key_nod_prefix 						:= '~prte::key::nod::';
		EXPORT nod_SuperKeyName 					:= key_nod_prefix+'@version@::';
		

	// autokey
		EXPORT autokeyname						 					:= key_foreclosure_prefix+ 'autokey::';
		EXPORT ak_keyname 											:= key_foreclosure_prefix+ 'autokey::@version@::';
		EXPORT ak_logical(string filedate) 			:= key_foreclosure_prefix+ filedate + '::autokey::';
		EXPORT ak_qa_keyname 										:= autokeyname+'qa::';
		EXPORT ak_skipSet												:= ['P','Q','F'];
		EXPORT ak_typeStr												:= 'AK';
		
		EXPORT nod_autokeyname									:= key_nod_prefix +'autokey::';
		EXPORT ak_nod_keyname										:= key_nod_prefix +'autokey::@version@::';
		EXPORT ak_nod_logical(string filedate)	:= key_nod_prefix + filedate + '::autokey::';
		EXPORT ak_nod_qa_keyname 								:= nod_autokeyname+'qa::';
	
end;

//P in this set to skip personal phones
//Q in this set to skip business phones
//S in this set to skip SSN
//F in this set to skip FEIN
//C in this set to skip ALL personal (Contact) data
//B in this set to skip ALL Business data
