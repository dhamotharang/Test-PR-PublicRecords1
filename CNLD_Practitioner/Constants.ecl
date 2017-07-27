EXPORT Constants(STRING filedate = '') := MODULE    
	export TempLayout := RECORD
		Layouts.KeyBuild;
		UNSIGNED6 BDID;
		UNSIGNED6 ZERO;
	END;
	
	export TempLayout trfReformat(Layouts.KeyBuild L) := TRANSFORM
		SELF.BDID := 0;
		SELF.ZERO := 0;
		SELF      := L;
	END;	

	EXPORT ak_dataset := PROJECT(Files().Keybuild.built,trfReformat(LEFT));

	/* Skip Parms: B(Biz), C(Person Contact), F(FEIN), P(Personal Phones), Q(Biz Phones), S(SSN) */
	EXPORT ak_skipSet	:=	['F', 'B', 'Q'];

	EXPORT ak_keyname    := Cluster + 'key::CNLD_Practitioner::autokey::@version@::';
	EXPORT ak_logical	   := Cluster + 'key::CNLD_Practitioner::' + filedate + '::autokey::';
	EXPORT ak_qa_keyname := Cluster + 'key::CNLD_Practitioner::autokey::qa::';



	EXPORT TYPE_STR	               := 'AK';    // Auto Key
	EXPORT BOOLEAN WORK_HARD       := TRUE;    // deep dive 
	EXPORT BOOLEAN NO_FAIL         := TRUE;    // 
	EXPORT BOOLEAN USE_ALL_LOOKUPS := TRUE;    // takes into account the "lookup bit" (????)


        /* the specialty field is not in the key files.  Using the equivalent specialty_codes to determine which 
           records are phramacist related.  
           specgrpid	specgrp	       specid	specialty	           cnldprof	  dm_spec	  poss_profs
                  47	Allied Health	   172	Pharmacy	               PRY		           PRY
                  47	Allied Health	   208	Pharmacology - Clinical	 PRY	    CPS	     PRY
                  47	Allied Health	   587	Psychopharmacology		   PCM	             PSY    
           Added PHA and PRM to the list because they are in the records that come up for Ingenix Pharmacy personel. */
  EXPORT CNLD_PharmacistCodes := [ 'CPS', 'PCM', 'PRY', 'PSY', 'PRM', 'PHA' ];

END;