IMPORT $, alerts, Bankruptcyv2_services, liensv2_services, LN_PropertyV2_Services,
       UCCv2_Services, VehicleV2_Services, WatercraftV2_services;

EXPORT alert_calcs(BOOLEAN curVersion = TRUE) := MODULE

  // shorter names
  SHARED layout_hashval := alerts.layouts.layout_hashval;
  SHARED layout_report_hash := alerts.layouts.layout_report_hash;
  SHARED layout_report_hashes := alerts.layouts.layout_report_hashes;
  
  // version numbers
  SHARED UNSIGNED1 nameHashVersion := 1;
  SHARED UNSIGNED1 addressHashVersion := 1;
  SHARED UNSIGNED1 assetHashVersion := 1;
  SHARED UNSIGNED1 licenseHashVersion := 1;
  SHARED UNSIGNED1 corpHashVersion := 1;
  
  // commoned up code for Functions below
  SHARED processReportAlerts(ds, trans, ver) := MACRO
    hashvals := PROJECT(ds, trans(LEFT));
    RETURN DATASET([{ver, SUM(hashvals,hashval)}], layout_report_hash);
  ENDMACRO;

  // hash calculation logic for each particular data type

  //
  // Best Info hashes
  //
  layout_hashval calcNameHashVals($.layouts.best_info_record l) := TRANSFORM
    SELF.hashval := HASH64((>data<)l.company_name);
  END;

  DATASET(layout_report_hash) calcNameHashes(DATASET($.layouts.best_info_record) recs) := FUNCTION
    processReportAlerts(recs,calcNameHashVals,nameHashVersion)
  END;

  layout_hashval calcAddressHashVals($.layouts.best_info_record l) := TRANSFORM
    SELF.hashval := HASH64((>data<)l.prim_range, l.predir,(>data<)l.prim_name,(>data<)l.addr_suffix,l.postdir,(>data<)l.sec_range,
                           (>data<)l.city,l.state,l.zip);
  END; // predir, postdir, state, zip are regular strings, all others qstrings.
  
  DATASET(layout_report_hash) calcAddressHashes(DATASET($.layouts.best_info_record) recs) := FUNCTION
    processReportAlerts(recs,calcAddressHashVals,addressHashVersion)
  END;

  //
  // Asset Hashes
  //
  layout_hashval calcAircHashVals($.layouts.faa_record l) := TRANSFORM
    // waiting for final instructions from content council
    SELF.hashval := HASH64(l.n_number,l.serial_number,l.name,l.street,l.street2,l.city,l.state,l.zip_code);
  END; // no fields of qstring type

  // WatercraftV2_Services.Layouts
  layout_hashval calcBoatOwnerHashes(WatercraftV2_services.Layouts.owner_report_rec l) := TRANSFORM
    SELF.hashval := HASH64(l.orig_address_1,l.orig_address_2,l.orig_name,l.orig_fein,l.orig_ssn);
  END; // no fields of qstring type

  layout_hashval calcBoatHashVals($.layouts.watercraft_record l) := TRANSFORM
    SELF.hashval := HASH64(l.hull_number) + SUM(PROJECT(l.owners, calcBoatOwnerHashes(LEFT)), hashval);
  END; // no fields of qstring type
  
  layout_hashval calcMVROwnerHashes(VehicleV2_services.Layout_vehicle_party_out.layout_vehicle_party_owner l) := TRANSFORM
    SELF.hashval := HASH64(l.fname,l.mname,l.lname,l.prim_range,l.prim_name,l.sec_range,l.v_city_name,l.st,l.zip5);
  END; // no fields of qstring type

  layout_hashval calcMVRRegistrantHashes(VehicleV2_services.Layout_vehicle_party_out.layout_vehicle_party_registrant l) := TRANSFORM
    SELF.hashval := HASH64(l.fname,l.mname,l.lname,l.prim_range,l.prim_name,l.sec_range,l.v_city_name,l.st,l.zip5);
  END; // no fields of qstring type

  layout_hashval calcMVRHashVals($.layouts.mvr_record_v2 l) := TRANSFORM
    l_owners := PROJECT(l.owners, TRANSFORM(VehicleV2_services.Layout_vehicle_party_out.layout_vehicle_party_owner,
                                            SELF.append_did := (INTEGER)LEFT.append_did,
                                            SELF.append_bdid := (INTEGER)LEFT.append_bdid,
                                            SELF := LEFT));
    l_registrants := PROJECT(l.registrants, TRANSFORM(VehicleV2_services.Layout_vehicle_party_out.layout_vehicle_party_registrant,
                                            SELF.append_did := (INTEGER)LEFT.append_did,
                                            SELF.append_bdid := (INTEGER)LEFT.append_bdid,
                                            SELF := LEFT));
    SELF.hashval := HASH64(l.vin) +
                    SUM(PROJECT(l_owners, calcMVROwnerHashes(LEFT)),hashval) +
                    SUM(PROJECT(l_registrants, calcMVRRegistrantHashes(LEFT)),hashval);
  END; // no fields of qstring type

  DATASET(layout_report_hash) calcAssetHashes(DATASET($.layouts.faa_record) airc,
                                              DATASET($.layouts.watercraft_record) boats,
                                              DATASET($.layouts.mvr_record_v2) vehicles) := FUNCTION
    hashvals := PROJECT(airc, calcAircHashVals(LEFT)) +
                PROJECT(boats, calcBoatHashVals(LEFT)) +
                PROJECT(vehicles, calcMVRHashVals(LEFT));
    res := DATASET([{assetHashVersion, SUM(hashvals,hashval)}], layout_report_hash);
    RETURN res;
  END;

  //
  // License Hashes
  //
  // Prof_License.layout_proflic_out
  layout_hashval calcProLicHashVals($.layout_proflic.slim_rec l) := TRANSFORM
    // waiting for final instructions from content council
    SELF.hashval := HASH64(l.orig_license_number,l.status,l.company_name,l.orig_name,
                           l.orig_addr_1,l.orig_addr_2,l.orig_addr_3,l.orig_addr_4,
                           l.orig_city,l.orig_st,l.orig_zip);
  END; // no fields of qstring type

  DATASET(layout_report_hash) calcLicenseHashes(DATASET($.layout_proflic.slim_rec) prolic) := FUNCTION
    hashvals := PROJECT(prolic,calcProLicHashVals(LEFT));
    res := DATASET([{licenseHashVersion, SUM(hashvals,hashval)}], layout_report_hash);
    RETURN res;
  END;
  
  // Corp Hashes
  // Corp2_services.layout_corps_out
  layout_hashval calcProfileHashVals($.layouts.profile_record l) := TRANSFORM
    SELF.hashval := HASH64(l.corp_legal_name,l.corp_status_desc);
  END; // no fields of qstring type

  // doxie_cbrs.registered_agents_records
  layout_hashval calcRegAgentHashVals($.layouts.registered_agent_record l) := TRANSFORM
    SELF.hashval := HASH64(l.corp_ra_name,(>data<)l.prim_range,l.predir,(>data<)l.prim_name,l.postdir,(>data<)l.sec_range,(>data<)l.city,l.state,(>data<)l.zip);
  END; // corp_ra_name, predir, postdir, state are regular strings; all others qstrings.

  DATASET(layout_report_hash) calcCorpHashes(DATASET($.layouts.profile_record) pr,
                                             DATASET(RECORDOF($.layouts.registered_agent_record)) ra) := FUNCTION
    hashvals := PROJECT(pr, calcProfileHashVals(LEFT)) +
                PROJECT(ra, calcRegAgentHashVals(LEFT));
    res := DATASET([{corpHashVersion, SUM(hashvals,hashval)}], layout_report_hash);
    RETURN res;
  END;
  
  EXPORT layout_report_hashes calcHashes($.layout_report l) := TRANSFORM
    SELF.name_hashes := calcNameHashes(l.best_information);
    SELF.address_hashes := calcAddressHashes(l.best_information);

    // as each underlying source is re-written, replace with calls to appropriate alert modules
    SELF.asset_hashes := calcAssetHashes(l.aircrafts, l.watercrafts,l.motor_vehicles_v2);
    SELF.prop_hashes := LN_PropertyV2_Services.alert.report_alerts(LN_PropertyV2_Services.resultFmt.widerOutToNarrowOut(l.property_V2));
    SELF.license_hashes := calcLicenseHashes(l.professional_licenses);
                                             //l.concealed_weapon_licenses_children
                                             //l.pilot_certificates_children,
                                             
    SELF.bkrp_hashes := BankruptcyV2_Services.alert.report_alerts(l.bankruptcy_v2);
    SELF.ucc_hashes := UCCV2_Services.alert.report_alerts(l.liens_judgments_v2[1].uccs);
    SELF.lien_hashes := LiensV2_Services.alert.report_alerts(l.liens_judgments_v2[1].judgment_liens);
    SELF.corp_hashes := calcCorpHashes(l.Profile_Information, l.Registered_Agents);
    SELF := [];
  END;

END;
