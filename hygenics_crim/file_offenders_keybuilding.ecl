//
//  Hygenics_Crim.file_offender_keybuilding
//

import doxie_build;
		ds:= dataset('~thor_Data400::base::Corrections_Offenders_' + doxie_build.buildstate + '_BUILDING', layout_Offender, flat)
										(length(trim(offender_key, left, right))>2);

export file_offenders_keybuilding := Prep_Build.PB_File_Offenders(ds);


