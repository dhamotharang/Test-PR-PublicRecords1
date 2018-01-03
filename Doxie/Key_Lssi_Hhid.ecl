//define the key using hhid field
import lssi, data_services;

export key_Lssi_hhid := index(lssi.file_hhid_did_lssi(hhid<>0, trim(clean_phone)<>''),
                              {unsigned6 l_hhid := hhid}, 
                              {lssi.file_hhid_did_lssi},
                              data_services.data_location.prefix() + 'thor_data400::key::lssi_hhid_key_' + doxie.Version_SuperKey);