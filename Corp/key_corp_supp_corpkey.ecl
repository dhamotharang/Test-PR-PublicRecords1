import doxie, data_services;

export key_corp_supp_corpkey := index(corp.File_Corp_supp_Base,
                                      {corp_key,record_type},
                                      {file_corp_supp_base},
                                      data_services.data_location.prefix() + 'thor_Data400::key::corp_supp_corpkey_' + doxie.Version_SuperKey);
