import doxie, data_services;

export key_corp_base_st_charter := index(corp.File_Corp_Base,
                                         {corp_state_origin,corp_sos_charter_nbr},
                                         {corp_key},
                                         data_services.data_location.prefix() + 'thor_Data400::key::corp_base_st_charter_' + doxie.Version_SuperKey);
