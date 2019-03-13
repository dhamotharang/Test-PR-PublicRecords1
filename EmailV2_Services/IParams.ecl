IMPORT $, BatchShare, doxie, Gateway, iesp, STD, ut;

EXPORT IParams := MODULE
 
  EXPORT EmailParams := INTERFACE(doxie.IDataAccess)
    EXPORT UNSIGNED2  PenaltThreshold      := $.Constants.Defaults.PenaltThreshold;  // specific to EAA search type
    EXPORT UNSIGNED  MaxResultsPerAcct    := $.Constants.Defaults.MaxResultsPerAcct;  
    EXPORT BOOLEAN   IncludeHistoricData  := FALSE;
    EXPORT BOOLEAN   RequireLexidMatch    := FALSE;  // specific to EAA search type
    EXPORT UNSIGNED  EmailQualityRulesMask := 0;
    EXPORT BOOLEAN   RunDeepDive          := FALSE;  // specific to EAA search type
    EXPORT STRING    SearchType := '';   
    EXPORT STRING    RestrictedUseCase := $.Constants.RestrictedUseCase.Standard; // for the purpose of email filtering by source as needed
    EXPORT STRING    BVAPIkey := '';   
    EXPORT UNSIGNED  MaxEmailsForDeliveryCheck := $.Constants.Defaults.MaxEmailsToCheckDeliverable;   //max number of result email addresses per account to send to gateway for delivery check
    EXPORT BOOLEAN   CheckEmailDeliverable := FALSE;  // option  for whether to use external gateway call to check if email address deliverable
    EXPORT BOOLEAN   KeepUndeliverableEmail := FALSE; // specific to EAA search type
    EXPORT DATASET (Gateway.Layouts.Config) gateways := DATASET ([], Gateway.Layouts.Config);  // to check delivery status
  END;

  EXPORT BatchParams := INTERFACE(EmailParams)
    EXPORT BOOLEAN   ReturnDetailedRoyalties := FALSE;   
  END;
  
  EXPORT GetEmailRulesMask(STRING _rules) := ut.BinaryStringToInteger(STD.Str.Reverse(TRIM(_rules)));
  
  EXPORT GetBatchParams() := FUNCTION
  
    base_params := BatchShare.IParam.getBatchParamsV2();

    email_batch_params := MODULE(PROJECT(base_params,BatchParams, OPT))
      _MaxResultsPerAcct := $.Constants.Defaults.MaxResultsPerAcct : STORED('Max_Results_Per_Acct');
      EXPORT UNSIGNED MaxResultsPerAcct := _MaxResultsPerAcct;
      _SearchType := '' : STORED('SearchType');
      EXPORT STRING  SearchType := STD.Str.ToUpperCase(TRIM(_SearchType,ALL));
      EXPORT BOOLEAN IncludeHistoricData := FALSE : STORED('IncludeHistoricData'); 
      EXPORT BOOLEAN RequireLexidMatch := FALSE : STORED('RequireLexidMatch'); 
      
      _EmailQualityRulesString := '0' : STORED('EmailQualityRulesMask'); 
      EXPORT UNSIGNED EmailQualityRulesMask := GetEmailRulesMask(_EmailQualityRulesString); 
      EXPORT STRING   BVAPIkey := '' : STORED('BVAPIkey');   
      EXPORT UNSIGNED MaxEmailsForDeliveryCheck := $.Constants.Defaults.MaxEmailsToCheckDeliverable : STORED('MaxEmailsForDeliveryCheck');   
      EXPORT BOOLEAN  CheckEmailDeliverable := FALSE : STORED('CheckEmailDeliverable');  
      EXPORT BOOLEAN  KeepUndeliverableEmail := FALSE : STORED('KeepUndeliverableEmail'); 
      EXPORT DATASET (Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
    END;    

    RETURN email_batch_params;
  END;
 
  EXPORT SearchParams := INTERFACE(EmailParams)
  END;
 
  EXPORT GetSearchParams(iesp.emailfinder.t_EmailFinderSearchOption in_optns) := FUNCTION
  
    mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());
    
    email_search_params := MODULE(PROJECT(mod_access, SearchParams, OPT))
      EXPORT BOOLEAN  RunDeepDive := in_optns.IncludeAlsoFound;  //= ~nodeepdive, specific to EAA search type
      EXPORT UNSIGNED2  PenaltThreshold := IF(in_optns.PenaltyThreshold > 0, in_optns.PenaltyThreshold, $.Constants.Defaults.PenaltThreshold);  // specific to EAA search type
      EXPORT UNSIGNED MaxResultsPerAcct := IF(in_optns.MaxResults > 0, in_optns.MaxResults, $.Constants.Defaults.MaxResultsPerAcct);
      EXPORT STRING SearchType := STD.Str.ToUpperCase(TRIM(in_optns.SearchType,ALL));
      EXPORT BOOLEAN IncludeHistoricData := in_optns.IncludeHistoricData; 
      EXPORT BOOLEAN RequireLexidMatch := ~in_optns.IncludeNoLexIdMatch; 
      
      _EmailQualityRulesString := IF(in_optns.EmailQualityRulesMask = '', '0', in_optns.EmailQualityRulesMask); 
      EXPORT UNSIGNED EmailQualityRulesMask := GetEmailRulesMask(_EmailQualityRulesString); 
      EXPORT STRING   BVAPIkey := in_optns.BVAPIkey;   
      EXPORT UNSIGNED MaxEmailsForDeliveryCheck := IF(in_optns.MaxEmailsForDeliveryCheck > 0, in_optns.MaxEmailsForDeliveryCheck, $.Constants.Defaults.MaxEmailsToCheckDeliverable);   
      EXPORT BOOLEAN  CheckEmailDeliverable := in_optns.CheckEmailDeliverable;  
      EXPORT BOOLEAN  KeepUndeliverableEmail := in_optns.KeepUndeliverableEmail; 
      EXPORT DATASET (Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
    END;    

    RETURN email_search_params;
  END;

END;
