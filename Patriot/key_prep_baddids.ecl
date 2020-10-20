// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.key_patriot_delta_rid
// ---------------------------------------------------------------

export key_prep_baddids :=index(baddies,{did,other_count,first_seen,rel_count,dummy},'~thor_data400::key::Baddids_' + thorlib.wuid());