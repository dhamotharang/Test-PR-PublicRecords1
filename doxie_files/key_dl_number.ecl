import doxie, doxie_build, data_services;

o6 := doxie_files.DL_Decoded(false);

export Key_DL_number := INDEX(
     O6, 
     {s_dl := o6.dl_number}, 
     {o6}, 
     data_services.data_location.prefix() + 'thor_data400::key::dl_number_'+doxie_build.buildstate+'_'+doxie.Version_SuperKey);