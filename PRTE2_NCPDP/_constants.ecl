IMPORT Data_services, prte2_ncpdp;

EXPORT _constants(STRING filedate = '') := MODULE    

// autokey
/* Skip Parms: B(Biz), C(Person Contact), F(FEIN), P(Personal Phones), Q(Biz Phones), S(SSN) */
	EXPORT ak_skipSet_DBAPhys	      := ['C', 'P', 'S'];
	EXPORT ak_skipSet_DBAMail	      := ['C', 'P', 'S'];
	EXPORT ak_skipSet_ContLegalPhys	:= ['S'];
	EXPORT ak_skipSet_ContLegalMail	:= ['S'];
	EXPORT str_typeStr := '\'AK\'';
	

  EXPORT autokeyname_DBAPhys	 									:= prte2_ncpdp.constants.KEY_PREFIX + 'autokey::dbaphys::';
	EXPORT ak_keyname_DBAPhys    									:= autokeyname_DBAPhys+ '@version@::';
	EXPORT ak_logical_DBAPhys										  := prte2_ncpdp.constants.KEY_PREFIX + filedate + '::autokey::dbaphys::';
	EXPORT ak_qa_keyname_DBAPhys 									:= autokeyname_DBAPhys + 'qa::';

	EXPORT autokeyname_DBAMail	 									:= prte2_ncpdp.constants.KEY_PREFIX + 'autokey::dbamail::';
	EXPORT ak_keyname_DBAMail   							 		:= autokeyname_DBAMail + '@version@::';
	EXPORT ak_logical_DBAMail										  := prte2_ncpdp.constants.KEY_PREFIX + filedate + '::autokey::dbamail::';
	EXPORT ak_qa_keyname_DBAMail 									:= autokeyname_DBAMail + 'qa::';

  EXPORT autokeyname_ContLegalPhys	 								:= constants.KEY_PREFIX + 'autokey::contlegalphys::';
	EXPORT ak_keyname_ContLegalPhys    								:= autokeyname_ContLegalPhys + '@version@::';
	EXPORT ak_logical_ContLegalPhys										:= constants.KEY_PREFIX + filedate + '::autokey::contlegalphys::';
	EXPORT ak_qa_keyname_ContLegalPhys 								:= autokeyname_ContLegalPhys + 'qa::';


  EXPORT autokeyname_ContLegalMail	 								:= prte2_ncpdp.constants.KEY_PREFIX + 'autokey::contlegalmail::';
	EXPORT ak_keyname_ContLegalMail    								:= autokeyname_ContLegalMail + '@version@::';
	EXPORT ak_logical_ContLegalMail										:= prte2_ncpdp.constants.KEY_PREFIX  + filedate + '::autokey::contlegalmail::';
	EXPORT ak_qa_keyname_ContLegalMail 								:= autokeyname_ContLegalMail + 'qa::';

end;
