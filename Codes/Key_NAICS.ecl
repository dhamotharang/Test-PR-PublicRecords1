import doxie_files, doxie, data_services;

f_naics := Codes.File_NAICS_Codes;

export Key_NAICS := index(f_naics
                         ,{NAICS_Code}
						 ,{f_naics}
						 ,data_services.data_location.prefix() + 'thor_data400::key::NAICS::Codes_Lookup_' + doxie.Version_SuperKey);
