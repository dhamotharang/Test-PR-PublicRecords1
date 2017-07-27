EXPORT ValidateInput := MODULE

  EXPORT fn_checkIfValid(FraudShared_Services.Layouts.batch_search_rec srchRec) := FUNCTION
    boolean isAddress := (srchRec.zip5 <> '' OR srchRec.st <> '' OR srchRec.v_city_name <> '');
    boolean isSSN := (srchRec.ssn <> '');
    boolean isPhone := (srchRec.phone10 <> '');
    boolean isPerson := (srchRec.did > 0);
    boolean isBusiness := (srchRec.seleid > 0 AND srchRec.orgid > 0 AND srchRec.ultid > 0);
    boolean isEmailAddress := (srchRec.emailaddress <> '');
    boolean isDevice := (srchRec.deviceid <> '');
    boolean isIpAddress := (srchRec.ipaddress <> '');
    boolean isProfessionalid := (srchRec.professionalid <> '');
    boolean isProvider := (srchRec.lnpid > 0) OR (srchRec.npi <> '') OR(srchRec.appendedproviderid > 0);
    boolean isTin := (srchRec.tin <> '');

    FraudShared_Services.Layouts.batch_search_flags_rec xfm_checkSearch(FraudShared_Services.Layouts.batch_search_rec L) := TRANSFORM
      SELF.isAddress := isAddress,
      SELF.isSSN := isSSN,
      SELF.isPhone := isPhone,
      SELF.isPerson := isPerson,
      SELF.isBusiness := isBusiness,
      SELF.isEmailAddress := isEmailAddress,
      SELF.isDevice := isDevice,
      SELF.isIpAddress := isIpAddress,
      SELF.isProfessionalid := isProfessionalid,
      SELF.isTin := isTin,
      SELF.isProvider := isProvider,
      SELF.isValidSearchInput := (isAddress OR isSSN OR isPhone OR isPerson OR isBusiness 
        OR isEmailAddress OR isDevice OR isIpAddress OR isProfessionalid OR isTin OR isProvider),
      SELF := L,    
    END;      
     
    isValidSearchInput := (DATASET([xfm_checkSearch(srchRec)]));  //ROW??
    
    RETURN isValidSearchInput[1];
  END;

  EXPORT ValidateBatchSearchInput(
    DATASET(FraudShared_Services.Layouts.batch_search_rec) srchRec = DATASET([],FraudShared_Services.Layouts.batch_search_rec)
  ):= FUNCTION

    ValidateBatchSearch := PROJECT (srchRec, 
	  TRANSFORM(FraudShared_Services.Layouts.batch_search_flags_rec,
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