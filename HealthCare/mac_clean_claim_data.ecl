EXPORT mac_clean_claim_data (Infile, Input_ProviderKey = '',Input_PatientKey = '',Input_ClaimNumber = '',Input_ClaimLineNumber = '',Input_BeginingDateOfService = '',
																		 Input_EndingDateOfService = '',Input_ServiceDate = '',Input_ChargeAmount = '',Input_PaidAmount = '',appendPrefix = '\'\'') := FUNCTIONMACRO

	 IMPORT HealthCareProvider, STD;	
	 
	 Claim_Clean_REC := RECORD
		RECORDOF(Infile);
		STRING50 #EXPAND(appendPrefix + 'ProviderKey');
		STRING50 #EXPAND(appendPrefix + 'PatientKey');
		STRING55 #EXPAND(appendPrefix + 'ClaimNumber');
		STRING10 #EXPAND(appendPrefix + 'ClaimLineNumber');
		STRING8	 #EXPAND(appendPrefix + 'BeginningDateOfService');
		STRING8  #EXPAND(appendPrefix + 'EndingDateOfService'); 	
		STRING8  #EXPAND(appendPrefix + 'ServiceDate');	
		STRING18 #EXPAND(appendPrefix + 'ChargeAmount');
		STRING18 #EXPAND(appendPrefix + 'PaidAmount'); 
	END;
	
	Claim_Clean_REC clean (Infile L) := TRANSFORM
		STRING ProviderKey 		 := #IF ( #TEXT(Input_ProviderKey) <> '' ) 	(STRING)HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Input_ProviderKey)) 	#ELSE '' #END;
		STRING PatientKey 		 := #IF ( #TEXT(Input_PatientKey) <> '' ) 	  (STRING)HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(L.Input_PatientKey)) 	  #ELSE '' #END;
		STRING ClaimNumber 		 := #IF ( #TEXT(Input_ClaimNumber) <> '' ) 	  (STRING)HealthCareProvider.CleanData.fReplaceUnprintable(L.Input_ClaimNumber)	  #ELSE '' #END;
		STRING ClaimLineNumber := #IF ( #TEXT(Input_ClaimLineNumber) <> '' ) 	  (STRING)HealthCareProvider.CleanData.fReplaceUnprintable(L.Input_ClaimLineNumber) 	  #ELSE '' #END;
		SELF.#EXPAND(appendPrefix + 'ProviderKey')						:=	TRIM (ProviderKey,LEFT, RIGHT);
		SELF.#EXPAND(appendPrefix + 'PatientKey')							:=	TRIM (PatientKey,LEFT, RIGHT);
		SELF.#EXPAND(appendPrefix + 'ClaimNumber')						:=	TRIM (ClaimNumber,LEFT, RIGHT);
		SELF.#EXPAND(appendPrefix + 'ClaimLineNumber')				:=	TRIM (ClaimLineNumber,LEFT, RIGHT);
		BeginningDateOfService																:=	TRIM (L.Input_BeginingDateOfService,LEFT,RIGHT);
		SELF.#EXPAND(appendPrefix + 'BeginningDateOfService')	:=	IF (HealthCareProvider.isValidDate (BeginningDateOfService),BeginningDateOfService,'');
		EndingDateOfService																		:=	TRIM (L.Input_EndingDateOfService,LEFT,RIGHT);
		SELF.#EXPAND(appendPrefix + 'EndingDateOfService')		:=	IF (HealthCareProvider.isValidDate (EndingDateOfService),EndingDateOfService,'');
		ServiceDate																						:=	TRIM (L.Input_ServiceDate,LEFT,RIGHT);
		SELF.#EXPAND(appendPrefix + 'ServiceDate')						:=	IF (HealthCareProvider.isValidDate (ServiceDate),ServiceDate,'');
		SELF.#EXPAND(appendPrefix + 'ChargeAmount')						:=	TRIM (L.Input_ChargeAmount,LEFT,RIGHT);
		SELF.#EXPAND(appendPrefix + 'PaidAmount')							:=	TRIM (L.Input_PaidAmount,LEFT,RIGHT);
		SELF := L;
		SELF := [];
	END;
	
	Clean_Data := PROJECT (Infile, clean(LEFT));
	
	RETURN Clean_Data;
ENDMACRO;
