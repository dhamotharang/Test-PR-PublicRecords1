import doxie_build, hygenics_crim;

export file_fcra_offenders_keybuilding := dataset('~thor_Data400::base::fcra_Corrections_Offenders_' + doxie_build.buildstate + '_BUILDING', hygenics_crim.layout_Offender, flat)(length(trim(offender_key, left, right))>2);