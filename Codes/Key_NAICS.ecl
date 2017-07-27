import doxie_files, doxie,ut;

f_naics := Codes.File_NAICS_Codes;

export Key_NAICS := index(f_naics
                         ,{NAICS_Code}
						 ,{f_naics}
						 ,'~thor_data400::key::NAICS::Codes_Lookup_' + doxie.Version_SuperKey);
