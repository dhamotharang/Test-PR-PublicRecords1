//
//	doxie_files.File_Fcra_Offenders
//

import doxie_build,corrections, data_services, hygenics_crim;

		ds := dataset('~thor_Data400::base::FCRA_Corrections_Offenders_' + doxie_build.buildstate + '_BUILT',corrections.layout_Offender,flat);
		
export File_FCRA_Offenders := hygenics_crim.Prep_Build.PB_File_Offenders(ds);