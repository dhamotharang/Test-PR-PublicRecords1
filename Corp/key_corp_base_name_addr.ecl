import doxie, data_services;

export key_corp_base_name_addr := index(corp.File_Corp_Base(corp_legal_name != ''),
                                        {corp_legal_name, corp_addr1_zip5, corp_addr1_prim_name, corp_addr1_prim_range},
                                        {corp_key},
                                        data_services.data_location.prefix() + 'thor_Data400::key::corp_base_name_addr_' + doxie.Version_SuperKey);
