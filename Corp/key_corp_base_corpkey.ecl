import doxie, data_services;

export key_corp_base_corpkey := index(corp.File_Corp_Base,
                                      {corp_key, record_type},
                                      {file_corp_base},
                                      data_services.data_location.prefix() + 'thor_Data400::key::corp_base_corpkey_' + doxie.Version_SuperKey);
