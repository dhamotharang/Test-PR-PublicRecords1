//
//  Hygenics_Crim.file_courtoffenses_keybuilding
//

import doxie_build, corrections;

		ds  := dataset('~thor_data400::base::corrections_court_offenses_' + doxie_build.buildstate + '_BUILDING', 
								hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory, flat)
								(length(trim(offender_key, left, right))>2);
		prep_ds := Prep_Build.PB_File_courtOffenses(ds);

		corrections.layout_CourtOffenses oldFile(prep_ds l) := transform
				self := l;
		end;
	
export file_courtoffenses_keybuilding:=	project(prep_ds, oldFile(left));
