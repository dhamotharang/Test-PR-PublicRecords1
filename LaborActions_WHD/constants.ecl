EXPORT Constants(STRING filedate = '') := MODULE    
	
	EXPORT ak_dataset			 := File_Base_Payload;
	
	EXPORT ak_skipSet	     := ['C','F','P','Q','S'];  
												 /* Skip Parms: B(Biz), C(Person Contact), F(FEIN), 
	                             P(Personal Phones), Q(Biz Phones), S(SSN) */
	EXPORT ak_typeStr	     := 'AK';
	
	EXPORT str_autokeyname := cluster+'key::LaborActions_WHD::autokey::qa::';
	EXPORT ak_keyname	     := cluster+'key::LaborActions_WHD::autokey::@version@::';
	EXPORT ak_logical	     := cluster+'key::LaborActions_WHD::'+filedate+'::autokey::';
	EXPORT ak_qa_keyname	 := cluster+'key::LaborActions_WHD::autokey::qa::';
	
END;