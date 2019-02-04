IMPORT $, BatchShare, doxie, Gateway, STD, ut;

EXPORT IParams := MODULE
 
  EXPORT EmailParams := INTERFACE(doxie.IDataAccess)
    EXPORT UNSIGNED  PenaltThreshold      := $.Constants.Defaults.PenaltThreshold;  // specific to EAA search type
    EXPORT UNSIGNED  MaxResultsPerAcct    := $.Constants.Defaults.MaxResultsPerAcct;  
    EXPORT BOOLEAN   IncludeHistoricData  := FALSE;
    EXPORT BOOLEAN   RequireLexidMatch    := FALSE;  // specific to EAA search type
    EXPORT UNSIGNED  EmailQualityRulesMask := 0;
    EXPORT BOOLEAN   RunDeepDive          := FALSE;  // specific to EAA search type
    EXPORT STRING    SearchType := '';   
    EXPORT STRING    IntendedPurpose := $.Constants.IntendedPurpose.Standard;   
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
  
    mod_access := Doxie.Compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
    base_params := BatchShare.IParam.getBatchParams();

    email_batch_params := MODULE(PROJECT(mod_access,BatchParams, opt))
      EXPORT BOOLEAN ReturnDetailedRoyalties := base_params.ReturnDetailedRoyalties; 
      EXPORT BOOLEAN RunDeepDive := base_params.RunDeepDive; 
      EXPORT UNSIGNED PenaltThreshold := base_params.PenaltThreshold;
      _MaxResultsPerAcct := $.Constants.Defaults.MaxResultsPerAcct : STORED('Max_Results_Per_Acct');
      EXPORT UNSIGNED MaxResultsPerAcct := _MaxResultsPerAcct;
      _SearchType := '' : STORED('SearchType');
      EXPORT STRING SearchType := STD.Str.ToUpperCase(TRIM(_SearchType,ALL));
      _IntendedPurpose  := $.Constants.IntendedPurpose.Standard : STORED('IntendedPurpose');
      EXPORT STRING IntendedPurpose  := STD.Str.ToUpperCase(TRIM(_IntendedPurpose,ALL));
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
  
END;
