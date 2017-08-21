// NOTE:  This is the Crim_Court court_offenses file
import Crim_Common, hygenics_crim;

export File_Court_Offenses
 := dataset('~thor_data400::base::court_offenses_' + Version.Court_Offenses,
			hygenics_crim.Layout_Common_Court_Offenses,flat,unsorted);