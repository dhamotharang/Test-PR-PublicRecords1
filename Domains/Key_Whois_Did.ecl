import doxie, data_services;

df := domains.File_Whois_Base;

export Key_Whois_Did := index(df(did != 0),
                              {unsigned6 d := df.did},
                              {df}, 
                              data_services.data_location.prefix() + 'thor_data400::key::whois_did_' + doxie.Version_SuperKey);