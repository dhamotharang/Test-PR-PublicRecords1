import AutoKeyI, AutoStandardI;

export IParam := module
  
  export autokey_search := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
    export boolean workHard := true;
    export boolean noFail := false;
    export boolean isdeepDive := false;
    export boolean mask_dl := false;
  end;
  
  export search := interface(autokey_search,AutoStandardI.InterfaceTranslator.application_type_val.params)
    export string40 Accident_Number := '';
    export string2 Accident_State := '';
    export string8 Tag_Number := '';
    export unsigned2 MAX_DEEP_DIDS := 100;
    export unsigned2 MAX_DEEP_BDIDS := 100;
    
    export string30 VIN := '';
    export string10 ReportType := '';
    export string24 DriverLicenseNumber := '';
    export string2 DriverLicenseState := '';
    export string22 UniqueId := '';
    
    export boolean EnableNationalAccidents := false;
    export boolean EnableExtraAccidents := false;
    export unsigned4 dateVal := 0;
    export unsigned4 AccidentDate := 0;
  end;
  
  export searchrecords := interface(
    search,
    AutoStandardI.LIBIN.PenaltyI_Indv.base,
    AutoStandardI.LIBIN.PenaltyI_Biz.base,
    AutoStandardI.InterfaceTranslator.glb_purpose.params,
    AutoStandardI.InterfaceTranslator.dppa_purpose.params,
    AutoStandardI.InterfaceTranslator.penalt_threshold_value.params,
    AutoStandardI.InterfaceTranslator.dl_mask_value.params)
    export unsigned2 penalty_Threshold;
  end;
  
end;
