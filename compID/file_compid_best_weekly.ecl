import watchdog,ut;

export file_compid_best_weekly := dataset('~thor_data400::base::best_compid_weekly', {watchdog.Layout_Best,unsigned8 __filepos {virtual(fileposition)}},flat);
