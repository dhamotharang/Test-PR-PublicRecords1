// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.key_patriot_delta_rid
// ---------------------------------------------------------------

export key_prep_badnames := index(annotated_names,{fname,mname,lname,cnt},'~thor_data400::key::annotated_names_' + thorlib.wuid());