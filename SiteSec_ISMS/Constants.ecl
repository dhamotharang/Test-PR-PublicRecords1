EXPORT Constants(STRING filedate = '') := MODULE    
	
	BaseTempLayout := RECORD
		Layouts.Base-ISMSScope;
		UNSIGNED6 DID;
		UNSIGNED6 BDID;
		UNSIGNED6 ZERO;
	END;
	
	BaseTempLayout trfReformat(Layouts.Base L) := TRANSFORM
		SELF.DID  := 0;
		SELF.BDID := 0;
		SELF.ZERO := 0;
		SELF      := L;
	END;	
	
	EXPORT ak_dataset			 := PROJECT(Files().Base.qa,trfReformat(LEFT));
	
	EXPORT str_autokeyname := cluster+'key::SiteSec_ISMS::autokey::qa::';
	EXPORT ak_keyname	     := cluster+'key::SiteSec_ISMS::autokey::@version@::';
	EXPORT ak_logical	     := cluster+'key::SiteSec_ISMS::'+filedate+'::autokey::';
	EXPORT ak_skipSet	     := ['C','F','P','Q','S']; //Skip Parms: B(Biz), C(Person Contact), F(FEIN), P(Personal Phones), Q(Biz Phones), S(SSN)
	EXPORT ak_typeStr	     := 'AK';
	EXPORT ak_qa_keyname	 := cluster+'key::SiteSec_ISMS::autokey::qa::';
		
END;