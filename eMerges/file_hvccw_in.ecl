_file_hvccw_in := dataset('~thor_data400::in::emerges_IN', emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout, flat);

export file_hvccw_in := f_clean_hvccw_in(_file_hvccw_in);