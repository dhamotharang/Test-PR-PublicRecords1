IMPORT tools, Strata, BusData, OneKey;

EXPORT Build_Strata(STRING pversion
                   ,BOOLEAN pOverwrite                                          = FALSE
                   ,DATASET(OneKey.Layouts.Base) pBaseFile                      = OneKey.Files().Base.Built		
                   ,STRING pfileversion                                         = 'using'
                   ,BOOLEAN pUseOtherEnviron                                    = OneKey._Constants().IsDataland
                   ,DATASET(OneKey.Layouts.InputA.Sprayed) pSprayedFileA        = OneKey.Files(pfileversion, pUseOtherEnviron).InputA.logical
                   ,DATASET(OneKey.Layouts.InputB.Sprayed) pSprayedFileB        = OneKey.Files(pfileversion, pUseOtherEnviron).InputB.logical
                   ,BOOLEAN pIsTesting                                          = tools._Constants.IsDataland
                   ) := FUNCTION

  dUpdate := OneKey.Strata_Stats(pBaseFile, pfileversion, pUseOtherEnviron, pSprayedFileA, pSprayedFileB);
	
  Strata.mac_CreateXMLStats(dUpdate.dInputANoGrouping,        OneKey._Constants().Name, 'InputA',    pversion, OneKey.Email_Notification_Lists().buildsuccess, BuildInputANoGrouping_Strata,        'View',        'Population', , pIsTesting, pOverwrite);
  Strata.mac_CreateXMLStats(dUpdate.dUniqueInputANoGrouping,  OneKey._Constants().Name, 'InputA',    pversion, OneKey.Email_Notification_Lists().buildsuccess, BuildInputAUniqueNoGrouping_Strata,  'View',        'Uniques',    , pIsTesting, pOverwrite);
  Strata.mac_CreateXMLStats(dUpdate.dInputBNoGrouping,        OneKey._Constants().Name, 'InputB',    pversion, OneKey.Email_Notification_Lists().buildsuccess, BuildInputBNoGrouping_Strata,        'View',        'Population', , pIsTesting, pOverwrite);
  Strata.mac_CreateXMLStats(dUpdate.dUniqueInputBNoGrouping,  OneKey._Constants().Name, 'InputB',    pversion, OneKey.Email_Notification_Lists().buildsuccess, BuildInputBUniqueNoGrouping_Strata,  'View',        'Uniques',    , pIsTesting, pOverwrite);

  Strata.mac_CreateXMLStats(dUpdate.dNoGrouping,              OneKey._Constants().Name, 'base_file', pversion, OneKey.Email_Notification_Lists().buildsuccess, BuildNoGrouping_Strata,              'View',        'Population', , pIsTesting, pOverwrite);
  Strata.mac_CreateXMLStats(dUpdate.dCleanAddressState,       OneKey._Constants().Name, 'base_file', pversion, OneKey.Email_Notification_Lists().buildsuccess, BuildCleanAddressState_Strata,       'Clean_State', 'Population', , pIsTesting, pOverwrite);
  Strata.mac_CreateXMLStats(dUpdate.dUniqueNoGrouping,        OneKey._Constants().Name, 'base_file', pversion, OneKey.Email_Notification_Lists().buildsuccess, BuildUniqueNoGrouping_Strata,        'View',        'Uniques',    , pIsTesting, pOverwrite);
  Strata.mac_CreateXMLStats(dUpdate.dUniqueCleanAddressState, OneKey._Constants().Name, 'base_file', pversion, OneKey.Email_Notification_Lists().buildsuccess, BuildUniqueCleanAddressState_Strata, 'Clean_State', 'Uniques',    , pIsTesting, pOverwrite);

  full_build := PARALLEL(BuildInputANoGrouping_Strata			
                        ,BuildInputAUniqueNoGrouping_Strata
                        ,BuildInputBNoGrouping_Strata			
                        ,BuildInputBUniqueNoGrouping_Strata
                        ,BuildNoGrouping_Strata								
                        ,BuildCleanAddressState_Strata				
                        ,BuildUniqueNoGrouping_Strata					
                        ,BuildUniqueCleanAddressState_Strata);

  RETURN IF(tools.fun_IsValidVersion(pversion)
           ,full_build		
           ,OUTPUT('No Valid version parameter passed, skipping OneKey.Build_Strata attribute'));
		
END;