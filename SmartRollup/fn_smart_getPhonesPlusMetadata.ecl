import AutoStandardI,doxie,doxie_raw,iesp, personreports;

export fn_smart_getPhonesPlusMetadata := MODULE

  SHARED iesp.dirassistwireless.t_DirAssistWirelessSearchRecord toESDL(Doxie_Raw.PhonesPlus_Layouts.preFinalLayout L) := TRANSFORM
    SELF.TelcordiaOnly       := L.telcordia_only='Y';
    SELF.TypeFlag            := L.typeflag;
    SELF.UniqueId            := L.did;
    SELF.Name                := iesp.ECL2ESP.SetName(L.fname,L.mname,L.lname,L.name_suffix,L.title);
    SELF.Address             := iesp.ECL2ESP.SetAddress(L.prim_name,L.prim_range,L.predir,L.postdir,L.suffix,L.unit_desig,L.sec_range,L.city_name,L.st,L.zip,L.zip4,L.county_name);
    SELF.CompanyName         := '',
    SELF.ListedName          := L.listed_name;
    SELF.Phone10             := L.Phone;
    SELF.TimeZone            := L.timezone;
    SELF.CentralOfficeCode   := ROW({L.COCType,CHOOSEN(PROJECT(L.COCDescription,TRANSFORM(iesp.share.t_StringArrayItem,SELF.value:=LEFT.description)),iesp.CONSTANTS.DAW.MAX_DESCRIPTIONS)},iesp.dirassistwireless.t_CentralOfficeCode);
    SELF.SpecialServiceCode  := ROW({L.SSC,CHOOSEN(PROJECT(L.SSCDescription,TRANSFORM(iesp.share.t_StringArrayItem,SELF.value:=LEFT.description)),iesp.CONSTANTS.DAW.MAX_DESCRIPTIONS)},iesp.dirassistwireless.t_SpecialServiceCode);
    SELF.DialIndicator       := L.dial_indicator='Y';
    SELF.PhoneRegion         := ROW({L.phone_region_city,L.phone_region_st},iesp.dirassistwireless.t_PhoneRegion);
    SELF.CarrierName         := L.carrier_name;
    SELF.IsConfirmed         := L.confirmed_flag;
    SELF.ListedNameVerified  := L.listed_name_targus;
    SELF.NewType             := L.new_type;
    SELF.VendorId            := L.vendor_id;
    SELF.DateFirstSeen       := iesp.ECL2ESP.toDatestring8(L.dt_first_seen);
    SELF.DateLastSeen        := iesp.ECL2ESP.toDatestring8(L.dt_last_seen);
    SELF.PhoneFeedback       := [], // not returned from doxie.phone_noreconn_records()
    SELF.ListingTypes        := CHOOSEN(DATASET([{L.listing_type_bus},{L.listing_type_res},{L.listing_type_gov}],iesp.share.t_StringArrayItem)(value!=''),iesp.CONSTANTS.DAW.MAX_LISTING_TYPES);
    SELF.HighRiskIndicators  := CHOOSEN(PROJECT(L.hri_phone,TRANSFORM(iesp.share.t_RiskIndicator,SELF.RiskCode:=LEFT.hri,SELF.Description:=LEFT.desc)),iesp.Constants.MaxCountHRI);
    SELF := [];
  END;

  SHARED dids_deduped := dedup(sort(doxie.Get_Dids(true,true),did),did)(did<>0);


  EXPORT byPhone(DATASET(fn_smart_getAddrMetadata.outLayout) addresses) := FUNCTION
    gm := AutoStandardI.GlobalModule();
    mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(gm);

    tmpPhone := RECORD
      DATASET(iesp.dirassistwireless.t_DirAssistWirelessSearchRecord) Phones;

    END;

    base_mod := MODULE(PROJECT(gm,doxie.phone_noreconn_param.searchParams,OPT))
        doxie.compliance.MAC_CopyModAccessValues(mod_access);
        EXPORT BOOLEAN   IncludeFullPhonesPlus := FALSE : STORED('IncludeFullPhonesPlus');
        EXPORT BOOLEAN   ExcludeCurrentGong := FALSE : STORED('ExcludeCurrentGong');
        EXPORT BOOLEAN   IncludeLastResort := FALSE;  // DO NOT SET TRUE! unless royalties calc'd for LastResort
        EXPORT UNSIGNED8 MaxResults := iesp.Constants.BR.MaxPhonesPlus;
        EXPORT UNSIGNED8 MaxResultsThisTime := iesp.Constants.BR.MaxPhonesPlus;
    END;

    tmpPhone getPhones(iesp.bpsreport.t_BpsReportPhone LE) := TRANSFORM
        srchMod := MODULE(base_mod)
          EXPORT STRING120 UnParsedFullName := LE.Name.Full;
          EXPORT STRING30  FirstName := LE.Name.First;
          EXPORT STRING30  MiddleName := LE.Name.Middle;
          EXPORT STRING30  LastName := LE.Name.Last;
          EXPORT STRING4   NameSuffix := LE.Name.Suffix;
          EXPORT STRING120 CompanyName := LE.CompanyName;
          EXPORT STRING15  Phone := LE.Phone10;
        END;
        rawphones := PROJECT(doxie.phone_noreconn_records(srchMod, dids_deduped),toESDL(LEFT));
        SELF.Phones := PROJECT(rawphones,TRANSFORM(iesp.dirassistwireless.t_DirAssistWirelessSearchRecord,
                                SELF.Name := LE.Name,
                                SELF.CompanyName := LE.CompanyName,
                                SELF.ListedName := LE.ListingName,
                                SELF.TimeZone := LE.TimeZone,
                                SELF := LEFT));
    END;

    iesp.smartlinxreport.t_SLRAddressSeq getPhonesPlusMetadata(fn_smart_getAddrMetadata.outLayout L) := TRANSFORM
      esdlPhones_temp  := NORMALIZE(PROJECT(L.bpsPhones,getPhones(LEFT)),LEFT.Phones,TRANSFORM(iesp.dirassistwireless.t_DirAssistWirelessSearchRecord,SELF:=RIGHT));
      esdlPhones := CHOOSEN(esdlPhones_temp, iesp.Constants.BR.MaxPhonesPlus);
      SELF.Phones := PROJECT(esdlPhones,TRANSFORM(iesp.dirassistwireless.t_DirAssistWirelessSearchRecord,
                            SELF.Address := L.Address,
                            SELF := LEFT));
      SELF := L;
    END;

    RETURN PROJECT(addresses,getPhonesPlusMetadata(LEFT));
  END;

  EXPORT byDid(doxie.layout_best B) := FUNCTION
    gm := AutoStandardI.GlobalModule();
    mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(gm);
    srchMod := MODULE(PROJECT(gm,doxie.phone_noreconn_param.searchParams,OPT))
      doxie.compliance.MAC_CopyModAccessValues(mod_access);
      EXPORT STRING14  DID := (STRING)ROW(B,TRANSFORM(doxie.layout_best,SELF:=LEFT)).did;
      EXPORT BOOLEAN   IncludeFullPhonesPlus := FALSE : STORED('IncludeFullPhonesPlus');
      EXPORT BOOLEAN   ExcludeCurrentGong := FALSE : STORED('ExcludeCurrentGong');
      EXPORT BOOLEAN   IncludeLastResort := FALSE;  // DO NOT SET TRUE! unless royalties calc'd for LastResort
      EXPORT UNSIGNED8 MaxResults := iesp.Constants.BR.MaxPhonesPlus;
      EXPORT UNSIGNED8 MaxResultsThisTime := iesp.Constants.BR.MaxPhonesPlus;
    END;
    phonesPlusMetadata := doxie.phone_noreconn_records(srchMod, dids_deduped);
    phonesPlusMetadataESDL := PROJECT(phonesPlusMetadata,toESDL(LEFT));
    // set premium phone flag, new layout with this field added.
    outPhones := fn_smart_setPhoneFlag(phonesPlusMetadataESDL);
    // OUTPUT(phonesPlusMetadata);
    RETURN outPhones;
  END;

END;
