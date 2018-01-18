import data_services;

// full header file, all sources, including TU
rm_score := doxie.header_pre_keybuild;

export Key_Header_with_TU := INDEX(rm_score, 
                                   {unsigned6 s_did := did}, 
                                   {rm_score}, 
                                   data_services.data_location.prefix() + 'thor_data400::key::header_with_TU_' + version_superkey, OPT);