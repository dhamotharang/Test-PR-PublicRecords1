//
//	SexOffender.file_Main
//

import doxie_build, sexoffender, Hygenics_SOff, data_services;

		ds := dataset('~thor_data400::base::sex_offender_main'+ doxie_build.buildstate, sexoffender.layout_out_main, thor);

export file_Main := Hygenics_SOff.Prep_Build.PB_Sex_Offender_Main(ds);