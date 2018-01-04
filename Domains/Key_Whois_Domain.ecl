import doxie, data_services;

df := domains.File_Whois_Base;

export Key_Whois_Domain := index(df,
                                 {string45 dn := df.domain_name},
                                 {df},
                                 data_services.data_location.prefix() + 'thor_data400::key::whois_domain_' + doxie.Version_SuperKey);
