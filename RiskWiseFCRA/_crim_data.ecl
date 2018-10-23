import CriminalRecords_Services, CrimSrch, corrections, doxie, doxie_files, fcra, riskwise, ut, iesp, risk_indicators;

boolean IsFCRA := true;
MAX_OVERRIDE_LIMIT := FCRA.compliance.MAX_OVERRIDE_LIMIT;

// fcra-specific restrictions attributes
integer date_max := CriminalRecords_Services.Constants.date_max;

todaysdate := ut.GetDate; // for checking derog's fcra-date compliance
unsigned3 history_date := 999999;  // removed the input history date, this query is not meant to be run in historical mode


// NOTE: function is not "batch-safe": if multiple DIDs ever going to be passed as an input,
// then correction records from the FlagFile should be checked for each DID individually.
// Right now there's no need to account for that.

layout_offenders    := Corrections.layout_offender;
layout_offenses     := Corrections.Layout_Offense_Common and not offense_category;
layout_punishment   := Corrections.Layout_CrimPunishment;
layout_offenderplus := corrections.layout_Offender;
layout_courtOffense := corrections.layout_CourtOffenses and not offense_category;
layout_activity     := corrections.layout_activity;

EXPORT _crim_data (dataset (doxie.layout_references) dids, 
                   dataset (fcra.Layout_override_flag) flag_file,
                   // integer nss = nss_const.doNothing,
									 boolean SkipRiskviewFilters = false
                   ) := MODULE
	boolean isFCRA := true;

  shared layout_offender_key := record
    layout_offenders.offender_key;
  end;


  // -------------  OFFENDERS  -------------
	crim_correct_ofk := SET(flag_file(file_id = FCRA.FILE_ID.OFFENDERS),record_id);
	crim_correct_ffid := SET(flag_file(file_id = FCRA.FILE_ID.OFFENDERS),flag_file_id);
  //get good records
  offenders := JOIN (dids, doxie_files.Key_Offenders(isFCRA), 
                     keyed (Left.did = Right.sdid) AND
                     ((string)Right.offender_key NOT IN crim_correct_ofk) AND
                     (unsigned3)(Right.fcra_date[1..6]) < history_date AND
										 (RIGHT.offense_score in risk_indicators.iid_constants.set_valid_offense_scores or SkipRiskviewFilters), 
                     TRANSFORM (layout_offenders, SELF := Right),
                     atmost(riskwise.max_atmost));

  //get corrections
  ds_override := fcra.key_override_crim.offenders (keyed (flag_file_id IN crim_correct_ffid));
  ds_corrected := PROJECT(CHOOSEN (ds_override, MAX_OVERRIDE_LIMIT), layout_offenders) + offenders;

  // fcra offenders data now only includes convicted felony data as of 10/17, so this filter is really only filtering by date now really
  shared pre_offenders := ds_corrected (FCRA.crim_is_ok (todaysdate, fcra_date, fcra_conviction_flag, fcra_traffic_flag));
  //these are preliminary records; they will be filtered later by dissmissed offenses


  // -------------  OFFENSES  -------------
	offenses_puid := SET (flag_file (file_id=FCRA.FILE_ID.OFFENSES), record_id);
  offenses_ffid := SET (flag_file (file_id=FCRA.FILE_ID.OFFENSES), flag_file_id);
  //get good records
  offenses := JOIN (dedup (pre_offenders, offender_key, all), doxie_files.Key_Offenses(isFCRA), 
                    Left.offender_key<>'' AND keyed (Left.offender_key = Right.ok) AND
                    ((string)Right.offense_persistent_id NOT IN offenses_puid) AND
										(RIGHT.offense_score in risk_indicators.iid_constants.set_valid_offense_scores or SkipRiskviewFilters),
                    TRANSFORM (layout_offenses, SELF := Right),
                    LEFT OUTER, atmost(riskwise.max_atmost));

  //get corrections
  ds_override := fcra.key_override_crim.offenses (keyed (flag_file_id IN offenses_ffid));
  ds_corrected := PROJECT (CHOOSEN (ds_override, MAX_OVERRIDE_LIMIT), layout_offenses) + offenses;
     
  // fcra offenders data now only includes convicted felony data as of 10/17, so this filter is really only filtering by date now really
  corrected_filtered := ds_corrected (FCRA.crim_is_ok (todaysdate, fcra_date, fcra_conviction_flag, fcra_traffic_flag));

  cSort := sort( corrected_filtered, except process_date); //process_date corresponds to first_date_reported and last_date_reported in old layout
  shared pre_offenses := dedup( cSort, except process_date);

  // check which offenses were "dismissed"
  dismissed_offenses := pre_offenses(stringlib.stringfind(ct_disp_desc_1, 'DISMISSED', 1) > 0 or stringlib.stringfind(ct_disp_desc_2, 'DISMISSED', 1) > 0 );
  shared set_ofks_dissmissed := if(SkipRiskviewFilters, [], set(dismissed_offenses, offender_key));

  // now: remove dissmissed offenders and offenses
  ungr_offenders := sort(pre_offenders (offender_key not in set_ofks_dissmissed), process_date);
  EXPORT offenders := ungr_offenders;

  EXPORT offenses := sort(pre_offenses(offender_key not in set_ofks_dissmissed), process_date);


  // if we want "cluster" suppression (i.e. by OFK, not record-level suppression)
  shared crim_ids := dedup (project (offenders, layout_offender_key), ALL);

  // -------------  PUNISHMENT  -------------
  // NB: uses offenses which were already corrected
  layout_punishment GetPunishmentData (DATASET (layout_offenses) offenses) := FUNCTION
		punishment_puid  := SET (flag_file (file_id=FCRA.FILE_ID.PUNISHMENT), record_id);
    punishment_ffid := SET (flag_file (file_id=FCRA.FILE_ID.PUNISHMENT), flag_file_id);
    punishments := JOIN (DEDUP (SORT (offenses, offender_key), offender_key), doxie_files.Key_Punishment(isFCRA), 
                    Left.offender_key <> '' AND keyed (Left.offender_key = Right.ok)
										and ((string)right.punishment_persistent_id NOT IN punishment_puid),
                    TRANSFORM (layout_punishment, SELF := Right), atmost(riskwise.max_atmost));
    // do not get good records: offender keys are all good, since 'offenses' were corrected already
    
    //get corrections
    ds_override := fcra.key_override_crim.punishment (keyed (flag_file_id IN punishment_ffid));
    ds_corrected := PROJECT (CHOOSEN (ds_override, MAX_OVERRIDE_LIMIT), layout_punishment) + punishments;

    RETURN ds_corrected;// (FCRA.crim_is_ok (todaysdate, fcra_date, fcra_conviction_flag, fcra_traffic_flag));
  END;	
  ungr_punishments := sort(GetPunishmentData (offenses), process_date);
  EXPORT punishments := ungr_punishments;

  // ===========================================================================================
  // ===========================================================================================
  // ===========================================================================================
  // additional 3 overrides, which are used by fcra-compreport;
  // all fetched just by criminal records' ID (offender_key), taken from OFFENDERS defined above

  // -------------  OFFENDER PLUS DATA  -------------
  layout_offenderplus GetOffendersPlusData (DATASET (layout_offender_key) ids) := FUNCTION
		offenders_puid  := SET (flag_file (file_id=FCRA.FILE_ID.OFFENDERS_PLUS), record_id);
		offenders_ffid := SET (flag_file (file_id=FCRA.FILE_ID.OFFENDERS_PLUS), flag_file_id);
    recs := join (ids, doxie_files.Key_Offenders_OffenderKey(isFCRA),
                  keyed (Left.offender_key = Right.ofk) and
                  ((string)right.offender_persistent_id NOT IN offenders_puid),
                  transform (layout_offenderplus, Self := Right),
                  atmost (ut.limits.OFFENDERS_MAX));

    //get corrections
    ds_override := fcra.key_override_crim.offenders_plus (keyed (flag_file_id IN offenders_ffid));
    ds_corrected := recs + CHOOSEN (project (ds_override, layout_offenderplus), MAX_OVERRIDE_LIMIT);

    // fcra filtering
    return ds_corrected (
      FCRA.crim_is_ok (ut.GetDate, fcra_date, fcra_conviction_flag, fcra_traffic_flag));
  END;
  EXPORT offenders_plus := sort(GetOffendersPlusData (crim_ids), -file_date);


  // -------------  COURT OFFENSES  -------------
  layout_courtOffense GetCourtOffenseData (DATASET (layout_offender_key) ids) := FUNCTION
		court_offenses_puid  := SET (flag_file (file_id=FCRA.FILE_ID.COURT_OFFENSES), record_id);
		court_offenses_ffid := SET (flag_file (file_id=FCRA.FILE_ID.COURT_OFFENSES), flag_file_id);
    recs := join (ids, doxie_files.key_court_offenses(isFCRA),
                  keyed (Left.offender_key = Right.ofk) and
                  //this is a formality, since input IDs are already corrected.
                  ((string)right.offense_persistent_id NOT IN court_offenses_puid),
                  transform (layout_courtOffense, Self := Right),
                  keep(iesp.Constants.CRIM.MaxCourtOffenses));

    //get corrections
    ds_override := fcra.key_override_crim.court_offenses (keyed (flag_file_id IN court_offenses_ffid));
    ds_corrected := recs + CHOOSEN (project (ds_override, layout_courtOffense), MAX_OVERRIDE_LIMIT);

    // fcra filtering
    // available dates are: (process_date, off_date, arr_date, arr_disp_date, court_disp_date, appeal_date)
    return ds_corrected (
      FCRA.crim_is_ok (ut.GetDate, fcra_date, fcra_conviction_flag, fcra_traffic_flag));
  END;
  EXPORT court_offenses := sort(GetCourtOffenseData (crim_ids), -appeal_date);


  // -------------  ACTIVITY  -------------
  layout_activity GetActivityData (DATASET (layout_offender_key) ids) := FUNCTION
		activity_puid  := SET (flag_file (file_id=FCRA.FILE_ID.ACTIVITY), record_id);
		activity_ffid := SET (flag_file (file_id=FCRA.FILE_ID.ACTIVITY), flag_file_id);
    recs := join (ids, doxie_files.key_activity (IsFCRA),
                  keyed (left.offender_key = right.ok) and
                  //this is a formality, since input IDs are already corrected.
                  ((string)right.activity_persistent_id NOT IN activity_puid),
                  transform (layout_activity, Self := Right),
                  keep (iesp.Constants.CRIM.MaxEvents));

    //get corrections
    ds_override := fcra.key_override_crim.activity (keyed (flag_file_id IN activity_ffid));
    ds_corrected := recs + CHOOSEN (project (ds_override, layout_activity), MAX_OVERRIDE_LIMIT);

    return ds_corrected (FCRA.crim_is_ok (ut.GetDate, event_date, 'Y', 'N'));
    // TODO: most probably conviction flag and traffic flag are not relevant to activity
      // that's what is there: (process_date, event_date; also event_type)
      // ... FCRA.crim_is_ok (ut.GetDate, fcra_date, fcra_conviction_flag, fcra_traffic_flag)
  END;
  EXPORT activity := sort(GetActivityData (crim_ids), -event_date);

END;   
