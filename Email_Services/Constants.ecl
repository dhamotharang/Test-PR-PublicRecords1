IMPORT STD;

EXPORT Constants := MODULE

  EXPORT SearchType := MODULE
    EXPORT STRING3 EIC := 'EIC'; // email identity check
    EXPORT STRING3 EIA := 'EIA'; // email identity append
    EXPORT STRING3 EAA := 'EAA'; // email address append
    EXPORT BOOLEAN isValidSearchType(STRING _type) := STD.Str.ToUpperCase(_type) IN [EIA];
    EXPORT BOOLEAN isEIA(STRING _type) := _type = EIA;
    EXPORT BOOLEAN isEIC(STRING _type) := _type = EIC;
    EXPORT BOOLEAN isEAA(STRING _type) := _type = EAA;
  END;
  
  EXPORT Defaults := MODULE
    EXPORT UNSIGNED PenaltThreshold      := 20;
    EXPORT UNSIGNED MaxResults           := 10;  
    EXPORT UNSIGNED MaxResultsPerAcct    := 10;  
  END;
  
  EXPORT UNSIGNED SEARCH_JOIN_LIMIT := 1000;
  EXPORT STRING EMAIL_SOURCES := 'EMAIL_SOURCES';
  
  EXPORT IntendedPurpose := MODULE
    EXPORT STRING Standard           := 'STANDARD'; // or blank, no use case restrictions
    EXPORT STRING Reseller           := 'RESELLER';  
    EXPORT STRING DirectMarketing    := 'DIRECTMARKETING';  
    
    EXPORT BOOLEAN isReseller(STRING _usecase) := STD.Str.ToUpperCase(TRIM(_usecase, ALL)) = Reseller;
    EXPORT BOOLEAN isDirectMarketing(STRING _usecase) := STD.Str.ToUpperCase(TRIM(_usecase, ALL)) = DirectMarketing;
  END;
 
END;
