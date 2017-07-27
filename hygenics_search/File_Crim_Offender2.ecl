import hygenics_crim, ut, crim_common;

ds := dataset('~thor_data400::base::crim_offender2_did_' + hygenics_crim.Version.CrimOffender + '_new',
			hygenics_crim.Layout_Common_Crim_Offender_new,flat,unsorted);

	Crim_Common.Layout_Moxie_Crim_Offender2.previous oldLayout(ds l):= transform
		self := l;
	end;

	oldOut := project(ds, oldLayout(left));

export File_Crim_Offender2 := oldOut;