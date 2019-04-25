//************************************************************************************************************************************//
//BK Key files for Key Validation purposes
//Author: Vikram Pareddy
//************************************************************************************************************************************//
EXPORT BKKeyFiles := module
	import KeyValidation, BankruptcyV3, BankruptcyV2, Autokey, Autokeyb2, fcra, ut;
	import ashirey;
	
	export bdidKey := BankruptcyV3.key_bankruptcyV3_bdid();
	export bdidFCRAKey := BankruptcyV3.key_bankruptcyV3_bdid(true);
	
	export caseNumberKey := BankruptcyV3.key_bankruptcyV3_casenumber();
	export caseNumberFCRAKey := BankruptcyV3.key_bankruptcyV3_casenumber(true);
	
	export bkv3DIDKey := BankruptcyV3.key_bankruptcyV3_did();
	export projectedDIDKey := KeyValidation.applyProject(bkv3DIDKey, recordof(bkv3DIDKey), ['self'], ['left'], 
																													KeyValidation.BKMappings.DIDIgnoredFields, isDev );
																													
	export bkv3DIDFCRAKey := BankruptcyV3.key_bankruptcyV3_did(true);
	export projectedDIDFCRAKey := KeyValidation.applyProject(bkv3DIDFCRAKey, recordof(bkv3DIDKey), ['self'], ['left'], 
																													KeyValidation.BKMappings.DIDIgnoredFields, isDev );
																													
	export suppKey := BankruptcyV3.key_bankruptcy_main_supp();
	export suppFCRAKey := BankruptcyV3.key_bankruptcy_main_supp(true);
	
	export bkv3SSNKey := BankruptcyV3.key_bankruptcyV3_ssn();			
	export projectedSSNKey := KeyValidation.applyProject(bkv3SSNKey, recordof(bkv3SSNKey), ['self'], ['left'], 
																													KeyValidation.BKMappings.SSNIgnoredFields, isDev );
																													
	export ssnMatchKey := BankruptcyV3.key_bankruptcyV3_ssnmatch();
	
	export tmsIDKey := BankruptcyV3.key_bankruptcyv3_search_full_bip();
	export tmsIDFCRAKey := BankruptcyV3.key_bankruptcyv3_search_full_bip(true);
	
		//TMSIDBKMain Key
		//Multi line code to normalize and flatten the key
	shared tmsIDBKMainKeyA := BankruptcyV3.key_bankruptcyV3_main_full();
	
		shared layout_status := KeyValidation.BKLayouts.layout_status;
		shared layout_comments := KeyValidation.BKLayouts.layout_comments;

		shared KeyValidation.BKLayouts.bkMainTMSIDKeyLayoutIN INTmsIDKeyBKMainTransformFunc(
																									recordof(tmsIDBKMainKeyA) l, 
																									unsigned c) := transform
			self.status:= l.status[c];
			self.comments := l.comments;
			self.filing_status := if(l.filing_status = 'Unknown' ,'',l.filing_status);
			self:= l;
		end;

		shared tmsIDKeyBKMainIN := normalize(pull(tmsIDBKMainKeyA), count(left.status), 
																														INTmsIDKeyBKMainTransformFunc(left, counter));
																														
   shared KeyValidation.BKLayouts.bkMainTMSIDKeyLayoutN tmsIDKeyBKMainTransformFunc(
																									recordof(tmsIDKeyBKMainIN) l, 
																									unsigned c) := transform
			self.comments:= l.comments[c];
			self.filing_status := if(l.filing_status = 'Unknown' ,'',l.filing_status);
			self:= l;
		end;

		shared tmsIDKeyBKMainN := normalize(pull(tmsIDKeyBKMainIN), count(left.comments), 
																														tmsIDKeyBKMainTransformFunc(left, counter));
																														
		ashirey.Flatten(tmsIDKeyBKMainN, tmsIDKeyBKMainNF);
		export tmsIDBKMainKey := tmsIDKeyBKMainNF;
	//end TMSID BKMain Key 
	
		shared  todaysdate := ut.GetDate;
		export tmsIDBKMainFCRAKey := tmsIDBKMainKey(fcra.bankrupt_is_ok (todaysdate,date_filed));

	export BKSearchLinkidsKey := BankruptcyV3.key_bankruptcyV3_linkids.key;

	export trusteeIDNameKey := Bankruptcyv3.key_bankruptcyv3_trusteeidname();
	export trusteeIDNameFCRAKey := Bankruptcyv3.key_bankruptcyv3_trusteeidname(true);
	
	shared payloadAutoKey := BankruptcyV2.Key_bankruptcy_payload;			
	
		ashirey.Flatten(payloadAutoKey, flatPayloadAutoKey);
		export FlattenedPayloadAK := flatPayloadAutoKey;
		
		
		shared payloadAutoKeyFCRA := BankruptcyV3.Key_bankruptcyV3_payload;			
	
		ashirey.Flatten(payloadAutoKeyFCRA, flatPayloadAutoKeyFCRA);
		export FlattenedPayloadAKFCRA := flatPayloadAutoKeyFCRA;
		
		export normalizedPayloadAK := KeyValidation.applyNormalize(payloadAutoKey, ['person_addr'], 
																																					['if(c=1, l.person_addr, l.company_addr)'], 
																																					['qa_defined_empty'],2);
																																					
    	
		export normalizedPayloadAKFCRA := KeyValidation.applyNormalize(payloadAutoKeyFCRA, ['person_addr'], 
																																					['if(c=1, l.person_addr, l.company_addr)'], 
																																					['qa_defined_empty'],2);
																																					
   export ssn4stFCRAKey := BankruptcyV3.key_bankruptcyV3_ssn4st(true);


		////Search auto keys are built out of the payload autokey defined above
		 export addressAutoKey := Autokey.Key_Address(BankruptcyV2.cluster + 'key::bankruptcy::autokey::');
		 export addressb2AutoKey := Autokeyb2.Key_Address(BankruptcyV2.cluster + 'key::bankruptcy::autokey::');
		 export cityStNameAutoKey := Autokey.Key_CityStName(BankruptcyV2.cluster + 'key::bankruptcy::autokey::');
		 export cityStNameb2AutoKey := Autokeyb2.Key_CityStName(BankruptcyV2.cluster + 'key::bankruptcy::autokey::');
		 export fein2AutoKey := Autokeyb2.Key_FEIN(BankruptcyV2.cluster + 'key::bankruptcy::autokey::');
		 export nameAutoKey := Autokey.Key_Name(BankruptcyV2.cluster + 'key::bankruptcy::autokey::');
		 export nameWords2AutoKey := Autokeyb2.Key_NameWords(BankruptcyV2.cluster + 'key::bankruptcy::autokey::');
		 export phone2AutoKey := Autokey.Key_Phone2(BankruptcyV2.cluster + 'key::bankruptcy::autokey::');
		 export phoneb2AutoKey := Autokeyb2.Key_Phone(BankruptcyV2.cluster + 'key::bankruptcy::autokey::');
		 export ssn4nameAutokey := Bankruptcyv2.key_bankruptcy_ssn4name(BankruptcyV2.cluster + 'key::bankruptcy::autokey::');
		 export ssn2AutoKey := Autokey.Key_SSN2(BankruptcyV2.cluster + 'key::bankruptcy::autokey::');
		 export stNameAutoKey := Autokey.Key_StName(BankruptcyV2.cluster + 'key::bankruptcy::autokey::');
		 export stNameb2AutoKey := Autokeyb2.Key_StName(BankruptcyV2.cluster + 'key::bankruptcy::autokey::');
		 export zipAutoKey := Autokey.Key_Zip(BankruptcyV2.cluster + 'key::bankruptcy::autokey::');
		 export zipb2AutoKey := Autokeyb2.Key_Zip(BankruptcyV2.cluster + 'key::bankruptcy::autokey::');
		 
		 //FCRA autokeys
		  export addressFCRAAutoKey := Autokey.Key_Address(BankruptcyV2.cluster + 'key::bankruptcy::autokey::fcra::');
		 export addressb2FCRAAutoKey := Autokeyb2.Key_Address(BankruptcyV2.cluster + 'key::bankruptcy::autokey::fcra::');
		 export cityStNameFCRAAutoKey := Autokey.Key_CityStName(BankruptcyV2.cluster + 'key::bankruptcy::autokey::fcra::');
		 export cityStNameb2FCRAAutoKey := Autokeyb2.Key_CityStName(BankruptcyV2.cluster + 'key::bankruptcy::autokey::fcra::');
		 export fein2FCRAAutoKey := Autokeyb2.Key_FEIN(BankruptcyV2.cluster + 'key::bankruptcy::autokey::fcra::');
		 export nameFCRAAutoKey := Autokey.Key_Name(BankruptcyV2.cluster + 'key::bankruptcy::autokey::fcra::');
		 export nameWords2FCRAAutoKey := Autokeyb2.Key_NameWords(BankruptcyV2.cluster + 'key::bankruptcy::autokey::fcra::');
		 export phone2FCRAAutoKey := Autokey.Key_Phone2(BankruptcyV2.cluster + 'key::bankruptcy::autokey::fcra::');
		 export phoneb2FCRAAutoKey := Autokeyb2.Key_Phone(BankruptcyV2.cluster + 'key::bankruptcy::autokey::fcra::');
		 export ssn4nameFCRAAutokey := Bankruptcyv2.key_bankruptcy_ssn4name(BankruptcyV2.cluster + 'key::bankruptcy::autokey::fcra::');
		 export ssn2FCRAAutoKey := Autokey.Key_SSN2(BankruptcyV2.cluster + 'key::bankruptcy::autokey::fcra::');
		 export stNameFCRAAutoKey := Autokey.Key_StName(BankruptcyV2.cluster + 'key::bankruptcy::autokey::fcra::');
		 export stNameb2FCRAAutoKey := Autokeyb2.Key_StName(BankruptcyV2.cluster + 'key::bankruptcy::autokey::fcra::');
		 export zipFCRAAutoKey := Autokey.Key_Zip(BankruptcyV2.cluster + 'key::bankruptcy::autokey::fcra::');
		 export zipb2FCRAAutoKey := Autokeyb2.Key_Zip(BankruptcyV2.cluster + 'key::bankruptcy::autokey::fcra::');
end;