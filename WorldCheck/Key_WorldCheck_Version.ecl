import doxie,data_services;

f_worldcheck := WorldCheck.File_Main;

m := max(f_worldcheck,updated);

d := dataset([{m}],{unsigned version});

export Key_WorldCheck_Version := index(d
                                  ,{version},{},data_services.data_location.prefix() + 'thor_data400::key::WorldCheck::version_'+doxie.Version_SuperKey);
