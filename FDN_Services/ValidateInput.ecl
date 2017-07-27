EXPORT ValidateInput := MODULE

		EXPORT fn_checkIfValid (FDN_Services.Layouts.batch_search_rec srchRec) :=   FUNCTION
				
					Boolean isAddress							:= (srchRec.zip5 <> '' OR srchRec.st <> '' OR srchRec.v_city_name <> '');
      		Boolean isSSN									:= (srchRec.ssn <> '');
      		Boolean isPhone								:= (srchRec.phone10 <> '');
      		Boolean isPerson							:= (srchRec.did > 0);
      		Boolean isBusiness						:= (srchRec.seleid > 0 AND srchRec.orgid > 0 AND srchRec.ultid > 0);
      		Boolean isEmailAddress				:= (srchRec.emailaddress <> '');
      		Boolean isDevice							:= (srchRec.deviceid <> '');
      		Boolean isIpAddress						:= (srchRec.ipaddress <> '');
      		Boolean isProfessionalid			:= (srchRec.professionalid <> '');
      		Boolean isProvider						:= (srchRec.lnpid > 0) OR (srchRec.npi <> '') OR(srchRec.appendedproviderid > 0);
      		Boolean isTin									:= (srchRec.tin <> '');
      		
					
					FDN_Services.Layouts.batch_search_rec_flags xfm_checkSearch(FDN_Services.Layouts.batch_search_rec L) := TRANSFORM
							SELF.isAddress					:= isAddress,
							SELF.isSSN							:= isSSN,
							SELF.isPhone						:= isPhone,
							SELF.isPerson						:= isPerson,
							SELF.isBusiness					:= isBusiness,
							SELF.isEmailAddress			:= isEmailAddress,
							SELF.isDevice						:= isDevice,
							SELF.isIpAddress				:= isIpAddress,
							SELF.isProfessionalid		:= isProfessionalid,
							SELF.isTin							:= isTin,
							SELF.isProvider					:= isProvider,
							SELF.isValidSearchInput := (isAddress
																					OR isSSN
																					OR isPhone
																					OR isPerson
																					OR isBusiness
																					OR isEmailAddress
																					OR isDevice
																					OR isIpAddress
																					OR isProfessionalid
																					OR isTin
																					OR isProvider),
							SELF := L,														
						END;															
      														 					
				isValidSearchInput := (DATASET([xfm_checkSearch(srchRec)]));
				
	RETURN isValidSearchInput[1];
END;

														 
	EXPORT ValidateBatchSearchInput(DATASET(FDN_Services.Layouts.batch_search_rec) srchRec = dataset([],FDN_Services.Layouts.batch_search_rec)):= FUNCTION
			ValidateBatchSearch := PROJECT (srchRec, TRANSFORM(FDN_Services.Layouts.batch_search_rec_flags,
																isvalidsearch := fn_checkIfValid(LEFT);
																SELF.isValidSearchInput := isValidSearch.isValidSearchInput;
																SELF.isAddress := isvalidsearch.isAddress;
																SELF.isSSN := isvalidsearch.isSSN;
																SELF.isPhone := isvalidsearch.isPhone;
																SELF.isPerson := isvalidsearch.isPerson;
																SELF.isBusiness := isvalidsearch.isBusiness;
																SELF.isEmailAddress := isvalidsearch.isEmailAddress;
																SELF.isDevice := isvalidsearch.isDevice;
																SELF.isIpAddress := isvalidsearch.isIpAddress;
																SELF.isProfessionalid := isvalidsearch.isProfessionalid;
																SELF.isProvider := isvalidsearch.isProvider;
																SELF.isTin := isvalidsearch.isTin;
																SELF := LEFT));
																
			RETURN ValidateBatchSearch;
	END;												 


END;