import doxie_build;

export file_offenses_keybuilding := dataset('~thor_data400::base::corrections_offenses_' + doxie_build.buildstate + '_BUILDING', layout_offense, flat)(length(trim(offender_key, left, right))>2);
