//
//  Hygenics_Crim.file_Activity_keybuilding
//

import doxie_build, ut;
		ds:= dataset('~thor_data400::base::corrections_Activity_' + doxie_build.buildstate + '_BUILDING', layout_activity, flat)
				(length(trim(offender_key, left, right))>2);

export file_activity_keybuilding := Prep_Build.PB_File_Activity(ds);
