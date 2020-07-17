import autostandardi, FLAccidents_eCrash, iesp, LIB_Date, AutoHeaderI, Census_data, Accident_services;

export Functions := module

  shared vStatusSet := constants.vStatusSet; // VIN has been validated

  shared autoStndGlbMod := AutoStandardI.GlobalModule();

  EXPORT FetchI_Hdr_Indv_do(Accident_services.IParam.searchrecords in_mod) := FUNCTION
    glbMod := MODULE(PROJECT(in_mod,autoStndGlbMod,OPT)),VIRTUAL
    END;
    tmpmod := MODULE(PROJECT(glbMod,AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,OPT))
      EXPORT BOOLEAN noFail := TRUE;
    END;
    RETURN AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(tmpmod);
  END;

  // search by name/address
  export search_except_vin(Accident_services.IParam.searchrecords in_mod) := function
    
    dids := project(limit(FetchI_Hdr_Indv_do(in_mod),in_mod.MAX_DEEP_DIDS,skip),
                transform(Accident_services.Layouts.search_did,
                          self := left));
      
    deduped := dedup(sort(dids,did),did);
    accnbr_dd := join(deduped,FLAccidents_eCrash.Key_eCrashV2_did,
                 keyed(left.did=right.l_did), LIMIT(Accident_services.Constants.MAX_RECS_ON_JOIN,skip));
                 
    has_accnbr := in_mod.accident_number <> '';
  
    accnbr_ak := dataset([ transform({Accident_services.Layouts.search_did, FLAccidents_eCrash.Key_eCrashV2_did},
                  self.accident_nbr := in_mod.accident_number;
                  self.isDeepDive := false;
                  self := [];
                  ) ]);
  
    acc_nbrs := if(has_accnbr, accnbr_ak, accnbr_dd);
        
    rptCodeSet := if(in_mod.EnableExtraAccidents,Accident_services.constants.rptCodeSet+Accident_services.constants.eCrashAccident_source,Accident_services.constants.rptCodeSet);

    res := join(acc_nbrs,FLAccidents_eCrash.Key_eCrashV2_accnbrV1,
      keyed(left.accident_nbr=right.l_accnbr) and
      (has_accnbr or left.vin = right.vin) and // VIN filter
      keyed(right.report_code in rptCodeSet) and // Code filter
      right.vehicle_status in vStatusSet, // Status filter
      transform(recordof(FLAccidents_eCrash.Key_eCrashV2_accnbrV1),
        self := right),limit(1000));
            
    return res;
  end;
  
  export search_vin(Accident_services.IParam.searchrecords in_mod) := function
  
    string30 VIN := stringlib.StringToUpperCase(in_mod.VIN);
    
    vin7key := FLAccidents_eCrash.Key_eCrashV2_vin7;
    vin7rec := recordof(FLAccidents_eCrash.Key_eCrashV2_vin7);
    len := length(trim(VIN));
    string7 VIN7 := VIN[len-6..len];
    acc_nbrs := project(limit(vin7key(keyed(l_vin7=VIN7)
        ,stringlib.stringFind(l_vin,trim(VIN),1)>0 // VIN filter
        ),500,keyed,skip),vin7rec);

    rptCodeSet := if(in_mod.EnableExtraAccidents,Accident_services.constants.rptCodeSet+Accident_services.constants.eCrashAccident_source,Accident_services.constants.rptCodeSet);

    res := join(acc_nbrs,FLAccidents_eCrash.Key_eCrashV2_accnbrV1,
        keyed(left.accident_nbr=right.l_accnbr) and
        left.l_vin = right.vin and // VIN filter
        keyed(right.report_code in rptCodeSet) and // Code filter
        right.vehicle_status in vStatusSet, // Status filter
        transform(recordof(FLAccidents_eCrash.Key_eCrashV2_accnbrV1),self:=right),limit(1000));
    
    return res;
  end;
  
  export daysBetween(iesp.share.t_Date accidentDate) := function
    string8 accDate := (string)(AccidentDate.day+(AccidentDate.month*100)+(AccidentDate.year*10000));
    string8 curDate := stringLib.getDateYYYYMMDD();
    return(LIB_Date.DaysApart(accDate,curDate));
  end;
  
  EXPORT get_county_name(STRING2 st_in, STRING3 county_in) := FUNCTION
    RETURN Census_data.Key_Fips2County(KEYED(st_in = state_code AND county_in = county_fips))[1].county_name;
  END;

  EXPORT BOOLEAN allowGLB() := FUNCTION
    RETURN AutoStandardI.InterfaceTranslator.glb_ok.val(PROJECT(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.glb_ok.params));
  END;

  EXPORT BOOLEAN allowDPPA() := FUNCTION
    RETURN AutoStandardI.InterfaceTranslator.dppa_ok.val(PROJECT(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.dppa_ok.params));
  END;
end;
