EXPORT Constants(STRING filedate = '') := MODULE    
	
	EXPORT ak_dataset			 := File_Base_Payload;
	
	/* Skip Parms: B(Biz), C(Person), F(FEIN), P(Personal Phone), Q(Biz Phone), S(SSN) */
	EXPORT ak_skipSet := ['F','P','S']; /* Query team did not want autokeys built for personal phone*/  
												 
	EXPORT ak_typeStr	     := 'AK';
	
	EXPORT str_autokeyname    := cluster+'key::Insurance_Certification::autokey::qa::';
		
	EXPORT ak_keyname	     := cluster+'key::Insurance_Certification::autokey::@version@::';
		
	EXPORT ak_logical	     := cluster+'key::Insurance_Certification::'+filedate+'::autokey::';
		
	EXPORT ak_qa_keyname	 := cluster+'key::Insurance_Certification::autokey::qa::';
		
END;
