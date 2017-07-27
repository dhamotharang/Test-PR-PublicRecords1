import doxie_files, doxie,ut;

f_sic4 := Codes.File_SIC4_Codes;

export Key_SIC4 := index(f_sic4
                        ,{SIC4_Code}
						,{f_sic4}
						,'~thor_data400::key::SIC4::Codes_Lookup_' + doxie.Version_SuperKey);
