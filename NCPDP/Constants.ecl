IMPORT Data_services;
EXPORT Constants(STRING filedate = '') := MODULE    

	EXPORT ak_dataset	:= Files().keybuild_base.built;

	/* Skip Parms: B(Biz), C(Person Contact), F(FEIN), P(Personal Phones), Q(Biz Phones), S(SSN) */
	EXPORT ak_skipSet_DBAPhys	      := ['C', 'P', 'S'];
	EXPORT ak_skipSet_DBAMail	      := ['C', 'P', 'S'];
	EXPORT ak_skipSet_ContLegalPhys	:= ['S'];
	EXPORT ak_skipSet_ContLegalMail	:= ['S'];

	EXPORT ak_keyname_DBAPhys    := Data_services.data_location.prefix('DEFAULT') + Cluster + 'key::NCPDP::autokey::dbaphys::@version@::';
	EXPORT ak_logical_DBAPhys	   := Data_services.data_location.prefix('DEFAULT') + Cluster + 'key::NCPDP::' + filedate + '::autokey::dbaphys::';
	EXPORT ak_qa_keyname_DBAPhys := Data_services.data_location.prefix('DEFAULT') + Cluster + 'key::NCPDP::autokey::dbaphys::qa::';

	EXPORT ak_keyname_DBAMail    := Data_services.data_location.prefix('DEFAULT') + Cluster + 'key::NCPDP::autokey::dbamail::@version@::';
	EXPORT ak_logical_DBAMail	   := Data_services.data_location.prefix('DEFAULT') + Cluster + 'key::NCPDP::' + filedate + '::autokey::dbamail::';
	EXPORT ak_qa_keyname_DBAMail := Data_services.data_location.prefix('DEFAULT') + Cluster + 'key::NCPDP::autokey::dbamail::qa::';

	EXPORT ak_keyname_ContLegalPhys    := Data_services.data_location.prefix('DEFAULT') + Cluster + 'key::NCPDP::autokey::contlegalphys::@version@::';
	EXPORT ak_logical_ContLegalPhys	   := Data_services.data_location.prefix('DEFAULT') + Cluster + 'key::NCPDP::' + filedate + '::autokey::contlegalphys::';
	EXPORT ak_qa_keyname_ContLegalPhys := Data_services.data_location.prefix('DEFAULT') + Cluster + 'key::NCPDP::autokey::contlegalphys::qa::';

	EXPORT ak_keyname_ContLegalMail    := Data_services.data_location.prefix('DEFAULT') + Cluster + 'key::NCPDP::autokey::contlegalmail::@version@::';
	EXPORT ak_logical_ContLegalMail	   := Data_services.data_location.prefix('DEFAULT') + Cluster + 'key::NCPDP::' + filedate + '::autokey::contlegalmail::';
	EXPORT ak_qa_keyname_ContLegalMail := Data_services.data_location.prefix('DEFAULT') + Cluster + 'key::NCPDP::autokey::contlegalmail::qa::';


END;