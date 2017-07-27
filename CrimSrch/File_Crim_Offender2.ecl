import Crim_Common;

export File_Crim_Offender2
 := dataset('~thor_data400::base::crim_offender2_did_' + Version.CrimOffender,
			Crim_Common.Layout_Moxie_Crim_Offender2,flat,unsorted);