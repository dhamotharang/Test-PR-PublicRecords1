import doxie, data_services;

df := corp.File_Corp_Cont_Base;

export key_corp_cont_name_addr := index(df,
                                        {cont_lname,cont_fname,cont_state},
                                        {corp_key},
                                        data_services.data_location.prefix() + 'thor_data400::key::corp_cont_name_addr_' + doxie.Version_SuperKey);
