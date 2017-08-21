import doxie_build, corrections;

 ds := dataset('~thor_Data400::base::corrections_court_offenses_' + doxie_build.buildstate + '_BUILDING',hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory,flat)(length(offender_key)>2);
//Added a new field offense_category in the base. We don't want that field to be in the keys.
	corrections.Layout_CourtOffenses oldFile(ds l) := transform
		self := l;
	end;

export file_courtoffenses_keybuilding:=	project(ds, oldFile(left));