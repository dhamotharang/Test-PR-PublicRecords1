import doxie_build,ut, corrections;

ds := dataset('~thor_Data400::base::Corrections_Punishment_' + doxie_build.buildstate + '_BUILT', hygenics_crim.Layout_CrimPunishment,flat);

	corrections.Layout_CrimPunishment oldFile(ds l) := transform
		self := l;
	end;

export File_Punishment := project(ds, oldFile(left));