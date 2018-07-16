//
// SexOffender.File_Offenses_2
//

import doxie_build, ut, Hygenics_SOff;
		ds := dataset('~thor_data400::base::sex_offender_Offenses'+ doxie_build.buildstate, 
								layout_Common_Offense_new, flat);

export File_Offenses_2 := Hygenics_SOff.Prep_Build.PB_Sex_Offender_Offense(ds);
