IMPORT STD;

EXPORT Constants := MODULE

  EXPORT SearchType := MODULE
    EXPORT STRING3 EIC := 'EIC'; // email identity check
    EXPORT STRING3 EIA := 'EIA'; // email identity append
    EXPORT STRING3 EAA := 'EAA'; // email address append
    EXPORT BOOLEAN isValidSearchType(STRING _type) := STD.Str.ToUpperCase(_type) IN [EIA, EAA];
    EXPORT BOOLEAN isEIA(STRING _type) := _type = EIA;
    EXPORT BOOLEAN isEIC(STRING _type) := _type = EIC;
    EXPORT BOOLEAN isEAA(STRING _type) := _type = EAA;
  END;
  
  EXPORT Defaults := MODULE
    EXPORT UNSIGNED PenaltThreshold      := 20;
    EXPORT UNSIGNED MaxResults           := 10;  
    EXPORT UNSIGNED MaxResultsPerAcct    := 10;  
    EXPORT UNSIGNED MaxEmailsToCheckDeliverable := 10;  //max number of result email addresses per account to send to gateway for delivery check
    EXPORT UNSIGNED DID_SCORE_THRESHOLD  := 80;  // BatchShare.Constants.Defaults.didScoreThreshold
  END;
  
  EXPORT UNSIGNED EmailQualityRulesForBVCall := 0;
  
  EXPORT UNSIGNED SEARCH_JOIN_LIMIT := 1000;
  EXPORT STRING EMAIL_SOURCES := 'EMAIL_SOURCES';
  
  EXPORT IntendedPurpose := MODULE
    EXPORT STRING Standard           := 'STANDARD'; // or blank, no use case restrictions
    EXPORT STRING Reseller           := 'RESELLER';  
    EXPORT STRING DirectMarketing    := 'DIRECTMARKETING';  
    
    EXPORT BOOLEAN isReseller(STRING _usecase) := STD.Str.ToUpperCase(TRIM(_usecase, ALL)) = Reseller;
    EXPORT BOOLEAN isDirectMarketing(STRING _usecase) := STD.Str.ToUpperCase(TRIM(_usecase, ALL)) = DirectMarketing;
  END;

  EXPORT SearchBy := MODULE
    EXPORT STRING5 ByEmail := 'EMAIL'; // email address to be used for search
    EXPORT STRING5 ByLexid := 'LEXID'; // only subject's Lexid to be used for search
    EXPORT STRING5 ByPII := 'BYPII'; // all subject's PII to be used for search
  END; 
  
  EXPORT GatewayValues := MODULE
    EXPORT UNSIGNED1 SQLSelectLimit  := 100;  // Limit SQL select GW history  recs for each email
    EXPORT UNSIGNED1 requestTimeout  := 5;
    EXPORT UNSIGNED1 requestRetries  := 1;
    EXPORT STRING    BriteVerifyEmail  := 'BriteVerify_Email';
  END;
END;
