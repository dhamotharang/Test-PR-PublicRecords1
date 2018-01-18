import header, data_services;  

f := header.File_HHID_Current;

export Key_Prep_Did_HDid := index(f,
                                  {did, ver},
                                  {hhid,hhid_indiv,hhid_relat},
                                  data_services.data_location.prefix() + 'thor_data400::key::did_hhid_' + thorlib.WUID(), OPT);