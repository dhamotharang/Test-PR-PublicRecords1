import doxie, data_services;

df := dnb.file_dnb_contacts_base(duns_number !=  '');

export Key_DNB_Contacts_DunsNum := index(df,
                                         {string9	dns := df.duns_number},
                                         {df},
                                         data_services.data_location.prefix() + 'thor_data400::key::dnb_contacts_dunsnum_' + doxie.Version_SuperKey);
