//
//  Hygenics_Crim.file_punishment_keybuilding
//

import doxie_build;
		ds:= dataset('~thor_data400::base::corrections_punishment_' + doxie_build.buildstate + '_BUILDING', Layout_CrimPunishment, flat)
					(length(trim(offender_key, left, right))>2);

export file_punishment_keybuilding := Prep_Build.PB_File_Punishment(ds);
