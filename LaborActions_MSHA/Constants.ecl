Import LaborActions_MSHA;

EXPORT Constants(STRING filedate = '',STRING filetype='') := MODULE    
	
	EXPORT ak_dataset_contractor	:= File_Base_Payload_Contractor;
	EXPORT ak_dataset_mine	 			:= File_Base_Payload_Mine;
	
	EXPORT str_autokeyname 				:= cluster+'key::LaborActions_MSHA::autokey::qa::'+filetype+'::';

	EXPORT ak_keyname_contractor	:= cluster+'key::LaborActions_MSHA::autokey::@version@::'+filetype+'::';
	EXPORT ak_logical_contractor	:= cluster+'key::LaborActions_MSHA::'+filedate+'::autokey::'+filetype+'::';
	
	EXPORT ak_keyname_controller	:= cluster+'key::LaborActions_MSHA::autokey::@version@::'+filetype+'::controller::';
	EXPORT ak_logical_controller	:= cluster+'key::LaborActions_MSHA::'+filedate+'::autokey::'+filetype+'::controller::';

	EXPORT ak_keyname_mine	     	:= cluster+'key::LaborActions_MSHA::autokey::@version@::'+filetype+'::mine::';
	EXPORT ak_logical_mine	     	:= cluster+'key::LaborActions_MSHA::'+filedate+'::autokey::'+filetype+'::mine::';

	EXPORT ak_keyname_operator   	:= cluster+'key::LaborActions_MSHA::autokey::@version@::'+filetype+'::operator::';
	EXPORT ak_logical_operator   	:= cluster+'key::LaborActions_MSHA::'+filedate+'::autokey::'+filetype+'::operator::';	

	EXPORT ak_skipSet	     := ['F','P','Q','S']; //Skip Parms: B(Biz), F(FEIN), P(Personal Phones), Q(Biz Phones), S(SSN)
	EXPORT ak_typeStr	     := 'AK';
	EXPORT ak_qa_keyname	 := cluster+'key::LaborActions_MSHA::autokey::qa::'+filetype+'::';
		
END;