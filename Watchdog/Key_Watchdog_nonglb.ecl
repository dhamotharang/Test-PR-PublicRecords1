//Dataset does not exist.   Just a reference for the index statement.
import doxie,ut,_Control;
flags := dataset('Fake_Dataset',watchdog.Layout_best_flags,flat);
export Key_Watchdog_nonglb := INDEX(flags,watchdog.Layout_best_flags,ut.foreign_prod+'thor_data400::key::watchdog_nonglb.did_'+doxie.Version_SuperKey);