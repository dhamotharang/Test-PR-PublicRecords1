import watchdog,ut;

export file_compid_best := dataset('~thor_data400::base::best_compid', {watchdog.Layout_Best,unsigned8 __filepos {virtual(fileposition)}},flat);