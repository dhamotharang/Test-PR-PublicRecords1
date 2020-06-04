//Dataset does not exist.   Just a reference for the index statement.
import doxie,_Control,Data_Services;
flags := dataset('Fake_Dataset',watchdog.Layout_best_flags,flat);
export Key_Watchdog_nonglb_old := INDEX(flags,watchdog.Layout_best_flags,Data_Services.Data_location.Prefix('Watchdog_Best')+'thor_data400::key::watchdog_nonglb.did_'+doxie.Version_SuperKey);