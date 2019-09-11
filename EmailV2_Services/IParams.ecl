IMPORT $, BatchShare, doxie, Gateway, iesp, STD, ut;

EXPORT IParams := MODULE
 
  EXPORT EmailParams := INTERFACE(doxie.IDataAccess)
    EXPORT UNSIGNED2  PenaltThreshold      := $.Constants.Defaults.PenaltThreshold;  // specific to EAA search type
    EXPORT UNSIGNED  MaxResultsPerAcct    := $.Constants.Defaults.MaxResultsPerAcct;  
    EXPORT BOOLEAN   IncludeHistoricData  := FALSE;
    EXPORT BOOLEAN   RequireLexidMatch    := FALSE;  // specific to EAA search type
    EXPORT UNSIGNED1 EmailQualityRulesMask := 0;
    EXPORT BOOLEAN   RunDeepDive          := FALSE;  // specific to EAA search type
    EXPORT STRING    SearchType := '';   
    EXPORT STRING    RestrictedUseCase := $.Constants.RestrictedUseCase.Standard; // for the purpose of email filtering by source as needed
    EXPORT STRING    BVAPIkey := '';   
    EXPORT UNSIGNED  MaxEmailsForDeliveryCheck := $.Constants.Defaults.MaxEmailsToCheckDeliverable;   //max number of result email addresses per account to send to gateway for delivery check
    EXPORT BOOLEAN   CheckEmailDeliverable := FALSE;  // option  for whether to use external gateway call to check if email address deliverable
    EXPORT BOOLEAN   KeepUndeliverableEmail := FALSE; // specific to EAA search type
    EXPORT UNSIGNED1 DIDScoreThreshold := $.Constants.Defaults.DID_SCORE_THRESHOLD; 
    EXPORT DATASET (Gateway.Layouts.Config) gateways := DATASET ([], Gateway.Layouts.Config);  // to check delivery status
  END;

  EXPORT BatchParams := INTERFACE(EmailParams)
    EXPORT BOOLEAN   ReturnDetailedRoyalties := FALSE;   
  END;
  
  EXPORT GetEmailRulesMask(STRING _rules) := ut.BinaryStringToInteger(STD.Str.Reverse(TRIM(_rules)));
  
  EXPORT GetBatchParams() := FUNCTION
  
    base_params := BatchShare.IParam.getBatchParams();

    email_batch_params := MODULE(PROJECT(base_params,BatchParams, OPT))
      _MaxResultsPerAcct := $.Constants.Defaults.MaxResultsPerAcct : STORED('Max_Results_Per_Acct');
      EXPORT UNSIGNED MaxResultsPerAcct := _MaxResultsPerAcct;
      _SearchType := '' : STORED('SearchType');
      EXPORT STRING  SearchType := STD.Str.ToUpperCase(TRIM(_SearchType,ALL));
      EXPORT BOOLEAN IncludeHistoricData := FALSE : STORED('IncludeHistoricData'); 
      BOOLEAN _IncludeNoLexIdMatch := FALSE : STORED('IncludeNoLexIdMatch'); 
      EXPORT BOOLEAN RequireLexidMatch := ~_IncludeNoLexIdMatch AND $.Constants.SearchType.isEAA(SearchType); // applicable to EAA search only, ignored by other search types
      EXPORT UNSIGNED1 DIDScoreThreshold := $.Constants.Defaults.DID_SCORE_THRESHOLD : STORED('DIDScoreThreshold');
  
      _EmailQualityRulesString := '' : STORED('EmailQualityRulesMask'); 
      EXPORT UNSIGNED1 EmailQualityRulesMask := MAP(
                   _EmailQualityRulesString<>'' => GetEmailRulesMask(_EmailQualityRulesString),
                   $.Constants.SearchType.isEAA(SearchType) => 0, // default here may change
                   $.Constants.SearchType.isEIA(SearchType) OR $.Constants.SearchType.isEIC(SearchType) => 0xF,  // by default no restrictions on search by input email address
                   0); 
      STRING _BVAPIkey := '' : STORED('BVAPIkey');   
      EXPORT STRING   BVAPIkey := IF(_BVAPIkey != '', _BVAPIkey, $.Constants.GatewayValues.BVAPIkey);   
      EXPORT UNSIGNED MaxEmailsForDeliveryCheck := $.Constants.Defaults.MaxEmailsToCheckDeliverable : STORED('MaxEmailsForDeliveryCheck');   
      STRING  _SearchTier := ''  : STORED('SearchTier');   
      STRING  SearchTier := IF(_SearchTier<>'', STD.Str.ToLowerCase(_SearchTier), $.Constants.Basic);   
      BOOLEAN  _CheckEmailDeliverable := FALSE : STORED('CheckEmailDeliverable');  
      EXPORT BOOLEAN  CheckEmailDeliverable := _CheckEmailDeliverable OR SearchTier = $.Constants.Premium;  
      BOOLEAN  _KeepUndeliverableEmail := FALSE : STORED('KeepUndeliverableEmail'); 
      EXPORT BOOLEAN  KeepUndeliverableEmail := _KeepUndeliverableEmail OR $.Constants.SearchType.isEIA(SearchType) 
                                                OR $.Constants.SearchType.isEIC(SearchType); // we never suppress email records for EIC/EIA searches
      BOOLEAN  _BypassTMXcheck := FALSE : STORED('SkipTMXcheck'); 
      EXPORT BOOLEAN  SkipTMXcheck := _BypassTMXcheck OR $.Constants.SearchType.isEIA(SearchType) 
                                      OR $.Constants.SearchType.isEIC(SearchType); // we never suppress email records for EIC/EIA searches and we are not returning TMX data otherwise
      EXPORT UNSIGNED MaxEmailsForTMXCheck := $.Constants.Defaults.MaxEmailsToCheckDeliverable : STORED('MaxEmailsForTMXCheck');   
      EXPORT DATASET (Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
    END;    

    RETURN email_batch_params;
  END;
 
  EXPORT SearchParams := INTERFACE(EmailParams)
  END;
 
  EXPORT GetSearchParams(iesp.emailsearchv2.t_EmailSearchV2Option in_optns) := FUNCTION
  
    mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());
    
    email_search_params := MODULE(PROJECT(mod_access, SearchParams, OPT))
      EXPORT BOOLEAN  RunDeepDive := in_optns.IncludeAlsoFound;  //= ~nodeepdive, specific to EAA search type
      EXPORT UNSIGNED2  PenaltThreshold := IF(in_optns.PenaltyThreshold > 0, in_optns.PenaltyThreshold, $.Constants.Defaults.PenaltThreshold);  // specific to EAA search type
      EXPORT UNSIGNED MaxResultsPerAcct := IF(in_optns.MaxResults > 0, in_optns.MaxResults, $.Constants.Defaults.MaxResultsPerAcct);
      EXPORT STRING SearchType := STD.Str.ToUpperCase(TRIM(in_optns.SearchType,ALL));
      EXPORT BOOLEAN IncludeHistoricData := in_optns.IncludeHistoricData; 
      EXPORT BOOLEAN RequireLexidMatch := ~in_optns.IncludeNoLexIdMatch; 
      
      EXPORT UNSIGNED1 EmailQualityRulesMask := IF(in_optns.EmailQualityRulesMask != '', GetEmailRulesMask(in_optns.EmailQualityRulesMask), 0); 
      EXPORT STRING   BVAPIkey := IF(in_optns.BVAPIkey != '', in_optns.BVAPIkey, $.Constants.GatewayValues.BVAPIkey);;   
      EXPORT UNSIGNED MaxEmailsForDeliveryCheck := IF(in_optns.MaxEmailsForDeliveryCheck > 0, in_optns.MaxEmailsForDeliveryCheck, $.Constants.Defaults.MaxEmailsToCheckDeliverable);   
      EXPORT BOOLEAN  CheckEmailDeliverable := in_optns.CheckEmailDeliverable;  
      EXPORT BOOLEAN  KeepUndeliverableEmail := in_optns.KeepUndeliverableEmail; 
      EXPORT DATASET (Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
    END;    

    RETURN email_search_params;
  END;

END;
