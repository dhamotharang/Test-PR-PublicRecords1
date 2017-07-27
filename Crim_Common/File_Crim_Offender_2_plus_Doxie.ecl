import crimsrch, ut;
export File_Crim_Offender_2_plus_Doxie := dataset(ut.foreign_prod + '~thor_data400::base::crim_offender2_did_' + Crim_Common.Version_CrimOffender_doxie,
			{Layout_Moxie_Crim_Offender2.previous,unsigned8 __fpos {virtual(fileposition)}},flat,unsorted);