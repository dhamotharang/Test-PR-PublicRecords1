import doxie_build;

export file_offenders_keybuilding := dataset('~thor_Data400::base::Corrections_Offenders_' + doxie_build.buildstate + '_BUILDING', layout_Offender, flat)(length(trim(offender_key, left, right))>2);