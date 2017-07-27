import doxie_build,corrections;

export File_FCRA_Offenders := dataset('~thor_Data400::base::FCRA_Corrections_Offenders_' + doxie_build.buildstate + '_BUILT',corrections.layout_Offender,flat);