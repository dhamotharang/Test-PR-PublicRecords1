IMPORT iesp, codes, AutoStandardI, corrections, fcra, doxie_files, FFD, STD, CriminalRecords_Services, hygenics_crim;

MAX_OVERRIDE_LIMIT := FCRA.compliance.MAX_OVERRIDE_LIMIT;

todays_date := (STRING) STD.Date.Today();

EXPORT Functions := MODULE

  // ------------------------
  // Parameters
  // ------------------------
  EXPORT params := INTERFACE(AutoStandardI.LIBIN.PenaltyI_Indv.base)
    EXPORT STRING25 city;
    EXPORT STRING2 st;
  END;
  
  EXPORT fnAppendOffenses(DATASET(CriminalRecords_Services.layouts.l_raw) in_recs,
    CriminalRecords_Services.IParam.Search in_mod,BOOLEAN isFCRA=FALSE) := FUNCTION

    offenseRec:=RECORD
      corrections.layout_Offender.offender_key;
      CriminalRecords_Services.layouts.offense_rec;
      BOOLEAN isFelony;
      BOOLEAN wasConvicted;
    END;

    workRec:=RECORD
      CriminalRecords_Services.layouts.raw_with_offenses;
      BOOLEAN hasFelony;
      BOOLEAN hasConviction;
      BOOLEAN hasFelonyConviction;
    END;

    offenses:=JOIN(in_recs,doxie_files.Key_Offenses(isFCRA),
      KEYED(LEFT.offender_key=RIGHT.ok),TRANSFORM(offenseRec,
      SELF.offender_key:=LEFT.offender_key,
      SELF.bitmap:=RIGHT.offense_category,
      SELF.description:=hygenics_crim._functions.get_category_from_bitmap(RIGHT.offense_category),
      SELF.isFelony:=RIGHT.off_typ=CriminalRecords_Services.Constants.FELONY[1],
      SELF.wasConvicted:=RIGHT.fcra_conviction_flag='D'), // D = DOC assumed conviction
      LIMIT(iesp.constants.CRIM.MaxOffenses,SKIP));

    court_offenses:=JOIN(in_recs,doxie_files.Key_Court_Offenses(isFCRA),
      KEYED(LEFT.offender_key=RIGHT.ofk),TRANSFORM(offenseRec,
      SELF.offender_key:=LEFT.offender_key,
      SELF.bitmap:=RIGHT.offense_category,
      SELF.description:=hygenics_crim._functions.get_category_from_bitmap(RIGHT.offense_category),
      SELF.isFelony:=Std.Str.Contains(RIGHT.court_off_lev_mapped,CriminalRecords_Services.Constants.FELONY,TRUE),
      SELF.wasConvicted:=RIGHT.fcra_conviction_flag='Y'),
      LIMIT(iesp.constants.CRIM.MaxCourtOffenses,SKIP));

    uniq_offenses:=DEDUP(SORT(offenses+court_offenses,offender_key,bitmap),offender_key,bitmap);
    slct_offenses:=IF(in_mod.OffenseCategories > 0,uniq_offenses(in_mod.OffenseCategories & bitmap > 0),uniq_offenses);

    workRec appendOffenses1(CriminalRecords_Services.layouts.l_raw L,DATASET(offenseRec) R) := TRANSFORM
      SELF.offenses:=PROJECT(R,CriminalRecords_Services.layouts.offense_rec);
      SELF.hasFelony:=EXISTS(R(isFelony));
      SELF.hasConviction:=EXISTS(R(wasConvicted));
      SELF.hasFelonyConviction:=EXISTS(R(isFelony AND wasConvicted));
      SELF:=L;
    END;

    // add selected offense categories and set booleans in records
    denormRecs:=DENORMALIZE(in_recs,slct_offenses,LEFT.offender_key=RIGHT.offender_key,GROUP,appendOffenses1(LEFT,ROWS(RIGHT)));

    // filter records by felony and conviction flags
    filterByFelony:=Std.Str.ToUpperCase(in_mod.OffenseType)[1..5]=CriminalRecords_Services.Constants.FELONY[1..5];
    tempRecs:=MAP(
      filterByFelony AND in_mod.ConvictionsOnly => denormRecs(hasFelonyConviction),
      filterByFelony => denormRecs(hasFelony),
      in_mod.ConvictionsOnly => denormRecs(hasConviction),
      denormRecs);

    // filter input records by selected offense categories
    fltrdRecs:=IF(in_mod.OffenseCategories > 0,tempRecs(EXISTS(offenses)),tempRecs);

    CriminalRecords_Services.layouts.raw_with_offenses appendOffenses2(workRec L,DATASET(offenseRec) R) := TRANSFORM
      SELF.offenses:=PROJECT(R,CriminalRecords_Services.layouts.offense_rec);
      SELF:=L;
    END;

    // return all offense categories for selected records
    crimRecs:=DENORMALIZE(fltrdRecs,uniq_offenses,LEFT.offender_key=RIGHT.offender_key,GROUP,appendOffenses2(LEFT,ROWS(RIGHT)));

    // OUTPUT(slct_offenses,NAMED('offenses'));
    // OUTPUT(tempRecs,NAMED('tempRecs'));
    // OUTPUT(fltrdRecs,NAMED('fltrdRecs'));
    // OUTPUT(crimRecs,NAMED('crimRecs'));

    RETURN crimRecs;
  END;

  // categories bitmap to dataset of group descriptions
  SHARED getGrpDescriptions(UNSIGNED bitmap) := FUNCTION

    BOOLEAN inGroup(UNSIGNED catBitmap, UNSIGNED grpBitmap):=catBitmap & grpBitmap > 0;

    STRING descriptions:=IF(bitmap=0,'',
      IF(inGroup(bitmap,hygenics_crim.Constants.CRIMES_AGAINST_PERSONS),
        hygenics_crim.Constants.GRP_CRIMES_AGAINST_PERSONS,'')+' '+
      IF(inGroup(bitmap,hygenics_crim.Constants.CRIMES_AGAINST_PROPERTY),
        hygenics_crim.Constants.GRP_CRIMES_AGAINST_PROPERTY,'')+' '+
      IF(inGroup(bitmap,hygenics_crim.Constants.DOMESTIC_PERSONAL_OFFENSES),
        hygenics_crim.Constants.GRP_DOMESTIC_PERSONAL_OFFENSES,'')+' '+
      IF(inGroup(bitmap,hygenics_crim.Constants.DRUG_ALCOHOL_OFFENSES),
        hygenics_crim.Constants.GRP_DRUG_ALCOHOL_OFFENSES,'')+' '+
      IF(inGroup(bitmap,hygenics_crim.Constants.FRAUD_OFFENSES),
        hygenics_crim.Constants.GRP_FRAUD_OFFENSES,'')+' '+
      IF(inGroup(bitmap,hygenics_crim.Constants.SEXUAL_OFFENSES),
        hygenics_crim.Constants.GRP_SEXUAL_OFFENSES,''));

    RETURN DATASET(Std.Str.SplitWords(descriptions,' '),iesp.share.t_StringArrayItem);
  END;

  // ------------------------
  // Generate search output
  // ------------------------
  EXPORT fnCrimSearchVal(DATASET(CriminalRecords_Services.layouts.raw_with_offenses) in_recs) := FUNCTION
  
    CriminalRecords_Services.layouts.t_CrimSearchRecordWithPenalty toSearch(CriminalRecords_Services.layouts.raw_with_offenses L) := TRANSFORM
      SELF._Penalty := L.penalt;
      SELF.AlsoFound := L.isDeepdive;
      SELF.datasource := L.datasource;
      SELF.offenderid := L.offender_key;
      
      SELF.name := iesp.ECL2ESP.SetName(L.fname, L.mname, L.lname, L.name_suffix,'');
      
      SELF.address := iesp.ECL2ESP.SetAddress(L.prim_name, L.prim_range, L.predir, L.postdir,
                               L.addr_suffix, L.unit_desig, L.sec_range, L.v_city_name,
                               L.st, L.zip5, L.zip4, L.county_name);
      
      SELF.ssn := IF(L.ssn<>'',L.ssn,L.ssn_appended);
      SELF.DOB := iesp.ECL2ESP.toDatestring8( IF(L.pty_typ='2',L.dob_alias,L.dob) );
      SELF.stateofOrigin := L.orig_state;
      SELF.stateofBirth := L.place_of_birth;
      SELF.uniqueid := L.did;
      SELF.countyofOrigin := L.county_of_origin;
      SELF.caseNumber := L.case_num;
      SELF.docNumber := L.doc_num;
      SELF.CaseFilingDate := iesp.ECL2ESP.toDatestring8(L.case_date);
      SELF.DateLastSeen := iesp.ECL2ESP.toDatestring8(L.process_date);
      SELF.isDisputed := L.isDisputed;
      SELF.StatementIDs := L.StatementIDs;

      // consolidate all offense bitmaps into one bitmap for getGrpDescriptions()
      bitmap:=MAX(ITERATE(L.offenses,
        TRANSFORM(CriminalRecords_Services.layouts.offense_rec,
          SELF.bitmap:=LEFT.bitmap | RIGHT.bitmap,
          SELF.description:='')
        ),bitmap);

      SELF.OffenseClassifications.Groups:=CHOOSEN(PROJECT(getGrpDescriptions(bitmap),
        TRANSFORM(iesp.share.t_StringArrayItem,SELF:=LEFT)),
          iesp.constants.CRIM.MaxOffenses);

      ds_parent:=PROJECT(L.offenses,
        TRANSFORM({DATASET(iesp.share.t_StringArrayItem) categories},
          SELF.categories:=DATASET(Std.Str.SplitWords(LEFT.description,' '),iesp.share.t_StringArrayItem)));

      ds_children:=DEDUP(SORT(NORMALIZE(ds_parent,LEFT.categories,
        TRANSFORM(iesp.share.t_StringArrayItem,SELF:=RIGHT)),RECORD),RECORD);

      SELF.OffenseClassifications.Categories:=CHOOSEN(PROJECT(ds_children,
        TRANSFORM(iesp.share.t_StringArrayItem,SELF:=LEFT)),
          iesp.constants.CRIM.MaxOffenses);
    END;
    temp_formatted := PROJECT(in_recs, toSearch(LEFT));
    
    formatted := DEDUP(SORT(temp_formatted,RECORD), RECORD);
    RETURN(formatted);
  END;
  
  
  // ------------------------
  // Generate report output
  // ------------------------
  EXPORT fnCrimReportVal(DATASET(CriminalRecords_Services.layouts.l_raw) in_recs,
                         params in_mod,
                         BOOLEAN IsFCRA = FALSE,
                         DATASET (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
                         DATASET(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
                         INTEGER8 inFFDOptionsMask = 0) := FUNCTION

    BOOLEAN showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
    BOOLEAN showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);

    // gather the raw materials for child datasets
    unique_offenders := DEDUP (in_recs, offender_key, ALL); // need to take only unique ids

    // --------------------------------------------------------------------
    // -------------------------- OFFENSE RECORDS -------------------------
    // --------------------------------------------------------------------
    offenses_ofk := SET (flagfile (file_id=FCRA.FILE_ID.OFFENSES), record_id);
    offenses_ffid := SET (flagfile (file_id=FCRA.FILE_ID.OFFENSES), flag_file_id);
    offense_rec := corrections.layout_offense_common AND NOT offense_category;
    offense_ds_rec := RECORD(offense_rec OR FFD.Layouts.CommonRawRecordElements)END;
      
    offenses_key := doxie_files.key_offenses(isFCRA);
    // FCRA: remove records subject to correction; apply date restrictions; apply overrides
    offense_data := JOIN(
      unique_offenders, offenses_key,
      KEYED(LEFT.offender_key=RIGHT.ok) AND
      (~isFCRA OR
      ((STRING)RIGHT.offense_persistent_id NOT IN offenses_ofk) AND
      FCRA.crim_is_ok (todays_date, RIGHT.fcra_date, RIGHT.fcra_conviction_flag, RIGHT.fcra_traffic_flag)),
      TRANSFORM(offense_rec, SELF:=RIGHT), // Evn though I have FFD offenders information IN LEFT, I decided NOT to take them.
      KEEP(iesp.Constants.CRIM.MaxOffenses),LIMIT(0)
    );

    // overrides (FCRA side only)
    offense_override := CHOOSEN (fcra.key_override_crim.offenses (KEYED (flag_file_id IN offenses_ffid),
                           (FCRA.crim_is_ok (todays_date, fcra_date, fcra_conviction_flag, fcra_traffic_flag))), MAX_OVERRIDE_LIMIT);

    off_over_st := PROJECT (offense_override, offense_rec);

    offense_fcra := offense_data + off_over_st;//project (off_over_st, GetStandardOffense (LEFT));
    
    // ------------------------------------------------FCRA FFD ----------------------------------
    offense_ds_rec xformDSOffense(offense_rec l,
                                  FFD.Layouts.PersonContextBatchSlim r ) := TRANSFORM,
    SKIP((~ShowDisputedRecords AND r.isDisputed) OR (~ShowConsumerStatements AND EXISTS(r.StatementIDs)))
      SELF.StatementIDs := r.StatementIds;
      SELF.IsDisputed := r.IsDisputed;
      SELF := l;
    END;
    
    offense_data_fcra := JOIN(offense_fcra, slim_pc_recs(DataGroup = FFD.Constants.DATAGROUPS.OFFENSES),
                              LEFT.offense_persistent_id = (UNSIGNED) RIGHT.RecId1,
                              xformDSOffense(LEFT,RIGHT),
                              LEFT OUTER,
                              KEEP(1),LIMIT(0));
    // -------------------------------------------------------------------------------------------
                          
    offense_raw := IF (IsFCRA, offense_data_fcra, PROJECT(offense_data,offense_ds_rec));

    // --------------------------------------------------------------------
    // ---------------------- COURT OFFENSE RECORDS -----------------------
    // --------------------------------------------------------------------
    court_offenses_ofk := SET (flagfile (file_id=FCRA.FILE_ID.COURT_OFFENSES), record_id);
    court_offenses_ffid := SET (flagfile (file_id=FCRA.FILE_ID.COURT_OFFENSES), flag_file_id);
    court_offenses_key := doxie_files.Key_Court_Offenses(isFCRA);
    
    court_rec := RECORD
      Corrections.layout_CourtOffenses -[offense_category];
    END;
    court_ds_rec := RECORD(court_rec)
      FFD.Layouts.CommonRawRecordElements;
    END;
    
    court_data := JOIN(
      unique_offenders, court_offenses_key,
      KEYED(LEFT.offender_key=RIGHT.ofk) AND
      (~isFCRA OR
      // TODO: this may be redundant in case if input is already FCRA-compliant.
      (STRING) RIGHT.offense_persistent_id NOT IN court_offenses_ofk),
      TRANSFORM(court_rec, SELF:=RIGHT),
      KEEP(iesp.Constants.CRIM.MaxCourtOffenses),LIMIT(0)
    );
    
    // overrides (FCRA side only)
    court_override := CHOOSEN (fcra.key_override_crim.court_offenses (KEYED (flag_file_id IN court_offenses_ffid)), MAX_OVERRIDE_LIMIT);
    // combine main data and overrides; apply FCRA-filtering
    // available dates are: (process_date, off_date, arr_date, arr_disp_date, court_disp_date, appeal_date)
    court_fcra_ready := court_data + PROJECT (court_override, court_rec) (
      FCRA.crim_is_ok (todays_date, fcra_date, fcra_conviction_flag, fcra_traffic_flag));
      
    // ------------------------------------------------FCRA FFD ----------------------------------
    court_ds_rec xformDSCourtOffense( court_rec l,
                                      FFD.Layouts.PersonContextBatchSlim r ) := TRANSFORM,
    SKIP((~ShowDisputedRecords AND r.isDisputed) OR (~ShowConsumerStatements AND EXISTS(r.StatementIDs)))
      SELF.StatementIDs := r.StatementIds;
      SELF.IsDisputed := r.IsDisputed;
      SELF := l;
    END;
    
    court_data_fcra := 
      JOIN(court_fcra_ready, slim_pc_recs(DataGroup = FFD.Constants.DATAGROUPS.COURT_OFFENSES),
        LEFT.offense_persistent_id = (UNSIGNED)RIGHT.RecId1,
        xformDSCourtOffense(LEFT, RIGHT),
        LEFT OUTER,
        KEEP(1),LIMIT(0));

    // ---------------------------------------------------------------------------------------------
    courtOffense_raw := IF (IsFCRA, court_data_fcra, PROJECT(court_data, court_ds_rec));


    // --------------------------------------------------------------------
    // ------------------------ PUNISHMENT RECORDS ------------------------
    // --------------------------------------------------------------------
    punishment_ofk := SET (flagfile (file_id=FCRA.FILE_ID.PUNISHMENT), record_id);
    punishment_ffid := SET (flagfile (file_id=FCRA.FILE_ID.PUNISHMENT), flag_file_id);
    punishment_rec := corrections.Layout_CrimPunishment;
    punishment_ds_rec := RECORD(punishment_rec OR FFD.Layouts.CommonRawRecordElements)END;
    
    punishment_key := doxie_files.key_punishment(isFCRA);
    punishment_data := JOIN(
      unique_offenders, punishment_key, //corrections.Layout_CrimPunishment
      KEYED(LEFT.offender_key=RIGHT.ok) AND KEYED(RIGHT.pt IN ['I','P']) AND
      (~isFCRA OR
      // TODO: this may be redundant in case if input is already FCRA-compliant.
      ((STRING) RIGHT.punishment_persistent_id NOT IN punishment_ofk)),
      // TODO: find out if fcra date restrictions should be applied to either of these:
      // date_first_reported, date_last_reported, parole dates, conviction override date
      // FCRA.crim_is_ok (todays_date, Right.fcra_date, Right.fcra_conviction_flag, Right.fcra_traffic_flag),
      TRANSFORM(punishment_rec, SELF:=RIGHT),
      KEEP(iesp.Constants.CRIM.MaxPrisons + iesp.Constants.CRIM.MaxParoles),LIMIT(0)
    );

    // overrides (FCRA side only)
    // TODO: check if fcra date restrictions are to be applied for overrides
    punishment_override := CHOOSEN (fcra.key_override_crim.punishment (KEYED (flag_file_id IN punishment_ffid)), MAX_OVERRIDE_LIMIT);
    pun_over_st := PROJECT (punishment_override, punishment_rec);

    punishment_fcra := punishment_data + pun_over_st;
    // ------------------------------------------------FCRA FFD ----------------------------------
    punishment_ds_rec xformDSPunishment(punishment_rec l,
                                        FFD.Layouts.PersonContextBatchSlim r ) := TRANSFORM,
    SKIP((~ShowDisputedRecords AND r.isDisputed) OR (~ShowConsumerStatements AND EXISTS(r.StatementIDs)))
      SELF.StatementIDs := r.StatementIds;
      SELF.IsDisputed := r.IsDisputed;
      SELF := l;
    END;
    
    punishment_data_fcra := 
      JOIN(punishment_fcra, slim_pc_recs(DataGroup = FFD.Constants.DATAGROUPS.PUNISHMENT),
        LEFT.punishment_persistent_id = (UNSIGNED) RIGHT.RecId1,
        xformDSPunishment(LEFT,RIGHT),
        LEFT OUTER,
        KEEP(1),LIMIT(0));

    // ---------------------------------------------------------------------------------------------
    punishment_raw := IF (IsFCRA, punishment_data_fcra, PROJECT(punishment_data,punishment_ds_rec));

    // --------------------------------------------------------------------
    // ------------------------- ACTIVITY RECORDS -------------------------
    // --------------------------------------------------------------------
    activity_ofk := SET (flagfile (file_id=FCRA.FILE_ID.ACTIVITY), record_id);
    activity_ffid := SET (flagfile (file_id=FCRA.FILE_ID.ACTIVITY), flag_file_id);
    activity_rec := corrections.layout_activity;
    activity_ds_rec := RECORD(activity_rec OR FFD.Layouts.CommonRawRecordElements)END;
    activity_data := JOIN(
      unique_offenders, doxie_files.key_activity (IsFCRA),
      KEYED(LEFT.offender_key = RIGHT.ok) AND
      // TODO: this may be redundant in case if input is already FCRA-compliant.
      (~IsFCRA OR ((STRING)RIGHT.activity_persistent_id NOT IN activity_ofk)),
      TRANSFORM(activity_rec,SELF:=RIGHT),
      KEEP(iesp.Constants.CRIM.MaxEvents),LIMIT(0)
    );

    // overrides (FCRA side only)
    activity_override := CHOOSEN (fcra.key_override_crim.activity (KEYED (flag_file_id IN activity_ffid)), MAX_OVERRIDE_LIMIT);
    // combine main data and overrides; apply FCRA-filtering
    activity_fcra := (activity_data + PROJECT (activity_override, activity_rec))
                       (FCRA.crim_is_ok (todays_date, event_date, 'Y', 'N'));
                       
    // ------------------------------------------------FCRA FFD ----------------------------------
    activity_ds_rec xformDSActivity( activity_rec l,
                                      FFD.Layouts.PersonContextBatchSlim r ) := TRANSFORM,
    SKIP((~ShowDisputedRecords AND r.isDisputed) OR (~ShowConsumerStatements AND EXISTS(r.StatementIDs)))
      SELF.StatementIDs := r.StatementIds;
      SELF.IsDisputed := r.IsDisputed;
      SELF := l;
    END;
    
    activity_data_fcra := JOIN(activity_fcra, slim_pc_recs(DataGroup = FFD.Constants.DATAGROUPS.ACTIVITY),
                              LEFT.activity_persistent_id = (UNSIGNED) RIGHT.RecId1,
                              xformDSActivity(LEFT,RIGHT),
                              LEFT OUTER,
                              KEEP(1),LIMIT(0));

    // ---------------------------------------------------------------------------------------------
    activity_raw := IF (IsFCRA, activity_data_fcra, PROJECT(activity_data,activity_ds_rec));

    // Census_Data.MAC_County2Fips_Keyed(in_recs, st, county_name, county,, in_recs_w_county);
    
    grp_in_tmp := GROUP(SORT(in_recs,offender_key,(UNSIGNED)pty_typ,RECORD),offender_key);
    
    CriminalRecords_Services.layouts.l_raw name_selection(CriminalRecords_Services.layouts.l_raw L) := TRANSFORM
      //*****************************************************************************
      // Calculating the penalty in the report to overcome the issue with records
      // having same offenderID, same pty_typ and different name. The record that
      // matches to the input name should be the primary name and the remainig records
      // should be displayed in AKAs.
      //*******************************************************************************

      tempindvmod := MODULE(PROJECT(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,OPT))
        EXPORT allow_wildcard := FALSE;
        EXPORT city_field := '';
        EXPORT did_field := '';
        EXPORT fname_field := l.fname;
        EXPORT lname_field := l.lname;
        EXPORT mname_field := l.mname;
        EXPORT phone_field := '';
        EXPORT pname_field := '';
        EXPORT postdir_field := '';
        EXPORT prange_field := '';
        EXPORT predir_field := '';
        EXPORT ssn_field := '';
        EXPORT state_field := '';
        EXPORT suffix_field := '';
        EXPORT zip_field := '';
        EXPORT city2_field := '';
        EXPORT county_field := '';
        EXPORT dob_field := '';
        EXPORT dod_field := '';
      END;

      tempPenaltName := IF(isFCRA, 0, AutoStandardI.LIBCALL_PenaltyI_Indv.val_indv_name(tempindvmod));

      SELF.penalt := tempPenaltName;
      SELF.pty_typ := IF((UNSIGNED)l.pty_typ<>0,l.pty_typ,IF(tempPenaltName=0,'0','2'));
      
      SELF:=L;
    END;
    
    grp_in_tmp_srt := SORT(PROJECT(grp_in_tmp,name_selection(LEFT)),penalt,(UNSIGNED)pty_typ,lname,fname,mname,name_suffix,RECORD);// 52891 fix could be - infront of lname, fname,mname

    grp_in := IF(COUNT(grp_in_tmp((UNSIGNED)pty_typ=0))>1,
          grp_in_tmp_srt,
          grp_in_tmp);
    
  
    // generate CrimReportOffense records from the Offense key
    iesp.criminal.t_CrimReportArrest toOffense_Arrest(offense_ds_rec L) := TRANSFORM
      SELF.agency := '';
      SELF.casenumber := '';
      SELF.date := iesp.ECL2ESP.toDatestring8(L.arr_date);
      SELF.disposition := L.arr_disp_desc_1 + L.arr_disp_desc_2 + L.arr_disp_desc_3;
      SELF.DispositionDate := iesp.ECL2ESP.toDatestring8(L.arr_disp_date);
      SELF.level := L.off_lev; // STUB - decode?
      SELF.offense := L.off_desc_1 + L.off_desc_2;
      SELF.statute := '';
      SELF._Type := L.off_typ; // STUB - decode?
    END;
    
    iesp.criminal.t_CrimReportCourt toOffense_Court(offense_ds_rec L) := TRANSFORM
      SELF.casenumber := '';
      SELF.Costs := '';
      SELF.Description := L.court_desc;
      SELF.Disposition := L.ct_disp_desc_1 + L.ct_disp_desc_2;
      SELF.DispositionDate := iesp.ECL2ESP.toDatestring8(L.ct_disp_dt);
      SELF.Fine := '';
      SELF.Level := L.ct_off_lev; // STUB - decode?
      SELF.Offense := L.ct_off_desc_1 + L.ct_off_desc_2;
      SELF.Plea := L.ct_fnl_plea;
      SELF.Statute := '';
      SELF.SuspendedFine := '';
    END;
    
    iesp.criminal_fcra.t_FcraCrimReportOffense toOffense(offense_ds_rec L, STRING case_type) := TRANSFORM
      SELF.AdjudicationWithheld := L.adj_wthd;
      SELF.CaseNumber := L.case_num;
      SELF.CaseType := case_type;//''; // STUB
      SELF.CaseTypeDescription := ''; // STUB
      SELF.COUNT := ''; // STUB
      SELF.County := L.county_of_origin;
      SELF.OffenseTown := L.OffenseTown; // added 07/30/19 for JIRA RR-15769
      SELF.Description := ''; // STUB
      SELF.MaximumTerm := L.max_term_desc;
      SELF.MinimumTerm := L.min_term_desc;
      SELF.NumberCounts := L.num_of_counts;
      SELF.OffenseDate := iesp.ECL2ESP.toDatestring8(L.off_date);
      SELF.OffenseType := L.off_typ;
      SELF.Sentence := STD.Str.CleanSpaces(l.stc_desc_1 + ' ' + l.stc_desc_2 + ' ' + l.stc_desc_3 + ' ' + l.stc_desc_4);//'';
      SELF.SentenceLengthDescription:= L.stc_lgth_desc;
      // self.SentenceDescription1 := L.stc_desc_1;
      SELF.SentenceDate := iesp.ECL2ESP.toDatestring8(L.stc_dt);
      SELF.IncarcerationDate := iesp.ECL2ESP.toDatestring8(L.inc_adm_dt);
      SELF.Appeal := [];
      SELF.Arrest := ROW(toOffense_Arrest(L));
      SELF.Court := ROW(toOffense_Court(L));
      SELF.CourtSentence := [];
      SELF.isDisputed := L.isDisputed;
      SELF.StatementIds := L.StatementIds;
    END;
    
    // generate CrimReportOffense records from the Court Offense key
    iesp.criminal.t_CrimReportAppeal toCourtOff_Appeal(court_ds_rec L) := TRANSFORM
      SELF.Disposition := L.appeal_off_disp;
      SELF.FinalDisposition := L.appeal_final_decision;
      SELF.date := iesp.ECL2ESP.toDatestring8(L.appeal_date);
    END;
    
    iesp.criminal.t_CrimReportArrest toCourtOff_Arrest(court_ds_rec L) := TRANSFORM
      SELF.agency := L.le_agency_desc;
      SELF.casenumber := L.le_agency_case_number;
      SELF.date := iesp.ECL2ESP.toDatestring8(L.arr_date);
      SELF.disposition := IF(L.arr_disp_desc_1<>'', L.arr_disp_desc_1 + L.arr_disp_desc_2, L.arr_disp_desc_2);
      SELF.DispositionDate := iesp.ECL2ESP.toDatestring8(L.arr_disp_date);
      SELF.level := L.arr_off_lev_mapped;
      SELF.offense := L.arr_off_desc_1 + L.arr_off_desc_2;
      SELF.statute := IF(L.arr_statute_desc<>'', L.arr_statute_desc, L.arr_statute);
      SELF._type := L.arr_off_type_desc;
    END;
    
    iesp.criminal.t_CrimReportCourt toCourtOff_Court(court_ds_rec L) := TRANSFORM
      SELF.casenumber := L.court_case_number;
      SELF.Costs := L.sent_court_cost;
      SELF.Description := L.court_desc;
      SELF.Disposition := IF(L.court_disp_desc_1<>'', L.court_disp_desc_1 + L.court_disp_desc_2, L.court_disp_desc_2);
      SELF.DispositionDate := iesp.ECL2ESP.toDatestring8(L.court_disp_date);
      SELF.Fine := L.sent_court_fine;
      SELF.Level := L.court_off_lev_mapped;
      SELF.Offense := L.court_off_desc_1 + L.court_off_desc_2;
      SELF.Plea := L.court_final_plea;
      SELF.Statute := IF(L.court_statute_desc<>'', L.court_statute_desc, L.court_statute);
      SELF.SuspendedFine := L.sent_susp_court_fine;
    END;
    
    iesp.criminal.t_CrimReportCourtSentence toCourtOff_Sentence(court_ds_rec L) := TRANSFORM
      SELF.jail := L.sent_jail;
      SELF.probation := L.sent_probation;
      SELF.suspended := L.sent_susp_time;
    END;
    
    iesp.criminal_fcra.t_FcraCrimReportOffense toCourtOffense(court_ds_rec L) := TRANSFORM
      SELF.AdjudicationWithheld := '';
      SELF.CaseNumber := '';
      SELF.CaseType := ''; // STUB
      SELF.CaseTypeDescription := ''; // STUB
      SELF.COUNT := L.off_comp;//''; // STUB
      SELF.County := '';
      SELF.OffenseTown := L.offense_town; // added 07/30/19 for JIRA RR-15769
      SELF.Description := ''; // STUB
      SELF.MaximumTerm := '';
      SELF.MinimumTerm := '';
      SELF.NumberCounts := L.num_of_counts;
      SELF.OffenseDate := iesp.ECL2ESP.toDatestring8(L.off_date);
      SELF.OffenseType := '';
      SELF.Sentence := '';
      SELF.SentenceLengthDescription:= ''; // STUB
      // self.SentenceDescription1 := '';
      SELF.SentenceDate := iesp.ECL2ESP.toDatestring8(L.sent_date);
      SELF.IncarcerationDate := iesp.ECL2ESP.toDatestring8('');
      SELF.Appeal := ROW(toCourtOff_Appeal(L));
      SELF.Arrest := ROW(toCourtOff_Arrest(L));
      SELF.Court := ROW(toCourtOff_Court(L));
      SELF.CourtSentence := ROW(toCourtOff_Sentence(L));
      SELF.isDisputed := L.isDisputed;
      SELF.StatementIds := L.StatementIds;
    END;
    
    iesp.criminal_fcra.t_FcraCrimReportPrison toPrison(punishment_ds_rec L) := TRANSFORM
      SELF.AdmittedDate := iesp.ECL2ESP.toDatestring8(L.latest_adm_dt);
      SELF.CurrentStatus := L.cur_stat_inm_desc;
      SELF.CustodyType := L.cur_loc_sec; // STUB
      SELF.CustodyTypeChangeDate := iesp.ECL2ESP.toDatestring8(''); // STUB
      SELF.GainTimeGranted := L.gain_time;
      SELF.LastGainTime := iesp.ECL2ESP.toDatestring8(L.gain_time_eff_dt);
      SELF.Location := L.cur_loc_inm; // STUB
      SELF.ScheduledReleaseDate := iesp.ECL2ESP.toDatestring8(L.sch_rel_dt);
      SELF.Sentence := L.sent_length_desc;
      SELF.isDisputed := L.isDisputed;
      SELF.StatementIds := L.StatementIds;
    END;

    iesp.criminal_fcra.t_FcraCrimReportParole toParole(punishment_ds_rec L) := TRANSFORM
      SELF.ActualEndDate := iesp.ECL2ESP.toDatestring8(L.par_act_end_dt);
      SELF.County := L.par_cty;
      SELF.CurrentStatus := L.par_cur_stat_desc;
      SELF.LENGTH := L.sent_length_desc;
      SELF.ScheduledEndDate := iesp.ECL2ESP.toDatestring8(L.par_sch_end_dt);
      SELF.StartDate := iesp.ECL2ESP.toDatestring8(L.par_st_dt);
      SELF.isDisputed := L.isDisputed;
      SELF.StatementIds := L.StatementIds;
    END;
    
    iesp.criminal_fcra.t_FcraCrimReportEvent toActivity(activity_ds_rec L) := TRANSFORM
      SELF.Date := iesp.ECL2ESP.toDatestring8(L.event_date);
      SELF.Description := TRIM(L.event_desc_1) + IF(TRIM(L.event_desc_2)='', '', ' '+L.event_desc_2);
      SELF.isDisputed := L.isDisputed;
      SELF.StatementIds := L.StatementIds;
    END;
    
    iesp.criminal.t_CrimReportParoleOffense toParoleOffense (offense_ds_rec L):=TRANSFORM
      SELF.SentenceDate :=[];
      SELF.LENGTH := (UNSIGNED) L.stc_lgth;
      SELF.OffenseCounty :=l.cty_conv;
      SELF.CauseNo := l.case_num;
      SELF.NCICCode := l.off_code;
      SELF.OffenseCount := (UNSIGNED) l.num_of_counts;
      SELF.OffenseDate := iesp.ECL2ESP.toDatestring8(L.off_date);
    END;
    
    iesp.criminal_fcra.t_FcraCrimReportParoleEx toParoleEx(CriminalRecords_Services.layouts.l_raw L, DATASET(punishment_ds_rec) P, DATASET(offense_ds_rec) O) := TRANSFORM

      parole_row:=p[1];
      SELF.ActualEndDate := iesp.ECL2ESP.toDatestring8(parole_row.par_act_end_dt);
      SELF.County := parole_row.par_cty;
      SELF.CurrentStatus := parole_row.par_cur_stat_desc;
      SELF.LENGTH := parole_row.sent_length_desc;
      SELF.ScheduledEndDate := iesp.ECL2ESP.toDatestring8(parole_row.par_sch_end_dt);
      SELF.StartDate := iesp.ECL2ESP.toDatestring8(parole_row.par_st_dt);
      
      SELF.DateReported := iesp.ECL2ESP.toDatestring8(L.file_date) ;
      SELF.PubicSaftyId := L.dle_num ;
      SELF.InmateId := L.doc_num ;
      SELF.ParoleInAbsentiaId := L.id_num ;
      SELF.Name := iesp.ECL2ESP.SetName(L.fname, L.mname, L.lname, L.name_suffix,'');
      SELF.Race := L.race ; // shoud it be l.race_desc[1] OR L.race ??????
      SELF.Gender := L.sex ;
      SELF.DOB := iesp.ECL2ESP.toDatestring8(L.dob) ;
      SELF.CountyOfBirth := L.county_of_birth ;
      SELF.StateOfBirth := L.place_of_birth ;
      SELF.HeightFeet := ((UNSIGNED) L.height) DIV 12 ;
      SELF.HeightInches := ((UNSIGNED) L.height)%12;
      SELF.WeightInPounds := (UNSIGNED) L.weight ;
      SELF.HairColor := L.hair_color ;
      SELF.SkinColor := L.skin_color ;
      SELF.EyeColor := L.eye_color ;

      SELF.CurrentStatusFlag := parole_row.parole_active_flag;//parole_row.par_cur_stat_desc ;
      SELF.CurrentStatusEffectiveDate := iesp.ECL2ESP.toDatestring8(parole_row.par_status_dt) ;
      SELF.ParoleRegion := parole_row.office_region ;
      SELF.SupervisingOffice := parole_row.supv_office ;
      SELF.SupervisingOfficerName := parole_row.supv_officer ;
      SELF.SupervisingOfficerPhone := parole_row.office_phone ;
      SELF.LastKnownResidence := iesp.ECL2ESP.SetAddress(L.prim_name, L.prim_range, L.predir, L.postdir,
                                             L.addr_suffix, L.unit_desig, L.sec_range,
                                             L.v_city_name, L.st, L.zip5, L.zip4, L.county_name);
      SELF.ReleaseArrivalDate := iesp.ECL2ESP.toDatestring8(parole_row.act_rel_dt) ;
      SELF.ReleaseType := parole_row.release_type ;
      SELF.ReleaseCounty := parole_row.par_cty ;
      SELF.LegalResidenceCounty := L.legal_residence_county ;
      SELF.OffenseCount := (UNSIGNED) o[1].total_num_of_offenses ;
      SELF.Is3GOffender := IF(L._3G_offender<>'',TRUE,FALSE);
      SELF.IsViolentOffender := IF(L.violent_offender<>'',TRUE,FALSE) ;
      SELF.IsSexOffender := IF(L.sex_offender<>'',TRUE,FALSE) ;
      SELF.IsOnViolentOffenderProgram := IF(L.vop_offender<>'',TRUE,FALSE) ;
      TimeToServe_val:=SORT(o,-stc_lgth);
      dur:=INTFORMAT((UNSIGNED) TimeToServe_val[1].stc_lgth,6,1);
      SELF.LongestTimeToServe := ROW({dur[1..2],dur[3..4],dur[5..6]} ,iesp.share.t_Duration);
      SELF.LongestTimeToServeDescription := TimeToServe_val[1].stc_lgth_desc;
      SELF.DischargeDate := iesp.ECL2ESP.toDatestring8(parole_row.sch_rel_dt) ; // OR L.act_rel_dt?
      SELF.ScarsMarksTattoos := DATASET([
        {L.scars_marks_tattoos_1},
        {L.scars_marks_tattoos_2},
        {L.scars_marks_tattoos_3},
        {L.scars_marks_tattoos_4},
        {L.scars_marks_tattoos_5}] ,
        iesp.share.t_StringArrayItem)(value<>'');
      // self.Offenses := choosen(dedup(normalize(o,count(o)/*4*/,toParoleOffense(LEFT,COUNTER)),all),iesp.Constants.crim.MaxOffenses) ;
      SELF.Offenses := CHOOSEN(DEDUP(SORT(PROJECT(o(vendor='TX'),toParoleOffense(LEFT)), -SentenceDate, -OffenseDate, RECORD), RECORD),iesp.Constants.crim.MaxParOffenses) ;
      SELF.LastParoleReviewDate := iesp.ECL2ESP.toDatestring8(parole_row.casepull_date) ;
      SELF.PrisonFacilityType := parole_row.tdcjid_unit_type ;
      SELF.PrisonFacilityName := parole_row.tdcjid_unit_assigned ;
      SELF.AdmittedDate := iesp.ECL2ESP.toDatestring8(parole_row.tdcjid_admit_date) ;
      SELF.PrisonStatus := parole_row.prison_status ;
      SELF.LastReceiveOrDepartCode := parole_row.recv_dept_code ;
      SELF.LastReceiveOrDepartCDate := iesp.ECL2ESP.toDatestring8(parole_row.recv_dept_date) ;
      record_setup_date:=INTFORMAT((UNSIGNED) l.record_setup_date,14,1);
      SELF.RecordCreatedTimeStamp := ROW({record_setup_date[1..4],
                                          record_setup_date[5..6],
                                          record_setup_date[7..8],
                                          record_setup_date[9..10],
                                          record_setup_date[11..12],
                                          record_setup_date[13..14]},
                                          iesp.share.t_TimeStamp) ;
      
      //***************************************************************************************
      //data not available. Will be implemented in Phase 2
      // self.CurrentStatusFlag := parole_row.parole_active_flag;
      // self.LastParoleReviewDate := iesp.ECL2ESP.toDatestring8(L.casepull_date) ; //LastParoleReviewDate')};
      // self.PrisonFacilityType := L.tdcjid_unit_type ; //PrisonFacilityType')};
      // self.PrisonFacilityName := L.tdcjid_unit_assigned ; //PrisonFacilityName')};
      // self.AdmittedDate := iesp.ECL2ESP.toDatestring8(L.tdcjid_admit_date) ; //AdmittedDate')};
      // self.PrisonStatus := L.prison_status ; //PrisonStatus')};
      // self.LastReceiveOrDepartCode := L.recv_dept_code ; //LastReceiveOrDepartCode')};
      // self.LastReceiveOrDepartCDate := iesp.ECL2ESP.toDatestring8(L.recv_dept_date) ; //LastReceiveOrDepartCDate')};
      // self.RecordCreatedTimeStamp := [];//ROW({iesp.ECL2ESP.toDatestring8(L.record_setup_date)},L.record_setup_date) ; //RecordCreatedTimeStamp')};
      //***************************************************************************************
      SELF.isDisputed := L.isDisputed;
      SELF.StatementIds := L.StatementIds;
    END;
    
    layout_tmp:=RECORD
      iesp.criminal_fcra.t_FcraCrimReportRecord;
      STRING2 vendor;
    END;
    layout_tmp toReport(CriminalRecords_Services.layouts.l_raw L, DATASET(CriminalRecords_Services.layouts.l_raw) R) := TRANSFORM

      SELF.datasource := L.datasource;
      SELF.offenderid := L.offender_key;
      
      SELF.name := iesp.ECL2ESP.SetName(L.fname, L.mname, L.lname, L.name_suffix,'');
      
      SELF.address := iesp.ECL2ESP.SetAddress(L.prim_name, L.prim_range, L.predir, L.postdir,
                               L.addr_suffix, L.unit_desig, L.sec_range,
                               L.v_city_name, L.st, L.zip5, L.zip4, L.county_name);
      
      SELF.ssn := IF(L.ssn<>'',L.ssn,L.ssn_appended);
      SELF.DOB := iesp.ECL2ESP.toDatestring8( IF(L.pty_typ='2',L.dob_alias,L.dob) );
      
      SELF.stateofOrigin := L.orig_state;
      SELF.stateofBirth := L.place_of_birth;
      SELF.uniqueid := L.did;
      SELF.countyofOrigin := L.county_of_origin;
      SELF.caseNumber := L.case_num;
      SELF.docNumber := L.doc_num;

      SELF.CaseFilingDate := iesp.ECL2ESP.toDatestring8(L.case_date);
      SELF.eyes := L.eye_color_desc;
      SELF.hair := L.hair_color_desc;
      SELF.height := L.height;
      SELF.weight := L.weight;
      SELF.race := L.race_desc;
      SELF.sex := Codes.General.GENDER(L.sex);
      SELF.skin := L.skin_color_desc;
      SELF.status := L.party_status_desc;
      SELF.CaseTypeDescription := L.case_type_desc;
      SELF.IsImageAvailable := IF(L.image_link = '', FALSE, TRUE);

      akas_fmt := PROJECT(R[2..],TRANSFORM(iesp.share.t_name, SELF:=iesp.ECL2ESP.SetName(LEFT.fname, LEFT.mname, LEFT.lname, LEFT.name_suffix,'')));
      akas_sort := DEDUP(SORT(akas_fmt,last,FIRST,middle,RECORD),RECORD);
      SELF.akas := CHOOSEN(akas_sort, iesp.Constants.CRIM.MaxAKAs);
  
      // NOTE: A given row will actually only have only offenses or court offenses, not both, but we
      // don't know in advance which key to check and they wind up in a common format anyway.
      courtOffense_filt := courtOffense_raw(offender_key=L.offender_key);
      coff := PROJECT(courtOffense_filt,toCourtOffense(LEFT));
      courtOffense_fmt := DEDUP(SORT(coff,coff.COUNT, -OffenseDate, -SentenceDate, RECORD),RECORD);
      
      offense_filt := offense_raw(offender_key=L.offender_key);
      offense_fmt := DEDUP(PROJECT(offense_filt,toOffense(LEFT,l.case_type_desc)),RECORD,ALL);
      ofds := courtOffense_fmt&offense_fmt;
      SELF.offenses := CHOOSEN(ofds, iesp.Constants.CRIM.MaxOffenses);
      
      prison_filt := punishment_raw(offender_key=L.offender_key, punishment_type='I');
      prison_fmt := PROJECT(prison_filt,toPrison(LEFT));
      prison_sort := DEDUP(SORT(prison_fmt, -AdmittedDate, -ScheduledReleaseDate, RECORD), RECORD);
      SELF.prisonSentences := CHOOSEN(prison_sort, iesp.Constants.CRIM.MaxPrisons);
      
      activity_filt := activity_raw(offender_key=L.offender_key);
      activity_fmt := PROJECT(activity_filt,toActivity(LEFT));
      activity_sort := DEDUP(SORT(activity_fmt, -Date, Description, RECORD), RECORD);
      SELF.activities := CHOOSEN(activity_sort, iesp.Constants.CRIM.MaxEvents);

      parole_filt := punishment_raw(offender_key=L.offender_key, punishment_type='P');
      parole_fmt := PROJECT(parole_filt,toParole(LEFT));
      parole_sort := DEDUP(SORT(parole_fmt, -ActualEndDate, -ScheduledEndDate, -StartDate, RECORD), RECORD);
      SELF.paroleSentences := CHOOSEN(parole_sort, iesp.Constants.CRIM.MaxParoles);
      
      Parole_fmt_Ex_Tx := PROJECT(DATASET (l),toParoleEx(LEFT,parole_filt,offense_filt));
      Parole_fmt_Ex := PROJECT (CHOOSEN(parole_sort, iesp.Constants.CRIM.MaxParoles), TRANSFORM (iesp.criminal_fcra.t_FcraCrimReportParoleEx, SELF := LEFT, SELF:=[]));

      SELF.vendor:=l.vendor;
      SELF.ParoleSentencesEx := IF (~IsFCRA, IF (l.vendor='TX', Parole_fmt_Ex_Tx,Parole_fmt_Ex));
      SELF.isDisputed := L.isDisputed;
      SELF.StatementIds := L.StatementIds;
    END;
    
    temp_formatted := ROLLUP(grp_in, GROUP, toReport(LEFT,ROWS(LEFT)));
    temp_sorted := SORT(temp_formatted, -CaseFilingDate, offenderid);
    
    iesp.criminal_fcra.t_FcraCrimReportRecord final_xform(layout_tmp l):=TRANSFORM
      nada:=DATASET([],iesp.criminal_fcra.t_FcraCrimReportParoleEx);
      SELF.ParoleSentencesEx:=IF(l.vendor='TX',l.ParoleSentencesEx,nada);
      SELF:=l;
    END;
    
    final_sorted:=PROJECT(temp_sorted,final_xform(LEFT));
    // output(grp_in, named('grp_in')); // DEBUG
    // output(get_parole_ex_data(), named('get_parole_ex_data')); // DEBUG
    // output(temp_formatted, named('temp_formatted')); // DEBUG
    // output(in_mod);
    //output(courtOffense_raw,named('courtOffense_raw'));
    //output(activity_raw,named('activity_raw'));
    //output(punishment_raw,named('punishment_raw'));
    //output(offense_raw,named('offense_raw'));
    //output(final_sorted,named('final_sorted'));
    RETURN final_sorted;
  END;
  
END;
