import doxie_build, sexoffender, data_services;

// changed 8-1
// export file_Main := dataset('~thor_data400::base::sex_offender_main'+ doxie_build.buildstate,sexoffender.layout_out_main,flat);

main_ds := dataset('~thor_data400::base::sex_offender_main'+ doxie_build.buildstate, sexoffender.layout_out_main, thor);

export file_Main := Hygenics_SOff.Prep_Build.PB_Sex_Offender_Main(main_ds);