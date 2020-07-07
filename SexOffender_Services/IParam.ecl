IMPORT AutokeyI, AutoStandardI, BatchShare, FCRA, doxie;

EXPORT IParam := MODULE
  
  export ids_params := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface,
                                AutoStandardI.InterfaceTranslator.location_value.params,
                                AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.params)
    export boolean workHard   := true;
    export boolean noFail     := false;
    export boolean isdeepDive := false;
    export boolean noDeepDive      := false;
    export unsigned2 MAX_DEEP_DIDS := 100;
    export boolean zip_only_search := false;
  end;
  
  //should we keep this separated or merge it into search_params...?
  export functions_params := interface
    (
    doxie.IDataAccess,      
    AutoStandardI.InterfaceTranslator.location_value.params
    )
    export boolean include_regaddrs   := false;
    export boolean include_unregaddrs := false;
    export boolean include_histaddrs  := false;
    export boolean include_assocaddrs := false;
    export boolean include_offenses := false;
    export boolean include_bestaddress := false;
    export boolean include_wealsofound := false;
    export string offenseCategory := '' ;
    export boolean filterRecsByAltAddr := false;
  end;
  
  export search := interface(
    doxie.IDataAccess, //already included in functions_params, but I want it to be explicit
    ids_params,
    functions_params,
    AutoStandardI.LIBIN.PenaltyI_Indv.base,
    AutoStandardI.InterfaceTranslator.penalt_threshold_value.params,
    AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.params,
    FCRA.iRules
    ) // FFD FCRA
    EXPORT string DataPermissionMask := AutoStandardI.Constants.DataPermissionMask_default; //INTERFACES: different definitions in base modules
    export boolean  Include_BestAddress  := false;
    export STRING offenseCategory := '';
    export STRING SmtWords := '';
  end;
      
  export report := interface(
    doxie.IDataAccess,
    FCRA.iRules) // FFD FCRA
    export string60  Primary_Key  := '';
    export string14 did;
    export boolean AllowGraphicDescription := false;
    export boolean Include_BestAddress := false;
  end;

  export batch_params := INTERFACE (BatchShare.IParam.BatchParams, FCRA.iRules)
  end;
  
END;
