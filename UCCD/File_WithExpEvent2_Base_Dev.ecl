export File_WithExpEvent2_Base_Dev := dataset('~thor_data400::base::ucc_event_wexp_deduped_' + uccd.version_development, {uccd.layout_moxie_WithExpEvent,unsigned8 __filepos { virtual(fileposition)}}, flat);