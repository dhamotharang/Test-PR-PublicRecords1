IMPORT AutoStandardI,doxie,SexOffender,Suppress,iesp,ut,AID_Build,
       FCRA, BatchServices, FFD, Std, Address;

EXPORT Raw := MODULE
  EXPORT byDIDs(DATASET(SexOffender_Services.layouts.search_did) in_dids,
                BOOLEAN isFCRA = FALSE) := FUNCTION
      deduped := DEDUP(SORT(in_dids,did),did);
      joinup := JOIN(deduped,SexOffender.Key_SexOffender_DID (isFCRA),
                     KEYED(LEFT.did=RIGHT.did),
                  TRANSFORM(SexOffender_Services.layouts.search,
                              SELF := LEFT,
                  SELF := RIGHT),
                  LIMIT(SexOffender_Services.Constants.MAX_RECS_PERDID,SKIP));
      RETURN joinup;
  END;

  EXPORT getDIDsbySPK(DATASET(SexOffender_Services.layouts.search) in_spks,
                      BOOLEAN isFCRA = FALSE) := FUNCTION
      deduped := DEDUP(SORT(in_spks,seisint_primary_key),seisint_primary_key);
      joinup := JOIN(deduped,SexOffender.Key_SexOffender_SPK (isFCRA),
                     KEYED(LEFT.seisint_primary_key=RIGHT.sspk),
                     TRANSFORM(SexOffender_Services.layouts.search_did,
                         SELF := RIGHT),
                         LIMIT(SexOffender_Services.Constants.MAX_RECS_PERSSPK,SKIP));
      RETURN joinup;
  END;
  
  EXPORT GetRawOffenders(DATASET(SexOffender_Services.layouts.search) in_spks,
                         STRING32 ApplicationType = '',
                         BOOLEAN isFCRA = FALSE,
                         DATASET(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
                         DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
                         INTEGER8 inFFDOptionsMask = 0) := FUNCTION
                         
      BOOLEAN showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
      BOOLEAN showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);

      ds_flags := flagfile(file_id = FCRA.FILE_ID.SO_MAIN);
      so_correct_rec_id := SET(ds_flags, record_id);
      so_key := SexOffender.key_SexOffender_SPK(isFCRA);
      
      deduped := DEDUP(SORT(in_spks,seisint_primary_key),seisint_primary_key);
       
      recs1 := JOIN(deduped,so_key,
                     KEYED(LEFT.seisint_primary_key=RIGHT.sspk)
                     AND (~isFCRA OR (STRING)RIGHT.offender_persistent_id NOT IN so_correct_rec_id),
                     TRANSFORM(SexOffender_Services.Layouts.raw_rec,
                         SELF := LEFT,
                         SELF := RIGHT,
                         SELF.bestaddress := [], SELF.bestlocation := []),
                         LIMIT(SexOffender_Services.Constants.MAX_RECS_PERSSPK,SKIP));
      
      //overrides
      recs_over := JOIN(ds_flags, FCRA.key_override_sexoffender.so_main,
                        KEYED(LEFT.flag_file_id = RIGHT.flag_file_id),
                        TRANSFORM(SexOffender_Services.Layouts.raw_rec,SELF := RIGHT, SELF.bestaddress := [], SELF.bestlocation := []),
                        LIMIT(0), KEEP(1));
      recs_override_final := JOIN(recs_over, in_spks,
                                  LEFT.seisint_primary_key = RIGHT.seisint_primary_key,
                                  TRANSFORM(SexOffender_Services.Layouts.raw_rec, SELF.acctno := RIGHT.acctno, SELF := LEFT), LIMIT(0), KEEP(1)); //we only want to KEEP the overrides that were IN the original search records
      
      recs_fcra := (recs1 + recs_override_final) (FCRA.crim_is_ok((STRING8)Std.Date.Today(), fcra_date, fcra_conviction_flag, fcra_traffic_flag));
      
      //*****************FFD***************************************************************************************************
      SexOffender_Services.Layouts.raw_rec xformStatements( SexOffender_Services.Layouts.raw_rec l,
                                                            FFD.Layouts.PersonContextBatchSlim r ) := TRANSFORM,
      SKIP((~ShowDisputedRecords AND r.isDisputed) OR (~ShowConsumerStatements AND EXISTS(r.StatementIDs)))
        SELF.StatementIDs := r.StatementIds;
        SELF.IsDisputed := r.isDisputed;
        SELF := l;
      END;
      
      recs_fcra_ds := JOIN(recs_fcra, slim_pc_recs,
        LEFT.offender_persistent_id = (UNSIGNED8)RIGHT.RecID1 AND
        ((LEFT.acctno = RIGHT.acctno) OR
        (RIGHT.acctno = FFD.Constants.SingleSearchAcctno))AND
          RIGHT.DataGroup = FFD.Constants.DataGroups.SO_MAIN,
        xformStatements(LEFT,RIGHT),
        LEFT OUTER,
        KEEP(1),
        LIMIT(0));
      
      recs := IF(isFCRA, recs_fcra_ds, recs1);
      
      doxie.MAC_Filter_SexOffender(ApplicationType, recs, recs_final);
      
      RETURN recs_final;
  END;
  
  EXPORT GetRawOffenses(DATASET(SexOffender_Services.Layouts.search) in_spks,
                        BOOLEAN isFCRA = FALSE,
                        DATASET(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
                        DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
                        INTEGER8 inFFDOptionsMask = 0) := FUNCTION
                        
      BOOLEAN showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
      BOOLEAN showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);

      ds_flags := flagfile(file_id = FCRA.FILE_ID.SO_OFFENSES);
      so_correct_rec_id := SET(ds_flags, record_id);
      offenses_key := SexOffender.Key_SexOffender_offenses(isFCRA);
            
      recs1 := JOIN(in_spks,offenses_key,
                     KEYED(LEFT.seisint_primary_key=RIGHT.sspk)
                     AND (~isFCRA OR (STRING)RIGHT.offense_persistent_id NOT IN so_correct_rec_id),
                     TRANSFORM(SexOffender_Services.Layouts.rec_offense_raw, SELF.acctno := LEFT.acctno, SELF := RIGHT),
                         LEFT OUTER, LIMIT(SexOffender_Services.Constants.MAX_OFFENSES_PERSSPK,SKIP));
                                        
      //overrides
      recs_over := JOIN(ds_flags, FCRA.key_override_sexoffender.so_offenses,
        KEYED(LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(sexOffender_Services.Layouts.rec_offense_raw, //offense key layout
                  SELF := RIGHT),
        LIMIT(0), KEEP(1));

      recs_override_final := JOIN(recs_over, in_spks,
        LEFT.seisint_primary_key = RIGHT.seisint_primary_key,
        TRANSFORM(sexOffender_Services.Layouts.rec_offense_raw, 
          SELF.acctno := RIGHT.acctno, SELF := LEFT), 
        LIMIT(0), KEEP(1)); //we only want to KEEP the overrides that were IN the original search records

      recs_fcra := (recs1 + recs_override_final) (FCRA.crim_is_ok((STRING8)Std.Date.Today(), fcra_date, fcra_conviction_flag, fcra_traffic_flag));
      
      //***************************************FFD****************************************************
      SexOffender_Services.Layouts.rec_offense_raw xformStatements( SexOffender_Services.Layouts.rec_offense_raw l,
                                                                FFD.Layouts.PersonContextBatchSlim r ) := TRANSFORM,
      SKIP((~ShowDisputedRecords AND r.isDisputed) OR (~ShowConsumerStatements AND EXISTS(r.StatementIDs)))
          SELF.StatementIDs := r.StatementIds;
          SELF.IsDisputed := r.isDisputed;
          SELF := l;
      END;
      
      recs_fcra_ds := JOIN(recs_fcra, slim_pc_recs,
        LEFT.offense_persistent_id = (UNSIGNED8)RIGHT.RecID1 AND
        ((LEFT.acctno = RIGHT.acctno) OR
          (RIGHT.acctno = FFD.Constants.SingleSearchAcctno)) AND
          RIGHT.DataGroup = FFD.Constants.DataGroups.SO_OFFENSES,
          xformStatements(LEFT,RIGHT),
          LEFT OUTER,
          KEEP(1),
          LIMIT(0));
      
      recs_final := IF(isFCRA, recs_fcra_ds, recs1);

      RETURN recs_final;
  END;

  SHARED bestAddressInfo := RECORD
    doxie.layout_best_ext.did;
    doxie.layout_best_ext.RawAID;
    iesp.sexualoffender.t_OffenderBestAddress bestaddress;
    iesp.share.t_GeoLocationMatch bestlocation;
  END;
  
  EXPORT GetBestAddressRec(DATASET(SexOffender_Services.Layouts.raw_rec) in_raw, doxie.IDataAccess mod_access) := FUNCTION
    
      glb_ok := mod_access.isValidGlb();
      dppa_ok := mod_access.isValidDppa();
      in_dids := DEDUP(SORT(PROJECT(in_raw, doxie.layout_references), did), did);
      doxie.mac_best_records(in_raw, did, best_recs, dppa_ok, glb_ok, FALSE, mod_access.DataRestrictionMask,,,doxie.layout_best_ext);
      
      bestAddressInfo xform1(SexOffender_Services.Layouts.raw_rec l, doxie.layout_best_ext r):=TRANSFORM
        SELF.bestaddress.AddressType := SexOffender_Services.Constants.address_type;
        SELF.bestaddress.DateLastSeen := iesp.ECL2ESP.toDateYM ((INTEGER4) r.addr_dt_last_seen);
        scz := SexOffender_Services.Functions.stateCityZipValue(r.city_name, r.st, r.zip);
        SELF.bestaddress.Address := iesp.ECL2ESP.SetAddress (r.prim_name, r.prim_range, r.predir, r.postdir,
          r.suffix, r.unit_desig, r.sec_range, r.city_name,
          r.st, r.zip, r.zip4, '', '',
          SexOffender_Services.Functions.streetAddress1Value(r.prim_name, r.prim_range, r.predir, r.suffix, r.postdir),
          scz, scz);
        //self.bestlocation := row({ r.geo_lat, r.geo_long, r.geo_match, ut.geo_desc(r.geo_match) }, iesp.share.t_GeoLocationMatch),
        SELF.bestaddress.bestaddressisnewer := SexOffender_Services.Functions.fnBestIsNewer(l.dt_last_reported,l.addr_dt_last_seen,(STRING)r.addr_dt_last_seen),
        SELF.bestaddress.bestaddressisdifferent := SexOffender_Services.Functions.fnBestIsDifferent(l.prim_name, l.prim_range, l.predir, l.postdir, 
          l.addr_suffix, l.unit_desig, l.sec_range,
          l.st, l.p_city_name, l.zip5, l.zip4,
          r.prim_name, r.prim_range, r.predir, r.postdir, r.suffix, r.unit_desig, r.sec_range,
          r.st, r.city_name, r.zip, r.zip4);
        SELF.did := l.did;
        SELF.RawAID := r.RawAID;
        SELF.bestlocation := [];
      END;
      
      best_data := JOIN(in_raw, best_recs,
        LEFT.did = RIGHT.did,
        xform1(LEFT, RIGHT),
        KEEP(1), LIMIT(0), LEFT OUTER);
      
      bestAddressInfo xform2(bestAddressInfo l, AID_Build.Key_AID_Base r):=TRANSFORM
        SELF.bestlocation := ROW({ r.geo_lat, r.geo_long, r.geo_match, Address.geo_desc(r.geo_match) }, iesp.share.t_GeoLocationMatch),
        SELF := l
      END;
      
      best_data_final := JOIN(best_data, AID_Build.Key_AID_Base,
                              KEYED(LEFT.rawaid=RIGHT.rawaid),
                              xform2(LEFT,RIGHT),
                              KEEP(1), LIMIT(0), LEFT OUTER);
      
      RETURN best_data_final;
  END;
  
  
  // ==========================================================================
  // Returns records of Sex offender data in search view
  // ==========================================================================
  EXPORT SEARCH_VIEW := MODULE
    SHARED getParsedWord(STRING wordsStream) := FUNCTION
      rs := RECORD
        STRING200 line;
      END;
      ds := DATASET([{wordsStream}], rs);

      PATTERN Alpha := PATTERN('[A-Za-z]');
      PATTERN word := Alpha+;
      PATTERN compound := PATTERN('"[^"\r\n]*"');

      RULE NounPhraseComponent3 := word | compound;


      ps3 := RECORD
        out1 := MATCHTEXT(NounPhraseComponent3);
      END;

      p3 := PARSE(ds, line, NounPhraseComponent3, ps3, BEST, MANY);

      noQuotes := PROJECT (p3 , TRANSFORM(RECORDOF(P3),
        SELF.OUT1 := STD.Str.Filter(STD.Str.ToUpperCase(LEFT.out1), ' -0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
      ));

      distinct := DEDUP(noQuotes, out1, ALL);
      RETURN distinct;
    END;
    
    //Returns records for Seisint Primary Keys
    EXPORT bySPK (DATASET (SexOffender_Services.layouts.search) in_spks,
                  SexOffender_Services.IParam.search in_mod,
                  BOOLEAN isFCRA = FALSE,
                  DATASET(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
                  DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim
                  ) := FUNCTION
          
      ds_raw_offenders := GetRawOffenders(in_spks, in_mod.application_type, isFCRA, flagfile, slim_pc_recs, in_mod.FFDOptionsMask);
      
      //this affects penalty calculation. when the address is just the center of a circle instead of a target, you dont want to penalize on street, etc.
      BOOLEAN SearchAroundAddress_value := AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.val(
          PROJECT(in_mod,AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.params))
          OR in_mod.zip_only_search;
      // Calculate the penalty on the records
      parsedSmt := getParsedWord(in_mod.SmtWords);
      smtSearchCount := COUNT(parsedSmt);
      
      recs_plus_pen := PROJECT(ds_raw_offenders,TRANSFORM(SexOffender_Services.Layouts.raw_rec,
        tempindvmod := MODULE(PROJECT(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,OPT))
          EXPORT allow_wildcard := FALSE;
          EXPORT fname_field := LEFT.fname;
          EXPORT mname_field := LEFT.mname;
          EXPORT lname_field := LEFT.lname;
          EXPORT prange_field := LEFT.prim_range;
          EXPORT predir_field := LEFT.predir;
          EXPORT pname_field := LEFT.prim_name;
          EXPORT suffix_field := LEFT.addr_suffix;
          EXPORT postdir_field := LEFT.postdir;
          EXPORT sec_range_field := LEFT.sec_range;
          EXPORT city_field := LEFT.p_city_name;
          EXPORT city2_field := LEFT.v_city_name;
          // Need to account for when addr state not = orig state code and
          // orig state code matches what is being searched on;
          // then orig state code should be used so penalty value is set properly.
          EXPORT state_field := IF (LEFT.st<>LEFT.orig_state_code OR
                                    LEFT.orig_state_code='',
                                    IF(LEFT.orig_state_code=in_mod.state,
                                      LEFT.orig_state_code,LEFT.st),
                                    LEFT.st);
          EXPORT zip_field := LEFT.zip5;
          EXPORT ssn_field := LEFT.ssn_appended;
          EXPORT did_field := (STRING) LEFT.did;
          EXPORT dob_field := LEFT.dob;
          // set fields not input to null
          EXPORT phone_field := '';
          EXPORT county_field := '';
        END;
        tempPenaltIndv := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempindvmod);
        // if its deepdive or FCRA, don't apply the penalty
        SELF.penalt := IF (SearchAroundAddress_value OR isFCRA, 0, tempPenaltIndv);
        smtField := LEFT.scars_marks_tattoos;
        // for each word in the scars_marks_tattoos input field that are now stored in
        // parsedSmt will try to match in the scars_marks_tattoos in the result dataset.
        result := PROJECT(parsedSmt, TRANSFORM({STRING200 word, STRING200 field, BOOLEAN match},
          SELF.word := LEFT.out1;
          SELF.field := smtField;
          SELF.match := STD.Str.Find(TRIM(SMTfield), TRIM(LEFT.out1), 1) > 0;));
        // Scars marks and tattos penalty is the number of words search minus the
        // number of words found in the record.
        SELF.penalt_osmt := smtSearchCount - COUNT(result(match)) ;
        SELF := LEFT));

      // ***** DID & SSN pulling and suppression ****
      Suppress.MAC_Suppress(recs_plus_pen,dids_pulled,in_mod.application_type,Suppress.Constants.LinkTypes.DID,did, isFCRA := isFCRA);
      // pull, prune & suppress ssns twice, once for ssn_appended & once for ssn
      Suppress.MAC_Suppress(dids_pulled,ssns_pulled1,in_mod.application_type,Suppress.Constants.LinkTypes.SSN,ssn_appended, isFCRA := isFCRA);
      Suppress.MAC_Suppress(ssns_pulled1,ssns_pulled2,in_mod.application_type,Suppress.Constants.LinkTypes.SSN,ssn, isFCRA := isFCRA);
      doxie.MAC_PruneOldSSNs(ssns_pulled2, ssns_pruned1, ssn_appended, did, isFCRA);
      doxie.MAC_PruneOldSSNs(ssns_pruned1, ssns_pruned2, ssn, did, isFCRA);

      suppress.MAC_Mask(ssns_pruned2, ssns_suppressed1, ssn_appended, blank, TRUE, FALSE, maskVal := in_mod.ssn_mask);
      suppress.MAC_Mask(ssns_suppressed1, ssns_suppressed2, ssn, blank, TRUE, FALSE, maskVal := in_mod.ssn_mask);
      RETURN ssns_suppressed2;
    END;

  END; //END of search_view

  // ==========================================================================
  // Returns records of Sex offender data in Report view
  // ==========================================================================
  EXPORT REPORT_VIEW := MODULE
    SHARED raw_rec := SexOffender_Services.Layouts.raw_rec;

    SHARED format_rpt (DATASET(raw_rec) recs,
                       SexOffender_Services.IParam.report in_mod,
                       BOOLEAN isFCRA = FALSE,
                       DATASET(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
                       DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim
                       ) := FUNCTION

      // Used to replace spaces in date strings with zeroes so cast to integer works Ok,
      // since some dates only contain a yyyy or a yyyymm.
      fixed_date(STRING8 dtin) := STD.Str.FindReplace(dtin, ' ', '0');
      // Restrict explicit offense descriptions
      od(STRING primKey, STRING od1, STRING od2) := FUNCTION
        isRestricted := (primKey[3..4] IN SexOffender.Constants.explicitOffenseStates);
        RETURN od1 + IF(in_mod.AllowGraphicDescription OR NOT isRestricted, ' ' + od2, '');
      END;
      
      //******** Offenses key file transform for Conviction data
    
      iesp.sexualoffender_fcra.t_FcraSexOffReportConviction offenses_file_xform(SexOffender_Services.Layouts.rec_offense_raw l) := TRANSFORM
        SELF.ConvictionJurisdiction := l.conviction_jurisdiction,
        SELF.ConvictionDate := iesp.ECL2ESP.toDate ((INTEGER4) l.conviction_date),
        SELF.CourtName := l.court,
        SELF.CourtCaseNumber := l.court_case_number,
        SELF.OffenseDate := iesp.ECL2ESP.toDate ((INTEGER4) l.offense_date),
        SELF.OffenseCodeOrStatute := l.offense_code_or_statute,
        SELF.OffenseDescription := od(l.seisint_primary_key, l.offense_description, l.offense_description_2),
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

      //******** Offender key file transform for AKA data
      iesp.share.t_Name SetAKANames (raw_rec l) := TRANSFORM
        SELF := iesp.ECL2ESP.setName (l.fname, l.mname, l.lname,l.name_suffix, '',l.name_orig);
      END;

      // **************** MAIN TRANSFORM ****************
      //******** Offender file transform
      iesp.sexualoffender_fcra.t_FcraSexOffReportRecord spk_file_xform(recs l) := TRANSFORM
        SELF.PrimaryKey := l.seisint_primary_key,
        SELF.RecordType := l.record_type,
        SELF.Name := iesp.ECL2ESP.setName(l.fname, l.mname, l.lname, l.name_suffix, '',l.name_orig);
                                                                  
        SELF.Address := iesp.ECL2ESP.setAddress(l.prim_name, l.prim_range,
                                                l.predir, l.postdir,
                                                l.addr_suffix, l.unit_desig,
                                                l.sec_range, l.v_city_name,
                                                l.st, l.zip5, l.zip4, ''),
        SELF.SSN := l.ssn_appended,
        SELF.OrigSSN := l.ssn,
        SELF.UniqueId := IF(l.did=0,'',INTFORMAT(l.did,12,1)),
        SELF.DOB := iesp.ECL2ESP.toDate ((INTEGER4) fixed_date(l.dob)),
        calculatedAge := IF( TRIM(l.dob) = '', '', (STRING) ut.Age((UNSIGNED)l.dob));//Calculate Age
        SELF.Age := calculatedAge;
        SELF.DOB2 := iesp.ECL2ESP.toDate ((INTEGER4) fixed_date(l.dob_aka)),
        SELF.DateFirstSeen := iesp.ECL2ESP.toDate ((INTEGER4) l.dt_first_reported),
        SELF.DateLastSeen := iesp.ECL2ESP.toDate ((INTEGER4) l.dt_last_reported),
        SELF.DateOffenderLastUpdated := iesp.ECL2ESP.toDateYM ((INTEGER4) l.addr_dt_last_seen),
        SELF.StateOfOrigin := l.orig_state,
        SELF.OriginStateCode := l.orig_state_code,
        SELF.OffenderStatus := l.offender_status,
        SELF.OffenderCategory := l.offender_category,
        SELF.RiskLevelCode := l.risk_level_code,
        SELF.RiskDescription := l.risk_description,
             
        // t_SexOffReportPoliceAgency record info
        SELF.PoliceAgency.Name := l.police_agency,
        SELF.PoliceAgency.ContactName := l.police_agency_contact_name,
        iesp.share.t_Address SetAddress () := TRANSFORM
          SELF.StreetAddress1 := l.police_agency_address_1;
          SELF.StreetAddress2 := l.police_agency_address_2;
          SELF := [];
        END;
        SELF.PoliceAgency.Address := ROW (SetAddress ());
        SELF.PoliceAgency.Phone := l.police_agency_phone,
          
        //t_SexOffReportSchool record info
        SELF.School.Name := l.school,
        SELF.School.Address1 := l.school_address_1,
        SELF.School.Address2 := l.school_address_2,
        SELF.School.Address3 := l.school_address_3,
        SELF.School.Address4 := l.school_address_4,
        SELF.School.Address5 := l.school_address_5,
        SELF.School.County := l.school_county,

        //t_SexOffReportEmployer record info
        SELF.Employer.Name := l.employer,
        SELF.Employer.Address1 := l.employer_address_1,
        SELF.Employer.Address2 := l.employer_address_2,
        SELF.Employer.Address3 := l.employer_address_3,
        SELF.Employer.Address4 := l.employer_address_4,
        SELF.Employer.Address5 := l.employer_address_5,
        SELF.Employer.County := l.employer_county,

        //t_SexOffReportRegistration record info
        SELF.Registration._Type := l.registration_type,
        SELF.Registration.Date1 := iesp.ECL2ESP.toDate ((INTEGER4) l.reg_date_1),
        SELF.Registration.Date1Type := l.reg_date_1_type,
        SELF.Registration.Date2 := iesp.ECL2ESP.toDate ((INTEGER4) l.reg_date_2),
        SELF.Registration.Date2Type := l.reg_date_2_type,
        SELF.Registration.Date3 := iesp.ECL2ESP.toDate ((INTEGER4) l.reg_date_3),
        SELF.Registration.Date3Type := l.reg_date_3_type,
        SELF.Registration.Address1 := l.registration_address_1,
        SELF.Registration.Address2 := l.registration_address_2,
        SELF.Registration.Address3 := l.registration_address_3,
        SELF.Registration.Address4 := l.registration_address_4,
        SELF.Registration.Address5 := l.registration_address_5,
        SELF.Registration.County := l.registration_county,

        //t_SexOffReportVehicle Vehicle1 record info
        SELF.Vehicle1.Year := (INTEGER) l.orig_veh_year_1,
        SELF.Vehicle1.Color := l.orig_veh_color_1,
        SELF.Vehicle1.MakeModel := l.orig_veh_make_model_1,
        SELF.Vehicle1.Plate := l.orig_veh_plate_1,
        SELF.Vehicle1.State := l.orig_veh_state_1,

        //t_SexOffReportVehicle Vehicle2 record info
        SELF.Vehicle2.Year := (INTEGER) l.orig_veh_year_2,
        SELF.Vehicle2.Color := l.orig_veh_color_2,
        SELF.Vehicle2.MakeModel := l.orig_veh_make_model_2,
        SELF.Vehicle2.Plate := l.orig_veh_plate_2,
        SELF.Vehicle2.State := l.orig_veh_state_2,
             
        //t_SexOffRecordPhysicalCharacteristics record info
        SELF.PhysicalCharacteristics.Age := calculatedAge,
        SELF.PhysicalCharacteristics.Race := l.race,
        SELF.PhysicalCharacteristics.Ethnicity := l.ethnicity,
        SELF.PhysicalCharacteristics.Sex := l.sex,
        SELF.PhysicalCharacteristics.HairColor := l.hair_color,
        SELF.PhysicalCharacteristics.EyeColor := l.eye_color,
        SELF.PhysicalCharacteristics.Height := l.height,
        SELF.PhysicalCharacteristics.Weight := l.weight,
        SELF.PhysicalCharacteristics.SkinTone := l.skin_tone,
        SELF.PhysicalCharacteristics.BuildType := l.build_type,
        SELF.PhysicalCharacteristics.ScarsMarksTattoos := l.scars_marks_tattoos,
        SELF.PhysicalCharacteristics.ShoeSize := l.shoe_size,
        SELF.PhysicalCharacteristics.CorrectiveLenseFlag := l.corrective_lense_flag='Y',

        //t_SexOffRecordIdNumbers record info
        SELF.IDNumbers.OffenderId := l.offender_id,
        SELF.IDNumbers.DocNumber := l.doc_number,
        SELF.IDNumbers.SORNumber := l.sor_number,
        SELF.IDNumbers.StateIdNumber := l.st_id_number,
        SELF.IDNumbers.FBINumber := l.fbi_number,
        SELF.IDNumbers.NCICNumber := l.ncic_number,
        SELF.DriverLicenseNumber := l.orig_dl_number,
        SELF.DriverLicenseState := l.orig_dl_state,
        SELF.AdditionalComment1 := l.addl_comments_1,
        SELF.AdditionalComment2 := l.addl_comments_2,
        SELF.ImageLink := l.image_link,

        // Sort Convictions by Conviction-Date reverse chron (descending)
        ds_spk := DATASET([{l.seisint_primary_key, l.isDeepDive}], SexOffender_Services.Layouts.search);
        SELF.Convictions := SORT(PROJECT(GetRawOffenses(ds_spk, isFCRA, flagfile, slim_pc_recs, in_mod.FFDOptionsMask),
                                          offenses_file_xform(LEFT)),
                                 -ConvictionDate),
        // (name_type=0 is the main name, not an AKA).
        SELF.AKAs := DEDUP(SORT(PROJECT(recs (seisint_primary_key = l.seisint_primary_key, name_type <>'0'), SetAKANames(LEFT)),
                                Last,First,Middle,Suffix),
                           Last,First,Middle,Suffix),
        SELF.BestAddress := [],
        SELF.StatementIDs := l.StatementIDs,
        SELF.isDisputed := l.isDisputed
      END; /* END of spk_file_xform TRANSFORM */

      // For offender data, use a project to do a keyed look up against the Key SPK (Offender)
      // file using the seisint primary key and also matching on the name_type = '0'
      // which is the main (not an AKA ) name.

      recs_pre_best := PROJECT(recs(name_type ='0'), spk_file_xform(LEFT));
      
      // adding best information if requested.
      recs_best := GetBestAddressRec(recs, in_mod);
      recs_with_best := JOIN(recs_pre_best, recs_best,
        (UNSIGNED6) LEFT.UniqueId = RIGHT.did,
        TRANSFORM(iesp.sexualoffender_fcra.t_FcraSexOffReportRecord,
          SELF.BestAddress := RIGHT.BestAddress,
          SELF := LEFT),
        LEFT OUTER, KEEP(1), LIMIT(0));
      
      recs_out := IF(in_mod.include_bestaddress AND ~isFCRA, recs_with_best, recs_pre_best);
                                     
      // ***** DID & SSN pulling and suppression ****
      Suppress.MAC_Suppress(recs_out,dids_pulled,in_mod.application_type,Suppress.Constants.LinkTypes.DID,UniqueId, isFCRA := isFCRA);

      // pull, prune & suppress ssns twice, once for ssn_appended & once for ssn
      Suppress.MAC_Suppress(dids_pulled,ssns_pulled1,in_mod.application_type,Suppress.Constants.LinkTypes.SSN,ssn, isFCRA := isFCRA);
      Suppress.MAC_Suppress(ssns_pulled1,ssns_pulled2,in_mod.application_type,Suppress.Constants.LinkTypes.SSN,OrigSSN, isFCRA := isFCRA);
      doxie.MAC_PruneOldSSNs(ssns_pulled2, ssns_pruned1, SSN, UniqueId, isFCRA);
      doxie.MAC_PruneOldSSNs(ssns_pruned1, ssns_pruned2, OrigSSN, UniqueId, isFCRA);

      suppress.MAC_Mask(ssns_pruned2, ssns_suppressed1, SSN, blank, TRUE, FALSE, maskVal := in_mod.ssn_mask);
      suppress.MAC_Mask(ssns_suppressed1, ssns_suppressed2, OrigSSN, blank, TRUE, FALSE, maskVal := in_mod.ssn_mask);

      RETURN ssns_suppressed2;
    END;
      
    EXPORT by_did (DATASET(doxie.layout_references) in_dids,
                   SexOffender_Services.IParam.report in_mod,
                   BOOLEAN isFCRA = FALSE,
                   DATASET(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
                   DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim
                   ) := FUNCTION

      fmt_dids := PROJECT(in_dids,SexOffender_Services.layouts.search_did);
      rec_ids := byDIDs(fmt_dids, isFCRA);
      rawrecs := GetRawOffenders(rec_ids, in_mod.application_type, isFCRA, flagfile, slim_pc_recs, in_mod.FFDOptionsMask);
      rpt_recs := format_rpt(rawrecs, in_mod, isFCRA, flagfile, slim_pc_recs);
      
      RETURN rpt_recs;
    END;
  
    EXPORT by_primary_key (DATASET(SexOffender_Services.layouts.search)in_spks,
                           SexOffender_Services.IParam.report in_mod,
                           BOOLEAN isFCRA = FALSE,
                           DATASET(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile) := FUNCTION
      
      rec_dids:= getDIDsbySPK(in_spks, isFCRA);
      rec_ids := byDIDs(rec_dids, isFCRA)+in_spks;
      dedup_rec_ids := DEDUP(SORT(rec_ids,seisint_primary_key),seisint_primary_key);
      rawrecs := GetRawOffenders(dedup_rec_ids, in_mod.application_type, isFCRA, flagfile);
      rpt_recs := format_rpt(rawrecs, in_mod, isFCRA, flagfile);
      
      RETURN rpt_recs;
    END;
      
  END; //END of report_view
  
  EXPORT batch_view := MODULE
    EXPORT getOffendersRecs(DATASET(SexOffender_Services.layouts.lookup_id_rec) in_spks,
                            BOOLEAN isFCRA = FALSE,
                            DATASET(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
                            DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
                            INTEGER8 inFFDOptionsMask = 0) := FUNCTION
                            
      search_spks := DEDUP(SORT(PROJECT(in_spks, SexOffender_Services.Layouts.search), seisint_primary_key), seisint_primary_key);
      ds_offenders_raw := GetRawOffenders(search_spks, , isFCRA, flagfile, slim_pc_recs, inFFDOptionsMask);
      // transform to layout with FFD fields
      ds_offenders_final := JOIN(in_spks, ds_offenders_raw,
        LEFT.seisint_primary_key = RIGHT.sspk,
        TRANSFORM(SexOffender_Services.Layouts.rec_offender_plus_acctno,
                  SELF.acctno := LEFT.acctno,
                  SELF.isDeepDive := LEFT.isDeepDive,
                  SELF := RIGHT),
        LIMIT(BatchServices.Constants.SEXPREDCPS_SERVICE_JOIN_LIMIT));

      RETURN ds_offenders_final;
    END;
    EXPORT GetOffensesRecs(DATASET(SexOffender_Services.Layouts.lookup_id_rec) in_spks,
                           BOOLEAN isFCRA = FALSE,
                           DATASET(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
                           DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
                           INTEGER8 inFFDOptionsMask = 0) := FUNCTION
                          
       search_spks := DEDUP(SORT(PROJECT(in_spks, SexOffender_Services.Layouts.search), seisint_primary_key), seisint_primary_key);
       raw_recs := GetRawOffenses(search_spks, isFCRA, flagfile, slim_pc_recs, inFFDOptionsMask);
       // transform to layout with FFD fields
       final_recs := JOIN(in_spks, raw_recs,
                          LEFT.seisint_primary_key = RIGHT.seisint_primary_key,
                          TRANSFORM(SexOffender_Services.Layouts.rec_offense_raw,
                                    SELF.acctno := LEFT.acctno,
                                    SELF := RIGHT));
     RETURN final_recs;
    END;
  END; //END of batch_view

END;
