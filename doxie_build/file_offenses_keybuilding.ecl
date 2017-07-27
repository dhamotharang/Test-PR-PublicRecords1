import corrections;

export file_offenses_keybuilding := dataset('~thor_data400::base::corrections_offenses_' + doxie_build.buildstate + '_BUILDING',corrections.layout_offense,flat);
