IMPORT doxie, codes, fcra, ut, FFD;

EXPORT get_watercraft(DATASET(WatercraftV2_Services.Layouts.search_watercraftkey) in_watercraftkeys,
                      STRING in_ssn_mask_type = '',
                      BOOLEAN isFCRA = FALSE,
                      DATASET(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
                      BOOLEAN include_non_regulated_sources = FALSE,
                      DATASET(FFD.Layouts.PersonContextBatchSlim ) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
                      INTEGER8 inFFDOptionsMask = 0) := MODULE

  SHARED layout_w_key_plus_rec := WatercraftV2_Services.Layouts.w_key_plus_rec;
  SHARED layout_c_key_plus_rec := WatercraftV2_Services.Layouts.c_key_plus_rec;
  
  SHARED owner_key_recs := WatercraftV2_Services.get_owner_records(in_watercraftkeys, IsFCRA, flagfile, include_non_regulated_sources, slim_pc_recs, inFFDOptionsMask);
  /*
  Because all searches seem to start with owners, the owner records search only seems to require a watercraft_key, not a state_origin
  or a sequence_key. In fact, the owners search will RETURN ALL possibilities if those two fields are blank. But when they are blank,
  the coastguard AND detail record searches are incorrect because they don't have the two key fields. So once the owners search
  has completed, we will need to extract a new dataset for the "in_watercraftkeys" that is built from the owner_key_recs.
  See https://jira.rsi.lexisnexis.com/browse/DF-18665 for the details
  */
  SHARED newSearchWatercraftKeys := DEDUP(SORT(PROJECT(owner_key_recs, WatercraftV2_Services.Layouts.search_watercraftkey), RECORD), RECORD);

  SHARED details_key_recs := WatercraftV2_Services.get_detail_records(newSearchWatercraftKeys, IsFCRA, flagfile, slim_pc_recs, inFFDOptionsMask);
  SHARED coast_key_recs := WatercraftV2_Services.get_coastguard_records(newSearchWatercraftKeys, IsFCRA, flagfile, slim_pc_recs, inFFDOptionsMask);

  //********* REPORT VIEW FUNCTION
  EXPORT report(BOOLEAN isReport = FALSE) := FUNCTION

    doxie.MAC_Header_Field_Declare(IsFCRA); //TODO: only (!) for DateVal
    
    wOwners_report := WatercraftV2_Services.get_owners(owner_key_recs, in_ssn_mask_type, IsFCRA).report(isReport);

    layout_report_w_extra_info := WatercraftV2_Services.Layouts.WCReportEX;

    WatercraftV2_Services.Layouts.owner_report_rec xformGENDer(WatercraftV2_Services.Layouts.owner_report_rec l) := TRANSFORM
        SELF.gender := CASE(l.gender,
          'M' => 'MALE',
          'F' => 'FEMALE',
          'B' => 'BUSINESS',
          '');
        SELF :=l;
    END;

    layout_report_w_extra_info get_coastguard(WatercraftV2_Services.Layouts.int_raw_rec l, layout_c_key_plus_rec r) := TRANSFORM
      SELF.state_origin_full :=codes.GENERAL.STATE_LONG(l.state_origin);
      SELF.owners := PROJECT(l.owners,xformGENDer(LEFT));
      SELF.NonDMVSource := l.NonDMVSource;
      SELF :=l;
      SELF := r; // StatementIds get assigned here
      SELF :=[];
    END;

    coast_recs := join (wOwners_report, coast_key_recs,
      (LEFT.subject_did = RIGHT.subject_did) AND
      (LEFT.state_origin = RIGHT.state_origin) AND
      (LEFT.watercraft_key = RIGHT.watercraft_key) AND
      (LEFT.sequence_key = RIGHT.sequence_key),
      get_coastguard(LEFT,RIGHT), LEFT OUTER);

    layout_report_w_extra_info get_main(layout_report_w_extra_info l, layout_w_key_plus_rec r) := TRANSFORM
      SELF.watercraft_key := l.watercraft_key;
      SELF.sequence_key := l.sequence_key;
      SELF.state_origin := l.state_origin;
      SELF.NonDMVSource := l.NonDMVSource;
      SELF.rec_type := CASE(r.history_flag, '' => 'Current',
                                            'E' => 'Expired',
                                            'H' => 'Historical',
                                            '');
      SELF.lienholders :=DATASET([{r.lien_1_name,r.lien_1_address_1,r.lien_1_address_2,r.lien_1_city,
                                    r.lien_1_state,r.lien_1_zip,r.lien_1_date,r.lien_1_indicator},
                                    {r.lien_2_name,r.lien_2_address_1,r.lien_2_address_2,r.lien_2_city,
                                    r.lien_2_state,r.lien_2_zip,r.lien_2_date,r.lien_2_indicator}],WatercraftV2_Services.layouts.lien_rec)
                                    (lien_name<>'' OR lien_address_1<>'' OR lien_address_2 <>'');
      SELF.engines := DATASET([{r.watercraft_hp_1,r.engine_make_1,r.engine_model_1,r.engine_number_1,r.engine_year_1,r.watercraft_number_of_engines},
                                {r.watercraft_hp_2,r.engine_make_2,r.engine_model_2,r.engine_number_2,r.engine_year_2,r.watercraft_number_of_engines},
                                {r.watercraft_hp_3,r.engine_make_3,r.engine_model_3,r.engine_number_3,r.engine_year_3,r.watercraft_number_of_engines}],
                                WatercraftV2_Services.Layouts.engine_rec)
                                (watercraft_hp <> '' OR engine_make <> '' OR engine_model <> '');
      SELF.hull_number := IF(l.hull_number <> '',l.hull_number,r.hull_number);
      SELF.name_of_vessel :=IF(r.watercraft_name<> '',r.watercraft_name,l.name_of_vessel);
      SELF.isDisputed := l.isDisputed OR r.isDisputed;
      SELF.StatementIds := l.statementids + r.statementids;
      SELF := r; //fields from the RIGHT with the same name as LEFT side are empty on the LEFT side AND getting filled from w_key, except for fields named above.
      SELF := l; //fields we wish to retain from the LEFT side do not overlap the RIGHT side, except for fields named above.
    END;

    wLiens_engines := JOIN(coast_recs, details_key_recs,
                          (LEFT.subject_did = RIGHT.subject_did) AND
                          (LEFT.state_origin = RIGHT.state_origin) AND
                          (LEFT.watercraft_key = RIGHT.watercraft_key) AND
                          (LEFT.sequence_key = RIGHT.sequence_key) AND
                          (dateVal=0 OR (UNSIGNED3) RIGHT.purchase_date[1..6] <= dateVal),
                          get_main (LEFT, RIGHT), LEFT OUTER);
    
    layout_report_w_extra_info fullrecroll(layout_report_w_extra_info l,DATASET(layout_report_w_extra_info) r)
        :=TRANSFORM
        SELF.lienholders := CHOOSEN(Normalize(r,LEFT.lienholders,TRANSFORM(RIGHT)),ut.limits.MAX_WATERCRAFT_LH);
        SELF.engines := CHOOSEN(Normalize(r,LEFT.engines,TRANSFORM(RIGHT)),ut.limits.MAX_WATERCRAFT_ENGINES);
        
        SELF :=l; // we only need the owners from the LEFT side because every record to be rolled up will have
                    // the same owners
      END;
            
      sorted_wLiens_engines := SORT(wLiens_engines,subject_did,state_origin,watercraft_key,sequence_key);
      rolledres :=ROLLUP(GROUP(sorted_wLiens_engines,subject_did,state_origin,watercraft_key,sequence_key),GROUP,fullrecroll(LEFT,rows(LEFT)));
      
      layout_report_w_extra_info sortchildren(layout_report_w_extra_info l):=TRANSFORM
        SELF.owners := DEDUP(SORT(l.owners,lname,fname,company_name,RECORD),RECORD);
        SELF.lienholders :=DEDUP(SORT(l.lienholders,RECORD),RECORD);
        SELF.engines :=DEDUP(SORT(l.engines,engine_year,RECORD),RECORD);
        SELF := l;
      END;

      res := PROJECT(DEDUP(SORT(rolledres,penalt,watercraft_key,-sequence_key,state_origin, -date_last_seen,RECORD),RECORD) ,sortchildren(LEFT));

      RETURN res;
        
  END;

  //********* SEARCH VIEW FUNCTION
  EXPORT search() := FUNCTION
  
      outrec := WatercraftV2_Services.Layouts.search_out;

      wOwners_search := WatercraftV2_Services.get_owners(owner_key_recs, in_ssn_mask_type, isFCRA).search();
      
      outrec get_hull(outrec le, layout_c_key_plus_rec ri):=TRANSFORM
        SELF.hull_number :=ri.hull_number;
        SELF.watercraft_name := ri.name_of_vessel;
        SELF.StatementIDs := ri.StatementIDs;
        SELF.isDisputed := ri.isDisputed;
        SELF := le;
      END;

      with_hullnum :=JOIN(wOwners_search, coast_key_recs,
                          (LEFT.subject_did = RIGHT.subject_did) AND
                          (LEFT.state_origin=RIGHT.state_origin) AND
                          (LEFT.watercraft_key =RIGHT.watercraft_key) AND
                          (LEFT.sequence_key =RIGHT.sequence_key) AND
                          (RIGHT.name_of_vessel <> '' OR RIGHT.hull_number <> ''),
                          get_hull(LEFT,RIGHT),
                          LEFT OUTER,KEEP(1),LIMIT(0));
      
      outrec get_watercraft_name(outrec le, layout_w_key_plus_rec ri):=TRANSFORM
        SELF.watercraft_name := IF(ri.watercraft_name<> '',ri.watercraft_name,le.watercraft_name);
        SELF.hull_number := IF(le.hull_number <> '',le.hull_number,ri.hull_number);
        SELF.registration_number := ri.registration_number;
        SELF.registration_date := ri.registration_date;
        SELF.Make := ri.watercraft_make_description;
        SELF.Model := ri.watercraft_model_description;
        SELF.YearMake := (INTEGER)ri.model_year;
        SELF.MajorColor := ri.watercraft_color_1_description;
        SELF.MinorColor := ri.watercraft_color_2_description;
        SELF.watercraft_length := (UNSIGNED2) ri.watercraft_length;
        SELF.engines := DATASET([{ri.watercraft_hp_1,ri.engine_make_1,ri.engine_model_1,ri.engine_number_1,ri.engine_year_1,ri.watercraft_number_of_engines},
          {ri.watercraft_hp_2,ri.engine_make_2,ri.engine_model_2,ri.engine_number_2,ri.engine_year_2,ri.watercraft_number_of_engines},
          {ri.watercraft_hp_3,ri.engine_make_3,ri.engine_model_3,ri.engine_number_3,ri.engine_year_3,ri.watercraft_number_of_engines}],
          WatercraftV2_Services.layouts.engine_rec)(watercraft_hp <> '' OR engine_make <> '' OR engine_number <> '');
        SELF.StatementIDs := ri.StatementIDs + le.StatementIDs;
        SELF.isDisputed := ri.isDisputed OR le.isDisputed;
        SELF := le;
      END;

      res := JOIN(with_hullnum, details_key_recs,
        (LEFT.subject_did = RIGHT.subject_did) AND
        (LEFT.state_origin = RIGHT.state_origin) AND
        (LEFT.watercraft_key = RIGHT.watercraft_key) AND
        (LEFT.sequence_key = RIGHT.sequence_key) AND
        (RIGHT.watercraft_name <>'' OR RIGHT.registration_date <>'' OR RIGHT.registration_number<>''),
        get_watercraft_name(LEFT,RIGHT),
        LEFT OUTER, KEEP(1), LIMIT(0));

      RETURN res;
  END;
END;
