import gong, data_Services; 

export key_hhid_prep := index(gong.file_gong_hhid(hhid<>0, trim(phone10)<>''),
                             {unsigned6 s_hhid := hhid},{gong.file_gong_hhid},
                             data_services.data_location.prefix() + 'thor_data400::key::gong_hhid' + thorlib.wuid());
