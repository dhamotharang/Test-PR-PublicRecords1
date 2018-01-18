import doxie, data_services;

df := edgar.File_Edgar_Contacts_Base(bdid != 0);

export key_edgar_contacts_bdid := index(df,{bdid},{df},
                                        data_services.data_location.prefix() + 'thor_data400::key::edgar_contacts_bdid_' + doxie.Version_SuperKey);