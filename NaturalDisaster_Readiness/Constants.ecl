EXPORT Constants(STRING filedate = '') := MODULE    
	
	AKTempLayout := RECORD
		Layouts.KeyBuild; 
		UNSIGNED6 DID;	//required for autokeys
		UNSIGNED6 ZERO;
	END;
	
	AKTempLayout trfReformat(Layouts.KeyBuild L) := TRANSFORM
		SELF.DID  := 0;
		SELF.ZERO := 0;
		SELF      := L;
	END;	

	EXPORT ak_dataset			 := File_Base_Payload;
	
	EXPORT ak_skipSet	     := ['C','F','P','S']; //Skip Parms: B(Biz), C(Person Contact), F(FEIN), P(Personal Phones), Q(Biz Phones), S(SSN)
	EXPORT ak_typeStr	     := 'AK';
		
	EXPORT str_autokeyname    := cluster+'key::NaturalDisaster_Readiness::autokey::qa::';
	
	EXPORT ak_keyname	     := cluster+'key::NaturalDisaster_Readiness::autokey::@version@::';
	
	EXPORT ak_logical	     := cluster+'key::NaturalDisaster_Readiness::'+filedate+'::autokey::';
	
	EXPORT ak_qa_keyname	 := cluster+'key::NaturalDisaster_Readiness::autokey::qa::';
			
END;