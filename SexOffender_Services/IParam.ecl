IMPORT AutokeyI, AutoStandardI, BatchShare, FCRA, doxie;

EXPORT IParam := MODULE
  
  EXPORT ids_params := INTERFACE(
    AutoKeyI.AutoKeyStandardFetchBaseInterface,
    AutoStandardI.InterfaceTranslator.location_value.params,
    AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.params
    )
    EXPORT BOOLEAN workHard := TRUE;
    EXPORT BOOLEAN noFail := FALSE;
    EXPORT BOOLEAN isdeepDive := FALSE;
    EXPORT BOOLEAN noDeepDive := FALSE;
    EXPORT UNSIGNED2 MAX_DEEP_DIDS := 100;
    EXPORT BOOLEAN zip_only_search := FALSE;
  END;
  
  //should we keep this separated or merge it into search_params...?
  EXPORT functions_params := INTERFACE(
    doxie.IDataAccess,
    AutoStandardI.InterfaceTranslator.location_value.params
    )
    EXPORT BOOLEAN include_regaddrs := FALSE;
    EXPORT BOOLEAN include_unregaddrs := FALSE;
    EXPORT BOOLEAN include_histaddrs := FALSE;
    EXPORT BOOLEAN include_assocaddrs := FALSE;
    EXPORT BOOLEAN include_offenses := FALSE;
    EXPORT BOOLEAN include_bestaddress := FALSE;
    EXPORT BOOLEAN include_wealsofound := FALSE;
    EXPORT STRING offenseCategory := '' ;
    EXPORT BOOLEAN filterRecsByAltAddr := FALSE;
  END;
  
  EXPORT search := INTERFACE(
    doxie.IDataAccess, //already included IN functions_params, but I want it to be explicit
    ids_params,
    functions_params,
    AutoStandardI.LIBIN.PenaltyI_Indv.base,
    AutoStandardI.InterfaceTranslator.penalt_threshold_value.params,
    AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.params,
    FCRA.iRules
    ) // FFD FCRA
    EXPORT STRING DataPermissionMask := AutoStandardI.Constants.DataPermissionMask_default; //INTERFACES: different definitions IN base modules
    EXPORT BOOLEAN Include_BestAddress := FALSE;
    EXPORT STRING offenseCategory := '';
    EXPORT STRING SmtWords := '';
  END;
      
  EXPORT report := INTERFACE(
    doxie.IDataAccess,
    FCRA.iRules) // FFD FCRA
    EXPORT STRING60 Primary_Key := '';
    EXPORT STRING14 did;
    EXPORT BOOLEAN AllowGraphicDescription := FALSE;
    EXPORT BOOLEAN Include_BestAddress := FALSE;
  END;

  EXPORT batch_params := INTERFACE (BatchShare.IParam.BatchParams, FCRA.iRules)
  END;
  
END;
