d :=  dataset('~thor_data400::base::ucc_event_wexp', uccd.Layout_WithExpEvent, flat);
uccd.mac_filterStateOverlap(d, stateclean)
export File_WithExpEvent := stateclean;