// NOTE:  This is the Crim_Court court_offenses file
import Crim_Common;

export File_Court_Offenses
 := dataset('~thor_data400::base::court_offenses_' + Version.Court_Offenses,
			Crim_Common.Layout_Moxie_Court_Offenses,flat,unsorted);