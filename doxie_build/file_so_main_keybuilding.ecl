//
// Doxie_build.file_so_main_keybuilding
// 

import sexoffender, Hygenics_SOff;

ds := dataset('~thor_data400::base::sex_offender_main'+ doxie_build.buildstate + '_BUILDING'
					, sexoffender.layout_out_main, thor);

export file_so_Main_keybuilding := Hygenics_SOff.Prep_Build.PB_Sex_Offender_Main(ds);
