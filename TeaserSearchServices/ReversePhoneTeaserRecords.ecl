IMPORT AutostandardI, iesp, doxie, dx_header, dx_Gong, Risk_Indicators, Phones, dx_PhonesInfo, Suppress, bipv2;

EXPORT ReversePhoneTeaserRecords := MODULE

EXPORT Records(AutoStandardI.DataRestrictionI.params tempMod,
               STRING32 application_type_value
               ) := FUNCTION

  gm := AutoStandardI.GlobalModule();
  mod_access := MODULE(Doxie.compliance.GetGlobalDataAccessModuleTranslated(gm))
    EXPORT DataRestrictionMask := tempMod.DataRestrictionMask;
    EXPORT dppa := tempMod.DPPAPurpose;
    EXPORT glb := tempMod.GLBPurpose;
    EXPORT show_minors := tempMod.IncludeMinors;
    EXPORT application_type := application_type_value;
  END;

  Phone_value := AutoStandardI.InterfaceTranslator.Phone_value.val(PROJECT(
    gm, AutoStandardI.InterfaceTranslator.Phone_value.params));

  dppa_ok := mod_access.isValidDPPA();
  glb_ok := mod_access.isValidGLB();
  DRM := mod_access.DataRestrictionMask;

  rec_phoneLayout := RECORD
    STRING10 phoneVal;
  END;

  phone_recs := DATASET([{phone_value}], rec_phoneLayout); // use this IF they want cell AND landline

    // *************
  srchMod := MODULE(PROJECT(gm, doxie.phone_noreconn_param.searchParams,OPT))
    doxie.compliance.MAC_CopyModAccessValues(mod_access);
    EXPORT STRING15 Phone := phone_value;
  END;

  dids_deduped := DEDUP(SORT(doxie.Get_Dids(TRUE,TRUE),did),did)(did<>0);

  // eliminate minors as necessary
  filteredDids := doxie.compliance.mac_FilterOutMinors(dids_deduped,,, mod_access.show_minors);

  // this call retrieves phone recs but no gateway hits since gateways are not passed
  phoneDIDs := doxie.phone_noreconn_records(srchMod, filteredDids);

  // check for business Phones
    bipv2.IDfunctions.rec_SearchInput xformBIpInput() := TRANSFORM
      SELF.Phone10 := Phone_value; // from autostandardI above 10 digits
      SELF.hsort := TRUE; // always make this TRUE;
      SELF := []; // blank out everything else.
    END;
    dsBIPInput := DATASET([ xformBipInput() ]);

    seleBest := SORT(BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(dsBIPInput).SeleBest(company_name <> ''), -record_score);
    // end of business PHone search.

  optout_layout := RECORD
    TeaserSearchServices.Layouts.ReversePhoneTeaserIntermediateLayout;
    UNSIGNED4 global_sid;
    UNSIGNED8 record_sid;
  END;
  // get info for land line phones based on phone input
  pre_AddrInfo_valueFromPhone := JOIN(phone_recs, dx_Gong.key_history_phone(),
  LEFT.PhoneVal[4..10] = RIGHT.p7 AND
  LEFT.PhoneVal[1..3] = RIGHT.p3,
  TRANSFORM(optout_layout,
    SELF.streetNumber := RIGHT.prim_range;
    SELF.streetName := RIGHT.prim_name;
    SELF.unitNumber := RIGHT.sec_range;
    SELF.city := RIGHT.v_city_name;
    SELF.state := RIGHT.st;
    SELF.zip5 := RIGHT.z5;
    SELF.DID := RIGHT.DID;
    SELF.global_sid := RIGHT.global_sid;
    SELF.record_sid := RIGHT.record_sid;
    SELF.current_flag := RIGHT.current_flag;
    SELF := [];
  ), LIMIT(0), KEEP(10000));

  AddrInfo_valueFromPhone_optout := Suppress.MAC_SuppressSource(pre_AddrInfo_valueFromPhone, mod_access);
  AddrInfo_valueFromPhone := PROJECT(AddrInfo_valueFromPhone_optout,
    TeaserSearchServices.Layouts.ReversePhoneTeaserIntermediateLayout);

  AddrInfo_valueFromPhoneSLim := AddrInfo_valueFromPhone (streetNumber <> '' AND
    StreetName <> '' AND
    city <> '' AND
    state <> '' AND Zip5 <> '');

   // rollup to set indicator for other previous addresses than current one.
   AddrValueFromPhoneRolled := ROLLUP(AddrInfo_valueFromPhoneSlim,
    LEFT.streetNumber = RIGHT.StreetNumber AND
    LEFT.StreetName = RIGHT.streetName AND
    LEFT.city = RIGHT.city AND
    LEFT.state = RIGHT.state AND
    LEFT.zip5 = RIGHT.zip5,
    TRANSFORM(RECORDOF(AddrInfo_valueFromPhone),
      SELF := LEFT,
      SELF := RIGHT;
    ));

  //add in dids' from doxie phone no reconn search here.
  possibleCellPhoneDids := PROJECT(phoneDIDs(penalt = 0), 
    TRANSFORM(TeaserSearchServices.Layouts.ReversePhoneTeaserIntermediateLayout,
      SELF.did := (UNSIGNED6) LEFT.did;
      SELF := [];
    ));

  // add did recs from phoneNoReconn search to dids recs obtained from hit to gong history key and slim
  AddrInfo_valueFromPhoneFinal := DEDUP(SORT(possibleCellPhoneDids + AddrInfo_valueFromPhone, did), did);

  Suppress.MAC_Suppress(AddrInfo_valueFromPhoneFinal,
      AddrInfo_valueFromPhoneFinalPulled,application_type_value,Suppress.Constants.LinkTypes.DID,DID);

  AddrInfoFromPhoneInput := JOIN(AddrInfo_valueFromPhoneFinalPulled, dx_header.key_did_hhid(),
    KEYED(LEFT.did = RIGHT.did),
    TRANSFORM(doxie.layout_presentation,
      SELF.hhid := RIGHT.hhid,
      SELF := LEFT,
      SELF := [];
    ), 
    LEFT OUTER, LIMIT(0), KEEP(1));

  // get the best recs for given DID
  // this info (name/addr/age for a particular did) is used later to set indicators
  doxie.mac_best_records(AddrInfoFromPhoneInput, did,
    AddrInfoFromPhoneInputOut,dppa_ok,glb_ok,,DRM);

  //bestInfo := if (NOT(exists(addrInfoFromPhoneInputOut), seleBest, AddrInfoFromPhoneInputOut);
  //Since only serv type is needed calling only the phone_type key
  phone_in := PROJECT(phone_recs, TRANSFORM(Phones.Layouts.rec_phoneLayout, SELF.phone := LEFT.PhoneVal));
  PortedMetadatapayload := SORT(dx_PhonesInfo.RAW.GetPhoneType(phone_in), -vendor_last_reported_dt);

  // this assumes 1 phone entry and one phone rec # returned for a given input.
  STRING1 phoneType := IF (EXISTS(PortedMetadatapayload),
    (STRING1) PortedMetadatapayload[1].serv,
    '');

  // Call doxie relative dids to retrieve necessary relative info
  did_recs := PROJECT(AddrInfo_valueFromPhoneFinalPulled,TRANSFORM(doxie.layout_references,
    SELF.DID := LEFT.DID;
  ));

  // suppress the relative dids after retrieving them.
  rel_dids := doxie.relative_dids(did_recs);
  Suppress.MAC_Suppress(rel_Dids,rel_DIDsPulled,
    application_type_value,Suppress.Constants.LinkTypes.DID,person1);

   // Risk_Indicators.Key_Telcordia_tpm (123) 456-7890
     //Risk_Indicators.Key_Telcordia_tpm(npa = '123' and nxx = '456' and tb = '7890'));

   // to get carrier indicator
   phoneRecsWCarrier := JOIN(phone_recs, Risk_Indicators.Key_Telcordia_tpm,
                              LEFT.PhoneVal[1..3] = RIGHT.NPA AND
                              LEFT.PhoneVal[4..6] = RIGHT.NXX,
                              TRANSFORM(RIGHT),LIMIT(0), KEEP(10000))(ocn <> '');

   city_fromPhoneRecs := phoneRecsWcarrier[1].city;
   state_fromPhoneRecs := phoneRecsWcarrier[1].st;
   // to get city/state info that is not in telecordia
   city_final := IF (city_fromPhoneRecs = '' AND state_fromPhoneRecs = '' AND
      selebest[1].v_city_name <> '' AND selebest[1].st <> '',
      selebest[1].v_city_name, city_fromPhoneRecs );

   state_final := IF (city_fromPhoneRecs = '' AND state_fromPhoneRecs = '' AND
      selebest[1].v_city_name <> '' AND selebest[1].st <> '',
      selebest[1].st, state_fromPhoneRecs);


   iesp.thinReversePhoneTeaser.t_ThinReversePhoneTeaserRecord xform_out() := TRANSFORM
    SELF.CarrierIndicator := EXISTS(phoneRecsWCarrier);
    SELF.PhoneType := MAP( (PhoneType = '0') => 'LANDLINE', // LANDLINE
                                            (PhoneType = '1') => 'CELL', // CELL
                                            (PhoneType = '2') => 'VOIP', // VOIP
                                            '');
                                        // LandLine = 0,Wireless = 1,VOIP = 2,Unknown = 3
    SELF.address := iesp.ecl2esp.setAddress('',//LEFT.prim_name,
                                        '',//LEFT.prim_range,
                                        '',//LEFT.predir,
                                        '',//LEFT.postdir,
                                        '',//LEFT.suffix,
                                        '',//LEFT.unit_desig,
                                        '',//LEFT.sec_range,
                                        city_final,//LEFT.v_city_name,
                                        state_final,//LEFT.st,
                                        '',//LEFT.zip,
                                        '',//LEFT.zip4,
                                        '',//CountyName,
                                        '','','','');
    SELF.OwnerNameIndicator := EXISTS(AddrInfoFromPhoneInputOut(AddrInfoFromPhoneInputOut.fname <> '' AND AddrInfoFromPhoneInputOut.lname <> ''))
                                    OR EXISTS(selebest(selebest.company_name <> '' AND selebest.match_company_phone >= 2));
    SELF.AddressIndicator := EXISTS(AddrInfoFromPhoneInputOut(AddrInfoFromPhoneInputOut.city_name <> '' AND AddrInfoFromPhoneInputOut.st <> ''))
                                    OR EXISTS(selebest(selebest.v_city_name <> '' AND selebest.st <> ''));
                                                    // ^^^^^^^ ^^^^^^^^^
                                                    // referencing this data set specifically so that
                                                    // there are no conflicts with other datasets in attributte
    SELF.AgeIndicator := EXISTS(AddrInfoFromPhoneInputOut(age <> 0));
    SELF.RelativeIndicator := EXISTS(rel_didsPulled);
    SELF.PreviousLocationIndicator := COUNT(AddrValueFromPhoneRolled) > 1;

    SELF := [];
  END;

  outRec := DATASET([xform_out()]);
  RETURN outRec;
  END; // FUNCTION
END; // MODULE
