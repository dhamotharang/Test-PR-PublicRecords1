import AutostandardI, iesp, doxie, dx_header, dx_Gong, Risk_Indicators, Phones, dx_PhonesInfo, Suppress, ut, bipv2;

EXPORT ReversePhoneTeaserRecords := Module

EXPORT Records(AutoStandardI.DataRestrictionI.params tempMod,
               STRING32 application_type_value
               ) := FUNCTION

  gm := AutoStandardI.GlobalModule();
  mod_access := MODULE(Doxie.compliance.GetGlobalDataAccessModuleTranslated(gm))
    export DataRestrictionMask := tempMod.DataRestrictionMask;
    export dppa := tempMod.DPPAPurpose;
    export glb := tempMod.GLBPurpose;
    export show_minors := tempMod.IncludeMinors;
    export application_type := application_type_value;
  END;

  Phone_value := AutoStandardI.InterfaceTranslator.Phone_value.val(project(
    gm, AutoStandardI.InterfaceTranslator.Phone_value.params));

  dppa_ok := mod_access.isValidDPPA();
  glb_ok :=  mod_access.isValidGLB();
  DRM := mod_access.DataRestrictionMask;

  rec_phoneLayout := RECORD
     STRING10 phoneVal;
  END;

  phone_recs := DATASET([{phone_value}], rec_phoneLayout); // use this if they want cell and landline

    // *************
  srchMod := MODULE(PROJECT(gm, doxie.phone_noreconn_param.searchParams,OPT))
      doxie.compliance.MAC_CopyModAccessValues(mod_access);
      EXPORT STRING15  Phone := phone_value;
  END;

  dids_deduped := dedup(sort(doxie.Get_Dids(true,true),did),did)(did<>0);

  // eliminate minors as necessary
  filteredDids := doxie.compliance.mac_FilterOutMinors(dids_deduped,,, mod_access.show_minors);

  // this call retrieves phone recs but no gateway hits since gateways are not passed
  phoneDIDs := doxie.phone_noreconn_records(srchMod, filteredDids);

  // check for business Phones
    bipv2.IDfunctions.rec_SearchInput xformBIpInput() := TRANSFORM
                                     SELF.Phone10 := Phone_value; // from autostandardI above 10 digits
                                     SELF.hsort := TRUE; // always make this true;
                                     SELF := []; // blank out everything else.
    END;
    dsBIPInput := DATASET([ xformBipInput() ]);

    seleBest :=  sort(BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(dsBIPInput).SeleBest(company_name <> ''), -record_score);
  // END of business PHone search.

  optout_layout := RECORD
    TeaserSearchServices.Layouts.ReversePhoneTeaserIntermediateLayout;
    unsigned4 global_sid;
    unsigned8 record_sid;
  END;
  // get info for land line phones based on phone input
  pre_AddrInfo_valueFromPhone := JOIN(phone_recs, dx_Gong.key_history_phone(),
  LEFT.PhoneVal[4..10] = RIGHT.p7 AND
  LEFT.PhoneVal[1..3] = RIGHT.p3,
  TRANSFORM(optout_layout,
    SELF.streetNumber   := RIGHT.prim_range;
    SELF.streetName     := RIGHT.prim_name;
    SELF.unitNumber     := RIGHT.sec_range;
    SELF.city           := RIGHT.v_city_name;
    SELF.state          := RIGHT.st;
    SELF.zip5           := RIGHT.z5;
    SELF.DID            := RIGHT.DID;
    SELF.global_sid     := RIGHT.global_sid;
    SELF.record_sid     := RIGHT.record_sid;
    SELF.current_flag   := RIGHT.current_flag;
    SELF := [];
  ), limit(0), keep(10000));

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
                                  LEFT.city = RIGHT.city                 AND
                                  LEFT.state = RIGHT.state               AND
                                  LEFT.zip5 = RIGHT.zip5,
                                       TRANSFORM(RECORDOF(AddrInfo_valueFromPhone),
                                  SELF := LEFT,
                                  SELF := RIGHT));

  //add in dids' from doxie phone no reconn search here.
  possibleCellPhoneDids := project(phoneDIDs(penalt = 0), TRANSFORM(TeaserSearchServices.Layouts.ReversePhoneTeaserIntermediateLayout,
                                 SELF.did := (UNSIGNED6) LEFT.did;
                                 SELF := []));

  // add did recs from phoneNoReconn search to dids recs obtained from hit to gong history key and slim
  AddrInfo_valueFromPhoneFinal := dedup(sort(possibleCellPhoneDids + AddrInfo_valueFromPhone, did), did);

  Suppress.MAC_Suppress(AddrInfo_valueFromPhoneFinal,
      AddrInfo_valueFromPhoneFinalPulled,application_type_value,Suppress.Constants.LinkTypes.DID,DID);

  AddrInfoFromPhoneInput := JOIN(AddrInfo_valueFromPhoneFinalPulled, dx_header.key_did_hhid(),
                        KEYED(LEFT.did = RIGHT.did),
                          transform(doxie.layout_presentation,
                                SELF.hhid := RIGHT.hhid,
                                SELF := LEFT,
                                SELF := [];
                                ), LEFT OUTER, LIMIT(0), KEEP(1));
  // get the best recs for given DID
  // this info (name/addr/age for a particular did) is used later to set indicators
  doxie.mac_best_records(AddrInfoFromPhoneInput, did,
                            AddrInfoFromPhoneInputOut,dppa_ok,glb_ok,,DRM);

  //bestInfo := if (NOT(exists(addrInfoFromPhoneInputOut), seleBest, AddrInfoFromPhoneInputOut);
  //Since only serv type is needed calling only the phone_type key
  phone_in := PROJECT(phone_recs, TRANSFORM(Phones.Layouts.rec_phoneLayout, SELF.phone := LEFT.PhoneVal));
  PortedMetadatapayload := SORT(dx_PhonesInfo.RAW.GetPhoneType(phone_in), -vendor_last_reported_dt);


  // this assumes 1 phone entry and one phone rec # returned for a given input.
  String1 phoneType := IF (EXISTS(PortedMetadatapayload),
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
                              TRANSFORM(RIGHT),limit(0), keep(10000))(ocn <> '');

   city_fromPhoneRecs           := phoneRecsWcarrier[1].city;
   state_fromPhoneRecs          := phoneRecsWcarrier[1].st;
   // to get city/state info that is not in telecordia
   city_final := if (city_fromPhoneRecs = '' and state_fromPhoneRecs = '' and
                          selebest[1].v_city_name <> '' and selebest[1].st <> '',
                          selebest[1].v_city_name, city_fromPhoneRecs );

   state_final := if (city_fromPhoneRecs = '' and state_fromPhoneRecs = '' and
                         selebest[1].v_city_name <> '' and selebest[1].st <> '',
                         selebest[1].st, state_fromPhoneRecs);


   iesp.thinReversePhoneTeaser.t_ThinReversePhoneTeaserRecord xform_out() := TRANSFORM
            SELF.CarrierIndicator          := EXISTS(phoneRecsWCarrier);
            SELF.PhoneType                 := MAP( (PhoneType = '0')  => 'LANDLINE', // LANDLINE
                                                   (PhoneType = '1') =>  'CELL', // CELL
                                                   (PhoneType = '2') =>  'VOIP', // VOIP
                                                    '');
                                               // LandLine = 0,Wireless = 1,VOIP = 2,Unknown = 3
            SELF.address                   := iesp.ecl2esp.setAddress('',//left.prim_name,
                                               '',//left.prim_range,
                                               '',//left.predir,
                                               '',//left.postdir,
                                               '',//left.suffix,
                                               '',//left.unit_desig,
                                               '',//left.sec_range,
                                               city_final,//left.v_city_name,
                                               state_final,//left.st,
                                               '',//left.zip,
                                               '',//left.zip4,
                                               '',//CountyName,
                                               '','','','');
            SELF.OwnerNameIndicator        := EXISTS(AddrInfoFromPhoneInputOut(AddrInfoFromPhoneInputOut.fname <> '' and AddrInfoFromPhoneInputOut.lname <> ''))
                                           OR EXISTS(selebest(selebest.company_name <> '' and selebest.match_company_phone >= 2));
            SELF.AddressIndicator          := EXISTS(AddrInfoFromPhoneInputOut(AddrInfoFromPhoneInputOut.city_name <> '' and AddrInfoFromPhoneInputOut.st <> ''))
                                           OR EXISTS(selebest(selebest.v_city_name <> '' and selebest.st <> ''));
                                                            // ^^^^^^^                       ^^^^^^^^^
                                                            // referencing this data set specifically so that
                                                            // there are no conflicts with other datasets in attributte
            SELF.AgeIndicator              := EXISTS(AddrInfoFromPhoneInputOut(age <> 0));
            SELF.RelativeIndicator         := EXISTS(rel_didsPulled);
            SELF.PreviousLocationIndicator :=	COUNT(AddrValueFromPhoneRolled) > 1;

            SELF := [];
    END;

   outRec := DATASET([xform_out()]);
   //output(AddrInfo_valueFromPhone, named('AddrInfo_valueFromPhone'));
   // output(AddrInfo_valueFromPhoneSLim, named('AddrInfo_valueFromPhoneSLim'));
   // output(dids_deduped, named('dids_deduped'));
   // output(phoneDIDS, named('phoneDIDs'));
   // output(did_recs, named('did_recs'));
   // output(rel_dids, named('rel_dids'));
   // output(outRec, named('outRec'));
   // output(PortedMetadatapayload, named('portedMetadatapayload'));
   // output(AddrInfoFromPhoneInputOut, named('AddrInfofromPhoneInputOut'));
  //	output(selebest, named('selebest'));
  // output(AddrInfo_valueFromPhoneSlim, named('AddrInfo_valueFromPhoneSlim'));
      // output(AddrValueFromPhoneRolled, named('AddrValueFromPhoneRolled'));
    //AddrInfoFromPhoneInputOut
return outRec;
END; // function
END; // MODULE
