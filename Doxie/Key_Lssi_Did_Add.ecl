//define the lssi update-add key using the did field
import lssi, data_services;

export key_lssi_did_add := index(lssi.file_hhid_did_add(did<>0, trim(clean_phone)<>''),
                                 {unsigned6 l_did := did},
                                 {lssi.file_hhid_did_add},
                                 data_services.data_location.prefix() + 'thor_data400::key::lssi_did_add_' + doxie.Version_SuperKey, OPT);