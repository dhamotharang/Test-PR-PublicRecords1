/**
This is a copy of the final LSSI history
**/
//lfn := '~thor::baseline::gong_history::20140401';
//lfn := '~thor::baseline::gong_history::20140501';
//lfn := '~thor::baseline::gong_history::20140601';
//lfn := '~thor::baseline::gong_history::20140617';
//lfn := '~thor::baseline::gong_history::20140630';
//lfn := '~thor::baseline::gong_history::20140731';
//'~thor::baseline::gong_history::20141201'
//lfn := '~thor::baseline::gong_history::20141130';		// simulated from the 12.01 prod version
//lfn := '~thor::baseline::gong_history::20141130::relinked::mname';		// simulated from the 12.01 prod version
//lfn := '~thor_200::base::gong_history20150202';
lfn := '~thor::gong::neustar::final_lssi_history';
EXPORT File_Final_LSSI_History := DATASET(lfn, Layout_History, THOR);
