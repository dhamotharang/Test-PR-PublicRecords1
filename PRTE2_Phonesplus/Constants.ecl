IMPORT _control;
EXPORT Constants	:= MODULE
		
		//Base/Input/Key Prefix/Key Suffix(s) 
		EXPORT IN_PREFIX 			:= '~prte::in::phonesplusv2::';
		EXPORT BASE_PREFIX		:= '~prte::base::phonesplusv2::';
		EXPORT KEY_PREFIX			:= '~prte::key::';
	
		// autokey - Traditional autokey naming convention is not used
		EXPORT	ak_keyname 									:= KEY_PREFIX + 'phonesplusv2::@version@::';
		EXPORT	ak_logical(string filedate) := KEY_PREFIX + 'phonesplusv2::' + filedate + '::';
		EXPORT	ak_qa_keyname 							:= KEY_PREFIX + 'phonesplusv2::qa::';
		EXPORT	ak_keyname_royal 									:= KEY_PREFIX + 'phonesplusv2_royalty::@version@::';
		EXPORT	ak_logical_royal(string filedate) := KEY_PREFIX + 'phonesplusv2_royalty::' + filedate + '::';
		EXPORT	ak_qa_keyname_royal 							:= KEY_PREFIX + 'phonesplusv2_royalty::qa::';
		EXPORT	ak_skipSet	:= ['B','F','Q'];
						// P in this set to skip personal phones
						// Q in this set to skip business phones
						// S in this set to skip SSN
						// F in this set to skip FEIN
						// C in this set to skip ALL personal (Contact) data
						// B in this set to skip ALL Business data

		EXPORT ak_typeStr := '';
		
		EXPORT ssn_set_exception := ['666326901','666253620','666514992','666447324', '666946500',
 																 '121984514','093355823','093358339','666205638', '666441009',
																 '666990130', '666162567','666501193','666505902', '666616404',
																 '666405378', '666273309','666299097','666511026', '666160713',
																 '666281879', '666400658','666403646','666626605'
																							];
	
	
END;