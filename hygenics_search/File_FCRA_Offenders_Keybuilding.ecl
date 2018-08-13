//
// hygenics_search.File_FCRA_Offenders_Keybuilding
//

import doxie_build, hygenics_crim;

ds:= dataset('~thor_data400::base::fcra_Corrections_Offenders_' + doxie_build.buildstate + '_BUILDING',
					hygenics_crim.layout_Offender, flat)
					(length(trim(offender_key, left, right))>2);

export file_fcra_offenders_keybuilding:= hygenics_crim.Prep_Build.PB_File_offenders(ds);
