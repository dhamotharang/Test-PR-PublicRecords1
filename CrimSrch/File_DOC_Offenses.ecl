// NOTE:  This is the DOC crim_offenses file
import Crim_Common;

export File_DOC_Offenses
 := dataset('~thor_data400::base::crim_offenses_' + Version.DOC_Offenses,
			Crim_Common.Layout_Moxie_DOC_Offenses,flat,unsorted);