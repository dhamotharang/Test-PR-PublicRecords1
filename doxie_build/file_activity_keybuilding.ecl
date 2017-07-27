import corrections;

export file_activity_keybuilding := dataset('~thor_data400::base::corrections_Activity_' + doxie_build.buildstate + '_BUILDING',corrections.layout_activity,flat);