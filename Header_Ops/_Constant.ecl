EXPORT _Constant := module

shared QH_path := '/data/Builds/builds/quick_header/logs/';

export QH_path_ready := QH_path + 'ready/';
export QH_path_done  := QH_path + 'done/';
export QH_filename   := 'go.txt';

export xadl_build_sf      := '~thor_data400::out::header_xadl_to_keys_status';
export postmove_build_sf  := '~thor_data400::out::header_post_move_status';
export postroxie_build_sf := '~thor_data400::out::header_post_roxie_release';
export ingest_build_sf(boolean incremental = true) := '~thor_data400::out::header_ingest_status_' + if(incremental, 'inc', 'mon');
export ikb_build_sf       := '~thor_data400::out::header_ikb_status';

END;
