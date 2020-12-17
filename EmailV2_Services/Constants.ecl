IMPORT dx_Email, STD;

EXPORT Constants := MODULE

  EXPORT SearchType := MODULE
    EXPORT STRING3 EIC := 'EIC'; // email identity check
    EXPORT STRING3 EIA := 'EIA'; // email identity append
    EXPORT STRING3 EAA := 'EAA'; // email address append
    EXPORT BOOLEAN isValidSearchType(STRING _type) := STD.Str.ToUpperCase(_type) IN [EIA, EAA, EIC];
    EXPORT BOOLEAN isEIA(STRING _type) := _type = EIA;
    EXPORT BOOLEAN isEIC(STRING _type) := _type = EIC;
    EXPORT BOOLEAN isEAA(STRING _type) := _type = EAA;
  END;

  EXPORT Defaults := MODULE
    EXPORT UNSIGNED EmailQualityRules    := 0;
    EXPORT UNSIGNED PenaltThreshold      := 10;
    EXPORT UNSIGNED MaxResults           := 25;
    EXPORT UNSIGNED MaxResultsPerAcct    := 10;
    EXPORT UNSIGNED MaxEmailsToCheckDeliverable := 10;  //max number of result email addresses per account to send to gateway for delivery check
    EXPORT UNSIGNED MaxEmailsForTMXcheck := 5;  //max number of result email addresses per account to send to TrustDefender gateway for status check
    EXPORT UNSIGNED DID_SCORE_THRESHOLD  := 80;  // BatchShare.Constants.Defaults.didScoreThreshold
    EXPORT UNSIGNED SSN_SEARCH_PENALTY   := 999;  // will be used to prevent name only match in case of blank ssn for name/ssn search
    EXPORT UNSIGNED RELATIONSHIP_PENALTY   := 100;  // will be used for fuzzy relations match where only input lexid is available
    EXPORT STRING20 SingleSearchAccountNo := '0';
  END;

  EXPORT UNSIGNED EmailQualityRulesForBVCall := 0
                                               | dx_Email.Translation_Codes.rules_bitmap_code('role_address')        // role address is valid email address for the purpose of email delivery check
                                               | dx_Email.Translation_Codes.rules_bitmap_code('disposable_address'); // disposable address is valid email address for the purpose of email delivery check

  EXPORT UNSIGNED SEARCH_JOIN_LIMIT := 1000;
  EXPORT STRING EMAIL_SOURCES := 'EMAIL_SOURCES';
  EXPORT STRING STR_TRUE := 'true';
  EXPORT STRING STR_FALSE := 'false';
  EXPORT STRING Basic := 'basic';
  EXPORT STRING Premium := 'premium';
  EXPORT BOOLEAN isPremium(STRING _tier) := STD.Str.ToLowerCase(_tier) = Premium;
  EXPORT BOOLEAN isBasic(STRING _tier) := STD.Str.ToLowerCase(_tier) = Basic;
  EXPORT BOOLEAN isValidTier(STRING _tier) := STD.Str.ToLowerCase(_tier) IN [Basic, Premium];

  EXPORT STRING LastVerified := 'last verified';

  EXPORT STRING StatusInvalid := 'invalid';
  EXPORT BOOLEAN isUndeliverableEmail(STRING _status) := STD.Str.ToLowerCase(_status) = StatusInvalid;
  EXPORT STRING DomainInactive := 'inactive';
  EXPORT STRING DomainAcceptAll := 'accept_all';
  EXPORT BOOLEAN isUnverifiableEmail(STRING _status) := STD.Str.ToLowerCase(_status) = DomainAcceptAll;
  STRING StatusValid := 'valid';
  EXPORT BOOLEAN isValid(STRING _status) := STD.Str.ToLowerCase(_status) = StatusValid;
  EXPORT STRING StatusUnknown := 'unknown';
  EXPORT BOOLEAN isUnknown(STRING _status) := STD.Str.ToLowerCase(_status) = StatusUnknown;
  EXPORT STRING StatusRejected := 'reject';
  EXPORT BOOLEAN isRejectedEmail(STRING _status) := STD.Str.ToLowerCase(_status) = StatusRejected;
  EXPORT STRING StatusPass := 'pass';
  EXPORT BOOLEAN isTMXVerifiedEmail(STRING _status) := STD.Str.ToLowerCase(_status) = StatusPass;

  EXPORT RestrictedUseCase := MODULE
    EXPORT STRING Standard           := 'STANDARD'; // or blank, no use case restrictions
    EXPORT STRING Reseller           := 'RESELLER';
    EXPORT STRING DirectMarketing    := 'DIRECTMARKETING';
    EXPORT STRING NoRoyaltySources   := 'NOROYALTY';  // for business cases when royalty sources are to be excluded per product requirements

    EXPORT BOOLEAN skipRoyaltySources(STRING _usecase) := STD.Str.ToUpperCase(TRIM(_usecase, ALL)) = NoRoyaltySources;
    EXPORT BOOLEAN isReseller(STRING _usecase) := STD.Str.ToUpperCase(TRIM(_usecase, ALL)) = Reseller;
    EXPORT BOOLEAN isDirectMarketing(STRING _usecase) := STD.Str.ToUpperCase(TRIM(_usecase, ALL)) = DirectMarketing;
    EXPORT BOOLEAN isValid(STRING _usecase) := STD.Str.ToUpperCase(_usecase) IN [Standard, NoRoyaltySources, DIRECTMARKETING, RESELLER];
  END;

  EXPORT SearchBy := MODULE
    EXPORT STRING5 ByEmail := 'EMAIL'; // email address to be used for search
    EXPORT STRING5 ByLexid := 'LEXID'; // only subject's Lexid to be used for search
    EXPORT STRING5 ByPII := 'BYPII'; // all subject's PII to be used for search
  END;

  EXPORT Relationship := MODULE
   EXPORT STRING NotFound        := 'No Relationship or Association Found';
   EXPORT STRING PossibleSubject := 'Possible Subject';
   EXPORT IsSubject(STRING _rel) := _rel = PossibleSubject;
  END;

  EXPORT GatewayValues := MODULE
    EXPORT UNSIGNED1 SQLSelectLimit  := 1000;  // Limit SQL select GW history  recs
    EXPORT UNSIGNED  MaxSQLBindVariables := 10;
    EXPORT UNSIGNED1 requestTimeout  := 5;
    EXPORT UNSIGNED1 requestRetries  := 1;
    EXPORT STRING    SourceBriteVerifyEmail := 'BriteVerify_Email';
    EXPORT STRING    SourceBV := 'BV';
    EXPORT STRING    RoleAddress  := 'Role Address';
    EXPORT STRING    DisposableAddress  := 'Disposable Address';
    EXPORT STRING    EMAIL_DOMAIN_INVALID  := 'EMAIL_DOMAIN_INVALID';
    EXPORT STRING    DOMAIN_INACTIVE  := 'DOMAIN_INACTIVE';
    EXPORT STRING    BVAPIkey  := '498acc88-a5a4-4dbc-942d-4bd9ac265ae1';
    EXPORT STRING    TMXOrgId       := 'ymyo6b64';
    EXPORT STRING    TMXApiKey      := 'ivdshxsu3m5xmoom';
    EXPORT STRING    TMXPolicy      := 'Email Risk Assessment';
    EXPORT STRING    TMXServiceType := 'all';
    EXPORT STRING    TMXApiType     := 'AttributeQuery';

    dict_email_address_invalid := DICTIONARY([
      {DOMAIN_INACTIVE => 'Email Domain Inactive'},
      {'EMAIL_ACCOUNT_INVALID' => 'Email Account Invalid'},
      {'EMAIL_ADDRESS_INVALID' => 'Email Address Invalid'},
      {EMAIL_DOMAIN_INVALID  => 'Email Domain Invalid'}],
      {STRING error_code => STRING error_desc});
    EXPORT get_error_desc(STRING _code) := dict_email_address_invalid[_code].error_desc;

  END;
END;
