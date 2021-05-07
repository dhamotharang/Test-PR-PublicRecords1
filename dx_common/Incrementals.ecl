/*
  ** A set of functions and macros to process incremental data (deltas).
  **
  ** NOTE: This attribute MUST be kept in sync with ThorProd branch.
*/
EXPORT Incrementals := MODULE

   /*
    **
    ** Common macro to apply incremental (deltas) rollup logic.
    **
    ** @param inf                    Input dataset; REQUIRED.
    ** @param k_delta_rid            Delta RID key associated with input dataset; OPTIONAL.
    ** @param rid_field              RID field; OPTIONAL.
    ** @param dt_effective_first     Date effective first field; OPTIONAL.
    ** @param dt_effective_last      Date effective last field; OPTIONAL.
    ** @param flag_deletes           Returns deleted records with a flag (is_delta_delete); OPTIONAL.
    ** @param use_distributed        Distribute datasets (Thor only); OPTIONAL, defaults to FALSE.
    ** @returns                      Result dataset corresponds to all 'active' records, taking into account all updates and
    **                               deletes found in incremental keys.
    **
    ** Reference: https://gitlab.ins.risk.regn.net/SALT/SALT/-/wikis/SALT3/Discussion/Incrementalism-Tutorial
    **
  */
  EXPORT mac_Rollupv2(
    inf,
    k_delta_rid = '',
    rid_field = 'record_sid',
    dt_first_field = 'dt_effective_first',
    dt_last_field = 'dt_effective_last',
    flag_deletes = FALSE,
    use_distributed = FALSE
    ) := FUNCTIONMACRO

    LOCAL layout_in_rec := RECORDOF(inf);
    LOCAL rec_delete_flag := RECORD 
      BOOLEAN is_delta_delete := false; // for flagging true deletes
    END;
    LOCAL layout_rids := RECORD
      layout_in_rec.rid_field;
      layout_in_rec.dt_first_field;
      layout_in_rec.dt_last_field; 
      rec_delete_flag;
    END;
    LOCAL layout_out_rec := layout_in_rec OR rec_delete_flag;
    LOCAL in_recs := #IF(use_distributed) DISTRIBUTE(inf, rid_field) #ELSE inf #END;

    // If a delta RID key is specified, must check for updates first.
    #IF(#TEXT(k_delta_rid) <> '')

    // fetch delta rids for all records in incoming dataset first, keeping only the most recent per RID.
    LOCAL unique_rids := DEDUP(
      SORT(PROJECT(in_recs, TRANSFORM({UNSIGNED8 rid_field;}, SELF := LEFT)), rid_field#IF(use_distributed),LOCAL#END),
      rid_field#IF(use_distributed),LOCAL#END);
    LOCAL delta_rids_j := JOIN(unique_rids, k_delta_rid,
      KEYED(LEFT.rid_field=RIGHT.rid_field),
      TRANSFORM(RIGHT),
      ATMOST(100)#IF(use_distributed),LOCAL#END); // up to 100 delta records for the same RID.
    LOCAL delta_rids := DEDUP(
      SORT(delta_rids_j, rid_field, -dt_first_field, -dt_last_field#IF(use_distributed),LOCAL#END)
      ,rid_field#IF(use_distributed),LOCAL#END);

    #ELSE
    
    // dedup all rids in incoming dataset first, keeping only the most recent per RID.
    LOCAL delta_rids_all := PROJECT(in_recs((UNSIGNED)rid_field != 0), layout_rids);
    LOCAL delta_rids_sort := SORT(delta_rids_all, rid_field, -dt_first_field, -dt_last_field, 
      RECORD #IF(use_distributed), LOCAL#END);
    LOCAL delta_rids := DEDUP(delta_rids_sort, rid_field#IF(use_distributed), LOCAL#END);
    
    #END

    // In a typical scenario, all records in in_recs dataset should have rid_field populated. 
    // The left outer join below will simply drop stale and deleted records.
    // Note that, if in_recs is the result set of a left outer join, dropping deletes
    // may produce incorrect results. Flag delete option must be used to account for
    // those cases.
    LOCAL recs_out := JOIN(in_recs, delta_rids,
      LEFT.rid_field = RIGHT.rid_field,
      TRANSFORM(layout_out_rec,
        // Drop record from result set if:
        // (1) record is older than most recent delta (stale)
        // (2) record has been deleted (and record is not a flag delete)
        is_stale := LEFT.dt_first_field < RIGHT.dt_first_field;
        is_deleted := RIGHT.dt_last_field > 0 AND LEFT.dt_first_field <= RIGHT.dt_last_field;

        // We only want to flag 'true' deletes, meaning, the latest record for this rid is a delete record.
        is_flag_delete := flag_deletes AND RIGHT.dt_last_field > 0 AND LEFT.dt_last_field = RIGHT.dt_last_field;
        skip_record := RIGHT.rid_field > 0 AND (is_stale OR (is_deleted AND ~is_flag_delete));
        SELF.rid_field := IF(skip_record, SKIP, LEFT.rid_field);
        SELF.is_delta_delete := is_flag_delete;
        SELF := LEFT;
      ), 
      LEFT OUTER, GROUPED, KEEP(1), LIMIT(0)
      #IF(use_distributed),LOCAL#END
    );

    // bypass the rollup completely if all records have no rid_field
    LOCAL gotDelta := EXISTS(in_recs((UNSIGNED)rid_field <> 0));
    #IF(flag_deletes)
    RETURN IF(gotDelta, recs_out, PROJECT(inf, layout_out_rec));
    #ELSE
    RETURN IF(gotDelta, PROJECT(recs_out, layout_in_rec), inf);
    #END

  ENDMACRO;

  /*
    **
    ** Common macro to apply incremental (deltas) rollup logic.
    **
    ** @param inf                    Input dataset; REQUIRED.
    ** @param k_delta_rid            Delta RID key associated with input dataset; OPTIONAL.
    ** @param rid_field              RID field; OPTIONAL.
    ** @param dt_effective_first     Date effective first field; OPTIONAL.
    ** @param dt_effective_last      Date effective last field; OPTIONAL.
    ** @param use_distributed        Distribute datasets (Thor only); OPTIONAL, defaults to FALSE.
    ** @returns                      Result dataset corresponds to all 'active' records, taking into account all updates and
    **                               deletes found in incremental keys.
    **
    ** Reference: https://gitlab.ins.risk.regn.net/SALT/SALT/-/wikis/SALT3/Discussion/Incrementalism-Tutorial
    **
  */
  EXPORT mac_Rollup(
    inf,
    k_delta_rid = '',
    rid_field = 'record_sid',
    dt_first_field = 'dt_effective_first',
    dt_last_field = 'dt_effective_last',
    use_distributed = FALSE
    ) := FUNCTIONMACRO

    // Note: we should consider dropping all delete records from input dataset to possibly improve performance.

    LOCAL layout_in_rec := RECORDOF(inf);
    LOCAL in_recs := #IF(use_distributed) DISTRIBUTE(inf, rid_field); #ELSE inf; #END

    // If a delta RID key is specified, must check for updates first.
    #IF(#TEXT(k_delta_rid) <> '')

    // fetch delta rids for all records in incoming dataset first, keeping only the most recent per RID.
    LOCAL unique_rids := DEDUP(
      SORT(PROJECT(in_recs, TRANSFORM({UNSIGNED8 rid_field;}, SELF := LEFT)), rid_field#IF(use_distributed),LOCAL#END),
      rid_field#IF(use_distributed),LOCAL#END);
    LOCAL delta_rids_j := JOIN(unique_rids, k_delta_rid,
      KEYED(LEFT.rid_field=RIGHT.rid_field),
      TRANSFORM(RIGHT),
      ATMOST(100)#IF(use_distributed),LOCAL#END); // up to 100 delta records for the same RID.
    LOCAL delta_rids := DEDUP(
      SORT(delta_rids_j, rid_field, -dt_first_field, -dt_last_field#IF(use_distributed),LOCAL#END)
      ,rid_field#IF(use_distributed),LOCAL#END);

    LOCAL recs_out := JOIN(in_recs, delta_rids,
      LEFT.rid_field = RIGHT.rid_field,
      TRANSFORM(layout_in_rec,
        // drop from result set if:
        // (1) record is older than delta (stale)
        // (2) record has been deleted
        is_stale := LEFT.dt_first_field < RIGHT.dt_first_field;
        is_delete := RIGHT.dt_last_field > 0 AND LEFT.dt_first_field <= RIGHT.dt_last_field;
        SELF.rid_field := IF(RIGHT.rid_field > 0 AND (is_stale OR is_delete),
          SKIP, LEFT.rid_field);
        SELF := LEFT;
      ), LEFT OUTER, KEEP(1), LIMIT(0)#IF(use_distributed),LOCAL#END);
    #ELSE
      LOCAL recs_no_rid := in_recs((UNSIGNED)rid_field = 0);
      LOCAL recs_rolled := DEDUP(
        SORT(in_recs((UNSIGNED)rid_field != 0), rid_field, -dt_first_field, -dt_last_field, RECORD #IF(use_distributed),LOCAL#END),
        rid_field #IF(use_distributed),LOCAL#END)(dt_last_field = 0);
      LOCAL recs_out := recs_rolled + recs_no_rid;
    #END

    RETURN recs_out;

  ENDMACRO;

  // convenience to copy metadata fields, typically within a join/transform.
  EXPORT mac_CopyMetadata(L, R) := MACRO
    L.global_sid := R.global_sid;
    L.record_sid := R.record_sid;
    L.dt_effective_first := R.dt_effective_first;
    L.dt_effective_last := R.dt_effective_last;
    L.delta_ind := R.delta_ind;
  ENDMACRO;

  EXPORT mac_CopyMetadataWithDeleteFlag(L, R) := MACRO
    L.record_sid := if(R.is_delta_delete, 0, R.record_sid);
    L.global_sid := if(R.is_delta_delete, 0, R.global_sid);
    L.dt_effective_first := if(R.is_delta_delete, 0, R.dt_effective_first);
    L.dt_effective_last := if(R.is_delta_delete, 0, R.dt_effective_last);
    L.delta_ind := if(R.is_delta_delete, 0, R.delta_ind);
  ENDMACRO;

END;
