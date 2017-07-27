import doxie_files, doxie,ut;

f_worldcheck := WorldCheck.File_External_Sources;

export Key_WorldCheck_ext_sources := index(f_worldcheck
                                          ,{UID}
                                          ,{f_worldcheck}
                                          ,'~thor_data400::key::WorldCheck::external_sources_'+doxie.Version_SuperKey);

