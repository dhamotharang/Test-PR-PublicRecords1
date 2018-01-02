import doxie,data_services;

f_worldcheck := WorldCheck.File_External_Sources;

export Key_WorldCheck_ext_sources := index(f_worldcheck
                                          ,{UID}
                                          ,{f_worldcheck}
                                          ,data_services.data_location.prefix() + 'thor_data400::key::WorldCheck::external_sources_'+doxie.Version_SuperKey);

