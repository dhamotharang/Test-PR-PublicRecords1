import doxie, Data_Services, Prof_License_Mari;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.key_search_delta_rid
// ---------------------------------------------------------------

base_file := Prof_License_Mari.file_mari_search((unsigned6)bdid != 0);

KeyName 			:= 'thor_data400::key::proflic_mari::';

export key_bdid := 	index(dedup(base_file,all)
                          ,{bdid}
                          ,{base_file} - enh_did_src
                          ,Data_Services.Data_location.Prefix('mari')+ KeyName+ doxie.Version_SuperKey+'::bdid');
