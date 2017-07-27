import doxie_build,corrections;

export File_Activity := dataset('~thor_data400::base::corrections_Activity_' + doxie_build.buildstate + '_BUILT',corrections.layout_activity,flat);