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
    LOCAL layout_join_rec := layout_in_rec OR rec_delete_flag;
    LOCAL layout_out_rec := #IF(flag_deletes) layout_join_rec #ELSE layout_in_rec #END;
    LOCAL in_recs := #IF(use_distributed) DISTRIBUTE(inf, rid_field) #ELSE inf #END;

    // If a delta RID key is specified, must check for updates first.
    #IF(#TEXT(k_delta_rid) <> '')

    // fetch delta rids for all records in incoming dataset first, keeping only the most recent per RID.
    LOCAL delta_rids_a := PROJECT(UNGROUP(in_recs((UNSIGNED)rid_field != 0)), TRANSFORM({UNSIGNED8 rid_field;}, SELF := LEFT));
    LOCAL delta_rids_b := DEDUP(SORT(delta_rids_a, rid_field#IF(use_distributed),LOCAL#END), rid_field#IF(use_distributed),LOCAL#END);
    LOCAL delta_rids_c := JOIN(delta_rids_b, k_delta_rid,
      KEYED(LEFT.rid_field=RIGHT.rid_field),
      TRANSFORM(RIGHT),
      ATMOST(100)#IF(use_distributed),LOCAL#END); // up to 100 delta records for the same RID.
    LOCAL unique_rids := DEDUP(
      SORT(delta_rids_c, rid_field, -dt_first_field, -dt_last_field#IF(use_distributed),LOCAL#END)
      ,rid_field#IF(use_distributed),LOCAL#END);

    #ELSE
    
    // dedup all rids in incoming dataset first, keeping only the most recent per RID.
    LOCAL delta_rids_a := PROJECT(UNGROUP(in_recs((UNSIGNED)rid_field != 0)), layout_rids);
    LOCAL delta_rids_b := SORT(delta_rids_a, rid_field, -dt_first_field, -dt_last_field, 
      RECORD #IF(use_distributed), LOCAL#END);
    LOCAL unique_rids := DEDUP(delta_rids_b, rid_field#IF(use_distributed), LOCAL#END);
    
    #END

    // In a typical scenario, all records in in_recs dataset should have rid_field populated. 
    // The left outer join below will simply drop stale and deleted records.
    // Note that, if in_recs is the result set of a left outer join, dropping deletes
    // may produce incorrect results. Flag delete option must be used to account for
    // those cases.
    LOCAL recs_out := JOIN(in_recs, unique_rids,
      LEFT.rid_field = RIGHT.rid_field,
      TRANSFORM(layout_join_rec,
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
      #IF(use_distributed)
      LEFT OUTER, KEEP(1), LIMIT(0), LOCAL
      #ELSE
      LEFT OUTER, GROUPED, KEEP(1), LIMIT(0) // <-- GROUPED here avoids 'branches of the condition have different grouping' error if input dataset happens to be grouped.
      #END
    );

    // bypass the rollup completely if all records have no rid_field
    LOCAL gotDelta := EXISTS(in_recs((UNSIGNED)rid_field <> 0));  
    RETURN IF(gotDelta, PROJECT(recs_out, layout_out_rec), PROJECT(inf, layout_out_rec));

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

  /* DO NOT CALL THIS MACRO DIRECTLY! A dx_<service>.Get interface should be created to access this macro.
  **
  ** Macro to fetch key records from an incremental key, and apply the necessary incremental rollup procedures.
  ** If no KEEP, LIMIT, or ATMOST is provided the join will LIMIT(10000).
  **
  ** NOTE: This macro will UNGROUP the input dataset.
  **
  ** @param inf                    Input dataset.
  ** @param inf_key                Key to join against.
  ** @param inf_join_conditions    Join conditions to use for join.
  ** @param inf_fetch_layout       Layout to use for returned key_rec.
  ** @param inf_limit_number       LIMIT(n) in join. OPTIONAL, omitted if not supplied.
  ** @param inf_skip_limit         Add SKIP to LIMIT(n). OPTIONAL, omitted if not supplied.
  ** @param inf_atmost_number      ATMOST(n) in join. OPTIONAL, omitted if not supplied.
  ** @param inf_keep_number        Number of matches to KEEP. OPTIONAL, omitted if not supplied.
  ** @param inf_delta_keep_number  Max number of records to KEEP in join to account for deltas.
  **                               OPTIONAL; If not supplied, defaults to 2x supplied inf_keep_number.
  ** @param LEFT_OUTER_JOIN        Use LEFT OUTER when joining against provided key.
  ** @returns                      DS of matching records from key in key layout.
  **
  */
  EXPORT mac_Fetch(
    inf,
    inf_key,
    inf_join_conditions,
    inf_fetch_layout,
    inf_limit_number = '',
    inf_skip_limit = FALSE,
    inf_atmost_number = '',
    inf_keep_number = '',
    inf_delta_keep_number = '',
    LEFT_OUTER_JOIN = FALSE
    ) := FUNCTIONMACRO
    
    LOCAL has_limit := #TEXT(inf_limit_number) != '';
    LOCAL has_atmost := #TEXT(inf_atmost_number) != '';
    LOCAL has_keep := #TEXT(inf_keep_number) != '';
    LOCAL has_delta_keep := #TEXT(inf_delta_keep_number) != '';
    LOCAL use_limit_safeguard := NOT has_limit AND NOT has_atmost AND NOT has_keep;
    LOCAL join_keep_number := #IF(has_delta_keep)inf_delta_keep_number;#ELSEIF(has_keep)IF(inf_keep_number < 10, 20, inf_keep_number *2);#ELSE 20;#END 

    LOCAL out_layout := RECORD
      RECORDOF(inf);
      RECORDOF(inf_fetch_layout) key_rec;
    END;

    LOCAL in_rec_seq := RECORD
      UNSIGNED4 __SEQ__; // explicitly defined because we want to fail syntax check in (unlikely) case of conflict.
      RECORDOF(inf); 
    END;
    LOCAL inf_seq := PROJECT(UNGROUP(inf), TRANSFORM(in_rec_seq, SELF.__SEQ__ := COUNTER; SELF := LEFT));
    // layout below may overwrite incoming metadata (additional changes to rollup macro required if we want to avoid that)
    LOCAL join_layout := out_layout OR dx_common.layout_metadata OR {{UNSIGNED4 __SEQ__}}; 
    
    LOCAL key_recs := JOIN(inf_seq, inf_key,
      inf_join_conditions,
      TRANSFORM(join_layout, 
        dx_common.Incrementals.mac_CopyMetadata(SELF, RIGHT),
        SELF.__SEQ__ := LEFT.__SEQ__; 
        SELF.key_rec := RIGHT; 
        SELF := LEFT)
      #IF(has_limit), LIMIT(inf_limit_number #IF(inf_skip_limit),SKIP#END) #END
      #IF(use_limit_safeguard), LIMIT(10000) #END
      #IF(has_atmost), ATMOST(inf_atmost_number) #END
      #IF(has_keep), KEEP(join_keep_number) #END
      #IF(LEFT_OUTER_JOIN), LEFT OUTER #END
    ); 

    #IF(LEFT_OUTER_JOIN)
    LOCAL rolled_recs_pre := dx_common.Incrementals.mac_Rollupv2(key_recs, flag_deletes := TRUE);
    LOCAL rolled_recs := PROJECT(rolled_recs_pre, TRANSFORM(RECORDOF(LEFT),
      SELF.key_rec := IF(NOT LEFT.is_delta_delete, LEFT.key_rec);
      SELF := LEFT));
    #ELSE
    LOCAL rolled_recs := dx_common.Incrementals.mac_Rollupv2(key_recs);  
    #END

    #IF(has_keep)
    // line below requires input dataset to be ungrouped.
    LOCAL rolled_keep := DEDUP(SORT(rolled_recs, __SEQ__), __SEQ__, KEEP(inf_keep_number));
    LOCAL out := PROJECT(rolled_keep, out_layout);
    #ELSE
    LOCAL out := PROJECT(rolled_recs, out_layout);
    #END;

    // OUTPUT(key_recs, NAMED('inc_mac_fetch_key_recs'), OVERWRITE);
    // OUTPUT(rolled_recs_pre, NAMED('inc_mac_fetch_rolled_recs_pre'), OVERWRITE);
    // OUTPUT(rolled_recs, NAMED('inc_mac_fetch_rolled_recs'), OVERWRITE);
    // OUTPUT(out, NAMED('inc_mac_fetch_out'), OVERWRITE);
    RETURN out;

  ENDMACRO;

END;
