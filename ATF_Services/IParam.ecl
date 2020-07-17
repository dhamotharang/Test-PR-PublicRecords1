IMPORT AutokeyI, AutoStandardI, Suppress, FCRA;

EXPORT IParam := MODULE
  
  export ak_params := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
    export boolean workHard := true;
    export boolean noFail := false;
    export boolean isdeepDive := false;
  end;
  
  export ids_params := interface(ak_params)
    export string15 license_number := '';
    export boolean noDeepDive := false;
    export unsigned2 MAX_DEEP_DIDS := 100;
    export unsigned2 MAX_DEEP_BDIDS := 100;
  end;
  
  export search_params := interface(
    ids_params,
    AutoStandardI.LIBIN.PenaltyI_Indv.base,
    AutoStandardI.InterfaceTranslator.glb_purpose.params,
    AutoStandardI.InterfaceTranslator.dppa_purpose.params,
    AutoStandardI.InterfaceTranslator.penalt_threshold_value.params,
    AutoStandardI.InterfaceTranslator.ssn_mask_value.params,
    FCRA.iRules)
    EXPORT BOOLEAN IncludeCriminalIndicators := FALSE;
    export unsigned1 non_subject_suppression := Suppress.Constants.NonSubjectSuppression.doNothing;
  end;
END;
