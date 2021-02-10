IMPORT AutoStandardI, doxie, doxie_raw, FCRA, iesp, moxie_phonesplus_server, paw_services, Suppress,
  Prof_LicenseV2, SexOffender, ut, VehicleV2, VehicleV2_Services, Relationship, FFD, Address, Std;

EXPORT search_functions := MODULE

  //This function must exist outside the transform in order for the logging macro to work.
  SHARED get_prof_lic(doxie.layout_references indata, doxie.IDataAccess mod_access) := FUNCTION
    prof_lic_raw := CHOOSEN(Prof_LicenseV2.Key_Proflic_Did()(did = indata.did), 255);
    prof_lic_suppressed := Suppress.MAC_SuppressSource(prof_lic_raw, mod_access);
    RETURN prof_lic_suppressed;
  END;

  SHARED get_motorvehicles (UNSIGNED6 did) := FUNCTION
    vehicles_raw := LIMIT(VehicleV2.Key_Vehicle_DID(KEYED(append_did=did)),UT.Limits.DEFAULT,SKIP);
    vehicles_grp := GROUP (DEDUP (SORT (PROJECT (vehicles_raw, TRANSFORM(VehicleV2_services.Layout_Vehicle_Key,SELF := LEFT)),
                                        Vehicle_Key, Iteration_Key, sequence_key),
                                  vehicle_key,iteration_key,sequence_key),
                           Vehicle_key, Iteration_key);

    vehicle_mod := VehicleV2_Services.IParam.getSearchModule();
    // if desired the limit might be increased to 20000 which will cover all dids except 118 records
    vehicles_res := VehicleV2_Services.raw.get_vehicle_search(vehicle_mod, vehicles_grp);
    RETURN vehicles_res(is_current);
  END;


  //Do not comment out this function or change to Doxie version
  //this version has special data filtering for sex offenders
  SHARED fnSearchWeAlsoFoundData(Doxie.IDataAccess mod_access, DATASET(doxie.layout_references) l) := FUNCTION
      iesp.sexualoffender.t_OffenderAlsoFound append_wealsofound(doxie.layout_references l) := TRANSFORM
        Relationship.Layout_GetRelationship.DIDs_layout prep_did() := TRANSFORM
          SELF.did := l.did;
          SELF := [];
        END;
        did_rec := DATASET ([prep_did()]);
        RelativesAndAssociates := CHOOSEN(Relationship.proc_GetRelationshipNeutral(did_rec,TRUE,TRUE,FALSE,FALSE,ut.limits.DEFAULT,,TRUE).result,500);
        SELF.MotorVehicle := COUNT(get_motorvehicles(l.did));
        SELF.DriversLicense := COUNT((Doxie_Raw.DLV2_Raw_Legacy(DATASET([{l.did}],doxie.layout_references),'')((expiration_date >= (UNSIGNED)Std.Date.Today()-10000 AND history = '') OR expiration_date=0)));
        SELF.PossibleRelatives := COUNT(RelativesAndAssociates(isRelative));
        SELF.PossibleAssociates := COUNT(RelativesAndAssociates(~isRelative));
        SELF.ProfessionalLicense := COUNT(get_prof_lic(l, mod_access));
        SELF.EmploymentRelated := paw_services.PAW_Raw.getPAWcount(l.did, mod_access.glb, mod_access.dppa, 255);
        SELF.Phones := COUNT(moxie_phonesplus_server.phonesplus_did_records(DATASET([{l.did}],doxie.layout_references),
                                          SexOffender_Services.Constants.phoneplus_maxrows,
                                          SexOffender_Services.Constants.phoneplus_score_threshold,
                                          mod_access.glb,
                                          mod_access.dppa,,TRUE).w_timezoneSeenDt);
        SELF := l;
      END;
      wealsofound_records := PROJECT(l,append_wealsofound(LEFT));
    RETURN wealsofound_records;
  END;

  EXPORT fnSearchVal(DATASET(Sexoffender_Services.Layouts.raw_rec) in_recs,
                     SexOffender_Services.IParam.functions_params in_mod,
                     BOOLEAN isFCRA = FALSE,
                     DATASET(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
                     DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
                     INTEGER8 inFFDOptionsMask = 0) := FUNCTION


    mod_access := PROJECT(in_mod, doxie.IDataAccess);

    // Used to replace spaces in date strings with zeroes so cast to integer works Ok,
    // since some dates only contain a yyyy or a yyyymm.
    fixed_date(STRING8 dtin) := STD.Str.FindReplace(dtin, ' ', '0');

    // Location Value
    lv := AutoStandardI.InterfaceTranslator.location_value.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.location_value.params));

    //******** spkpublic (offender) key file transform for AKA data
    iesp.share.t_Name spk_file_xform2(SexOffender_Services.Layouts.raw_rec l) := TRANSFORM
      SELF := iesp.ECL2ESP.setName(l.fname, l.mname, l.lname, l.name_suffix, '')
    END;


    //******** enhpublic key file transform for Alternate Address data
    key_enh := SexOffender.Key_SexOffender_SPK_Enh (isFCRA);
    iesp.sexualoffender.t_OffenderAddress enh_file_xform(key_enh l) := TRANSFORM
       SELF.AddressType := l.alt_type,
       // The alt_addr_dt_last_seen field used below is integer3 and just contains a yyyymm.
       // So it is multiplied by 100 to shift it left which will put "00" in the day
       // portion of the date.
       SELF.DateLastSeen := iesp.ECL2ESP.toDate ((INTEGER4) l.alt_addr_dt_last_seen*100),
       SELF.Address := iesp.ECL2ESP.setAddress(l.alt_prim_name, l.alt_prim_range, l.alt_predir, l.alt_postdir,
                                               l.alt_suffix, l.alt_unit_desig, l.alt_sec_range, l.alt_city_name,
                                               l.alt_st, l.alt_zip, l.alt_zip4, '');
    END;

    //******** Offenses key file transform for Conviction data
    //Added FFD
    iesp.sexualoffender_fcra.t_FcraSexOffReportConviction offenses_file_xform(SexOffender_Services.Layouts.rec_offense_raw l) := TRANSFORM
      SELF.ConvictionJurisdiction := l.conviction_jurisdiction,
      SELF.ConvictionDate := iesp.ECL2ESP.toDate ((INTEGER4) l.conviction_date),
      SELF.CourtName := l.court,
      SELF.CourtCaseNumber := l.court_case_number,
      SELF.OffenseDate := iesp.ECL2ESP.toDate ((INTEGER4) l.offense_date),
      SELF.OffenseCodeOrStatute := l.offense_code_or_statute,
      SELF.OffenseDescription := l.offense_description + ' ' + l.offense_description_2,
      SELF.OffenseCategory := (STRING)l.offense_category;
      SELF.VictimIsMinor := IF (l.victim_minor='Y',TRUE, FALSE),
      SELF.VictimIsMinor2 := l.victim_minor,
      SELF.VictimAge := (INTEGER) l.victim_age,
      SELF.VictimGender := l.victim_gender,
      SELF.VictimRelationship := l.victim_relationship,
      SELF.SentenceDescription := l.sentence_description + ' ' + l.sentence_description_2,
      SELF.StatementIDs := l.StatementIDs,
      SELF.IsDisputed := l.isDisputed,
    END;

    // Compute distance between two lat/long pairs, and return as a string to the nearest
    // hundredth of a mile. If either coordinate is invalid, just return the empty string.
    STRING validDist(real lat1, real long1, real lat2, real long2) := IF(
      (lat1<>0.0 OR long1<>0.0) AND (lat2<>0.0 OR long2<>0.0),
      TRIM(realformat(ut.LL_Dist(lat1, long1, lat2, long2),10,2),ALL),
      '');

    // **************** MAIN TRANSFORM ****************
    //******** Offender file transform
    SexOffender_Services.Layouts.t_OffenderRecord_plus spk_file_xform(SexOffender_Services.Layouts.raw_rec l) := TRANSFORM
      SELF._penalty := l.penalt,
      SELF.AlsoFound := l.isDeepDive,
      SELF.PrimaryKey := l.seisint_primary_key,
      SELF.UniqueId := IF(l.did=0,'',INTFORMAT(l.did,12,1)),
      SELF.SSN := l.ssn_appended,
      // For some reason moxie outputs 'R' in RecordType for all records.
      // According to Lee Lindquist on 02/19/09, R=Regular and it's on every returned record.
      // The sex_offender base & key files have values = S, F, H, etc. and will be
      // returned below.
      SELF.RecordType := l.record_type,
      SELF.OffenderStatus := l.offender_status,
      SELF.OriginalState := l.orig_state,
      SELF.OriginStateCode := l.orig_state_code,
      SELF.ScarsMarksTattoos := l.scars_marks_tattoos,
      SELF.DateFirstSeen := iesp.ECL2ESP.toDate ((INTEGER4) l.dt_first_reported),
      SELF.DateLastSeen := iesp.ECL2ESP.toDate ((INTEGER4) l.dt_last_reported),
      SELF.DateOffenderLastUpdated := iesp.ECL2ESP.toDateYM ((INTEGER4) l.addr_dt_last_seen),
      SELF.DOB := iesp.ECL2ESP.toDate ((INTEGER4) fixed_date(l.dob)),
      calculatedAge := IF (TRIM(l.dob) = '', '', (STRING)ut.Age((UNSIGNED)l.dob));//Calculate Age
      SELF.Age := calculatedAge;
      SELF.Name := iesp.ECL2ESP.SetName(l.fname, l.mname, l.lname, l.name_suffix, ''),

      SELF.Address := iesp.ECL2ESP.SetAddress(l.prim_name, l.prim_range, l.predir,
                                              l.postdir, l.addr_suffix, l.unit_desig,
                                              l.sec_range, l.v_city_name,l.st, l.zip5, l.zip4, ''),

      // Lat/Long and radius search info (when available)
      SELF.Location := ROW({ l.geo_lat, l.geo_long, l.geo_match, Address.geo_desc(l.geo_match) }, iesp.share.t_GeoLocationMatch);
      SELF.SearchAroundDistance := validDist(lv.latitude, lv.longitude, (real)l.geo_lat, (real)l.geo_long);

      SELF.ImageLink := l.image_link,

      // AddressType not in moxie/prod results and marked as hidden[internal] in iesp.sexualoffender.
      // For a spk, the address on the key spkpublic file that matches the address on the
      // key enhpublic (alternate addresses) file has a alt_type=S on the
      // key enhpublic (alternate addresses) file.
      SELF.AddressType := 'S',

      ds_spk := DATASET([{l.seisint_primary_key, l.isDeepDive}], SexOffender_Services.Layouts.search);
      offenses := SexOffender_Services.Raw.GetRawOffenses(ds_spk, isFCRA, flagfile, slim_pc_recs, inFFDOptionsMask);
      INTEGER categoryInput := (INTEGER)in_mod.offenseCategory;
      categoryPenalty := IF (COUNT(offenses(offense_category & categoryInput = categoryInput)) > 0 OR categoryInput = 0, 0, 10);

      SELF.SecondaryPenalty := l.penalt_osmt + categoryPenalty;

      // Sort Convictions by Conviction-Date reverse chron (descending)
      SELF.Convictions := IF(in_mod.include_offenses,SORT(PROJECT(offenses,
                                       offenses_file_xform(LEFT)),
                               -ConvictionDate)),
      // For AKA data, use a project to do a keyed look up against the Key SPK (Offender)
      // file using the seisint primary key and also matching on the name_type not = '0'
      // (name_type=0 is the main name, not an AKA).
      // Then sort the AKAs by last, first & middle; then dedup on those fields as well.
      // Because some records with duplicate names were found when running stats.
      // i.e. see sspk=C2IL1571413 in thor_data400::key::sexoffender::yyyymmdd::spkpublic
      // Then use a "choosen" to limit the total AKA records returned to 75.
      // (see SEXOFF_MAX_COUNT_AKAS in iesp.Constants.)
      aka_recs := SexOffender_Services.Raw.GetRawOffenders(ds_spk,,isFCRA, flagfile);
      SELF.AKAs := CHOOSEN(DEDUP(SORT(PROJECT(aka_recs(name_type <>'0'),
                                             spk_file_xform2(LEFT)),
                                     Last,First,Middle,Suffix),
                                RECORD),
                          iesp.Constants.SEXOFF_MAX_COUNT_AKAS),

      // For Alt address data, use a project to do a keyed look up against the key
      // enhpublic file using the seisint primary key and also matching on the alt_type,
      // depending upon the input Include* switches.
      // Then sort on: address_type, datelastseen, State, City, Zip, Street Name,
      // predir, postdir, Street Number.
      // Max actual count of all address types for 1 spk = 1169 (sspk=C2TX1867828; W20090218-101551 on dev)
      // of which all 1169 are unique.
      // NOTE: The logic below was modeled after doxie/sexoffender_search_people_local xtra_addresses JOIN
      SELF.AlternativeAddresses := CHOOSEN(DEDUP(SORT(
                                    PROJECT(key_enh(
                                            KEYED(l.seisint_primary_key = sspk) AND
                                            ~isFCRA AND //currently we are NOT supporting the options for using SPK_Enh key for FCRA
                                            ((in_mod.include_regaddrs AND alt_type='S') OR
                                             (in_mod.include_histaddrs AND alt_type='H') OR
                                             (in_mod.include_assocaddrs AND alt_type='R') OR
                                             (in_mod.include_unregaddrs AND
                                              sexoffender.std_offender_status(
                                                    l.offender_status) NOT IN ['C','D'] AND
                                              alt_type NOT IN ['S','H','R']))
                                           ),
                                           enh_file_xform(LEFT)),
                                                       //sort order
                                                       -AddressType,
                                                       -DateLastSeen,
                                                       address.state,
                                                       address.city,
                                                       address.zip5,
                                                       address.streetname,
                                                       address.streetpredirection,
                                                       address.streetpostdirection,
                                                       address.streetnumber,
                                                       address.unitdesignation),
                                                  // dedup on record
                                                  RECORD),
                                            // choosen limit
                                            iesp.Constants.SEXOFF_MAX_COUNT_ALT_ADDRESSES),

      // Store additional fields that are not returned in the final results,
      // but are needed for alert hash calculation.
      // For the extra fields, the field names used on the t_OffenderRecord_plus is
      // the same as the same on key spkpublic file, so the line below will pick all
      // of them up.
      SELF.BestAddress := l.bestaddress,
      SELF.BestAddrLocation := l.bestlocation,
      //Do we want to allow WeAlsoFound Data for FCRA...? if so we would need FCRA keys for each of these MotorVehicle, DriversLicense, Relatives, ProfessionalLicense, PAW, PhonesPlus
      SELF.WeAlsoFound := IF(~isFCRA AND in_mod.include_wealsofound,fnSearchWeAlsoFoundData(mod_access, DATASET([{(UNSIGNED)l.did}],doxie.layout_references))[1]);
      SELF.PhysicalCharacteristics := ROW({calculatedAge, l.race, l.ethnicity, l.height, l.weight, l.scars_marks_tattoos}, iesp.sexualoffender.t_PhysicalCharacteristics);
      SELF.StatementIDs := l.StatementIDs;
      SELF.isDisputed := l.isDisputed;
    END;

    best_data := SexOffender_Services.Raw.GetBestAddressRec(in_recs, mod_access);
    in_recs_with_best := JOIN(in_recs, best_data,
                             LEFT.did = RIGHT.did,
                             TRANSFORM(SexOffender_Services.Layouts.raw_rec,
                                        SELF.BestAddress := RIGHT.BestAddress,
                                        SELF.BestLocation := RIGHT.BestLocation,
                                        SELF := LEFT),
                             LEFT OUTER, KEEP(1), LIMIT(0));
    recs_out := IF(in_mod.include_bestaddress AND ~isFCRA, in_recs_with_best, in_recs);

    // NOTE: Passed-in in_recs contains 1 record for each spk to be returned.
    recs_fmtd := PROJECT(recs_out, spk_file_xform(LEFT));

    RETURN(recs_fmtd);

  END;
END;
