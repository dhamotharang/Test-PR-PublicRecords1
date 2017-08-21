import corrections, hygenics_crim;

export file_courtoffenses_keybuilding := dataset('~thor_Data400::base::corrections_court_offenses_' + doxie_build.buildstate + '_BUILDING',hygenics_crim.layout_courtoffenses,flat);