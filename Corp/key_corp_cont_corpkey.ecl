import doxie, data_services;

export key_corp_cont_corpkey := index(corp.File_Corp_Cont_Base,
                                      {corp_key,record_type},
                                      {file_corp_cont_base},
                                      data_services.data_location.prefix() + 'thor_Data400::key::corp_cont_corpkey_' + doxie.Version_SuperKey);
