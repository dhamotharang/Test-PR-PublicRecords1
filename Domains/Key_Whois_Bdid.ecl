import doxie, data_services;

df := domains.File_Whois_Base;

export Key_Whois_Bdid := index(df(bdid != 0),
                               {bdid},
                               {df}, 
                               data_services.data_location.prefix() + 'thor_Data400::key::whois_bdid_' + doxie.Version_SuperKey);