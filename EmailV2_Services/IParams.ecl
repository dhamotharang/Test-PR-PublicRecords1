IMPORT AutoStandardI, BatchShare, EmailV2_Services, doxie, Gateway, iesp, STD, ut;

EXPORT IParams := MODULE

  EXPORT EmailParams := INTERFACE(doxie.IDataAccess)
    EXPORT UNSIGNED2 PenaltThreshold      := EmailV2_Services.Constants.Defaults.PenaltThreshold;  // specific to EAA search type
    EXPORT UNSIGNED  MaxResultsPerAcct    := EmailV2_Services.Constants.Defaults.MaxResultsPerAcct;
    EXPORT BOOLEAN   IncludeHistoricData  := FALSE;
    EXPORT BOOLEAN   RequireLexidMatch    := FALSE;  // specific to EAA search type
    EXPORT UNSIGNED1 EmailQualityRulesMask := 0;
    EXPORT BOOLEAN   RunDeepDive          := FALSE;  // specific to EAA search type
    EXPORT BOOLEAN   KeepRawData          := FALSE;  // if true data won't be rolled up - keeping all individual source docs - for headersource service usage
    EXPORT BOOLEAN   IncludeAdditionalInfo := TRUE;  // if true best info and num_lexId_per_email/num_email_per_lexid calculated (default). Can be set to False if this info is not used in results to skip these steps - (will be False for headersource service usage)
    EXPORT STRING    SearchType := '';  // expected values are listed in EmailV2_Services.Constants.SearchType
    EXPORT STRING    RestrictedUseCase := EmailV2_Services.Constants.RestrictedUseCase.Standard; // for the purpose of email filtering by source as needed
    EXPORT STRING    BVAPIkey := '';
    EXPORT STRING    EmailValidationType := EmailV2_Services.Constants.EmailValidationType.BriteVerify;
    EXPORT UNSIGNED  MaxEmailsForDeliveryCheck := EmailV2_Services.Constants.Defaults.MaxEmailsToCheckDeliverable;   //max number of result email addresses per account to send to gateway for delivery check
    EXPORT BOOLEAN   CheckEmailDeliverable := FALSE;  // option  for whether to use external gateway call to check if email address deliverable
    EXPORT BOOLEAN   KeepUndeliverableEmail := FALSE; // specific to EAA search type; if true emai addresses with status 'invalid' will be kept in results (default - remove invalid addresses)
    EXPORT BOOLEAN   UseTMXRules          := FALSE; // if true TMX GW call is used for ERA policy check
    EXPORT UNSIGNED  MaxEmailsForTMXCheck := 0;
    EXPORT BOOLEAN   SuppressTMXRejectedEmail := FALSE; // specific to EAA search type - if UseTMXRules=true it regulates whether email addresses rejected by TMX are to be removed
    EXPORT UNSIGNED1 DIDScoreThreshold := EmailV2_Services.Constants.Defaults.DID_SCORE_THRESHOLD;
    EXPORT DATASET (Gateway.Layouts.Config) gateways := DATASET ([], Gateway.Layouts.Config);  // to check delivery status and for TMX gw
  END;

  EXPORT BatchParams := INTERFACE(EmailParams)
    EXPORT BOOLEAN   ReturnDetailedRoyalties := FALSE;
  END;

  EXPORT GetEmailRulesMask(STRING _rules) := ut.BinaryStringToInteger(STD.Str.Reverse(TRIM(_rules)));

  EXPORT GetBatchParams() := FUNCTION

    base_params := BatchShare.IParam.getBatchParams();

    email_batch_params := MODULE(PROJECT(base_params,BatchParams, OPT))
      _MaxResultsPerAcct := EmailV2_Services.Constants.Defaults.MaxResultsPerAcct : STORED('Max_Results_Per_Acct');
      EXPORT UNSIGNED MaxResultsPerAcct := _MaxResultsPerAcct;
      _SearchType := '' : STORED('SearchType');
      EXPORT STRING  SearchType := STD.Str.ToUpperCase(TRIM(_SearchType,ALL));
      EXPORT BOOLEAN IncludeHistoricData := FALSE : STORED('IncludeHistoricData');
      BOOLEAN _IncludeNoLexIdMatch := FALSE : STORED('IncludeNoLexIdMatch');
      EXPORT BOOLEAN RequireLexidMatch := ~_IncludeNoLexIdMatch AND EmailV2_Services.Constants.SearchType.isEAA(SearchType); // applicable to EAA search only, ignored by other search types
      EXPORT BOOLEAN RunDeepDive := base_params.RunDeepDive OR ~RequireLexidMatch; // applicable to EAA search only, ignored by other search types
      EXPORT UNSIGNED1 DIDScoreThreshold := EmailV2_Services.Constants.Defaults.DID_SCORE_THRESHOLD : STORED('DIDScoreThreshold');

      _EmailQualityRulesString := '' : STORED('EmailQualityRulesMask'); // internal option not passed by EmailSearchV2 batch plugin
      EXPORT UNSIGNED1 EmailQualityRulesMask := MAP(
                   _EmailQualityRulesString<>'' => GetEmailRulesMask(_EmailQualityRulesString),
                   EmailV2_Services.Constants.SearchType.isEAA(SearchType) => 0, // default here may change
                   EmailV2_Services.Constants.SearchType.isEIA(SearchType) OR EmailV2_Services.Constants.SearchType.isEIC(SearchType) => 0xF,  // by default no restrictions on search by input email address
                   0);
      EXPORT STRING   BVAPIkey := EmailV2_Services.Constants.GatewayValues.BVAPIkey;
      EXPORT UNSIGNED MaxEmailsForDeliveryCheck := EmailV2_Services.Constants.Defaults.MaxEmailsToCheckDeliverable : STORED('MaxEmailsForDeliveryCheck'); // internal option not passed by EmailSearchV2 batch plugin
      STRING  _SearchTier := ''  : STORED('SearchTier');
      SHARED STRING SearchTier := IF(EmailV2_Services.Constants.isValidTier(_SearchTier), _SearchTier,
                                     EmailV2_Services.Constants.Basic); //default to basic
      EXPORT STRING   RestrictedUseCase := IF (EmailV2_Services.Constants.isBasic(SearchTier),
                                               EmailV2_Services.Constants.RestrictedUseCase.NoRoyaltySources,
                                               EmailV2_Services.Constants.RestrictedUseCase.Standard);
      BOOLEAN  _CheckEmailDeliverable := FALSE : STORED('CheckEmailDeliverable');  // not used by EmailSearchV2 batch plugin, internal option
      EXPORT BOOLEAN  CheckEmailDeliverable := EmailV2_Services.Constants.isPremium(SearchTier) OR _CheckEmailDeliverable;
      _EmailValidationType := '' : STORED('EmailValidationType');
      EXPORT STRING EmailValidationType := MAP(
        $.Constants.EmailValidationType.isValidType(_EmailValidationType) => _EmailValidationType,
        CheckEmailDeliverable => EmailV2_Services.Constants.EmailValidationType.BriteVerify,
        '');
      BOOLEAN  _KeepUndeliverableEmail := FALSE : STORED('KeepUndeliverableEmail'); // internal option not passed by EmailSearchV2 batch plugin
      EXPORT BOOLEAN  KeepUndeliverableEmail := _KeepUndeliverableEmail OR EmailV2_Services.Constants.SearchType.isEIA(SearchType)
                                                OR EmailV2_Services.Constants.SearchType.isEIC(SearchType); // we never suppress email records for EIC/EIA searches
      BOOLEAN  _BypassTMXcheck := FALSE : STORED('SkipTMXcheck'); // specific to EAA search type
      BOOLEAN  SkipTMXcheck := _BypassTMXcheck OR EmailV2_Services.Constants.SearchType.isEIA(SearchType)
                                      OR EmailV2_Services.Constants.SearchType.isEIC(SearchType); // we never suppress email records for EIC/EIA searches and we are not returning TMX data otherwise

      EXPORT BOOLEAN UseTMXRules := ~SkipTMXcheck;

      EXPORT UNSIGNED MaxEmailsForTMXCheck := EmailV2_Services.Constants.Defaults.MaxEmailsToCheckDeliverable : STORED('MaxEmailsForTMXCheck'); // specific to EAA search type - internal option not passed by EmailSearchV2 batch plugin
      BOOLEAN KeepTMXRejectedEmail := FALSE  : STORED('KeepTMXRejectedEmail'); // specific to EAA search type - internal option not passed by EmailSearchV2 batch plugin
      EXPORT BOOLEAN SuppressTMXRejectedEmail := ~KeepTMXRejectedEmail AND EmailV2_Services.Constants.SearchType.isEAA(SearchType); // specific to EAA search type - regulates whether email addresses failing TMX check are to be removed
      EXPORT DATASET (Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
    END;

    RETURN email_batch_params;
  END;

  EXPORT SearchParams := INTERFACE(EmailParams)
  END;

  EXPORT GetSearchParams(iesp.emailsearchv2.t_EmailSearchV2Option in_optns) := FUNCTION

    mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());

    email_search_params := MODULE(PROJECT(mod_access, SearchParams, OPT))
      EXPORT BOOLEAN  RunDeepDive := in_optns.IncludeAlsoFound OR in_optns.IncludeNoLexIdMatch;  //= ~nodeepdive, specific to EAA search type
      EXPORT UNSIGNED2  PenaltThreshold := IF(in_optns.PenaltyThreshold > 0, in_optns.PenaltyThreshold, EmailV2_Services.Constants.Defaults.PenaltThreshold);  // specific to EAA search type
      EXPORT UNSIGNED MaxResultsPerAcct := MAP(in_optns.MaxResults > 0 => in_optns.MaxResults, in_optns.ReturnCount > 0 => in_optns.ReturnCount, EmailV2_Services.Constants.Defaults.MaxResults);
      EXPORT STRING SearchType := STD.Str.ToUpperCase(TRIM(in_optns.SearchType,ALL));
      EXPORT BOOLEAN IncludeHistoricData := in_optns.IncludeHistoricData;
      EXPORT BOOLEAN RequireLexidMatch := ~in_optns.IncludeNoLexIdMatch; //specific to EAA search type

      EXPORT UNSIGNED1 EmailQualityRulesMask := IF(in_optns.EmailQualityRulesMask != '', GetEmailRulesMask(in_optns.EmailQualityRulesMask), 0);
      EXPORT BOOLEAN isDirectMarketing () := in_optns.IsMarketingUse OR mod_access.isDirectMarketing ();
      SHARED STRING SearchTier := IF($.Constants.isValidTier(in_optns.SearchTier), in_optns.SearchTier,'');

      EXPORT STRING   _RestrictedUseCase := in_optns.RestrictedUseCase;
      EXPORT STRING   RestrictedUseCase := MAP (EmailV2_Services.Constants.RestrictedUseCase.isValid(_RestrictedUseCase) => _RestrictedUseCase,
                                               EmailV2_Services.Constants.isPremium(SearchTier)=>EmailV2_Services.Constants.RestrictedUseCase.Standard,
                                               EmailV2_Services.Constants.RestrictedUseCase.NoRoyaltySources);
      EXPORT STRING   BVAPIkey := IF(in_optns.BVAPIkey != '', in_optns.BVAPIkey, EmailV2_Services.Constants.GatewayValues.BVAPIkey);;
      EXPORT UNSIGNED MaxEmailsForDeliveryCheck := IF(in_optns.MaxEmailsForDeliveryCheck > 0, in_optns.MaxEmailsForDeliveryCheck, EmailV2_Services.Constants.Defaults.MaxEmailsToCheckDeliverable);
      BOOLEAN  _CheckEmailDeliverable := in_optns.CheckEmailDeliverable;
      EXPORT BOOLEAN  CheckEmailDeliverable := EmailV2_Services.Constants.isPremium(SearchTier) OR _CheckEmailDeliverable;
      STRING _EmailValidationType := in_optns.EmailValidationType;
      EXPORT STRING EmailValidationType := MAP(
        $.Constants.EmailValidationType.isValidType(_EmailValidationType) => _EmailValidationType,
        CheckEmailDeliverable => EmailV2_Services.Constants.EmailValidationType.BriteVerify,
        '');
      EXPORT BOOLEAN  KeepUndeliverableEmail := in_optns.KeepUndeliverableEmail;
      BOOLEAN  SkipTMXcheck := in_optns.SkipTMX OR EmailV2_Services.Constants.SearchType.isEIA(SearchType)
                                      OR EmailV2_Services.Constants.SearchType.isEIC(SearchType); // we never suppress email records for EIC/EIA searches and we are not returning TMX data otherwise

      EXPORT BOOLEAN  UseTMXRules := ~SkipTMXcheck;  // specific to EAA search type
      EXPORT UNSIGNED MaxEmailsForTMXCheck := IF(in_optns.MaxEmailsForTMX>0, in_optns.MaxEmailsForTMX, EmailV2_Services.Constants.Defaults.MaxEmailsForTMXcheck); // specific to EAA search type
      EXPORT BOOLEAN  SuppressTMXRejectedEmail := ~in_optns.SkipTMX AND EmailV2_Services.Constants.SearchType.isEAA(SearchType); // specific to EAA search type - regulates whether email addresses failing TMX check are to be removed
      EXPORT DATASET (Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
    END;

    RETURN email_search_params;
  END;

END;
