import doxie_build,corrections;

ds  := dataset('~thor_data400::base::corrections_offenses_' + doxie_build.buildstate + '_BUILDING', hygenics_crim.Layout_Base_Offenses_with_OffenseCategory, flat)(length(trim(offender_key, left, right))>2);

 corrections.layout_offense_common oldFile(ds l) := transform
		self := l;
 end;
	
 export file_offenses_keybuilding :=	project(ds, oldFile(left));