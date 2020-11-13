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
        is_delete := RIGHT.dt_last_field > 0; 
        SELF.rid_field := IF(RIGHT.rid_field > 0 AND (is_stale OR is_delete), 
          SKIP, LEFT.rid_field); 
        SELF := LEFT;
      ), LEFT OUTER, KEEP(1), LIMIT(0)#IF(use_distributed),LOCAL#END);
    #ELSE
      LOCAL recs_out := DEDUP(
        SORT(in_recs, rid_field, -dt_first_field, -dt_last_field, RECORD #IF(use_distributed),LOCAL#END),
        rid_field #IF(use_distributed),LOCAL#END)(dt_last_field = 0);
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

END;
