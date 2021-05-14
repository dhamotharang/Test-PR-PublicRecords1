IMPORT $, iesp, gateway, STD, Risk_Indicators, ut;
IMPORT AlloyMedia_student_list, American_student_list, doxie, dx_Email, dx_header, dx_gong, infutor, infutorcid, Impulse_Email;
IMPORT DayBatchPCNSR, header_quick, PhonesFeedback, phonesplus, phonesplus_v2, ProfileBooster, dx_prof_license_mari, prof_licensev2, POE, POEsFromEmails;
IMPORT one_click_data, saleschannel, spoke, targus, thrive, vehiclev2, zoom;

EXPORT TestMod := MODULE

  SHARED DataSource := ENUM(Both = 0, Report = 1, Keys = 2);
  SHARED FieldComparePrefix := 'meta_';
  SHARED FieldExclusionREGEX := '^(meta_src)';
  SHARED MaxRecsOut := 200;

  SHARED IParam := INTERFACE($.SOAP.ISOAPParam)
    EXPORT STRING collection;
    EXPORT UNSIGNED1 include_data_source;
    EXPORT BOOLEAN return_diff_only;
  END;

  SHARED getParams() := FUNCTION
    gateways := Gateway.Configuration.Get();
    in_mod := MODULE(IParam)
      EXPORT UNSIGNED6 LexID := 0 : STORED('LexId');
      EXPORT STRING8 request_date := '' : STORED('RequestDate');
      EXPORT STRING collection := '' : STORED('Collection');
      EXPORT UNSIGNED1 include_data_source := 0; // 0 - (all), 1 - Report only, 2 - Roxie Keys only
      EXPORT BOOLEAN return_diff_only := FALSE : STORED('ReturnDiffOnly');
      EXPORT STRING target_url := gateways(Gateway.Configuration.IsNeutralRoxie(servicename))[1].URL;
    END;
    RETURN in_mod;
  END;

  // compare collection dataset to data in roxie key
  SHARED doRawCompare(lexID, collection_name, collection_report_recs, raw_recs, date_field = '', sort_field = '') := FUNCTIONMACRO

    LOCAL layout_raw := RECORD
      STRING1 #expand(FieldComparePrefix+'src');
      RECORDOF(raw_recs);
    END;
    LOCAL this_collection := collection_report_recs(STD.STR.CompareIgnoreCase(metadata.name, collection_name) = 0);
    LOCAL this_collection_recs := PROJECT(this_collection.Records, TRANSFORM(layout_raw,
      SELF.#expand(FieldComparePrefix+'src') := 'Q';
      SELF := FROMJSON(layout_raw, '{'+LEFT.content+'}');
      ));

    // must sort the same way we sort in collection report
    LOCAL this_raw_recs_sorted := SORT(raw_recs,
      #IF(#TEXT(sort_field) != '') sort_field,#END
      #IF(#TEXT(date_field) != '') -date_field,#END
      RECORD);
    LOCAL this_raw_recs := PROJECT(this_raw_recs_sorted, TRANSFORM(layout_raw,
      SELF.#expand(FieldComparePrefix+'src') := 'K';
      SELF := LEFT;
      ));

    this_recs := ut.CompareDatasets(this_collection_recs, this_raw_recs, FieldComparePrefix,  FieldExclusionREGEX);
    RETURN this_recs(~in_mod.return_diff_only OR #expand(FieldComparePrefix + 'diff'));

  ENDMACRO;

  SHARED mac_output(in_mod, cname, recs) := MACRO
    if(STD.STR.CompareIgnoreCase(cname, in_mod.collection) = 0 OR in_mod.collection = '', OUTPUT(CHOOSEN(recs,MaxRecsOut), named(cname), ALL));
  ENDMACRO;

  SHARED mac_get_payload(lexID, key, k_did_field) := FUNCTIONMACRO
    RETURN LIMIT(key(keyed(k_did_field = (UNSIGNED6) lexID)),10000);
  ENDMACRO;

  // soap calls collection report and compare each dataset to associated roxie key to flag for any discrepancies
  SHARED doCompare(IParam in_mod) := FUNCTION

    duplicate_set := [$.Constants.Collection.EXPERIAN_CRDB, $.Constants.Collection.SANCTN]; // TODO: remove these collections from tier1
    collection_report_t1 := $.SOAP.callReport(in_mod).Result.Collections(metadata.name not in duplicate_set);
    collection_report_t2 := $.SOAP.callReportTier2(in_mod).Result.Collections;
    collection_report := collection_report_t1 + collection_report_t2;

    lexid := in_mod.LexID;
    dids := DATASET([{lexid}], doxie.layout_references);

    alloy_raw_recs := mac_get_payload(lexid, AlloyMedia_student_list.Key_DID, did);
    asl_raw_recs := mac_get_payload(lexid, American_student_list.key_DID, l_did);
    death_raw_recs := mac_get_payload(lexid, doxie.key_death_masterV2_ssa_DID, l_did);
    email_raw_recs := $.Raw.GetEmailRecs(dids);
    gong_raw_recs := mac_get_payload(lexid, dx_Gong.key_history_did(), l_did);
    impulse_raw_recs := mac_get_payload(lexid, Impulse_Email.Key_Impulse_DID, did);
    infutor_raw_recs := mac_get_payload(lexid, infutor.Key_Header_Infutor_Knowx, s_did);
    infutor_cid_raw_recs := mac_get_payload(lexid, InfutorCID.Key_Infutor_DID, did);
    infutor_narc_raw_recs := mac_get_payload(lexid, ProfileBooster.Key_Infutor_DID, did);
    proflic_mari_raw_recs := mac_get_payload(lexid, dx_prof_license_mari.key_did(), s_did);
    oneclick_raw_recs := mac_get_payload(lexid, one_click_data.keys().did.qa, did);
    paw_raw_recs := $.Raw.GetPawRecs(dids);
    pcnrs_raw_recs := mac_get_payload(lexid, DayBatchPCNSR.Key_PCNSR_DID, did);
    header_raw_recs := mac_get_payload(lexid, dx_header.key_header(), s_did);
    phf_raw_recs := mac_get_payload(lexid, PhonesFeedback.Key_PhonesFeedback_DID, did);
    pp_raw_recs := mac_get_payload(lexid, phonesplus_v2.Key_Phonesplus_Did, l_did);
    pp_royal_raw_recs := mac_get_payload(lexid, phonesplus_v2.Key_Royalty_Did, l_did);
    prof_lic_raw_recs := mac_get_payload(lexid, prof_licensev2.Key_Proflic_Did(), did);
    poe_raw_recs := mac_get_payload(lexid, POE.Keys().did.qa, did);
    poe_email_raw_recs := mac_get_payload(lexid, POEsFromEmails.keys().did.qa, did);
    qsent_raw_recs := mac_get_payload(lexid, Phonesplus.key_qsent_did, l_did);
    qheader_raw_recs := mac_get_payload(lexid, header_quick.key_DID, did);
    schannel_raw_recs := mac_get_payload(lexid, saleschannel.keys().did.qa, did);
    spoke_raw_recs := mac_get_payload(lexid, spoke.keys().did.qa, did);
    targus_raw_recs := mac_get_payload(lexid, targus.Key_Targus_DID, did);
    thrive_raw_recs := mac_get_payload(lexid, thrive.keys().did.qa, did);
    vehicle_ids := $.Raw.GetVehicleIds(dids);
    veh_party_raw_recs := $.Raw.GetVehiclePartyRecs(vehicle_ids);
    veh_main_raw_recs := $.Raw.GetVehicleMainRecs(vehicle_ids);
    zoom_raw_recs := mac_get_payload(lexid, zoom.keys().did.qa, did);

    alloy_recs := doRawCompare(lexid, $.Constants.Collection.ALLOY, collection_report, alloy_raw_recs, date_last_seen);
    asl_recs := doRawCompare(lexid, $.Constants.Collection.ASL, collection_report, asl_raw_recs, date_last_seen);
    deathmaster_recs := doRawCompare(lexid, $.Constants.Collection.DEATH_MASTER, collection_report, death_raw_recs, filedate);
    email_recs := doRawCompare(lexid, $.Constants.Collection.EMAIL, collection_report, email_raw_recs, date_last_seen, email_rec_key);
    gong_recs := doRawCompare(lexid, $.Constants.Collection.GONG, collection_report, gong_raw_recs, dt_last_seen);
    impulse_recs := doRawCompare(lexid, $.Constants.Collection.IMPULSE_EMAIL, collection_report, impulse_raw_recs, datevendorlastreported);
    infutor_recs := doRawCompare(lexid, $.Constants.Collection.INFUTOR, collection_report, infutor_raw_recs, dt_last_seen);
    infutor_cid_recs := doRawCompare(lexid, $.Constants.Collection.INFUTOR_CID, collection_report, infutor_cid_raw_recs, dt_last_seen);
    infutor_narc_recs := doRawCompare(lexid, $.Constants.Collection.INFUTOR_NARC, collection_report, infutor_narc_raw_recs);
    proflic_mari_recs := doRawCompare(lexid, $.Constants.Collection.MARI, collection_report, proflic_mari_raw_recs, date_last_seen);
    oneclick_recs := doRawCompare(lexid, $.Constants.Collection.ONECLICK_DATA, collection_report, oneclick_raw_recs, dt_last_seen);
    paw_recs := doRawCompare(lexid, $.Constants.Collection.PAW, collection_report, paw_raw_recs, dt_last_seen, contact_id);
    pcnrs_recs := doRawCompare(lexid, $.Constants.Collection.PCNRS, collection_report, pcnrs_raw_recs, date_vendor_last_reported);
    header_recs := doRawCompare(lexid, $.Constants.Collection.PERSON_HEADER, collection_report, header_raw_recs, dt_last_seen);
    phf_recs := doRawCompare(lexid, $.Constants.Collection.PHONE_FEEDBACK, collection_report, phf_raw_recs);
    pp_recs := doRawCompare(lexid, $.Constants.Collection.PHONESPLUS, collection_report, pp_raw_recs, datelastseen);
    pp_royal_recs := doRawCompare(lexid, $.Constants.Collection.PHONESPLUS_ROYALTY, collection_report, pp_royal_raw_recs, datelastseen);
    prof_lic_recs := doRawCompare(lexid, $.Constants.Collection.PROF_LICENSE, collection_report, prof_lic_raw_recs, date_last_seen);
    poe_recs := doRawCompare(lexid, $.Constants.Collection.POE, collection_report, poe_raw_recs, dt_last_seen);
    poe_email_recs := doRawCompare(lexid, $.Constants.Collection.POE_FROM_EMAIL, collection_report, poe_email_raw_recs, date_last_seen);
    qsent_recs := doRawCompare(lexid, $.Constants.Collection.QSENT, collection_report, qsent_raw_recs, DateLastSeen);
    qheader_recs := doRawCompare(lexid, $.Constants.Collection.QUICK_HEADER, collection_report, qheader_raw_recs, dt_last_seen);
    schannel_recs := doRawCompare(lexid, $.Constants.Collection.SALES_CHANNEL, collection_report, schannel_raw_recs, date_last_seen);
    spoke_recs := doRawCompare(lexid, $.Constants.Collection.SPOKE, collection_report, spoke_raw_recs, dt_last_seen);
    targus_recs := doRawCompare(lexid, $.Constants.Collection.TARGUS, collection_report, targus_raw_recs, dt_last_seen);
    thrive_recs := doRawCompare(lexid, $.Constants.Collection.THRIVE, collection_report, thrive_raw_recs, dt_last_seen);
    veh_party_recs := doRawCompare(lexid, $.Constants.Collection.VEHICLE_PARTY, collection_report, veh_party_raw_recs, date_last_seen, vehicle_key);
    veh_main_recs := doRawCompare(lexid, $.Constants.Collection.VEHICLE_MAIN, collection_report, veh_main_raw_recs,,vehicle_key);
    zoom_recs := doRawCompare(lexid, $.Constants.Collection.ZOOM, collection_report, zoom_raw_recs, dt_vendor_last_reported);

    mac_output(in_mod, $.Constants.Collection.ALLOY, alloy_recs);
    mac_output(in_mod, $.Constants.Collection.ASL, asl_recs);
    mac_output(in_mod, $.Constants.Collection.DEATH_MASTER, deathmaster_recs);
    mac_output(in_mod, $.Constants.Collection.EMAIL, email_recs);
    mac_output(in_mod, $.Constants.Collection.GONG, gong_recs);
    mac_output(in_mod, $.Constants.Collection.IMPULSE_EMAIL, impulse_recs);
    mac_output(in_mod, $.Constants.Collection.INFUTOR, infutor_recs);
    mac_output(in_mod, $.Constants.Collection.INFUTOR_CID, infutor_cid_recs);
    mac_output(in_mod, $.Constants.Collection.INFUTOR_NARC, infutor_narc_recs);
    mac_output(in_mod, $.Constants.Collection.MARI, proflic_mari_recs);
    mac_output(in_mod, $.Constants.Collection.ONECLICK_DATA, oneclick_recs);
    mac_output(in_mod, $.Constants.Collection.PAW, paw_recs);
    mac_output(in_mod, $.Constants.Collection.PCNRS, pcnrs_recs);
    mac_output(in_mod, $.Constants.Collection.PERSON_HEADER, header_recs);
    mac_output(in_mod, $.Constants.Collection.PHONE_FEEDBACK, phf_recs);
    mac_output(in_mod, $.Constants.Collection.PHONESPLUS, pp_recs);
    mac_output(in_mod, $.Constants.Collection.PHONESPLUS_ROYALTY, pp_royal_recs);
    mac_output(in_mod, $.Constants.Collection.PROF_LICENSE, prof_lic_recs);
    mac_output(in_mod, $.Constants.Collection.POE, poe_recs);
    mac_output(in_mod, $.Constants.Collection.POE_FROM_EMAIL, poe_email_recs);
    mac_output(in_mod, $.Constants.Collection.QSENT, qsent_recs);
    mac_output(in_mod, $.Constants.Collection.SALES_CHANNEL, schannel_recs);
    mac_output(in_mod, $.Constants.Collection.SPOKE, spoke_recs);
    mac_output(in_mod, $.Constants.Collection.TARGUS, targus_recs);
    mac_output(in_mod, $.Constants.Collection.THRIVE, thrive_recs);
    mac_output(in_mod, $.Constants.Collection.VEHICLE_PARTY, veh_party_recs);
    mac_output(in_mod, $.Constants.Collection.VEHICLE_MAIN, veh_main_recs);
    mac_output(in_mod, $.Constants.Collection.ZOOM, zoom_recs);

    output(collection_report_t1, named('collection_report_t1'));
    output(collection_report_t2, named('collection_report_t2'));

    return TRUE;
  end;

  // Runs validation from a test service.
  EXPORT runSVCValidation := FUNCTION
    RETURN doCompare(getParams());
  END;

  // Runs validation from BWR window.
  EXPORT runBWRValidation := FUNCTION

    #WORKUNIT('name', '-- CCPA: Collection Report Validation --');
    gateways := dataset([{'neutralroxie', 'http://roxiestaging.br.seisint.com:9876'}], risk_indicators.layout_gateways_in);
    #STORED('Gateways', gateways);

    RETURN doCompare(getParams());
  END;

end;
