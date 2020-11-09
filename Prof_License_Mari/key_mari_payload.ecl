import doxie, Data_Services;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.key_search_delta_rid
// ---------------------------------------------------------------

base_file := Prof_License_Mari.file_mari_search;

KeyName := 'thor_data400::key::proflic_mari::';

export key_mari_payload := 	index(base_file
                                  ,{mari_rid}
                                  ,{base_file} - enh_did_src
                                  ,Data_Services.Data_location.Prefix('mari')+ KeyName+ doxie.Version_SuperKey+'::rid');
