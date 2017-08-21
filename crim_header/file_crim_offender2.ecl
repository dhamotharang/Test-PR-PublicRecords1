import Crim_Common,ut,crimsrch;

export File_Crim_Offender2
 := dataset(ut.foreign_prod + '~thor_data400::base::crim_offender2_did_' + crim_header.version.crimoffender,
			Crim_Common.Layout_Moxie_Crim_Offender2,flat,unsorted);